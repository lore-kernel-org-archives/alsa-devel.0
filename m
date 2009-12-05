From: Alexey Fisher <bug-track@fisher-privat.net>
Subject: Re: line-in on Intel DG45ID
Date: Sat, 05 Dec 2009 23:14:59 +0100
Message-ID: <1260051299.3187.39.camel@zwerg>
References: <1259568400.4835.25.camel@zwerg> <s5hhbsazqgt.wl%tiwai@suse.de>
	<1259682335.3397.9.camel@zwerg>  <s5h638qzobx.wl%tiwai@suse.de>
	<1259749850.3195.22.camel@mini>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-zToUA7/DuVgP1P3ZTK3I"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id EFAE02433E
	for <alsa-devel@alsa-project.org>; Sat,  5 Dec 2009 23:15:02 +0100 (CET)
In-Reply-To: <1259749850.3195.22.camel@mini>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--=-zToUA7/DuVgP1P3ZTK3I
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Am Mittwoch, den 02.12.2009, 11:30 +0100 schrieb Alexey Fisher:
> Am Dienstag, den 01.12.2009, 16:49 +0100 schrieb Takashi Iwai:
> > At Tue, 01 Dec 2009 16:45:35 +0100,
> > Alexey Fisher wrote:
> > > 
> > > Am Dienstag, den 01.12.2009, 16:03 +0100 schrieb Takashi Iwai:
> > > > At Mon, 30 Nov 2009 09:06:40 +0100,
> > > > Alexey Fisher wrote:
> > > > > 
> > > > > Hi,
> > > > > i recently tried to digitalise some tapes and found line-in not enabled
> > > > > on my board (Intel DG45ID). (Codec: IDT 92HD73E1X5)
> > > > > >From the board documentation i know  blue jack used for line-in or side
> > > > > surround. Even i use normal stereo i can't enable line-in.
> > > > > 
> > > > > So my question, is it really to make a switch between surround and
> > > > > stereo with line-in? I know it should be possible. Or to have this
> > > > > switch for mic input?
> > > > 
> > > > Which ALSA driver version are you using?
> > > > 
> > > > The very latest one should have a "Line Jack Mode", with which you
> > > > can change the input/output via enum control.
> > > 
> > > i use recent alsa-kernel.git, i found this switch.
> > 
> > Check sound GIT tree, to be sure:
> >   git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git
> > 
> > A snapshot tarball for external builds is:
> >   ftp://ftp.kernel.org/pub/linux/kernel/people/tiwai/snapshot/alsa-driver-snapshot.tar.gz
> > 
> > > Currently i trying to
> > > dig deeper in the code. Seems like this board is not really supported...
> > > for normal tasks like stereo in / stereo out - is ok, but surround seems
> > > to be messed up, mixer map too.
> > > For example: "speaker-test -c 6" will produce "Front L/R" on all jacks.
> > 
> > You have to pass -Dsurround51, too.
> 
> Tank you for the tip, speaker-test worked for my Hercules so i thout
> should work for intel too. So with tiwai.git and -Dsurround51 or
> surrounf71 outputs are working. Bad the mixer map is in really bad
> state. Here is my current investigation, here are the controls i tested:
> 
> [jack]  [surround]; [mixers;...]
> green - front r/l;Master; PCM; Speeker 0;
> blue - side r/l ------- PCM; Speaker 3;
> black - rear r/l; Master; PCM; Speaker 1;
> orange - cenrat f/r; Master; PCM; ------; swap;
> ('Swap Center/LFE Playback Switch' (change front and reare outputs))

I need help,

one and half problem solved:
hp_out and mic_in didn't worked on front panel,
mic was silent, and hp did only high frequency noise (sound like
something wrong).
Now front and rear mic working. hp don't do the noise any more but i
still can't get any output from it. 
Mixer is working now too, so i can use three inputs together, but it
seems not supported by driver, so i force selection with: 
hda-verb /dev/snd/hwC0D2 0x20 SET_CONNECT_SEL 0x0b

I used .ini file from windows to set it up, see attachment. There is
cadec dump before and after tweaks, and patch.

regards,
Alexey



--=-zToUA7/DuVgP1P3ZTK3I
Content-Disposition: attachment; filename="I73E-EL1_V.INI"
Content-Type: text/plain; name="I73E-EL1_V.INI"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

