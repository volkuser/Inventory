CREATE TABLE `Role`(
    `IdRole` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `Name` NVARCHAR(30) NOT NULL UNIQUE CHECK ('^[[:alpha:]]+' REGEXP `Name`)
);

CREATE TABLE `Employee`(
    `IdEmployee` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `LastName` NVARCHAR(100) NOT NULL CHECK ('[[:alpha:]]+' REGEXP `LastName`),
    `FirstName` NVARCHAR(100) NOT NULL CHECK ('[[:alpha:]]+' REGEXP `FirstName`),
    `Email` VARCHAR(100) NOT NULL UNIQUE CHECK (`Email` LIKE '%@%.%')
);

CREATE TABLE `User`(
    `IdUser` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `Login` NVARCHAR(100) NOT NULL UNIQUE,
    `Password` NVARCHAR(100) NOT NULL,
    `RoleId` INT NOT NULL,
    `EmployeeId` INT NOT NULL,

    FOREIGN KEY (`RoleId`) REFERENCES `Role` (`IdRole`),
    FOREIGN KEY (`EmployeeId`) REFERENCES `Employee` (`IdEmployee`)
);

CREATE TABLE `Commission`(
    `IdCommission` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `CommissionFormationDate` DATE NOT NULL
);

CREATE TABLE `CommissionMember`(
    `IdCommissionMember` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `CommissionId` INT NOT NULL,
    `EmployeeId` INT NOT NULL,

    FOREIGN KEY (`CommissionId`) REFERENCES `Commission` (`IdCommission`),
    FOREIGN KEY (`EmployeeId`) REFERENCES `Employee` (`IdEmployee`)
);

CREATE TABLE `TrainingCenter`(
    `IdTrainingCenter` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `Address` NVARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE `Audience`(
    `IdAudience` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `Number` NVARCHAR(4) NOT NULL UNIQUE,
    `TrainingCenterId` INT NOT NULL,

    FOREIGN KEY (`TrainingCenterId`) REFERENCES `TrainingCenter` (`IdTrainingCenter`)
);

CREATE TABLE `Status`(
    `IdStatus` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `Name` NVARCHAR(30) NOT NULL UNIQUE CHECK ('[[:alpha:]]+' REGEXP `Name`)
);

CREATE TABLE `State`(
    `IdState` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `Name` NVARCHAR(30) NOT NULL UNIQUE CHECK ('[[:alpha:]]+' REGEXP `Name`)
);

CREATE TABLE `EquipmentType`(
    `IdEquipmentType` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `Name` NVARCHAR(100) NOT NULL UNIQUE CHECK ('[[:alpha:]]+' REGEXP `Name`)
);
CREATE TABLE `Equipment`(
    `IdEquipment` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `EquipmentTypeId` INT NOT NULL,

    FOREIGN KEY (`EquipmentTypeId`) REFERENCES `EquipmentType` (`IdEquipmentType`)
);

CREATE TABLE `EquipmentUnit`(
    `IdEquipmentUnit` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `Series` INT NOT NULL,
    `Number` NVARCHAR(100) NOT NULL UNIQUE,
    `StatusId` INT NOT NULL,
    `AudienceId` INT NOT NULL,
    `IntroductionDate` DATE NOT NULL,
    `StateId` INT NOT NULL,
    `EquipmentId` INT NOT NULL,

    FOREIGN KEY (`StatusId`) REFERENCES `Status` (`IdStatus`),
    FOREIGN KEY (`AudienceId`) REFERENCES `Audience` (`IdAudience`),
    FOREIGN KEY (`StateId`) REFERENCES `State` (`IdState`),
    FOREIGN KEY (`EquipmentId`) REFERENCES `Equipment` (`IdEquipment`)
);

CREATE TABLE `Inventory`(
    `IdInventory` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `EventDate` DATE NOT NULL,
    `CommissionId` INT NOT NULL,

    FOREIGN KEY (`CommissionId`) REFERENCES `Commission` (`IdCommission`)
);

CREATE TABLE `InspectedUnit`(
    `IdInspectedUnit` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `InventoryId` INT NOT NULL,
    `EquipmentUnitId` INT NOT NULL,

    FOREIGN KEY (`EquipmentUnitId`) REFERENCES `EquipmentUnit` (`IdEquipmentUnit`)
);