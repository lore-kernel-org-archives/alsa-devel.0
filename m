From: "Brian Hinz" <bphinz@hotmail.com>
Subject: stac9200 speaker/hp not detected
Date: Tue, 03 Jul 2007 23:08:42 -0400
Message-ID: <BAY105-F1496C298D811B5DE533EBAC8030@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bay0-omc3-s3.bay0.hotmail.com (bay0-omc3-s3.bay0.hotmail.com
	[65.54.246.203])
	by alsa0.perex.cz (Postfix) with ESMTP id 02DD31038A1
	for <alsa-devel@alsa-project.org>;
	Wed,  4 Jul 2007 05:08:46 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I'm trying to get the sound working on my Gateway S-7110M (a.k.a. NX100X?).  
Using the ini files from the windows driver, I created the following patch 
(applied to both the hg tree, and 1.0.14):

--- a/alsa-kernel/pci/hda/patch_sigmatel.c      2007-07-03 
21:59:21.000000000 -0400
+++ b/alsa-kernel/pci/hda/patch_sigmatel.c      2007-06-04 
03:28:54.000000000 -0400
@@ -39,6 +39,7 @@

enum {
        STAC_REF,
+       STAC_M4,
        STAC_9200_MODELS
};

@@ -453,12 +452,19 @@
        0x02a19020, 0x01a19021, 0x90100140, 0x01813122,
};

+static unsigned int stac9200_M4_pin_configs[8] = {
+       0x400000fe, 0x00451030, 0x400100f0, 0x90110010,
+       0x400100f1, 0x02a1902e, 0x500000f2, 0x500000f3,
+};
+
static unsigned int *stac9200_brd_tbl[STAC_9200_MODELS] = {
        [STAC_REF] = ref9200_pin_configs,
+       [STAC_M4] = stac9200_M4_pin_configs,
};

static const char *stac9200_models[STAC_9200_MODELS] = {
        [STAC_REF] = "ref",
+       [STAC_M4] = "m4",
};

static struct snd_pci_quirk stac9200_cfg_tbl[] = {
@@ -494,6 +486,9 @@
        SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x01f5,
                      "Dell Inspiron 1501", STAC_REF),

+       /* Gateway */
+       SND_PCI_QUIRK(0x107b, 0x0205, "Gateway S-7110M", STAC_M4),
+
        /* Panasonic */
        SND_PCI_QUIRK(0x10f7, 0x8338, "Panasonic CF-74", STAC_REF),

however it still does not work.  I can see in dmesg that the speaker and 
headphones are not detected, but I can't seem to figure out why:

[95006.300000] ALSA 
/home/bphinz/alsa/alsa-hg/alsa-driver/pci/hda/hda_codec.c:1810: hda_codec: 
model 'm4' is selected
[95006.300000] ALSA 
/home/bphinz/alsa/alsa-hg/alsa-driver/pci/hda/hda_codec.c:2339: autoconfig: 
line_outs=1 (0xe/0x0/0x0/0x0/0x0)
[95006.300000] ALSA 
/home/bphinz/alsa/alsa-hg/alsa-driver/pci/hda/hda_codec.c:2343:    
speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[95006.300000] ALSA 
/home/bphinz/alsa/alsa-hg/alsa-driver/pci/hda/hda_codec.c:2347:    hp_outs=0 
(0x0/0x0/0x0/0x0/0x0)
[95006.300000] ALSA 
/home/bphinz/alsa/alsa-hg/alsa-driver/pci/hda/hda_codec.c:2355:    inputs: 
mic=0x0, fmic=0x10, line=0x0, fline=0x0, cd=0x0, aux=0x0
[95006.432000] ALSA 
/home/bphinz/alsa/alsa-hg/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/patch_si3054.c:244: 
si3054: cannot initialize. EXT MID = 0000
[95006.432000] ALSA 
/home/bphinz/alsa/alsa-hg/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/patch_si3054.c:256: 
Link Frame Detect(FDT) is not ready (line status: 0000)

This laptop has only an internal speaker, a headphone out, and a mic in 
(unless there are other outs enabled when the dock is connected).  The 
windows INI seems to be setting some gpio bits but I don't understand how to 
map the ini syntax into the alsa driver (or if it needs to be...)

