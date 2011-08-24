From: Kristian Amlie <kristian@amlie.name>
Subject: Re: How to add a new MIDI device to the usbaudio driver
Date: Wed, 24 Aug 2011 15:19:06 +0200
Message-ID: <4E54FA4A.5000809@amlie.name>
References: <4E5234F0.8000502@amlie.name>	<CACTFLAMA08qqaNALA1dksxVN_yAwXnONxXadeuUb1Owkz6VwsA@mail.gmail.com>	<4E52401C.8030605@amlie.name>	<4E537524.9010303@ladisch.de>	<4E537BE9.4050004@amlie.name>
	<CACTFLAPzug5yxmhxDKocdLt-eoHXr6nOwmyOqWkEJ_vjqNff6w@mail.gmail.com>
	<4E53959A.7090702@amlie.name> <4E54E437.7020209@ladisch.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060500090508040502060809"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from oproxy4-pub.bluehost.com (oproxy4-pub.bluehost.com
	[69.89.21.11]) by alsa0.perex.cz (Postfix) with SMTP id 77E092469F
	for <alsa-devel@alsa-project.org>;
	Wed, 24 Aug 2011 15:19:20 +0200 (CEST)
In-Reply-To: <4E54E437.7020209@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------060500090508040502060809
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On 08/24/11 13:44, Clemens Ladisch wrote:
> Kristian Amlie wrote:
>> I tried 38400 baud, and that seemed to work. I got a small number
>> of bytes everytime I pressed a key on the instrument.
>>
>> 18 f9 ff 18 03 f8
>> 18 f9 ff 18 01 f8
>> 18 f9 ff 18 01 f8
>> 18 fb ff 18 01 f8
>> 18 fb ff 18 01 f8
>> 18 fb ff 18 03 f8
>> 18 f9 ff 18 01 f8
>> 18 fb ff 18 01 f8
>> 18 fb ff 18 01 f8
>> 18 fb ff 18 01 f8
> 
> This is not MIDI.  However, these value might by explained by
> a 31250-baud signal sampled at 38400 baud.

Indeed. I have tried different baud rates and that produces different
values. I'm starting to suspect that the "cu" tool itself does not
support certain baud rates, even if the ftdi_sio driver does.

>> Daniel Mack wrote:
>>> I think that requires a special divider setup that is not
>>> supported by the ftdi_sio driver.
> 
> Indeed.
> 
> Kristian, what do the .inf files that come with the Windows driver say?

I have attached the three files that come with the installation. I'm not
sure what to look for myself, I'm afraid.

At least FTDI is mentioned all over the place so we must be on the right
track.

-- 
Kristian

--------------060500090508040502060809
Content-Type: text/plain;
 name="FTDIBUS.INF.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="FTDIBUS.INF.txt"

; FTDIBUS.INF
; Copyright (c) 2000-2006 FTDI Ltd.
;
; USB serial converter driver installation for Windows 2000 and XP.
;

[Version]
Signature="$Windows NT$"
DriverPackageType=PlugAndPlay
DriverPackageDisplayName=%DESC%
Class=USB
ClassGUID={36fc9e60-c465-11cf-8056-444553540000}
Provider=%FTDI%
CatalogFile=ftdibus.cat
DriverVer=05/19/2006,2.00.00

[SourceDisksNames]
1=%DriversDisk%,,,

[SourceDisksFiles]
ftdibus.sys = 1
ftdiunin.exe = 1
ftdiun2k.ini = 1
ftbusui.dll = 1
ftd2xx.dll = 1

[DestinationDirs]
FtdiBus.NT.Copy = 10,system32\drivers
FtdiBus.NT.Copy2 = 10,system32

[Manufacturer]
%Ftdi%=FtdiHw

[FtdiHw]
%USB\VID_0403&PID_B8D8.DeviceDesc%=FtdiBus,USB\VID_0403&PID_B8D8

[ControlFlags]
ExcludeFromSelect=*

[FtdiBus.NT]
CopyFiles=FtdiBus.NT.Copy,FtdiBus.NT.Copy2
AddReg=FtdiBus.NT.AddReg,FtdiBusUnInst.NT.Reg

[FtdiBus.NT.Services]
AddService = FTDIBUS, 0x00000002, FtdiBus.NT.AddService

[FtdiBus.NT.AddService]
DisplayName = %SvcDesc%
ServiceType = 1 ; SERVICE_KERNEL_DRIVER
StartType = 3 ; SERVICE_DEMAND_START
ErrorControl = 1 ; SERVICE_ERROR_NORMAL
ServiceBinary = %10%\system32\drivers\ftdibus.sys
LoadOrderGroup = Base

