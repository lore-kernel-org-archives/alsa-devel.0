From: Predrag Ivanovic <predivan@open.telekom.rs>
Subject: Re: [REGRESSION][IDT 92HD88B1] Reversed mute key LED
 status after update to 3.2
Date: Thu, 12 Jan 2012 20:04:45 +0100
Message-ID: <20120112200445.305e8b9f@deus.skynet.net>
References: <20120108013908.30a90bc1@deus.skynet.net>
	<1326365723.2760.1.camel@oberon.sagui.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from e11mailgw06.open.telekom.rs (e11mailgw06.open.telekom.rs
	[212.200.12.199])
	by alsa0.perex.cz (Postfix) with ESMTP id 428BB103C45
	for <alsa-devel@alsa-project.org>; Thu, 12 Jan 2012 20:05:17 +0100 (CET)
In-Reply-To: <1326365723.2760.1.camel@oberon.sagui.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Gustavo Maciel Dias Vieira <gustavo@sagui.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 12 Jan 2012 08:55:23 -0200
Gustavo Maciel Dias Vieira wrote:

<snip>
>> If you need more information, I'll be happy to provide it.
>> Would output of dmidecode be useful in any way?
>> Please cc me, I am not subscribed to the list.
>
>The output of dmidecode would definitely help.

Outputs of dmidecode and dmidecode -u are below.
=3D=3D=3D
dmidecode =

=3D=3D=3D
# dmidecode 2.9
SMBIOS 2.6 present.
21 structures occupying 1074 bytes.
Table at 0x000E6BB0.

Handle 0x0000, DMI type 0, 24 bytes
BIOS Information
	Vendor: Hewlett-Packard
	Version: F.15
	Release Date: 01/14/2011
	ROM Size: 2048 kB
	Characteristics:
		PCI is supported
		BIOS is upgradeable
		BIOS shadowing is allowed
		Boot from CD is supported
		Selectable boot is supported
		BIOS ROM is socketed
		EDD is supported
		Japanese floppy for NEC 9800 1.2 MB is supported (int 13h)
		Japanese floppy for Toshiba 1.2 MB is supported (int 13h)
		5.25"/360 KB floppy services are supported (int 13h)
		5.25"/1.2 MB floppy services are supported (int 13h)
		3.5"/720 KB floppy services are supported (int 13h)
		3.5"/2.88 MB floppy services are supported (int 13h)
		8042 keyboard services are supported (int 9h)
		CGA/mono video services are supported (int 10h)
		ACPI is supported
		USB legacy is supported
		Targeted content distribution is supported
	BIOS Revision: 15.15
	Firmware Revision: 121.75

Handle 0x0001, DMI type 1, 27 bytes
System Information
	Manufacturer: Hewlett-Packard
	Product Name: HP Mini 110-3100                =

	Version: 058F110000202B00000300100
	Serial Number: CNC04646VT
	UUID: 300059FF-631D-BE0A-B42F-68B599DA73E9
	Wake-up Type: Power Switch
	SKU Number: LD741EA#ABZ =

	Family: 103C_5335KV

Handle 0x0002, DMI type 2, 16 bytes
Base Board Information
	Manufacturer: Hewlett-Packard
	Product Name: 148A
	Version: 79.4B
	Serial Number: PBNLF1127ZPBP1     =

	Asset Tag: Base Board Asset Tag
	Features:
		Board is a hosting board
		Board is replaceable
	Location In Chassis: Base Board Chassis Location
	Chassis Handle: 0x0003
	Type: Motherboard
	Contained Object Handles: 0

Handle 0x0003, DMI type 3, 22 bytes
Chassis Information
	Manufacturer: Hewlett-Packard
	Type: Notebook
	Lock: Not Present
	Version: Chassis Version
	Serial Number: Chassis Serial Number
	Asset Tag: Chassis Asset Tag
	Boot-up State: Safe
	Power Supply State: Safe
	Thermal State: Safe
	Security Status: None
	OEM Information: 0x0000002B
	Height: Unspecified
	Number Of Power Cords: 1
	Contained Elements: 0