[Models]
Default=this
[DelRegKeys]
HKR\Settings=yes
HKLM\Software\IDT=yes
[APPS]
[CopyFiles.32]
stlang.dll = 0x25
stacsv.exe = 0x25
idtcpl.cpl = 0x25
idtmini1.exe = 0x25
[CopyFiles.64]
stlang64.dll = 0x25
stacsv64.exe = 0x25
idtcpl64.cpl = 0x25
idt64mp1.exe = 0x25
[ReplaceDlls.32]
stapo.dll = 0x25
stcplx.dll = 0x25
[ReplaceDlls.64]
stapo64.dll = 0x25
stcplx64.dll = 0x25
[StartServices.32]
STacSV -r
[StartServices.64]
STacSV64 -r
[StopServices.32]
STacSV -u
[StopServices.64]
STacSV64 -u
[HKLM\Software\Microsoft\Windows\CurrentVersion\Run.32]
SysTrayApp="%ProgramFiles%\IDT\WDM\sttray.exe"
[HKLM\Software\Microsoft\Windows\CurrentVersion\Run.64]
SysTrayApp="%ProgramFiles%\IDT\WDM\sttray64.exe"
[HKLM\Software\IDT\State\Shared]
ShowEventDialog = dword: 1
HdmiState	= dword: 1
[HKLM\Software\IDT\State\STACSV]
HdmiSupport	= dword: 1
[HKLM\Software\IDT\State\UI]
MultiStream     = dword: 1
HPSlave 	= dword: 1
DDLSupport 	= dword: 1
[HKLM\Software\IDT\Config\Shared]
PollingPeriod   = dword: 100
UseDriverEvent 	= dword: 1
[HKLM\Software\IDT\Config\STacsv]
HwSpkCfg        = dword: 0
MultiStream     = dword: 1
VIM_Enabled	= dword: 1
[HKLM\Software\IDT\Config\SysTray]
HideTrayIcon    = dword: 0
PopUpType       = dword: 1
[HKLM\Software\IDT\Config\SysTray.32]
ControlPanel    = "idtcpl.cpl"
[HKLM\Software\IDT\Config\SysTray.64]
ControlPanel    = "idtcpl64.cpl"
[StartConsoleApps.32]
IDTPIMA.exe -mode 0 -submode 2 -defaultCapture 0x0E
IDTPIMA.exe -mode 3 -submode 2 -defaultRender 0x0D
IDTPIMA.exe -mode 2 -endpointAssoc 5 -enable 1 -endpointSequence 16
[StartConsoleApps.64]
IDTPMA64.exe -mode 0 -submode 2 -defaultCapture 0x0E
IDTPMA64.exe -mode 3 -submode 2 -defaultRender 0x0D
IDTPMA64.exe -mode 2 -endpointAssoc 5 -enable 1 -endpointSequence 16
[HKLM\Software\IDT\Config\EventExpressions]
Version=dword:1
[HKLM\Software\IDT\Config\EventExpressions\StreamStart0003]
010="MSenabled=GetGlobalRegDword("MultiStream",0)"
020="SetDeviceType(10,2) && SetVerified(10,1)"
030="SetGlobalRegDword("RTCstreamOn",1)"
040="MuteRear=MSEnabled==0 && GetPresence(10)"
050="MutePin(13,MuteRear)"
060="MutePin(15,MuteRear)"
070="MutePin(16,MuteRear)"
080="MutePin(12,MuteRear && (GetDeviceType(12)==1))"
200="SetDolbyHPmode(1,GetPresence(10))"
[HKLM\Software\IDT\Config\EventExpressions\StreamStop0003]
010="if(GetDeviceType(10)==2, (SetDeviceTypeSlaved(10,2) && SetVerified(10,1)), (SetDeviceTypeSlaved(10,1) && SetVerified(10,1)))"
020="MuteRear=GetPresence(10)"
030="MutePin(13,MuteRear)"
040="MutePin(15,MuteRear)"
050="MutePin(16,MuteRear)"
060="MutePin(12,MuteRear && (GetDeviceType(12)==1))"
070="SetGlobalRegDword("RTCstreamOn",0)"
200="SetDolbyHPmode(1,GetPresence(10))"
[HKLM\Software\IDT\Config\EventExpressions\JackPresenceA]
010="MuteRear=(GetPresence(10) && (JackSequence(10)==15))"
020="MutePin(13,MuteRear)"
030="MutePin(15,MuteRear)"
040="MutePin(16,MuteRear)"
050="MutePin(12,MuteRear && (GetDeviceType(12)==1))"
200="SetDolbyHPmode(1,GetPresence(10))"
[HKLM\Software\IDT\Config\EventExpressions\JackDeviceA]
010="RTCStatus=GetGlobalRegDword("RTCstreamOn",0)"
020="nowDT=GetDeviceType(10)"
030="if(RTCStatus==0,(SetDeviceTypeSlaved(10,nowDT) && SetVerified(10,1)),(0))"
040="if((RTCStatus==1 && GetDeviceType(10)==2),(SetDeviceType(10,2) && SetVerified(10,1)),(0))"
050="if((RTCStatus==1 && GetDeviceType(10)==1),(SetDeviceTypeSlaved(10,1) && SetVerified(10,1)),(0))"
060="MuteRear=(GetPresence(10) && (JackSequence(10)==15))"
070="MutePin(13,MuteRear)"
080="MutePin(15,MuteRear)"
090="MutePin(16,MuteRear)"
100="MutePin(12,MuteRear && (GetDeviceType(12)==1))"
200="if((nowDT==1),(SetDolbyHPmode(1,0)),(SetDolbyHPmode(1,GetPresence(10))))"
[HKLM\Software\IDT\Config\EventExpressions\ServiceStartup]
010="SetGlobalRegDword("RTCstreamOn",0)"
020="SetDeviceTypeSlaved(10,2) && SetVerified(10,1)"
030="MuteRear=GetPresence(10)"
040="MutePin(13,MuteRear)"
050="MutePin(15,MuteRear)"
060="MutePin(16,MuteRear)"
070="MutePin(12,MuteRear && (GetDeviceType(12)==1))"
200="if((nowDT==1),(SetDolbyHPmode(1,0)),(SetDolbyHPmode(1,GetPresence(10))))"
[HKR]
CodecName = "92HD73E1X"
[HKR\Settings]
InitVerbs				= hex: 1f,b0,e3,21
TraceFlags                           = dword: 0x89B3
CPL_SaveExtraPower                   = hex: 0
CPL_MaySwitchExtAmpPowerState        = hex: 0
CPL_UserControlsMaySwitchExtAmpPowerState = hex: 0
CPL_SecondsAfter                     = dword: 15
CPL_UserControlsPowerManagementSettings = hex: 0
CPL_SpdifTransmitterEnabledByUser    = hex: 1
CPL_UserControlsFixedDigitalOutRate  = hex: 0
PmEnabledWidget = hex: 0A,0B,0C,0D,0E,0F,10
DelayInMsAfterPortDisabling = dword: 0x40
PlaybackCaptureAssociations	= hex: 51
[HKR\Settings\pin]
[HKR\Settings\Pin\0A]
CfgDflt                         = dword: 0x02214230
CfgCurr                       = dword: 0x0221421F
AltCfg                          = hex: 1F,42,21,02,1F,42,11,02,30,42,21,02
[HKR\Settings\Pin\0B]
CfgDflt                         = dword: 0x02A19240
[HKR\Settings\Pin\0C]
CfgDflt                         = dword: 0x01113214
AltCfg                          = hex: 5E,32,81,01
AssignedDAC			= hex: 0x18
[HKR\Settings\Pin\0D]
CfgDflt                         = dword: 0x01114210
AltCfg                          = hex: 1F,42,21,01
AssignedDAC			= hex: 0x15
[HKR\Settings\Pin\0E]
CfgDflt                         = dword: 0x01A19250
[HKR\Settings\Pin\0F]
CfgDflt                         = dword: 0x01111212
AssignedDAC			= hex: 0x17
[HKR\Settings\Pin\10]
CfgDflt                         = dword: 0x01116211
AssignedDAC			= hex: 0x16
[HKR\Settings\Pin\11]
CfgDflt                         = dword: 0x40F000F0
[HKR\Settings\Pin\12]
CfgDflt                         = dword: 0x40F000F0
[HKR\Settings\Pin\13]
CfgDflt                         = dword: 0x40F000F0
[HKR\Settings\Pin\14]
CfgDflt                         = dword: 0x40F000F0
[HKR\Settings\Pin\22]
CfgDflt                         = dword: 0x014510A0
[HKR\Settings\Pin\23]
CfgDflt                         = dword: 0x074510B0
[HKR\Settings\Pin\24]
CfgDflt                         = dword: 0x40F000F0
[HKR\Settings\GPIO]
[HKR\Settings\Connselector]
[HKR\Settings\filter\Speaker]
LegacyIoctlHere                      = hex: 1
Associations                         = hex: 1
DigitalVolumeControl                 = hex: 0
EnableVendorPcBeep                   = hex: 0
PcBeepMute                           = hex: 1
PcBeepVolume                         = dword: 0xFFFA0000
MasterVolume                         = dword: 0xFFFA0000
EnableInputMonitor		     = hex: 0
RecMonitorMute                       = hex: 1
DisableNonPcmPin                     = hex: 1
EnableSubdeviceOnDevicePresence = hex: 1,0,1,1,1,2,1,4,2,F,1,F
[HKR\Settings\filter\HpOut]
Associations                         = hex: 3
DigitalVolumeControl                 = hex: 0
DisableNonPcmPin                     = hex: 1
EnableOnAltCfgDevPresence = hex: 1
EnableSubdeviceOnDevicePresence = hex: 2,0
[HKR\Settings\filter\MuxedIn]
Associations                         = hex: 5
MicInRecVolume                       = dword: 0x000A8000
LineInRecVolume                      = dword: 0x000A8000
MixInRecVolume                       = dword: 0x000A8000
[HKR\Settings\filter\MuxedIn\MaxLvlLimiters]
MicBoostLevel                   = dword: 0x000A0000
Mic2BoostLevel			= dword: 0x000A0000
LineInRecVolume                 = dword: 0x00127c9b
[HKR\Settings\filter\MuxedIn\TopoNames]
MicIn                                = "{A72A6A9C-896A-45ce-AD88-6BB096B11B36}"
[HKR\Settings\filter\MicIn]
Associations                         = hex: 4
MicInRecVolume                       = dword: 0x000A8000
[HKR\Settings\filter\MicIn\MaxLvlLimiters]
MicBoostLevel                   = dword: 0x000A0000
Mic2BoostLevel			= dword: 0x000A0000
[HKR\Settings\filter\MicIn\TopoNames]
[HKR\Settings\filter\SpdifOut]
Associations                    = hex: A
EnabledNonPcmBitsAndRates	= dword: 0x0020040
LastSpdifPcmChanCnt 		= dword: 0x2
LastSpdifPcmFormat 		= dword: 0x00020020
MasterMuteControlsSpdif 	= hex: 1
[HKR\settings\filter\HdmiOut]
Associations				= hex: B
DisableNonPcmPin                = hex: 0
EnabledNonPcmBitsAndRates       = dword: 0x0020040
MasterMuteControlsSpdif 	= hex: 1
[HKLM\software\IDT\Apo\LFX\MuxedIn\plugins\MonoMic]
idEffect = dword: 30
idEffectType = dword: 30
load = dword: 1
order = dword: 120
[HKLM\software\IDT\Apo\LFX\MuxedIn\Presets\_Initial\MonoMic]
bypass = dword: 1
Patch0 = dword: 0
Patch1 = dword: 0
[HKLM\Software\IDT\Config\UI\MuxedIn]
Config_ExTab = dword: 0x11
[HKLM\software\IDT\Apo\LFX\MicIn\plugins\MonoMic]
idEffect = dword: 30
idEffectType = dword: 30
load = dword: 1
order = dword: 120
[HKLM\software\IDT\Apo\LFX\MicIn\Presets\_Initial\MonoMic]
bypass = dword: 1
Patch0 = dword: 0
Patch1 = dword: 0
[HKLM\Software\IDT\Config\UI\MicIn]
Config_ExTab = dword: 0x11
[HKLM\Software\IDT\Apo\GFX\Speaker\plugins\MSAPO]
idEffect = dword: 50
idEffectType = dword: 50
load = dword: 1
order = dword: 5
ApoClsId = "{637c490d-eee3-4c0a-973f-371958802da2}"
[HKLM\Software\IDT\Apo\LFX\Speaker\plugins\MSAPO]
idEffect = dword: 50
idEffectType = dword: 50
load = dword: 1
order = dword: 5
ApoClsId = "{62dc1a93-ae24-464c-a43e-452f824c4250}"
[HKLM\Software\IDT\Apo\GFX\HpOut\plugins\MSAPO]
idEffect = dword: 50
idEffectType = dword: 50
load = dword: 1
order = dword: 5
ApoClsId = "{637c490d-eee3-4c0a-973f-371958802da2}"
[HKLM\Software\IDT\Apo\LFX\HpOut\plugins\MSAPO]
idEffect = dword: 50
idEffectType = dword: 50
load = dword: 1
order = dword: 5
ApoClsId = "{62dc1a93-ae24-464c-a43e-452f824c4250}"
[HKLM\software\IDT\Apo\LFX\Speaker\Plugins\TwoUp]
idEffect = dword: 25
idEffectType = dword: 25
load = dword: 1
order = dword: 1
znMode00 = dword: 0x612abf42
znMode01 = dword: 0xb15ea410
znMode02 = dword: 0xa0169716
[HKLM\software\IDT\Apo\LFX\Speaker\Presets\_Initial\TwoUp]
Bypass = dword: 0
Detector = dword: 1
Enable = dword: 0
[HKLM\software\IDT\Apo\LFX\Speaker\Plugins\DMS]
idEffect = dword: 14
idEffectType = dword: 14
load = dword: 1
order = dword: 400
role = dword: 400
znMode00 = dword: 0xcf98ca7f
znMode01 = dword: 0x1fecd12d
znMode02 = dword: 0x0ea4e22b
[HKLM\software\IDT\Apo\LFX\Speaker\Presets\_Initial\DMS]
Bypass = dword: 0
CompGain = dword: 2
PL2Enable = dword: 0
SpeakerConfig = dword: 4
VSHPEnable = dword: 0
VSWideEnable = dword: 1
[HKLM\software\IDT\Apo\GFX\Speaker\plugins\DMS2]
idEffect = dword: 24
idEffectType = dword: 24
load = dword: 1
order = dword: 500
role = dword: 500
znMode00 = dword: 0x78318e03
znMode01 = dword: 0xa8459551
znMode02 = dword: 0xb90da657
[HKLM\software\IDT\Apo\GFX\Speaker\Presets\_Initial\DMS2]
Bypass = dword: 0
CompGain = dword: 2
PL2Enable = dword: 0
SpeakerConfig = dword: 4
VSHPEnable = dword: 0
VSWideEnable = dword: 1
[HKLM\software\IDT\Apo\GFX\Speaker\plugins\Rumbler]
idEffect = dword: 27
idEffectType = dword: 27
load = dword: 1
order = dword: 800
role = dword: 701
znMode00 = dword: 0x38653bdd
znMode01 = dword: 0xe811208f
znMode02 = dword: 0xf9591389
[HKLM\software\IDT\Apo\GFX\Speaker\Presets\_Initial\Rumbler]
Bypass = dword: 0
Enable = dword: 0
Cutoff = dword: 6
Boost = dword: 3
Level = dword: 0
VSHPEnable = dword: 0
AutoConfigure = dword: 1
[HKLM\software\IDT\Apo\LFX\HpOut\Plugins\TwoUp]
idEffect = dword: 25
idEffectType = dword: 25
load = dword: 1
order = dword: 1
znMode00 = dword: 0x612abf42
znMode01 = dword: 0xb15ea410
znMode02 = dword: 0xa0169716
[HKLM\software\IDT\Apo\LFX\HpOut\Presets\_Initial\TwoUp]
Bypass = dword: 0
Detector = dword: 1
Enable = dword: 0
[HKLM\software\IDT\Apo\LFX\HpOut\Plugins\DMS]
idEffect = dword: 14
idEffectType = dword: 14
load = dword: 1
order = dword: 400
role = dword: 401
znMode00 = dword: 0xcf98ca7f
znMode01 = dword: 0x1fecd12d
znMode02 = dword: 0x0ea4e22b
[HKLM\software\IDT\Apo\LFX\HpOut\Presets\_Initial\DMS]
Bypass = dword: 0
CompGain = dword: 2
PL2Enable = dword: 0
SpeakerConfig = dword: 0
VSHPEnable = dword: 0
VSWideEnable = dword: 1
[HKLM\software\IDT\Apo\GFX\HpOut\plugins\DMS2]
idEffect = dword: 24
idEffectType = dword: 24
load = dword: 1
order = dword: 500
role = dword: 500
znMode00 = dword: 0x78318e03
znMode01 = dword: 0xa8459551
znMode02 = dword: 0xb90da657
[HKLM\software\IDT\Apo\GFX\HpOut\Presets\_Initial\DMS2]
Bypass = dword: 0
CompGain = dword: 2
PL2Enable = dword: 0
SpeakerConfig = dword: 0
VSHPEnable = dword: 0
VSWideEnable = dword: 1
[HKLM\software\IDT\Apo\GFX\HpOut\plugins\Rumbler]
idEffect = dword: 27
IdEffectType = dword: 27
load = dword: 1
order = dword: 800
role = dword: 701
znMode00 = dword: 0x38653bdd
znMode01 = dword: 0xe811208f
znMode02 = dword: 0xf9591389
[HKLM\software\IDT\Apo\GFX\HpOut\Presets\_Initial\Rumbler]
Bypass = dword: 0
Enable = dword: 0
Cutoff = dword: 6
Boost = dword: 3
Level = dword: 0
VSHPEnable = dword: 0
AutoConfigure = dword: 1
[HKLM\software\IDT\Apo\LFX\SpdifOut\Plugins\DMS]
idEffect = dword: 14
idEffectType = dword: 14
load = dword: 1
order = dword: 400
role = dword: 402
znMode00 = dword: 0xcf98ca7f
znMode01 = dword: 0x1fecd12d
znMode02 = dword: 0x0ea4e22b
[HKLM\software\IDT\Apo\LFX\SpdifOut\Presets\_Initial\DMS]
Bypass = dword: 0
PL2Enable = dword: 1
SpeakerConfig = dword: 4
CompGain = dword: 2
VSHPEnable = dword: 0
VSWideEnable = dword: 1
NoSurroundSwap = dword: 0
HPRoomId = dword:1
HPCrossoverFreq = dword: 100
PL2Mode = dword: 1
PL2PanoramaEnable = dword: 0
PL2Dimension = dword: 3
PL2CenterWidth = dword: 3
PL2CrossoverFreq = dword: 100
StereoDownmixAttenDbx1000 = dword: 0
[HKLM\Software\IDT\Apo\GFX\SpdifOut\Plugins\DDL]
idEffect = dword: 51
idEffectType = dword: 51
load = dword: 1
order = dword: 100000
role = dword: 600
znMode00 = dword: 0x31cc9f43
znMode01 = dword: 0xe1b88411
znMode02 = dword: 0xf0f0b717
[HKLM\Software\IDT\Apo\GFX\SpdifOut\Presets\_Initial\DDL]
Bypass = dword: 0
[HKLM\software\IDT\Apo\LFX\HdmiOut\Plugins\DMS]
idEffect = dword: 14
idEffectType = dword: 14
load = dword: 1
order = dword: 400
role = dword: 402
znMode00 = dword: 0xcf98ca7f
znMode01 = dword: 0x1fecd12d
znMode02 = dword: 0x0ea4e22b
[HKLM\software\IDT\Apo\LFX\HdmiOut\Presets\_Initial\DMS]
Bypass = dword: 0
PL2Enable = dword: 1
SpeakerConfig = dword: 4
CompGain = dword: 2
VSHPEnable = dword: 0
VSWideEnable = dword: 1
NoSurroundSwap = dword: 0
HPRoomId = dword:1
HPCrossoverFreq = dword: 100
PL2Mode = dword: 1
PL2PanoramaEnable = dword: 0
PL2Dimension = dword: 3
PL2CenterWidth = dword: 3
PL2CrossoverFreq = dword: 100
StereoDownmixAttenDbx1000 = dword: 0
[HKLM\Software\IDT\Apo\GFX\HdmiOut\Plugins\DDL]
idEffect = dword: 51
idEffectType = dword: 51
load = dword: 1
order = dword: 100000
role = dword: 600
znMode00 = dword: 0x31cc9f43
znMode01 = dword: 0xe1b88411
znMode02 = dword: 0xf0f0b717
[HKLM\Software\IDT\Apo\GFX\HdmiOut\Presets\_Initial\DDL]
Bypass = dword: 0
[HKLM\Software\IDT\APO\LFX\Speaker\Plugins\Spread]
idEffect                        = dword: 0x8
idEffectType                    = dword: 0x8
load                            = dword: 0x0
order                           = dword: 1000
[HKLM\Software\IDT\APO\LFX\Speaker\Presets\_Initial\Spread]
bypass                          = dword: 0x1
SpoofJackPresence               = dword: 1
SpoofJackPresenceFront          = dword: 1
SpoofJackPresenceCLfe           = dword: 1
SpoofJackPresenceRearPair3      = dword: 1
SpoofJackPresenceSidePair4      = dword: 1
[HKLM\SOFTWARE\IDT\APO\GFX\Speaker\plugins\FFT]
idEffect = dword: 43
idEffectType = dword: 43
load = dword: 1
order = dword: 1115
[HKLM\Software\IDT\APO\GFX\Speaker\Presets\_Initial\FFT]
bypass = dword: 0
[HKLM\SOFTWARE\IDT\APO\GFX\HpOut\plugins\FFT]
idEffect = dword: 43
idEffectType = dword: 43
load = dword: 1
order = dword: 1115
[HKLM\Software\IDT\APO\GFX\HpOut\Presets\_Initial\FFT]
bypass = dword: 0
[HKLM\Software\IDT\APO\GFX\Speaker\Plugins\EQ]
Load = dword: 1
IdEffect = dword: 1
IdEffectType = dword: 1
Order = dword: 1500
[HKLM\Software\IDT\APO\GFX\HpOut\Plugins\EQ]
Load = dword: 1
IdEffect = dword: 1
IdEffectType = dword: 1
Order = dword: 1500
[HKLM\Software\IDT\APO\GFX\SpdifOut\Plugins\EQ]
Load = dword: 0
IdEffect = dword: 1
IdEffectType = dword: 1
Order = dword: 200
[HKLM\Software\IDT\APO\GFX\HdmiOut\Plugins\EQ]
Load = dword: 0
IdEffect = dword: 1
IdEffectType = dword: 1
Order = dword: 200
[HKLM\Software\IDT\APO\GFX\Speaker\Plugins\SpeakerMgr]
Load = dword: 1
IdEffect = dword: 32
IdEffectType = dword: 32
Order = dword: 2000
[HKLM\Software\IDT\APO\GFX\Speaker\Presets\_Initial\SpeakerMgr]
Bypass = dword: 0
RegVersion = dword: 1
DelayDelta = dword: 0
Flags = dword: 0
[HKLM\Software\IDT\APO\GFX\HpOut\Plugins\SpeakerMgr]
Load = dword: 1
IdEffect = dword: 32
IdEffectType = dword: 32
Order = dword: 2000
[HKLM\Software\IDT\APO\GFX\HpOut\Presets\_Initial\SpeakerMgr]
Bypass = dword: 0
RegVersion = dword: 1
DelayDelta = dword: 0
Flags = dword: 0
[HKLM\Software\IDT\Config\UI]
Config_Adv                           = dword: 0x288101
Config_MicLevN                       = dword: 0x4
MicBoost[0]                          = dword: 0xA
MicBoost[1]                          = dword: 0x14
MicBoost[2]                          = dword: 0x1E
MicBoost[3]                          = dword: 0x28
HPSlaveNid                           = dword: 0xA
Config_SpkFlags				 = dword: 0x5A
Config_Dolby				 = dword: 0x5
Config_PortMap = dword: 0x40
[HKLM\Software\IDT\Config\UI\Speaker]
Config_ExTab = dword: 0xC0
[HKLM\Software\IDT\Config\UI\MuxedIn]
Config_ExTab = dword: 0x11
[HKLM\Software\IDT\Config\Shared]
Config_Oem                           = dword: 0x2
[HKLM\Software\IDT\Config\UI\Layout\Panel[0]]
Location = "Front"
Size = "1x2"
[HKLM\Software\IDT\Config\UI\Layout\Panel[1]]
Location = "Rear"
Size = "3x2"
[HKLM\Software\IDT\Config\UI\Layout\Panel[2]]
Location                        = "special0"
Size                            = "1x1"
[HKLM\Software\IDT\Config\UI\Layout\Schema[0]]
Desc = "IDS_CONFIG_OPEN"
[HKLM\Software\IDT\Config\UI\Layout\Schema[0]\Jack[0]]
Panel = dword: 0x0
Row = dword: 0x0
Col = dword: 0x0
Color = "Pink"
Port = dword: 0xB
Dev[0] = "Mic"
[HKLM\Software\IDT\Config\UI\Layout\Schema[0]\Jack[1]]
Panel = dword: 0x0
Row = dword: 0x0
Col = dword: 0x1
Color = "Green"
Port = dword: 0xA
Dev[0] = "HP"
Dev[1] = "Speaker_front"
[HKLM\Software\IDT\Config\UI\Layout\Schema[0]\Jack[2]]
Panel = dword: 0x1
Row = dword: 0x0
Col = dword: 0x0
Color = "black"
Port = dword: 0xF
Dev[0] = "Speaker_rear"
[HKLM\Software\IDT\Config\UI\Layout\Schema[0]\Jack[3]]
Panel = dword: 0x1
Row = dword: 0x1
Col = dword: 0x0
Color = "Orange"
Port = dword: 0x10
Dev[0] = "Speaker_Center"
[HKLM\Software\IDT\Config\UI\Layout\Schema[0]\Jack[4]]
Panel = dword: 0x1
Row = dword: 0x2
Col = dword: 0x0
Color = "Black"
Port = dword: 0x22
Dev[0] = "SpdifOut"
[HKLM\Software\IDT\Config\UI\Layout\Schema[0]\Jack[5]]
Panel = dword: 0x1
Row = dword: 0x0
Col = dword: 0x1
Color = "blue"
Port = dword: 0xC
Dev[0] = "Speaker_Side"
Dev[1] = "LineIn"
[HKLM\Software\IDT\Config\UI\Layout\Schema[0]\Jack[6]]
Panel = dword: 0x1
Row = dword: 0x1
Col = dword: 0x1
Color = "green"
Port = dword: 0xD
Dev[0] = "Speaker_front"
Dev[1] = "HP"
[HKLM\Software\IDT\Config\UI\Layout\Schema[0]\Jack[7]]
Panel = dword: 0x1
Row = dword: 0x2
Col = dword: 0x1
Color = "Pink"
Port = dword: 0xE
Dev[0] = "Mic"
[HKLM\Software\IDT\Config\UI\Layout\Schema[0]\Jack[8]]
Panel                           = dword: 0x2
Row                             = dword: 0x0
Col                             = dword: 0x0
Color                           = "Black"
Port                            = dword: 0x23
Dev[0]                          = "SpdifOut"
[HKLM\Software\IDT\Config\UI\Layout\Schema[1]]
Desc="IDS_CONFIG_51"
[HKLM\Software\IDT\Config\UI\Layout\Schema[1]\Jack[0]]
Panel = dword: 0x0
Row = dword: 0x0
Col = dword: 0x0
Color = "Pink"
Port = dword: 0xB
Dev[0] = "Mic"
[HKLM\Software\IDT\Config\UI\Layout\Schema[1]\Jack[1]]
Panel = dword: 0x0
Row = dword: 0x0
Col = dword: 0x1
Color = "Green"
Port = dword: 0xA
Dev[0] = "HP"
Dev[1] = "Speaker_front"
[HKLM\Software\IDT\Config\UI\Layout\Schema[1]\Jack[2]]
Panel = dword: 0x1
Row = dword: 0x0
Col = dword: 0x0
Color = "black"
Port = dword: 0xF
Dev[0] = "Speaker_rear"
[HKLM\Software\IDT\Config\UI\Layout\Schema[1]\Jack[3]]
Panel = dword: 0x1
Row = dword: 0x1
Col = dword: 0x0
Color = "Orange"
Port = dword: 0x10
Dev[0] = "Speaker_Center"
[HKLM\Software\IDT\Config\UI\Layout\Schema[1]\Jack[4]]
Panel = dword: 0x1
Row = dword: 0x2
Col = dword: 0x0
Color = "Black"
Port = dword: 0x22
Dev[0] = "SpdifOut"
[HKLM\Software\IDT\Config\UI\Layout\Schema[1]\Jack[5]]
Panel = dword: 0x1
Row = dword: 0x0
Col = dword: 0x1
Color = "blue"
Port = dword: 0xC
Dev[0] = "LineIn"
[HKLM\Software\IDT\Config\UI\Layout\Schema[1]\Jack[6]]
Panel = dword: 0x1
Row = dword: 0x1
Col = dword: 0x1
Color = "green"
Port  = dword: 0xD
Dev[0] = "Speaker_front"
Dev[1] = "HP"
[HKLM\Software\IDT\Config\UI\Layout\Schema[1]\Jack[7]]
Panel = dword: 0x1
Row = dword: 0x2
Col = dword: 0x1
Color = "Pink"
Port = dword: 0xE
Dev[0] = "Mic"
[HKLM\Software\IDT\Config\UI\Layout\Schema[1]\Jack[8]]
Panel                           = dword: 0x2
Row                             = dword: 0x0
Col                             = dword: 0x0
Color                           = "Black"
Port                            = dword: 0x23
Dev[0]                          = "SpdifOut"
[HKLM\Software\IDT\Config\UI\Layout\Schema[1]]
Desc="IDS_CONFIG_71"
[HKLM\Software\IDT\Config\UI\Layout\Schema[1]\Jack[0]]
Panel = dword: 0x0
Row = dword: 0x0
Col = dword: 0x0
Color = "Pink"
Port = dword: 0xB
Dev[0] = "Mic"
[HKLM\Software\IDT\Config\UI\Layout\Schema[1]\Jack[1]]
Panel = dword: 0x0
Row = dword: 0x0
Col = dword: 0x1
Color = "Green"
Port = dword: 0xA
Dev[0] = "HP"
Dev[1] = "Speaker_front"
[HKLM\Software\IDT\Config\UI\Layout\Schema[1]\Jack[2]]
Panel = dword: 0x1
Row = dword: 0x0
Col = dword: 0x0
Color = "black"
Port = dword: 0xF
Dev[0] = "Speaker_rear"
[HKLM\Software\IDT\Config\UI\Layout\Schema[1]\Jack[3]]
Panel = dword: 0x1
Row = dword: 0x1
Col = dword: 0x0
Color = "Orange"
Port = dword: 0x10
Dev[0] = "Speaker_Center"
[HKLM\Software\IDT\Config\UI\Layout\Schema[1]\Jack[4]]
Panel = dword: 0x1
Row = dword: 0x2
Col = dword: 0x0
Color = "Black"
Port = dword: 0x22
Dev[0] = "SpdifOut"
[HKLM\Software\IDT\Config\UI\Layout\Schema[1]\Jack[5]]
Panel = dword: 0x1
Row = dword: 0x0
Col = dword: 0x1
Color = "blue"
Port = dword: 0xC
Dev[0] = "Speaker_Side"
[HKLM\Software\IDT\Config\UI\Layout\Schema[1]\Jack[6]]
Panel = dword: 0x1
Row = dword: 0x1
Col = dword: 0x1
Color = "green"
Port  = dword: 0xD
Dev[0] = "Speaker_front"
Dev[1] = "HP"
[HKLM\Software\IDT\Config\UI\Layout\Schema[1]\Jack[7]]
Panel = dword: 0x1
Row = dword: 0x2
Col = dword: 0x1
Color = "Pink"
Port = dword: 0xE
Dev[0] = "Mic"
[HKLM\Software\IDT\Config\UI\Layout\Schema[1]\Jack[8]]
Panel                           = dword: 0x2
Row                             = dword: 0x0
Col                             = dword: 0x0
Color                           = "Black"
Port                            = dword: 0x23
Dev[0]                          = "SpdifOut"