[FtdiBus.NT.AddReg]
HKR,,DevLoader,,*ntkern
HKR,,NTMPDriver,,ftdibus.sys
HKR,,EnumPropPages32,,"ftbusui.dll,FTBUSUIPropPageProvider"

[FtdiBus.NT.Copy]
ftdibus.sys

[FtdiBus.NT.Copy2]
ftdiunin.exe
ftdiun2k.ini
ftbusui.dll
ftd2xx.dll

[FtdiBusUnInst.NT.Reg]
HKLM,%WINUN%,"FTDICOMM"
HKLM,%WINUN%\FTDICOMM , "UninstallString",,"%11%\ftdiunin.exe %11%\ftdiun2k.ini"
HKLM,%WINUN%\FTDICOMM , "DisplayName",,"FTDI USB Serial Converter Drivers"
HKLM,%WINUN%\FTDICOMM , "URLInfoAbout",,"http://www.ftdichip.com"
HKLM,%WINUN%\FTDICOMM , "Publisher",,"FTDI Ltd"
HKLM,%WINUN%\FTDICOMM , "DisplayVersion",,"2.00.00"

[Strings]
Ftdi="FTDI"
DESC="CDM Driver Package"
DriversDisk="FTDI USB Drivers Disk"
USB\VID_0403&PID_B8D8.DeviceDesc="USB Serial Converter"
WINUN="Software\Microsoft\Windows\CurrentVersion\Uninstall"
SvcDesc="USB Serial Converter Driver"
ClassName="USB"

--------------060500090508040502060809
Content-Type: text/plain;
 name="FTDIPORT.INF.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="FTDIPORT.INF.txt"

; FTDIPORT.INF
; Copyright (c) 2000-2006 FTDI Ltd.
;
; USB serial port driver installation for Windows 2000 and XP.
;

[Version]
Signature="$Windows NT$"
DriverPackageType=PlugAndPlay
DriverPackageDisplayName=%DESC%
Class=Ports
ClassGUID={4d36e978-e325-11ce-bfc1-08002be10318}
Provider=%FTDI%
CatalogFile=ftdiport.cat
DriverVer=05/19/2006,2.00.00

[SourceDisksNames]
1=%DriversDisk%,,,

[SourceDisksFiles]
ftser2k.sys=1
ftserui2.dll=1
FTLang.Dll = 1
ftcserco.dll = 1

[DestinationDirs]
FtdiPort.NT.Copy=10,system32\drivers
FtdiPort.NT.CopyUI=10,system32

[ControlFlags]
ExcludeFromSelect=*

[Manufacturer]
%FTDI%=FtdiHw

[FtdiHw]
%VID_0403&PID_B8D8.DeviceDesc%=FtdiPort232,FTDIBUS\COMPORT&VID_0403&PID_B8D8

[FtdiPort.NT.AddService]
DisplayName    = %SvcDesc%
ServiceType    = 1                  ; SERVICE_KERNEL_DRIVER
StartType      = 3                  ; SERVICE_DEMAND_START
ErrorControl   = 1                  ; SERVICE_ERROR_NORMAL
ServiceBinary  = %10%\system32\drivers\ftser2k.sys
LoadOrderGroup = Base

; -------------- Serenum Driver install section
[SerEnum_AddService]
DisplayName    = %SerEnum.SvcDesc%
ServiceType    = 1               ; SERVICE_KERNEL_DRIVER
StartType      = 3               ; SERVICE_DEMAND_START
ErrorControl   = 1               ; SERVICE_ERROR_NORMAL
ServiceBinary  = %12%\serenum.sys
LoadOrderGroup = PNP Filter

[FtdiPort.NT.AddReg]
HKR,,EnumPropPages32,,"ftserui2.dll,SerialPortPropPageProvider"

[FtdiPort.NT.Copy]
ftser2k.sys
;serenum.sys

[FtdiPort.NT.CopyUI]
ftserui2.dll
FTLang.dll

[FtdiPort232.NT]
CopyFiles=FtdiPort.NT.Copy,FtdiPort.NT.CopyUI
AddReg=FtdiPort.NT.AddReg

[FtdiPort232.NT.HW]
AddReg=FtdiPort232.NT.HW.AddReg