Handle 0x0004, DMI type 9, 17 bytes
System Slot Information
	Designation: J7
	Type: x1 PCI Express
	Current Usage: Available
	Length: Other
	ID: 0
	Characteristics:
		PME signal is supported
		Hot-plug devices are supported

Handle 0x0005, DMI type 10, 6 bytes
On Board Device Information
	Type: Video
	Status: Enabled
	Description: Video Graphics Controller

Handle 0x0006, DMI type 10, 6 bytes
On Board Device Information
	Type: Ethernet
	Status: Enabled
	Description: Realtek Lan Controller

Handle 0x0007, DMI type 11, 5 bytes
OEM Strings
	String 1: $HP$
	String 2: LOC#   =

	String 3: ABS 70/71 78 79 7A 7B
	String 4: CNB1 058F110000202B00000300100
	String 5: HP_Mute_LED_P_G

Handle 0x0008, DMI type 22, 26 bytes
Portable Battery
	Location: Primary
	Manufacturer: CPT-S26G
	Name: TY03027
	Chemistry: Lithium Ion
	Design Capacity: 2550 mWh
	Design Voltage: 10800 mV
	SBDS Version: 1.1
	Maximum Error: 0%
	SBDS Serial Number: 08A2
	SBDS Manufacture Date: 2010-11-12
	OEM-specific Information: 0x0000FFFF

Handle 0x0009, DMI type 32, 20 bytes
System Boot Information
	Status: No errors detected

Handle 0x000A, DMI type 41, 11 bytes
Unknown Type
	Header and Data:
		29 0B 0A 00 01 85 01 00 00 00 01
	Strings:
		82567LM Gigabit Network Connection

Handle 0x000B, DMI type 16, 15 bytes
Physical Memory Array
	Location: System Board Or Motherboard
	Use: System Memory
	Error Correction Type: None
	Maximum Capacity: 4 GB
	Error Information Handle: No Error
	Number Of Devices: 2

Handle 0x000C, DMI type 17, 28 bytes
Memory Device
	Array Handle: 0x000B
	Error Information Handle: 0x000D
	Total Width: 64 bits
	Data Width: 64 bits
	Size: 2048 MB
	Form Factor: SODIMM
	Set: None
	Locator: DIMM1
	Bank Locator: BANK 0
	Type: DDR2
	Type Detail: Synchronous
	Speed: 667 MHz (1.5 ns)
	Manufacturer: Kingston
	Serial Number: 4933965700
	Asset Tag: Unknown
	Part Number:                   =


Handle 0x000D, DMI type 18, 23 bytes
32-bit Memory Error Information
	Type: OK
	Granularity: Unknown
	Operation: Unknown
	Vendor Syndrome: Unknown
	Memory Array Address: Unknown
	Device Address: Unknown
	Resolution: Unknown

Handle 0x000E, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0007FFFFFFF
	Range Size: 2 GB
	Physical Device Handle: 0x000C
	Memory Array Mapped Address Handle: 0x0010
	Partition Row Position: 1

Handle 0x000F, DMI type 18, 23 bytes
32-bit Memory Error Information
	Type: OK
	Granularity: Unknown
	Operation: Unknown
	Vendor Syndrome: Unknown
	Memory Array Address: Unknown
	Device Address: Unknown
	Resolution: Unknown

Handle 0x0010, DMI type 19, 15 bytes
Memory Array Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0007FFFFFFF
	Range Size: 2 GB
	Physical Array Handle: 0x000B
	Partition Width: 0