--=-zToUA7/DuVgP1P3ZTK3I
Content-Disposition: attachment; filename="codec_intel_old"
Content-Type: text/plain; name="codec_intel_old"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Codec: IDT 92HD73E1X5
Address: 2
Function Id: 0x1
Vendor Id: 0x111d7676
Subsystem Id: 0x80865002
Revision Id: 0x100202
No Modem Function Group found
Default PCM:
    rates [0x5e0]: 44100 48000 88200 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Default Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
Default Amp-Out caps: ofs=0x7f, nsteps=0x7f, stepsize=0x02, mute=1
GPIO: io=8, o=0, i=0, unsolicited=1, wake=1
  IO[0]: enable=1, dir=1, wake=0, sticky=0, data=0, unsol=0
  IO[1]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
  IO[2]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
  IO[3]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
  IO[4]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
  IO[5]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
  IO[6]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
  IO[7]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
Power-Map: 0x67
Analog Loopback: 0x00
Node 0x0a [Pin Complex] wcaps 0x400183: Stereo Amp-In
  Amp-In caps: N/A
  Amp-In vals:  [0x00 0x00]
  Pincap 0x0000173f: IN OUT HP Detect Trigger ImpSense
    Vref caps: HIZ 50 GRD 80
  Pin Default 0x0221401f: [Jack] HP Out at Ext Front
    Conn = 1/8, Color = Green
    DefAssociation = 0x1, Sequence = 0xf
  Pin-ctls: 0x00: VREF_HIZ
  Unsolicited: tag=01, enabled=1
  Connection: 6
     0x15 0x16 0x17 0x18 0x19* 0x1e