[FtdiPort232.NT.Services]
AddService = FTSER2K, 0x00000002, FtdiPort.NT.AddService
AddService = Serenum,,SerEnum_AddService
DelService = FTSERIAL

[FtdiPort232.NT.HW.AddReg]
HKR,,"UpperFilters",0x00010000,"serenum"
;HKR,,"ConfigData",1,01,04,00,00,10,27,88,13,C4,09,E2,04,71,02,38,41,9c,80,4E,C0,34,00,1A,00,0D,00,06,40,03,80,00,00,d0,80
HKR,,"ConfigData",1,11,04,00,00,10,27,00,00,88,13,00,00,C4,09,00,00,E2,04,00,00,71,02,00,00,38,41,00,00,9C,80,00,00,4E,C0,00,00,34,00,00,00,1A,00,00,00,0D,00,00,00,06,40,00,00,03,80,00,00,00,00,00,00,D0,80,00,00
HKR,,"MinReadTimeout",0x00010001,0
HKR,,"MinWriteTimeout",0x00010001,0
HKR,,"LatencyTimer",0x00010001,2

;---------------------------------------------------------------;

[Strings]
FTDI="FTDI"
DESC="CDM Driver Package"
DriversDisk="FTDI USB Drivers Disk"
PortsClassName = "Ports (COM & LPT)"
VID_0403&PID_B8D8.DeviceDesc="USB Serial Port"
SvcDesc="USB Serial Port Driver"
SerEnum.SvcDesc="Serenum Filter Driver"



--------------060500090508040502060809
Content-Type: text/plain;
 name="dmusftdi.inf.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dmusftdi.inf.txt"

; -------------------------------------------------------------
; DMUSFTDI.INF
; Installs core Digital Music and FTDI support files.
; Copyright (c) 2006 Starr Labs
; -------------------------------------------------------------

[Version]
Signature="$CHICAGO$"
Class=MEDIA
ClassGUID={4d36e96c-e325-11ce-bfc1-08002be10318}
Provider=%STARRLABS%
CatalogFile=dmusftdi.cat
DriverVer = 05/29/2007, 1.01.0.0001


;You must specify which platform is supported by each SourceDisksNames section
;Valid platform identifiers include .x86, .ia64, .alpha, .axp64
[SourceDisksNames.x86]
222="Starr Labs Driver Disk","",222

;You must also specify which platform is supported by each SourceDisksFiles section
;Valid platform identifiers include .x86, .ia64, .alpha, .axp64
[SourceDisksFiles.x86]
dmusftdi.sys=222

[Manufacturer]
%MfgName%=StarrLabs


[StarrLabs]
%DMUSFTDI.DeviceDesc%=DMUSFTDI,,DMUS0100

[DMUSFTDI]
AlsoInstall=ks.registration(ks.inf),wdmaudio.registration(wdmaudio.inf)
CopyFiles=DMUSFTDI.CopyList
AddReg=DMUSFTDI.AddReg

[DMUSFTDI.Interfaces]
AddInterface=%KSCATEGORY_AUDIO%,%KSNAME_UART%,DMUS.I.UART
AddInterface=%KSCATEGORY_RENDER%,%KSNAME_UART%,DMUS.I.UART
AddInterface=%KSCATEGORY_CAPTURE%,%KSNAME_UART%,DMUS.I.UART
AddInterface=%KSCATEGORY_AUDIO%,%KSNAME_Topology%,DMUS.I.Topo

[DMUS.I.UART]
AddReg=DMUS.I.UART.AddReg
[DMUS.I.UART.AddReg]
HKR,,CLSID,,%Proxy.CLSID%
HKR,,FriendlyName,,%DMUS.UART.szPname%

[DMUS.I.Topo]
AddReg=DMUS.I.Topo.AddReg
[DMUS.I.Topo.AddReg]
HKR,,CLSID,,%Proxy.CLSID%
HKR,,FriendlyName,,%DMUS.Topo.szPname%

[DMUS.I.DMusic]
AddReg=DMUS.I.DMusic.AddReg
[DMUS.I.DMusic.AddReg]
HKR,,CLSID,,%Proxy.CLSID%
HKR,,FriendlyName,,%DMUS.DMusic.szPname%

[DMUS.I.Wave]
AddReg=DMUS.I.Wave.AddReg
[DMUS.I.Wave.AddReg]
HKR,,CLSID,,%Proxy.CLSID%
HKR,,FriendlyName,,%DMUS.Wave.szPname%