Handle 0x0011, DMI type 4, 42 bytes
Processor Information
	Socket Designation: CPU
	Type: Central Processor
	Family: Pentium M
	Manufacturer: Intel(R) Corporation
	ID: CA 06 01 00 FF FB E9 BF
	Signature: Type 0, Family 6, Model 28, Stepping 10
	Flags:
		FPU (Floating-point unit on-chip)
		VME (Virtual mode extension)
		DE (Debugging extension)
		PSE (Page size extension)
		TSC (Time stamp counter)
		MSR (Model specific registers)
		PAE (Physical address extension)
		MCE (Machine check exception)
		CX8 (CMPXCHG8 instruction supported)
		APIC (On-chip APIC hardware supported)
		SEP (Fast system call)
		MTRR (Memory type range registers)
		PGE (Page global enable)
		MCA (Machine check architecture)
		CMOV (Conditional move instruction supported)
		PAT (Page attribute table)
		CLFSH (CLFLUSH instruction supported)
		DS (Debug store)
		ACPI (ACPI supported)
		MMX (MMX technology supported)
		FXSR (Fast floating-point save and restore)
		SSE (Streaming SIMD extensions)
		SSE2 (Streaming SIMD extensions 2)
		SS (Self-snoop)
		HTT (Hyper-threading technology)
		TM (Thermal monitor supported)
		PBE (Pending break enabled)
	Version: Intel(R) Atom(TM) CPU N455   @ 1.66GHz
	Voltage: 1.6 V
	External Clock: 667 MHz
	Max Speed: 1666 MHz
	Current Speed: 1666 MHz
	Status: Populated, Enabled
	Upgrade: Socket 478
	L1 Cache Handle: 0x0013
	L2 Cache Handle: 0x0012
	L3 Cache Handle: Not Provided
	Serial Number: Not Specified
	Asset Tag: FFFF
	Part Number: Not Specified
	Core Count: 1
	Core Enabled: 1
	Thread Count: 2
	Characteristics:
		64-bit capable

Handle 0x0012, DMI type 7, 19 bytes
Cache Information
	Socket Designation: Unknown
	Configuration: Enabled, Not Socketed, Level 2
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 512 KB
	Maximum Size: 512 KB
	Supported SRAM Types:
		Synchronous
	Installed SRAM Type: Synchronous
	Speed: Unknown
	Error Correction Type: Single-bit ECC
	System Type: Unified
	Associativity: 8-way Set-associative

Handle 0x0013, DMI type 7, 19 bytes
Cache Information
	Socket Designation: Unknown
	Configuration: Enabled, Not Socketed, Level 1
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 32 KB
	Maximum Size: 32 KB
	Supported SRAM Types:
		Synchronous
	Installed SRAM Type: Synchronous
	Speed: Unknown
	Error Correction Type: Single-bit ECC
	System Type: Instruction
	Associativity: 8-way Set-associative

Handle 0x0014, DMI type 127, 4 bytes
End Of Table
=3D=3D=3D

dmidecode -u
=3D=3D=3D
 # dmidecode 2.9
SMBIOS 2.6 present.
21 structures occupying 1074 bytes.
Table at 0x000E6BB0.

Handle 0x0000, DMI type 0, 24 bytes
	Header and Data:
		00 18 00 00 01 02 00 00 03 1F 80 98 FB 4B 01 00
		10 00 03 04 0F 0F 79 4B
	Strings:
		48 65 77 6C 65 74 74 2D 50 61 63 6B 61 72 64 00
		"Hewlett-Packard"
		46 2E 31 35 00
		"F.15"
		30 31 2F 31 34 2F 32 30 31 31 00
		"01/14/2011"

Handle 0x0001, DMI type 1, 27 bytes
	Header and Data:
		01 1B 01 00 01 02 03 04 30 00 59 FF 63 1D BE 0A
		B4 2F 68 B5 99 DA 73 E9 06 05 06
	Strings:
		48 65 77 6C 65 74 74 2D 50 61 63 6B 61 72 64 00
		"Hewlett-Packard"
		48 50 20 4D 69 6E 69 20 31 31 30 2D 33 31 30 30
		20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
		00
		"HP Mini 110-3100                "
		30 35 38 46 31 31 30 30 30 30 32 30 32 42 30 30
		30 30 30 33 30 30 31 30 30 00
		"058F110000202B00000300100"
		43 4E 43 30 34 36 34 36 56 54 00
		"CNC04646VT"
		4C 44 37 34 31 45 41 23 41 42 5A 20 00
		"LD741EA#ABZ "
		31 30 33 43 5F 35 33 33 35 4B 56 00
		"103C_5335KV"