Node 0x0b [Pin Complex] wcaps 0x400183: Stereo Amp-In
  Control: name="Front Mic Jack Mode", index=0, device=0
  Control: name="Front Mic Capture Volume", index=0, device=0
  Amp-In caps: N/A
  Amp-In vals:  [0x03 0x03]
  Pincap 0x0000173f: IN OUT HP Detect Trigger ImpSense
    Vref caps: HIZ 50 GRD 80
  Pin Default 0x02a19020: [Jack] Mic at Ext Front
    Conn = 1/8, Color = Pink
    DefAssociation = 0x2, Sequence = 0x0
  Pin-ctls: 0x24: IN VREF_80
  Unsolicited: tag=03, enabled=1
  Connection: 6
     0x15* 0x16 0x17 0x18 0x19 0x1e
Node 0x0c [Pin Complex] wcaps 0x400183: Stereo Amp-In
  Amp-In caps: N/A
  Amp-In vals:  [0x00 0x00]
  Pincap 0x00001737: IN OUT Detect Trigger ImpSense
    Vref caps: HIZ 50 GRD 80
  Pin Default 0x01113014: [Jack] Speaker at Ext Rear
    Conn = 1/8, Color = Blue
    DefAssociation = 0x1, Sequence = 0x4
  Pin-ctls: 0x40: OUT VREF_HIZ
  Unsolicited: tag=04, enabled=1
  Connection: 6
     0x15 0x16 0x17 0x18* 0x19 0x1e