[Models]
HDAUDIO\FUNC_01&VEN_8384&DEV_7690=this
Default=this
[CopyFiles.32]
stacgui.cpl = 0x25
stlang.dll = 0x25
stacsv.exe = 0x25
[CopyFiles.64]
stacui64.cpl = 0x25
stlang64.dll = 0x25
stacsv64.exe = 0x25
[LaunchProgramsAfter.32]
STacSV -r
[LaunchProgramsAfter.64]
STacSV64 -r
[HKLM\Software\Microsoft\Windows\CurrentVersion\Run.32]
[HKLM\Software\Microsoft\Windows\CurrentVersion\Run.64]
[DelRegKeys]
HKR\Settings=Yes
HKCU\Software\Sigmatel\Settings=Yes
HKLM\Software\Sigmatel\Presets=Yes
HKCU\Software\Microsoft\Windows\CurrentVersion\Applets\Volume 
Control\SigmaTel Audio=Yes
HKCU\Software\Microsoft\Windows\CurrentVersion\Applets\Volume 
Control\SigmaTel C-Major Audio=Yes
HKCU\Software\Microsoft\Windows\CurrentVersion\Applets\Volume 
Control\SigmaTel High Definition Audio=Yes
[HKLM\Software\Sigmatel\GlobalState]
[HKR]
CodecName = "STAC9200"
[HKR\Settings]
TraceFlags = dword: 0x89B3
CPL_SaveExtraPower = hex: 0
CPL_UserControlsFixedDigitalOutRate = hex: 0
InitVerbs                    = hex: 0x03, 0xa0, 0x43, 0x01
9200MixerCompensation1PcmMode = hex: 2
9200MixerCompensation2PcmMode = hex: 3
CodecAccessAttempts  = dword:00000352
[HKR\Settings\GPIO]
03                                   = hex: 0x85
AntiPopGpo                           = hex: 3,2
[HKR\Settings\pin]
[HKR\Settings\Pin\08]
CfgDflt = dword: 0x400000FE
[HKR\Settings\Pin\09]
CfgDflt = dword: 0x00451030
[HKR\Settings\Pin\0D]
CfgDflt = dword: 0x400100F0
[HKR\Settings\Pin\0E]
CfgDflt = dword: 0x90110010
Action = hex: 81,09
[HKR\Settings\Pin\0F]
CfgDflt = dword: 0x400100F1
[HKR\Settings\Pin\10]
CfgDflt = dword: 0x02A1902E
[HKR\Settings\Pin\11]
CfgDflt = dword: 0x500000F2
[HKR\Settings\Pin\12]
CfgDflt = dword: 0x500000F3
[HKR\Settings\Connselector]
[HKR\settings\filter\Speaker]
UniqueID                             = hex: 0
LegacyIoctlHere                      = hex: 1
Pins                                 = hex: 0E
RenderConverter                      = hex: 2
Associations                         = hex: 1
DigitalVolumeControl                 = hex: 0
EnableSetFormatSupport               = hex: 1
EnableHwSpeakerConfigurationSupport  = hex: 0
EnabledPcmRenderBitsAndRates         = dword: 0x000FFFFE
MasterControlsIndependentMixerInputs = hex: 0
EnableVendorPcBeep                   = hex: 1
PcBeepVolume                         = dword: 0
PcBeepMute                           = hex: 1
EnableInputMonitor                   = hex: 1
RecMonitorMute                 = hex: 1
EnabledNonPcmBitsAndRates            = dword: 0x20040
BiosInterfaceAddress              = dword: 0x000DF7E0
[HKR\settings\filter\SpdifOut]
UniqueID                             = hex: 1
LegacyIoctlHere                      = hex: 0
Pins                                 = hex: 09
SpdifOutConverter                    = hex: 5
SpdifMaster                          = hex:
Associations                         = hex: 3
EnabledPcmRenderSpdifBitsAndRates         = dword: 0x000FFFFF
DisableSPDIFControl                  = hex: 0
[HKR\Settings\filter\MuxedIn]
UniqueID                             = hex: 2
LegacyIoctlHere                      = hex: 0
Pins                                 = hex: 10
CaptureConverter                     = hex: 3
EnableCompositeMuxAndAdcCtrl         = hex: 0
Associations                         = hex: 2
MicBoost                             = hex: 1
DisableMicBoost                 = hex: 0
EnabledPcmCaptureBitsAndRates        = dword: 0x000FFFFF
MicInRecVolume                 = dword: 0x000a8000
[HKR\Settings\filter\MuxedIn\MaxLvlLimiters]
MicBoostLevel                                      = dword: 0x000c0000
[HKR\Settings\filter\MuxedIn\TopoNames]
[HKLM\software\SigmaTel\Apo\GFX\Speaker\plugins\MSAPO]
idEffect = dword: 50
idEffectType = dword: 50
load = dword: 1
order = dword: 5
ApoClsId = "{637c490d-eee3-4c0a-973f-371958802da2}"
[HKLM\software\SigmaTel\Apo\LFX\Speaker\plugins\MSAPO]
idEffect = dword: 50
idEffectType = dword: 50
load = dword: 1
order = dword: 5
ApoClsId = "{62dc1a93-ae24-464c-a43e-452f824c4250}"
[HKLM\software\SigmaTel\Apo\GFX\SpdifOut\plugins\MSAPO]
idEffect = dword: 50
idEffectType = dword: 50
load = dword: 1
order = dword: 5
ApoClsId = "{637c490d-eee3-4c0a-973f-371958802da2}"
[HKLM\software\SigmaTel\Apo\LFX\SpdifOut\plugins\MSAPO]
idEffect = dword: 50
idEffectType = dword: 50
load = dword: 1
order = dword: 5
ApoClsId = "{62dc1a93-ae24-464c-a43e-452f824c4250}"
[HKLM\Software\Sigmatel\APO\GFX\Speaker\plugins\SysEq]
Load = dword: 1
IdEffect = dword: 101
IdEffectType = dword: 1
Order = dword: 1100
[HKLM\Software\Sigmatel\APO\GFX\Speaker\presets\_Initial\SysEq]
NumBands = dword:12
RegVersion = dword: 1
Bypass = dword: 0
[HKLM\Software\Sigmatel\APO\GFX\Speaker\presets\_Initial\SysEq\Band0]
idxBand = dword: 0
Flags = dword: 0
ChannelMask = dword: 262143
Type = dword: 1
GroupId = dword: 0
Freq =dword: 150
GainDbx1000 = dword: -3000
Bandwidthx1000 = dword: 1000
[HKLM\Software\Sigmatel\APO\GFX\Speaker\presets\_Initial\SysEq\Band1]
idxBand = dword: 1
Flags = dword: 0
ChannelMask = dword: 262143
Type = dword: 0
GroupId = dword: 0
Freq =dword: 300
GainDbx1000 = dword: -3000
Bandwidthx1000 = dword: 1000
[HKLM\Software\Sigmatel\APO\GFX\Speaker\presets\_Initial\SysEq\Band2]
idxBand = dword: 2
Flags = dword: 0
ChannelMask = dword: 262143
Type = dword: 0
GroupId = dword: 0
Freq =dword: 500
GainDbx1000 = dword: -2000
Bandwidthx1000 = dword: 1000
[HKLM\Software\Sigmatel\APO\GFX\Speaker\presets\_Initial\SysEq\Band3]
idxBand = dword: 3
Flags = dword: 0
ChannelMask = dword: 262143
Type = dword: 0
GroupId = dword: 0
Freq =dword: 750
GainDbx1000 = dword: -1000
Bandwidthx1000 = dword: 1000
[HKLM\Software\Sigmatel\APO\GFX\Speaker\presets\_Initial\SysEq\Band4]
idxBand = dword: 4
Flags = dword: 0
ChannelMask = dword: 262143
Type = dword: 0
GroupId = dword: 0
Freq =dword: 1000
GainDbx1000 = dword: 0
Bandwidthx1000 = dword: 1000
[HKLM\Software\Sigmatel\APO\GFX\Speaker\presets\_Initial\SysEq\Band5]
idxBand = dword: 5
Flags = dword: 0
ChannelMask = dword: 262143
Type = dword: 0
GroupId = dword: 0
Freq =dword: 2000
GainDbx1000 = dword: -1000
Bandwidthx1000 = dword: 1000
[HKLM\Software\Sigmatel\APO\GFX\Speaker\presets\_Initial\SysEq\Band6]
idxBand = dword: 6
Flags = dword: 0
ChannelMask = dword: 262143
Type = dword: 0
GroupId = dword: 0
Freq =dword: 8000
GainDbx1000 = dword: 0
Bandwidthx1000 = dword: 1000
[HKLM\Software\Sigmatel\APO\GFX\Speaker\presets\_Initial\SysEq\Band7]
idxBand = dword: 7
Flags = dword: 0
ChannelMask = dword: 262143
Type = dword: 0
GroupId = dword: 0
Freq =dword: 12000
GainDbx1000 = dword: 0
Bandwidthx1000 = dword: 1000
[HKLM\Software\Sigmatel\APO\GFX\Speaker\presets\_Initial\SysEq\Band8]
idxBand = dword: 8
Flags = dword: 0
ChannelMask = dword: 262143
Type = dword: 0
GroupId = dword: 0
Freq =dword: 15000
GainDbx1000 = dword: 0
Bandwidthx1000 = dword: 1000
[HKLM\Software\Sigmatel\APO\GFX\Speaker\presets\_Initial\SysEq\Band9]
idxBand = dword: 9
Flags = dword: 0
ChannelMask = dword: 262143
Type = dword: 0
GroupId = dword: 0
Freq =dword: 17000
GainDbx1000 = dword: -1000
Bandwidthx1000 = dword: 1000
[HKLM\Software\Sigmatel\APO\GFX\Speaker\presets\_Initial\SysEq\Band10]
idxBand = dword: 10
Flags = dword: 0
ChannelMask = dword: 262143
Type = dword: 0
GroupId = dword: 0
Freq =dword: 17000
GainDbx1000 = dword: -1000
Bandwidthx1000 = dword: 1000
[HKLM\Software\Sigmatel\APO\GFX\Speaker\presets\_Initial\SysEq\Band11]
idxBand = dword: 11
Flags = dword: 0
ChannelMask = dword: 262143
Type = dword: 2
GroupId = dword: 0
Freq =dword: 17000
GainDbx1000 = dword: -1000
Bandwidthx1000 = dword: 1000
[HKLM\Software\Sigmatel\APO\GFX\Speaker\plugins\Compressor]
Load = dword: 1
IdEffect = dword: 5
Order = dword: 1150
[HKLM\Software\Sigmatel\APO\GFX\Speaker\presets\_Initial\Compressor]
CompRatio= dword: 200
CompAttack= dword: 9910
CompRelease= dword: 9910
CompThreshDb= dword: -600
MakeupGainDb= dword: 200
GateRatio= dword: 600
GateAttack= dword: 9990
GateRelease= dword: 9990
GateThreshDb= dword: -9000
Flags= dword: 8
[HKLM\Software\Sigmatel\APO\GFX\Speaker\plugins\Limiter]
Load = dword: 1
IdEffect = dword: 6
Order = dword: 1155
[HKLM\Software\Sigmatel\APO\GFX\Speaker\presets\_Initial\Limiter]
CompRatio= dword: 3700
CompAttack= dword: 9900
CompRelease= dword: 9900
CompThreshDb= dword: 0
MakeupGainDb= dword: 0
GateRatio= dword: 100
GateAttack= dword: 9000
GateRelease= dword: 9000
GateThreshDb= dword: -9000
Flags= dword: 10
[HKLM\SOFTWARE\SigmaTel\STSysTray\1.0\EventExpressions]
Version=dword:1
[HKLM\SOFTWARE\SigmaTel\STSysTray\1.0\EventExpressions\JackPresenseD]
Action1="if(JackState(13) == 1,(BypassSystemEq(1)),(BypassSystemEq(0)))"
Action2="if(JackState(13) == 1,(BypassSystemComp(1)),(BypassSystemComp(0)))"
[HKLM\SOFTWARE\Sigmatel\STacGUI]
Config_Tab     = dword: 0x8
Config_Spk     = dword: 0x0
Config_Adv     = dword: 0x01
[HKLM\SOFTWARE\Sigmatel\STacGUI\XML]
Nconfigs       = dword: 0x0