Handle 0x0002, DMI type 2, 16 bytes
	Header and Data:
		02 10 02 00 01 02 03 04 05 09 06 03 00 0A 00 00
	Strings:
		48 65 77 6C 65 74 74 2D 50 61 63 6B 61 72 64 00
		"Hewlett-Packard"
		31 34 38 41 00
		"148A"
		37 39 2E 34 42 00
		"79.4B"
		50 42 4E 4C 46 31 31 32 37 5A 50 42 50 31 20 20
		20 20 20 00
		"PBNLF1127ZPBP1     "
		42 61 73 65 20 42 6F 61 72 64 20 41 73 73 65 74
		20 54 61 67 00
		"Base Board Asset Tag"
		42 61 73 65 20 42 6F 61 72 64 20 43 68 61 73 73
		69 73 20 4C 6F 63 61 74 69 6F 6E 00
		"Base Board Chassis Location"

Handle 0x0003, DMI type 3, 22 bytes
	Header and Data:
		03 16 03 00 01 0A 02 03 04 03 03 03 03 2B 00 00
		00 00 01 00 00 00
	Strings:
		48 65 77 6C 65 74 74 2D 50 61 63 6B 61 72 64 00
		"Hewlett-Packard"
		43 68 61 73 73 69 73 20 56 65 72 73 69 6F 6E 00
		"Chassis Version"
		43 68 61 73 73 69 73 20 53 65 72 69 61 6C 20 4E
		75 6D 62 65 72 00
		"Chassis Serial Number"
		43 68 61 73 73 69 73 20 41 73 73 65 74 20 54 61
		67 00
		"Chassis Asset Tag"

Handle 0x0004, DMI type 9, 17 bytes
	Header and Data:
		09 11 04 00 01 A5 08 03 01 00 00 00 03 FF FF FF
		FF
	Strings:
		4A 37 00
		"J7"

Handle 0x0005, DMI type 10, 6 bytes
	Header and Data:
		0A 06 05 00 83 01
	Strings:
		56 69 64 65 6F 20 47 72 61 70 68 69 63 73 20 43
		6F 6E 74 72 6F 6C 6C 65 72 00
		"Video Graphics Controller"

Handle 0x0006, DMI type 10, 6 bytes
	Header and Data:
		0A 06 06 00 85 01
	Strings:
		52 65 61 6C 74 65 6B 20 4C 61 6E 20 43 6F 6E 74
		72 6F 6C 6C 65 72 00
		"Realtek Lan Controller"

Handle 0x0007, DMI type 11, 5 bytes
	Header and Data:
		0B 05 07 00 05
	Strings:
		24 48 50 24 00
		"$HP$"
		4C 4F 43 23 20 20 20 00
		"LOC#   "
		41 42 53 20 37 30 2F 37 31 20 37 38 20 37 39 20
		37 41 20 37 42 00
		"ABS 70/71 78 79 7A 7B"
		43 4E 42 31 20 30 35 38 46 31 31 30 30 30 30 32
		30 32 42 30 30 30 30 30 33 30 30 31 30 30 00
		"CNB1 058F110000202B00000300100"
		48 50 5F 4D 75 74 65 5F 4C 45 44 5F 50 5F 47 00
		"HP_Mute_LED_P_G"

Handle 0x0008, DMI type 22, 26 bytes
	Header and Data:
		16 1A 08 00 01 02 00 00 03 06 F6 09 30 2A 04 00
		A2 08 6C 3D 05 01 FF FF 00 00
	Strings:
		50 72 69 6D 61 72 79 00
		"Primary"
		43 50 54 2D 53 32 36 47 00
		"CPT-S26G"
		54 59 30 33 30 32 37 00
		"TY03027"
		31 2E 31 00
		"1.1"
		4C 49 4F 4E 00
		"LION"