Node 0x0d [Pin Complex] wcaps 0x400183: Stereo Amp-In
  Amp-In caps: N/A
  Amp-In vals:  [0x00 0x00]
  Pincap 0x0000003f: IN OUT HP Detect Trigger ImpSense
  Pin Default 0x01114010: [Jack] Speaker at Ext Rear
    Conn = 1/8, Color = Green
    DefAssociation = 0x1, Sequence = 0x0
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=05, enabled=1
  Connection: 6
     0x15* 0x16 0x17 0x18 0x19 0x1e
Node 0x0e [Pin Complex] wcaps 0x400183: Stereo Amp-In
  Control: name="Mic Jack Mode", index=0, device=0
  Control: name="Mic Capture Volume", index=0, device=0
  Amp-In caps: N/A
  Amp-In vals:  [0x03 0x03]
  Pincap 0x00001737: IN OUT Detect Trigger ImpSense
    Vref caps: HIZ 50 GRD 80
  Pin Default 0x01a19030: [Jack] Mic at Ext Rear
    Conn = 1/8, Color = Pink
    DefAssociation = 0x3, Sequence = 0x0
  Pin-ctls: 0x24: IN VREF_80
  Unsolicited: tag=02, enabled=1
  Connection: 6
     0x15* 0x16 0x17 0x18 0x19 0x1e
Node 0x0f [Pin Complex] wcaps 0x400183: Stereo Amp-In
  Amp-In caps: N/A
  Amp-In vals:  [0x00 0x00]
  Pincap 0x00000037: IN OUT Detect Trigger ImpSense
  Pin Default 0x01111012: [Jack] Speaker at Ext Rear
    Conn = 1/8, Color = Black
    DefAssociation = 0x1, Sequence = 0x2
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=06, enabled=1
  Connection: 6
     0x15 0x16* 0x17 0x18 0x19 0x1e
Node 0x10 [Pin Complex] wcaps 0x400183: Stereo Amp-In
  Amp-In caps: N/A
  Amp-In vals:  [0x00 0x00]
  Pincap 0x00000037: IN OUT Detect Trigger ImpSense
  Pin Default 0x01116011: [Jack] Speaker at Ext Rear
    Conn = 1/8, Color = Orange
    DefAssociation = 0x1, Sequence = 0x1
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=07, enabled=1
  Connection: 6
     0x15 0x16 0x17* 0x18 0x19 0x1e
Node 0x11 [Pin Complex] wcaps 0x400183: Stereo Amp-In
  Amp-In caps: N/A
  Amp-In vals:  [0x00 0x00]
  Pincap 0x00000037: IN OUT Detect Trigger ImpSense
  Pin Default 0x40f000f0: [N/A] Other at Ext N/A
    Conn = Unknown, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0x00:
  Unsolicited: tag=00, enabled=0
  Connection: 6
     0x15* 0x16 0x17 0x18 0x19 0x1e
Node 0x12 [Pin Complex] wcaps 0x400081: Stereo
  Pincap 0x00000024: IN Detect
  Pin Default 0x40f000f0: [N/A] Other at Ext N/A
    Conn = Unknown, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0x00:
  Unsolicited: tag=00, enabled=0