here's the output of /proc/asound/card0/codec#0:

Codec: SigmaTel STAC9200
Address: 0
Vendor Id: 0x83847690
Subsystem Id: 0x100
Revision Id: 0x102201
No Modem Function Group found
Default PCM:
    rates [0x7e0]: 44100 48000 88200 96000 176400 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Default Amp-In caps: N/A
Default Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=1
Node 0x02 [Audio Output] wcaps 0xd0401: Stereo
  Power: 0x0
Node 0x03 [Audio Input] wcaps 0x1d0541: Stereo
  Power: 0x0
  Connection: 1
     0x0a
Node 0x04 [Audio Input] wcaps 0x140311: Stereo Digital
  PCM:
    rates [0x160]: 44100 48000 96000
    bits [0xe]: 16 20 24
    formats [0x5]: PCM AC3
  Connection: 1
     0x08
Node 0x05 [Audio Output] wcaps 0x40211: Stereo Digital
  PCM:
    rates [0x1e0]: 44100 48000 88200 96000
    bits [0xe]: 16 20 24
    formats [0x5]: PCM AC3
Node 0x06 [Vendor Defined Widget] wcaps 0xf30201: Stereo Digital
Node 0x07 [Audio Selector] wcaps 0x300901: Stereo
  Connection: 3
     0x02* 0x08 0x0a