Handle 0x0009, DMI type 32, 20 bytes
	Header and Data:
		20 14 09 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00

Handle 0x000A, DMI type 41, 11 bytes
	Header and Data:
		29 0B 0A 00 01 85 01 00 00 00 01
	Strings:
		38 32 35 36 37 4C 4D 20 47 69 67 61 62 69 74 20
		4E 65 74 77 6F 72 6B 20 43 6F 6E 6E 65 63 74 69
		6F 6E 00
		"82567LM Gigabit Network Connection"

Handle 0x000B, DMI type 16, 15 bytes
	Header and Data:
		10 0F 0B 00 03 03 03 00 00 40 00 FF FF 02 00

Handle 0x000C, DMI type 17, 28 bytes
	Header and Data:
		11 1C 0C 00 0B 00 0D 00 40 00 40 00 00 08 0D 00
		01 02 13 80 00 9B 02 03 04 05 06 00
	Strings:
		44 49 4D 4D 31 00
		"DIMM1"
		42 41 4E 4B 20 30 00
		"BANK 0"
		4B 69 6E 67 73 74 6F 6E 00
		"Kingston"
		34 39 33 33 39 36 35 37 30 30 00
		"4933965700"
		55 6E 6B 6E 6F 77 6E 00
		"Unknown"
		20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
		20 20 00
		"                  "

Handle 0x000D, DMI type 18, 23 bytes
	Header and Data:
		12 17 0D 00 03 02 02 00 00 00 00 00 00 00 80 00
		00 00 80 00 00 00 80

Handle 0x000E, DMI type 20, 19 bytes
	Header and Data:
		14 13 0E 00 00 00 00 00 FF FF 1F 00 0C 00 10 00
		01 00 00

Handle 0x000F, DMI type 18, 23 bytes
	Header and Data:
		12 17 0F 00 03 02 02 00 00 00 00 00 00 00 80 00
		00 00 80 00 00 00 80

Handle 0x0010, DMI type 19, 15 bytes
	Header and Data:
		13 0F 10 00 00 00 00 00 FF FF 1F 00 0B 00 02

Handle 0x0011, DMI type 4, 42 bytes
	Header and Data:
		04 2A 11 00 03 03 B9 02 CA 06 01 00 FF FB E9 BF
		01 90 9B 02 82 06 82 06 41 0F 13 00 12 00 FF FF
		00 04 00 01 01 02 04 00 B9 00
	Strings:
		49 6E 74 65 6C 28 52 29 20 41 74 6F 6D 28 54 4D
		29 20 43 50 55 20 4E 34 35 35 20 20 20 40 20 31
		2E 36 36 47 48 7A 00
		"Intel(R) Atom(TM) CPU N455   @ 1.66GHz"
		49 6E 74 65 6C 28 52 29 20 43 6F 72 70 6F 72 61
		74 69 6F 6E 00
		"Intel(R) Corporation"
		43 50 55 00
		"CPU"
		46 46 46 46 00
		"FFFF"

Handle 0x0012, DMI type 7, 19 bytes
	Header and Data:
		07 13 12 00 01 81 01 00 02 00 02 20 00 20 00 00
		05 05 07
	Strings:
		55 6E 6B 6E 6F 77 6E 00
		"Unknown"

Handle 0x0013, DMI type 7, 19 bytes
	Header and Data:
		07 13 13 00 01 80 01 20 00 20 00 20 00 20 00 00
		05 03 07
	Strings:
		55 6E 6B 6E 6F 77 6E 00
		"Unknown"

Handle 0x0014, DMI type 127, 4 bytes
	Header and Data:
		7F 04 14 00
=3D=3D=3D

>Abra=E7os,
>Gustavo
>

Thanks.
Pedja