Node 0x13 [Pin Complex] wcaps 0x400003: Stereo Amp-In
  Amp-In caps: N/A
  Amp-In vals:  [0x00 0x00]
  Pincap 0x00000020: IN
  Pin Default 0x40f000f0: [N/A] Other at Ext N/A
    Conn = Unknown, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0x20: IN
Node 0x14 [Pin Complex] wcaps 0x400003: Stereo Amp-In
  Amp-In caps: N/A
  Amp-In vals:  [0x00 0x00]
  Pincap 0x00000020: IN
  Pin Default 0x40f000f0: [N/A] Other at Ext N/A
    Conn = Unknown, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0x20: IN
Node 0x15 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out R/L
  Control: name="Speaker Playback Volume", index=0, device=0
  Control: name="Speaker Playback Switch", index=0, device=0
  Device: name="STAC92xx Analog", type="Audio", device=0
  Amp-Out caps: N/A
  Amp-Out vals:  [0x64 0x00]
  Converter: stream=0, channel=0
  Power: setting=D0, actual=D0
  Delay: 13 samples
Node 0x16 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out R/L
  Control: name="Speaker Playback Volume", index=1, device=0
  Control: name="Speaker Playback Switch", index=1, device=0
  Amp-Out caps: N/A
  Amp-Out vals:  [0x64 0x64]
  Converter: stream=0, channel=0
  Power: setting=D0, actual=D0
  Delay: 13 samples
Node 0x17 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out R/L
  Control: name="Center Playback Volume", index=0, device=0
  Control: name="Center Playback Switch", index=0, device=0
  Control: name="LFE Playback Volume", index=0, device=0
  Control: name="LFE Playback Switch", index=0, device=0
  Control: name="Swap Center/LFE Playback Switch", index=0, device=0
  Amp-Out caps: N/A
  Amp-Out vals:  [0x64 0x64]
  Converter: stream=0, channel=0
  Power: setting=D0, actual=D0
  Delay: 13 samples
Node 0x18 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out R/L
  Control: name="Speaker Playback Volume", index=3, device=0
  Control: name="Speaker Playback Switch", index=3, device=0
  Amp-Out caps: N/A
  Amp-Out vals:  [0x7f 0x7f]
  Converter: stream=0, channel=0
  Power: setting=D0, actual=D0
  Delay: 13 samples
Node 0x19 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out R/L
  Control: name="Headphone Playback Volume", index=0, device=0
  Control: name="Headphone Playback Switch", index=0, device=0
  Amp-Out caps: N/A
  Amp-Out vals:  [0x64 0x64]
  Converter: stream=0, channel=0
  Power: setting=D0, actual=D0
  Delay: 13 samples
Node 0x1a [Audio Input] wcaps 0x1d0541: Stereo
  Device: name="STAC92xx Analog", type="Audio", device=0
  Converter: stream=0, channel=0
  SDI-Select: 0
  Power: setting=D0, actual=D0
  Delay: 13 samples
  Connection: 1
     0x20
  Processing caps: benign=0, ncoeff=0
Node 0x1b [Audio Input] wcaps 0x1d0541: Stereo
  Converter: stream=0, channel=0
  SDI-Select: 0
  Power: setting=D0, actual=D0
  Delay: 13 samples
  Connection: 1
     0x21
  Processing caps: benign=0, ncoeff=0
Node 0x1c [Beep Generator Widget] wcaps 0x70000c: Mono Amp-Out
  Amp-Out caps: ofs=0x03, nsteps=0x03, stepsize=0x17, mute=1
  Amp-Out vals:  [0x00]
Node 0x1d [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-In vals:  [0x97 0x97] [0x97 0x97] [0x97 0x97] [0x97 0x97] [0x97 0x97]
  Connection: 5
     0x28 0x29 0x2a 0x2b 0x12
Node 0x1e [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x9f 0x9f]
  Connection: 1
     0x1d
Node 0x1f [Volume Knob Widget] wcaps 0x600000: Mono
  Volume-Knob: delta=1, steps=127, direct=1, val=127
  Connection: 5
     0x15 0x16 0x17 0x18 0x19
Node 0x20 [Audio Selector] wcaps 0x30090d: Stereo Amp-Out R/L
  Control: name="Capture Volume", index=0, device=0
  Control: name="Capture Switch", index=0, device=0
  Amp-Out caps: ofs=0x00, nsteps=0x0f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x0f 0x0f]
  Connection: 12
     0x0a 0x0b 0x0c 0x0d 0x0e* 0x0f 0x10 0x11 0x12 0x13 0x14 0x1d
Node 0x21 [Audio Selector] wcaps 0x30090d: Stereo Amp-Out R/L
  Control: name="Capture Volume", index=1, device=0
  Control: name="Capture Switch", index=1, device=0
  Amp-Out caps: ofs=0x00, nsteps=0x0f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x0f 0x0f]
  Connection: 12
     0x0a 0x0b 0x0c 0x0d 0x0e* 0x0f 0x10 0x11 0x12 0x13 0x14 0x1d
Node 0x22 [Pin Complex] wcaps 0x400301: Stereo Digital
  Pincap 0x00000010: OUT
  Pin Default 0x40f000f0: [N/A] Other at Ext N/A
    Conn = Unknown, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0x00:
  Connection: 3
     0x25* 0x20 0x21
Node 0x23 [Pin Complex] wcaps 0x400301: Stereo Digital
  Pincap 0x00000010: OUT
  Pin Default 0x01451140: [Jack] SPDIF Out at Ext Rear
    Conn = Optical, Color = Black
    DefAssociation = 0x4, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Connection: 3
     0x26* 0x20 0x21
Node 0x24 [Pin Complex] wcaps 0x400681: Stereo Digital
  Pincap 0x00010024: IN EAPD Detect
  EAPD 0x0:
  Pin Default 0x40f000f0: [N/A] Other at Ext N/A
    Conn = Unknown, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0x00:
  Unsolicited: tag=00, enabled=0
  Power: setting=D0, actual=D0
Node 0x25 [Audio Output] wcaps 0x4021d: Stereo Digital Amp-Out
  Control: name="IEC958 Playback Con Mask", index=0, device=0
  Control: name="IEC958 Playback Pro Mask", index=0, device=0
  Control: name="IEC958 Playback Default", index=0, device=0
  Control: name="IEC958 Playback Switch", index=0, device=0
  Control: name="IEC958 Default PCM Playback Switch", index=0, device=0
  Device: name="STAC92xx Digital", type="SPDIF", device=1
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Converter: stream=0, channel=0
  Digital: Enabled
  Digital category: 0x0
  PCM:
    rates [0x5e0]: 44100 48000 88200 96000 192000
    bits [0xe]: 16 20 24
    formats [0x5]: PCM AC3
  Delay: 4 samples
Node 0x26 [Audio Output] wcaps 0x4021d: Stereo Digital Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Converter: stream=0, channel=0
  Digital: Enabled
  Digital category: 0x0
  PCM:
    rates [0x5e0]: 44100 48000 88200 96000 192000
    bits [0xe]: 16 20 24
    formats [0x5]: PCM AC3
  Delay: 4 samples
Node 0x27 [Audio Input] wcaps 0x14031b: Stereo Digital Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00]
  Converter: stream=0, channel=0
  SDI-Select: 0
  Digital:
  Digital category: 0x0
  PCM:
    rates [0x160]: 44100 48000 96000
    bits [0xe]: 16 20 24
    formats [0x5]: PCM AC3
  Delay: 4 samples
  Connection: 1
     0x24
Node 0x28 [Audio Selector] wcaps 0x300101: Stereo
  Connection: 4
     0x0a* 0x0b 0x0d 0x0f
Node 0x29 [Audio Selector] wcaps 0x300101: Stereo
  Connection: 4
     0x0a* 0x0e 0x10 0x11
Node 0x2a [Audio Selector] wcaps 0x300101: Stereo
  Connection: 4
     0x0b* 0x0c 0x10 0x11
Node 0x2b [Audio Selector] wcaps 0x300101: Stereo
  Connection: 4
     0x15* 0x16 0x17 0x18

--=-zToUA7/DuVgP1P3ZTK3I
Content-Disposition: attachment; filename="codec_intel_new"
Content-Type: text/plain; name="codec_intel_new"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Codec: IDT 92HD73E1X5
Address: 2
Function Id: 0x1
Vendor Id: 0x111d7676
Subsystem Id: 0x80865002
Revision Id: 0x100202
No Modem Function Group found
Default PCM:
    rates [0x5e0]: 44100 48000 88200 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Default Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