Node 0x08 [Pin Complex] wcaps 0x430681: Stereo Digital
  Pincap 0x0810024: IN EAPD Detect
  Pin Default 0x400000fe: [N/A] Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
  Pin-ctls: 0x00:
  Power: 0x0
Node 0x09 [Pin Complex] wcaps 0x400301: Stereo Digital
  Pincap 0x0810: OUT
  Pin Default 0x00451030: [Jack] SPDIF Out at Ext N/A
    Conn = Optical, Color = Black
  Pin-ctls: 0x40: OUT
  Connection: 2
     0x05* 0x0a
Node 0x0a [Audio Selector] wcaps 0x30090d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x0f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x0d 0x0d]
  Connection: 1
     0x0c
Node 0x0b [Audio Selector] wcaps 0x300105: Stereo Amp-Out
  Amp-Out caps: N/A
  Amp-Out vals:  [0x80 0x80]
  Connection: 1
     0x07
Node 0x0c [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x04, stepsize=0x27, mute=0
  Amp-Out vals:  [0x04 0x04]
  Connection: 5
     0x10* 0x0f 0x0e 0x0d 0x12
Node 0x0d [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x083f: IN OUT HP Detect
  Pin Default 0x400100f0: [N/A] Line Out at Ext N/A
    Conn = 1/8, Color = Unknown
  Pin-ctls: 0x00:
  Connection: 1
     0x0b
Node 0x0e [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x083f: IN OUT HP Detect
  Pin Default 0x90110010: [Fixed] Speaker at Int N/A
    Conn = 1/8, Color = Unknown
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x0b
Node 0x0f [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x0837: IN OUT Detect
  Pin Default 0x400100f1: [N/A] Line Out at Ext N/A
    Conn = 1/8, Color = Unknown
  Pin-ctls: 0x20: IN
  Connection: 1
     0x0b
Node 0x10 [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x081737: IN OUT Detect
  Pin Default 0x02a1902e: [Jack] Mic at Ext Front
    Conn = 1/8, Color = Pink
  Pin-ctls: 0x24: IN
  Connection: 1
     0x0b
Node 0x11 [Pin Complex] wcaps 0x400104: Mono Amp-Out
  Amp-Out caps: N/A
  Amp-Out vals:  [0x00]
  Pincap 0x0810: OUT
  Pin Default 0x500000f2: [N/A] Line Out at Int N/A
    Conn = Unknown, Color = Unknown
  Pin-ctls: 0x00:
  Connection: 1
     0x13
Node 0x12 [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x0820: IN
  Pin Default 0x500000f3: [N/A] Line Out at Int N/A
    Conn = Unknown, Color = Unknown
  Pin-ctls: 0x20: IN
Node 0x13 [Audio Mixer] wcaps 0x200100: Mono
  Connection: 1
     0x07
Node 0x14 [Beep Generator Widget] wcaps 0x70000c: Mono Amp-Out
  Amp-Out caps: ofs=0x03, nsteps=0x03, stepsize=0x17, mute=1
  Amp-Out vals:  [0x00]

Thanks for any assistance!
-brian