[DMUS.I.Topo]
AddReg=DMUS.I.Topo.AddReg
[DMUS.I.Topo.AddReg]
HKR,,CLSID,,%Proxy.CLSID%
HKR,,FriendlyName,,%DMUS.Topo.szPname%


; ----------------------------------------------------------------
; Install Windows Multimedia System Support for the Audio Adapter
; ----------------------------------------------------------------

[DMUSFTDI.AddReg]
HKR,,AssociatedFilters,,"wdmaud,swmidi,redbook"
HKR,,Driver,,dmusftdi.sys
HKR,,NTMPDriver,,"dmusftdi.sys,sbemul.sys"

HKR,Drivers,SubClasses,,"wave,midi,mixer,aux"

HKR,Drivers\wave\wdmaud.drv,Driver,,wdmaud.drv
HKR,Drivers\midi\wdmaud.drv,Driver,,wdmaud.drv
HKR,Drivers\mixer\wdmaud.drv,Driver,,wdmaud.drv
HKR,Drivers\aux\wdmaud.drv,Driver,,wdmaud.drv

HKR,Drivers\wave\wdmaud.drv,Description,,%DMUSFTDI.DeviceDesc%
HKR,Drivers\midi\wdmaud.drv,Description,,%STARR_MIDI%
HKR,Drivers\mixer\wdmaud.drv,Description,,%DMUSFTDI.DeviceDesc%
HKR,Drivers\aux\wdmaud.drv,Description,,%DMUSFTDI.DeviceDesc%

[DestinationDirs]
DMUSFTDI.CopyList= 10,system32\drivers ; %SystemRoot%\system32\drivers

[DMUSFTDI.CopyList]
dmusftdi.sys


; -------------------------------------------------------------
; NT Install
; -------------------------------------------------------------

[DMUSFTDI.NTx86]
Include=ks.inf,wdmaudio.inf
Needs=KS.Registration, WDMAUDIO.Registration
CopyFiles=DMUSFTDI.CopyList
AddReg=DMUSFTDI.AddReg

[DMUSFTDI.NTx86.Interfaces]
AddInterface=%KSCATEGORY_AUDIO%,%KSNAME_UART%,DMUS.I.UART
AddInterface=%KSCATEGORY_RENDER%,%KSNAME_UART%,DMUS.I.UART
AddInterface=%KSCATEGORY_CAPTURE%,%KSNAME_UART%,DMUS.I.UART
AddInterface=%KSCATEGORY_AUDIO%,%KSNAME_Topology%,DMUS.I.Topo

[DMUSFTDI.NTx86.Services]
AddService=dmus_ftdi,0x00000002,Dmus_Ftdi_Service_Inst

[Dmus_Ftdi_Service_Inst]
DisplayName=%dmus_ftdi.SvcDesc%
ServiceType=1
StartType=3
ErrorControl=1
ServiceBinary=%10%\system32\drivers\dmusftdi.sys


[Strings]
STARRLABS="Starr Labs"
MfgName="Starr Labs"
DMUSFTDI.DeviceDesc="Starr Labs Audio Device"

STARR_MIDI="Starr Labs MIDI Device"

Proxy.CLSID="{17CCA71B-ECD7-11D0-B908-00A0C9223196}"
KSCATEGORY_AUDIO="{6994AD04-93EF-11D0-A3CC-00A0C9223196}"
KSCATEGORY_RENDER="{65E8773E-8F56-11D0-A3B9-00A0C9223196}"
KSCATEGORY_CAPTURE="{65E8773D-8F56-11D0-A3B9-00A0C9223196}"
KSCATEGORY_TOPOLOGY="{DDA54A40-1E4C-11D1-A050-405705C10000}"

KSNAME_DMusic="DMusic"
KSNAME_Wave="Wave"
KSNAME_UART="UART"
KSNAME_FMSynth="FMSynth"
KSNAME_Topology="Topology"

DMUS.DMusic.szPname="Starr Labs DMusic"
DMUS.Wave.szPname="Starr Labs Wave"
DMUS.Topo.szPname="Starr Labs Topology"
STARR_MIDI="Starr Labs MIDI Instrument"
DMUS.UART.szPname="Starr Labs MIDI Device"


dmus_ftdi.SvcDesc="Starr Labs MIDI Device"
MediaCategories="SYSTEM\CurrentControlSet\Control\MediaCategories"

DMUSFTDI.DeviceDesc="Starr Labs MIDI Device"

--------------060500090508040502060809
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------060500090508040502060809--