Default Amp-Out caps: ofs=0x7f, nsteps=0x7f, stepsize=0x02, mute=1
GPIO: io=8, o=0, i=0, unsolicited=1, wake=1
  IO[0]: enable=1, dir=1, wake=0, sticky=0, data=1, unsol=0
  IO[1]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
  IO[2]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
  IO[3]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
  IO[4]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
  IO[5]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
  IO[6]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
  IO[7]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
Power-Map: 0x6d
Analog Loopback: 0x00
Node 0x0a [Pin Complex] wcaps 0x400183: Stereo Amp-In
  Amp-In caps: N/A
  Amp-In vals:  [0x00 0x00]
  Pincap 0x0000173f: IN OUT HP Detect Trigger ImpSense
    Vref caps: HIZ 50 GRD 80
  Pin Default 0x02214230: [Jack] HP Out at Ext Front
    Conn = 1/8, Color = Green
    DefAssociation = 0x3, Sequence = 0x0
  Pin-ctls: 0x00: VREF_HIZ
  Unsolicited: tag=01, enabled=1
  Connection: 6
     0x15 0x16 0x17 0x18 0x19* 0x1e
Node 0x0b [Pin Complex] wcaps 0x400183: Stereo Amp-In
  Amp-In caps: N/A
  Amp-In vals:  [0x00 0x00]
  Pincap 0x0000173f: IN OUT HP Detect Trigger ImpSense
    Vref caps: HIZ 50 GRD 80
  Pin Default 0x02a19240: [Jack] Mic at Ext Front
    Conn = 1/8, Color = Pink
    DefAssociation = 0x4, Sequence = 0x0
  Pin-ctls: 0x24: IN VREF_80
  Unsolicited: tag=03, enabled=1
  Connection: 6
     0x15* 0x16 0x17 0x18 0x19 0x1e
Node 0x0c [Pin Complex] wcaps 0x400183: Stereo Amp-In
  Amp-In caps: N/A
  Amp-In vals:  [0x00 0x00]
  Pincap 0x00001737: IN OUT Detect Trigger ImpSense
    Vref caps: HIZ 50 GRD 80
  Pin Default 0x01113214: [Jack] Speaker at Ext Rear
    Conn = 1/8, Color = Blue
    DefAssociation = 0x1, Sequence = 0x4
  Pin-ctls: 0x40: OUT VREF_HIZ
  Unsolicited: tag=04, enabled=1
  Connection: 6
     0x15 0x16 0x17 0x18* 0x19 0x1e
Node 0x0d [Pin Complex] wcaps 0x400183: Stereo Amp-In
  Amp-In caps: N/A
  Amp-In vals:  [0x00 0x00]
  Pincap 0x0000003f: IN OUT HP Detect Trigger ImpSense
  Pin Default 0x01114210: [Jack] Speaker at Ext Rear
    Conn = 1/8, Color = Green
    DefAssociation = 0x1, Sequence = 0x0
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=05, enabled=1
  Connection: 6
     0x15* 0x16 0x17 0x18 0x19 0x1e
Node 0x0e [Pin Complex] wcaps 0x400183: Stereo Amp-In
  Amp-In caps: N/A
  Amp-In vals:  [0x02 0x02]
  Pincap 0x00001737: IN OUT Detect Trigger ImpSense
    Vref caps: HIZ 50 GRD 80
  Pin Default 0x01a19250: [Jack] Mic at Ext Rear
    Conn = 1/8, Color = Pink
    DefAssociation = 0x5, Sequence = 0x0
  Pin-ctls: 0x24: IN VREF_80
  Unsolicited: tag=02, enabled=1
  Connection: 6
     0x15* 0x16 0x17 0x18 0x19 0x1e
Node 0x0f [Pin Complex] wcaps 0x400183: Stereo Amp-In
  Amp-In caps: N/A
  Amp-In vals:  [0x00 0x00]
  Pincap 0x00000037: IN OUT Detect Trigger ImpSense
  Pin Default 0x01111212: [Jack] Speaker at Ext Rear
    Conn = 1/8, Color = Black
    DefAssociation = 0x1, Sequence = 0x2
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=06, enabled=1
  Connection: 6
     0x15 0x16* 0x17 0x18 0x19 0x1e
Node 0x10 [Pin Complex] wcaps 0x400183: Stereo Amp-In
  Amp-In caps: N/A
  Amp-In vals:  [0x00 0x00]
  Pincap 0x00000037: IN OUT Detect Trigger ImpSense
  Pin Default 0x01116211: [Jack] Speaker at Ext Rear
    Conn = 1/8, Color = Orange
    DefAssociation = 0x1, Sequence = 0x1
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=07, enabled=1
  Connection: 6
     0x15 0x16 0x17* 0x18 0x19 0x1e
Node 0x11 [Pin Complex] wcaps 0x400183: Stereo Amp-In
  Amp-In caps: N/A
  Amp-In vals:  [0x00 0x00]
  Pincap 0x00000037: IN OUT Detect Trigger ImpSense
  Pin Default 0x40f000f0: [N/A] Other at Ext N/A
    Conn = Unknown, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0x00:
  Unsolicited: tag=00, enabled=0
  Connection: 6
     0x15* 0x16 0x17 0x18 0x19 0x1e
Node 0x12 [Pin Complex] wcaps 0x400081: Stereo
  Pincap 0x00000024: IN Detect
  Pin Default 0x4f0000f0: [N/A] Line Out at Ext UNKNOWN
    Conn = Unknown, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0x00:
  Unsolicited: tag=00, enabled=0
Node 0x13 [Pin Complex] wcaps 0x400003: Stereo Amp-In
  Amp-In caps: N/A
  Amp-In vals:  [0x00 0x00]
  Pincap 0x00000020: IN
  Pin Default 0x4f0000f0: [N/A] Line Out at Ext UNKNOWN
    Conn = Unknown, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0x20: IN
Node 0x14 [Pin Complex] wcaps 0x400003: Stereo Amp-In
  Amp-In caps: N/A
  Amp-In vals:  [0x00 0x00]
  Pincap 0x00000020: IN
  Pin Default 0x4f0000f0: [N/A] Line Out at Ext UNKNOWN
    Conn = Unknown, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0x20: IN
Node 0x15 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out R/L
  Amp-Out caps: N/A
  Amp-Out vals:  [0x7f 0x7f]
  Converter: stream=0, channel=0
  Power: setting=D0, actual=D0
  Delay: 13 samples
Node 0x16 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out R/L
  Amp-Out caps: N/A
  Amp-Out vals:  [0x7f 0x7f]
  Converter: stream=0, channel=0
  Power: setting=D0, actual=D0
  Delay: 13 samples
Node 0x17 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out R/L
  Amp-Out caps: N/A
  Amp-Out vals:  [0x7f 0x7f]
  Converter: stream=0, channel=0
  Power: setting=D0, actual=D0
  Delay: 13 samples
Node 0x18 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out R/L
  Amp-Out caps: N/A
  Amp-Out vals:  [0x7f 0x7f]
  Converter: stream=0, channel=0
  Power: setting=D0, actual=D0
  Delay: 13 samples
Node 0x19 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out R/L
  Amp-Out caps: N/A
  Amp-Out vals:  [0x7f 0x7f]
  Converter: stream=0, channel=0
  Power: setting=D0, actual=D0
  Delay: 13 samples
Node 0x1a [Audio Input] wcaps 0x1d0541: Stereo
  Converter: stream=0, channel=0
  SDI-Select: 0
  Power: setting=D0, actual=D0
  Delay: 13 samples
  Connection: 1
     0x20
  Processing caps: benign=0, ncoeff=0
Node 0x1b [Audio Input] wcaps 0x1d0541: Stereo
  Converter: stream=0, channel=0
  SDI-Select: 0
  Power: setting=D0, actual=D0
  Delay: 13 samples
  Connection: 1
     0x21
  Processing caps: benign=0, ncoeff=0
Node 0x1c [Beep Generator Widget] wcaps 0x70000c: Mono Amp-Out
  Amp-Out caps: ofs=0x03, nsteps=0x03, stepsize=0x17, mute=1
  Amp-Out vals:  [0x00]
Node 0x1d [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-In vals:  [0x17 0x17] [0x17 0x17] [0x97 0x97] [0x97 0x97] [0x97 0x97]
  Connection: 5
     0x28 0x29 0x2a 0x2b 0x12
Node 0x1e [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x9f 0x9f]
  Connection: 1
     0x1d
Node 0x1f [Volume Knob Widget] wcaps 0x600000: Mono
  Volume-Knob: delta=1, steps=127, direct=0, val=127
  Connection: 5
     0x15 0x16 0x17 0x18 0x19
Node 0x20 [Audio Selector] wcaps 0x30090d: Stereo Amp-Out R/L
  Amp-Out caps: ofs=0x00, nsteps=0x0f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x0f 0x0f]
  Connection: 12
     0x0a 0x0b* 0x0c 0x0d 0x0e 0x0f 0x10 0x11 0x12 0x13 0x14 0x1d
Node 0x21 [Audio Selector] wcaps 0x30090d: Stereo Amp-Out R/L
  Amp-Out caps: ofs=0x00, nsteps=0x0f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x80 0x80]
  Connection: 12
     0x0a 0x0b 0x0c 0x0d 0x0e* 0x0f 0x10 0x11 0x12 0x13 0x14 0x1d
Node 0x22 [Pin Complex] wcaps 0x400301: Stereo Digital
  Pincap 0x00000010: OUT
  Pin Default 0x014510a0: [Jack] SPDIF Out at Ext Rear
    Conn = Optical, Color = Black
    DefAssociation = 0xa, Sequence = 0x0
  Pin-ctls: 0x40: OUT
  Connection: 3
     0x25* 0x20 0x21
Node 0x23 [Pin Complex] wcaps 0x400301: Stereo Digital
  Pincap 0x00000010: OUT
  Pin Default 0x074510b0: [Jack] SPDIF Out at Ext Rear Panel
    Conn = Optical, Color = Black
    DefAssociation = 0xb, Sequence = 0x0
  Pin-ctls: 0x00:
  Connection: 3
     0x26* 0x20 0x21
Node 0x24 [Pin Complex] wcaps 0x400681: Stereo Digital
  Pincap 0x00010024: IN EAPD Detect
  EAPD 0x0:
  Pin Default 0x40f000f0: [N/A] Other at Ext N/A
    Conn = Unknown, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0x00:
  Unsolicited: tag=00, enabled=0
  Power: setting=D0, actual=D0
Node 0x25 [Audio Output] wcaps 0x4021d: Stereo Digital Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Converter: stream=0, channel=0
  Digital:
  Digital category: 0x0
  PCM:
    rates [0x5e0]: 44100 48000 88200 96000 192000
    bits [0xe]: 16 20 24
    formats [0x5]: PCM AC3
  Delay: 4 samples
Node 0x26 [Audio Output] wcaps 0x4021d: Stereo Digital Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Converter: stream=0, channel=0
  Digital:
  Digital category: 0x0
  PCM:
    rates [0x5e0]: 44100 48000 88200 96000 192000
    bits [0xe]: 16 20 24
    formats [0x5]: PCM AC3
  Delay: 4 samples
Node 0x27 [Audio Input] wcaps 0x14031b: Stereo Digital Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00]
  Converter: stream=0, channel=0
  SDI-Select: 0
  Digital:
  Digital category: 0x0
  PCM:
    rates [0x160]: 44100 48000 96000
    bits [0xe]: 16 20 24
    formats [0x5]: PCM AC3
  Delay: 4 samples
  Connection: 1
     0x24
Node 0x28 [Audio Selector] wcaps 0x300101: Stereo
  Connection: 4
     0x0a 0x0b* 0x0d 0x0f
Node 0x29 [Audio Selector] wcaps 0x300101: Stereo
  Connection: 4
     0x0a 0x0e* 0x10 0x11
Node 0x2a [Audio Selector] wcaps 0x300101: Stereo
  Connection: 4
     0x0b 0x0c* 0x10 0x11
Node 0x2b [Audio Selector] wcaps 0x300101: Stereo
  Connection: 4
     0x15* 0x16 0x17 0x18

--=-zToUA7/DuVgP1P3ZTK3I
Content-Disposition: attachment; filename="sound.diff"
Content-Type: text/x-patch; name="sound.diff"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index 86de305..e650845 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -859,6 +859,40 @@ static struct hda_verb dell_eq_core_init[] = {
 	{}
 };
 
+static struct hda_verb intel_dg45id_init[] = {
+	/* connect all inputs to the mixer */
+	/* 0x0b -> mixer */
+	{ 0x28, AC_VERB_SET_CONNECT_SEL, 0x01},
+	/* 0x0e -> mixer */
+	{ 0x29, AC_VERB_SET_CONNECT_SEL, 0x01},
+	/* FIXME: if sorround51 0x0c can be used for line-in
+	 * currently do not working */
+	{ 0x2a, AC_VERB_SET_CONNECT_SEL, 0x01},
+
+	/* connect mixer to the switch */
+	{ 0x20, AC_VERB_SET_CONNECT_SEL, 0x0b},
+
+	/* unmute inputs on mixer */
+	{ 0x1d, AC_VERB_SET_AMP_GAIN_MUTE, 0x7017},
+	{ 0x1d, AC_VERB_SET_AMP_GAIN_MUTE, 0x7117},
+	/* TODO: make option for 0x0c to be line-in
+	 * { 0x1d, AC_VERB_SET_AMP_GAIN_MUTE, 0x7217}, */
+
+	/* FIXME: 0x0a is output */
+	{ 0x1d, 0x707, 0x40},
+
+	/* extra check all DACs */
+	/* 0x18 -> 0x0c */
+	{ 0x0c, AC_VERB_SET_CONNECT_SEL, 0x03},
+	/* 0x15 -> 0x0d */
+	{ 0x0d, AC_VERB_SET_CONNECT_SEL, 0x00},
+	/* 0x16 -> 0x0f */
+	{ 0x0f, AC_VERB_SET_CONNECT_SEL, 0x02},
+	/* 0x17 -> 0x10 */
+	{ 0x10, AC_VERB_SET_CONNECT_SEL, 0x01},
+	{}
+};
+
 static struct hda_verb stac92hd73xx_core_init[] = {
 	/* set master volume and direct control */
 	{ 0x1f, AC_VERB_SET_VOLUME_KNOB_CONTROL, 0xff},
@@ -1530,6 +1564,19 @@ static unsigned int dell_m6_pin_configs[13] = {
 	0x4f0000f0,
 };
 
+/* TODO: _config[1] (PIN 0x0a) still do not working (Front panel speaker/hp),
+ * $.ini provide some variants of this pin: 0x02214230, 0x0221421F, 0x0211421F.
+ * Def. and Seq. should make difference.
+ * Same for _config[4] (0x0d): wariants 0x01114210, 0x0121421f -should be
+ * some hove in sync with 0x0a? _config[3] (0x0c) can be switched to line-in
+ * wariant 0x0181325e. */
+static unsigned int intel_dg45id_pin_configs[14] = {
+	0x02214230, 0x02A19240, 0x01113214, 0x01114210,
+	0x01A19250, 0x01111212, 0x01116211, 0x40f000f0,
+	0x4f0000f0, 0x4f0000f0, 0x4f0000f0, 0x014510A0,
+	0x074510B0, 0x40f000f0
+};
+
 static unsigned int alienware_m17x_pin_configs[13] = {
 	0x0321101f, 0x0321101f, 0x03a11020, 0x03014020,
 	0x90170110, 0x4f0000f0, 0x4f0000f0, 0x4f0000f0,
@@ -1543,6 +1590,7 @@ static unsigned int *stac92hd73xx_brd_tbl[STAC_92HD73XX_MODELS] = {
 	[STAC_DELL_M6_DMIC]	= dell_m6_pin_configs,
 	[STAC_DELL_M6_BOTH]	= dell_m6_pin_configs,
 	[STAC_DELL_EQ]	= dell_m6_pin_configs,
+	[STAC_92HD73XX_INTEL]	= intel_dg45id_pin_configs,
 	[STAC_ALIENWARE_M17X]	= alienware_m17x_pin_configs,
 };
 
@@ -5015,6 +5063,7 @@ again:
 		num_dacs = STAC92HD73_DAC_COUNT;
 	}
 	spec->init = stac92hd73xx_core_init;
+
 	switch (num_dacs) {
 	case 0x3: /* 6 Channel */
 		spec->aloopback_ctl = stac92hd73xx_6ch_loopback;
@@ -5072,6 +5121,11 @@ again:
 			break;
 		}
 		break;
+	case STAC_92HD73XX_INTEL:
+		spec->init = intel_dg45id_init;
+		spec->num_dmics = STAC92HD73XX_NUM_DMICS;
+		spec->num_smuxes = ARRAY_SIZE(stac92hd73xx_smux_nids);
+		break;
 	case STAC_ALIENWARE_M17X:
 		spec->num_dmics = STAC92HD73XX_NUM_DMICS;
 		spec->num_smuxes = ARRAY_SIZE(stac92hd73xx_smux_nids);

--=-zToUA7/DuVgP1P3ZTK3I
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-zToUA7/DuVgP1P3ZTK3I--
