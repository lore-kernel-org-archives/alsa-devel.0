From: Abdelghani Ouchabane <abdelghani@ezono.com>
Subject: "modprobe snd_hda_intel" crashes on my hardware
Date: Tue, 27 Sep 2011 08:41:20 +0200
Message-ID: <4E817010.7030607@ezono.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010604040106060109050504"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ezo.ezono.com (ezo.ezono.com [50.22.105.208])
	by alsa0.perex.cz (Postfix) with ESMTP id B88002440D
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Sep 2011 10:41:28 +0200 (CEST)
Received: from [82.119.190.67] (port=59744 helo=sugi.ezono.net)
	by ezo.ezono.com with esmtpa (Exim 4.69)
	(envelope-from <abdelghani@ezono.com>) id 1R8TED-0004Ao-1Y
	for alsa-devel@alsa-project.org; Tue, 27 Sep 2011 03:41:25 -0500
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

This is a multi-part message in MIME format.
--------------010604040106060109050504
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"


--------------010604040106060109050504
Content-Type: text/x-patch;
 name="linux-2.6.27-sound-ezono.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.6.27-sound-ezono.patch"

diff -auNrp kernel-2.6.26.orig/sound/pci/hda/patch_via.c kernel-2.6.26.new/sound/pci/hda/patch_via.c
--- kernel-2.6.26.orig/sound/pci/hda/patch_via.c	2008-10-17 18:58:06.000000000 +0200
+++ kernel-2.6.26.new/sound/pci/hda/patch_via.c	2008-10-17 19:01:21.000000000 +0200
@@ -891,6 +891,49 @@ static int via_auto_init(struct hda_code
 	return 0;
 }
 
+static int ezono_vt1708_init(struct hda_codec *codec)
+{
+    /* THis is added because Ezono sound card doesn't support auto detection */
+    
+    /* Port_A PW0 */
+    snd_hda_codec_write(codec, 0x1c, 0, AC_VERB_SET_CONFIG_DEFAULT_BYTES_0, 0x00);
+    snd_hda_codec_write(codec, 0x1c, 0, AC_VERB_SET_CONFIG_DEFAULT_BYTES_1, 0xf0);
+    snd_hda_codec_write(codec, 0x1c, 0, AC_VERB_SET_CONFIG_DEFAULT_BYTES_2, 0x00);
+    snd_hda_codec_write(codec, 0x1c, 0, AC_VERB_SET_CONFIG_DEFAULT_BYTES_3, 0x00);
+
+    /* Port_B Pw1 */
+    snd_hda_codec_write(codec, 0x1d, 0, AC_VERB_SET_CONFIG_DEFAULT_BYTES_0, 0x40);
+    snd_hda_codec_write(codec, 0x1d, 0, AC_VERB_SET_CONFIG_DEFAULT_BYTES_1, 0xf0);
+    snd_hda_codec_write(codec, 0x1d, 0, AC_VERB_SET_CONFIG_DEFAULT_BYTES_2, 0xa0);
+    snd_hda_codec_write(codec, 0x1d, 0, AC_VERB_SET_CONFIG_DEFAULT_BYTES_3, 0x00);
+
+    /* Port_D PW3 */
+    snd_hda_codec_write(codec, 0x1f, 0, AC_VERB_SET_CONFIG_DEFAULT_BYTES_0, 0x10);
+    snd_hda_codec_write(codec, 0x1f, 0, AC_VERB_SET_CONFIG_DEFAULT_BYTES_1, 0xf0);
+    snd_hda_codec_write(codec, 0x1f, 0, AC_VERB_SET_CONFIG_DEFAULT_BYTES_2, 0x00);
+    snd_hda_codec_write(codec, 0x1f, 0, AC_VERB_SET_CONFIG_DEFAULT_BYTES_3, 0x01);
+
+    /* Port_E PW4 */
+    snd_hda_codec_write(codec, 0x20, 0, AC_VERB_SET_CONFIG_DEFAULT_BYTES_0, 0x00);
+    snd_hda_codec_write(codec, 0x20, 0, AC_VERB_SET_CONFIG_DEFAULT_BYTES_1, 0xf0);
+    snd_hda_codec_write(codec, 0x20, 0, AC_VERB_SET_CONFIG_DEFAULT_BYTES_2, 0x20);
+    snd_hda_codec_write(codec, 0x20, 0, AC_VERB_SET_CONFIG_DEFAULT_BYTES_3, 0x00);
+
+    /* Port_G PW6 */
+    snd_hda_codec_write(codec, 0x22, 0, AC_VERB_SET_CONFIG_DEFAULT_BYTES_0, 0x02);
+    snd_hda_codec_write(codec, 0x22, 0, AC_VERB_SET_CONFIG_DEFAULT_BYTES_1, 0xf0);
+    snd_hda_codec_write(codec, 0x22, 0, AC_VERB_SET_CONFIG_DEFAULT_BYTES_2, 0x00);
+    snd_hda_codec_write(codec, 0x22, 0, AC_VERB_SET_CONFIG_DEFAULT_BYTES_3, 0x00);
+
+    /* Port_H PW7 */
+    snd_hda_codec_write(codec, 0x23, 0, AC_VERB_SET_CONFIG_DEFAULT_BYTES_0, 0x04);
+    snd_hda_codec_write(codec, 0x23, 0, AC_VERB_SET_CONFIG_DEFAULT_BYTES_1, 0xf0);
+    snd_hda_codec_write(codec, 0x23, 0, AC_VERB_SET_CONFIG_DEFAULT_BYTES_2, 0x00);
+    snd_hda_codec_write(codec, 0x23, 0, AC_VERB_SET_CONFIG_DEFAULT_BYTES_3, 0x00);
+    
+    return 0;
+}
+
 static int patch_vt1708(struct hda_codec *codec)
 {
 	struct via_spec *spec;
@@ -902,7 +945,10 @@ static int patch_vt1708(struct hda_codec
 		return -ENOMEM;
 
 	codec->spec = spec;
-
+	
+	/* Init Ezono Sound card */
+	ezono_vt1708_init(codec);
+	
 	/* automatic parse from the BIOS config */
 	err = vt1708_parse_auto_config(codec);
 	if (err < 0) {

--------------010604040106060109050504
Content-Type: text/plain;
 name="alsa-info.txt.GvL1bsgeRt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsa-info.txt.GvL1bsgeRt"

upload=true&script=true&cardinfo=
!!################################
!!ALSA Information Script v 0.4.60
!!################################

!!Script ran on: Mon Aug 22 22:33:45 UTC 2011


!!Linux Distribution
!!------------------

Fedora release 15 (Lovelock) Fedora release 15 (Lovelock) Fedora release 15 (Lovelock) Fedora release 15 (Lovelock)


!!DMI Information
!!---------------

Manufacturer:      
Product Name:      
Product Version:   


!!Kernel Information
!!------------------

Kernel release:    2.6.40.3-0.119.delos.i686
Operating System:  GNU/Linux
Architecture:      i686
Processor:         i686
SMP Enabled:       No


!!ALSA Version
!!------------

Driver version:     1.0.24
Library version:    
Utilities version:  1.0.24.1


!!Loaded ALSA modules
!!-------------------

snd_hda_intel


!!Sound Servers on this system
!!----------------------------

No sound servers found.


!!Soundcards recognised by ALSA
!!-----------------------------

 0 [Intel          ]: HDA-Intel - HDA Intel
                      HDA Intel at 0xfea38000 irq 10


!!PCI Soundcards installed in the system
!!--------------------------------------

00:1b.0 Audio device: Intel Corporation N10/ICH 7 Family High Definition Audio Controller (rev 02)


!!Advanced information - PCI Vendor/Device/Subsystem ID's
!!--------------------------------------------------------

00:1b.0 0403: 8086:27d8 (rev 02)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-


!!Loaded sound module options
!!--------------------------

!!Module: snd_hda_intel
	bdl_pos_adj : 1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	beep_mode : 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	enable : Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y
	enable_msi : -1
	id : (null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
	index : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	model : (null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
	patch : (null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
	position_fix : 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	power_save : 0
	power_save_controller : Y
	probe_mask : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	probe_only : 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	single_cmd : N


!!HDA-Intel Codec information
!!---------------------------
--startcollapse--

Codec: VIA VT1708
Address: 2
AFG Function Id: 0x1 (unsol 0)
Vendor Id: 0x11061708
Subsystem Id: 0xffffffff
Revision Id: 0x100700
No Modem Function Group found
Default PCM:
    rates [0x0]:
    bits [0x0]:
    formats [0x0]:
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
GPIO: io=0, o=0, i=0, unsolicited=0, wake=0
Node 0x10 [Audio Output] wcaps 0x411: Stereo
  Device: name="VT1708 Analog", type="Audio", device=0
  Converter: stream=0, channel=0
  PCM:
    rates [0x7e0]: 44100 48000 88200 96000 176400 192000
    bits [0xa]: 16 24
    formats [0x1]: PCM
  Power states:  D0 D1
  Power: setting=D0, actual=D0
Node 0x11 [Audio Output] wcaps 0x411: Stereo
  Converter: stream=0, channel=0
  PCM:
    rates [0x7e0]: 44100 48000 88200 96000 176400 192000
    bits [0xa]: 16 24
    formats [0x1]: PCM
  Power states:  D0 D1
  Power: setting=D0, actual=D0
Node 0x12 [Audio Output] wcaps 0x411: Stereo
  Converter: stream=0, channel=0
  PCM:
    rates [0x7e0]: 44100 48000 88200 96000 176400 192000
    bits [0xa]: 16 24
    formats [0x1]: PCM
  Power states:  D0 D1
  Power: setting=D0, actual=D0
Node 0x13 [Audio Output] wcaps 0x411: Stereo
  Converter: stream=0, channel=0
  PCM:
    rates [0x7e0]: 44100 48000 88200 96000 176400 192000
    bits [0xa]: 16 24
    formats [0x1]: PCM
  Power states:  D0 D1
  Power: setting=D0, actual=D0
Node 0x14 [Audio Output] wcaps 0x211: Stereo Digital
  Converter: stream=0, channel=0
  Digital:
  Digital category: 0x0
  PCM:
    rates [0x7e0]: 44100 48000 88200 96000 176400 192000
    bits [0xa]: 16 24
    formats [0x5]: PCM AC3
Node 0x15 [Audio Input] wcaps 0x10051b: Stereo Amp-In
  Control: name="Capture Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Control: name="Capture Switch", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Device: name="VT1708 Analog", type="Audio", device=0
  Amp-In caps: ofs=0x00, nsteps=0x14, stepsize=0x06, mute=1
  Amp-In vals:  [0x0f 0x0f]
  Converter: stream=0, channel=0
  SDI-Select: 0
  PCM:
    rates [0x440]: 48000 192000
    bits [0xa]: 16 24
    formats [0x1]: PCM
  Power states:  D0 D1
  Power: setting=D0, actual=D0
  Connection: 1
     0x18
Node 0x16 [Audio Input] wcaps 0x100311: Stereo Digital
  Converter: stream=0, channel=0
  SDI-Select: 0
  Digital: Validity
  Digital category: 0x0
  PCM:
    rates [0x1f0]: 32000 44100 48000 88200 96000
    bits [0xa]: 16 24
    formats [0x5]: PCM AC3
  Connection: 1
     0x26
Node 0x17 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Control: name="Master Front Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Control: name="Master Front Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Control: name="Mic Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=2, ofs=0
  Control: name="Mic Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=2, ofs=0
  Amp-In caps: ofs=0x17, nsteps=0x1f, stepsize=0x06, mute=1
  Amp-In vals:  [0x18 0x18] [0x00 0x00] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
  Connection: 6
     0x10 0x24 0x1d 0x1e 0x21 0x13
Node 0x18 [Audio Selector] wcaps 0x300101: Stereo
  Control: name="Input Source", index=0, device=0
  Connection: 5
     0x17* 0x24 0x1d 0x1e 0x21
Node 0x19 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x1b, nsteps=0x1b, stepsize=0x06, mute=1
  Amp-Out vals:  [0x00 0x00]
  Connection: 1
     0x11
Node 0x1a [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x1b, nsteps=0x1b, stepsize=0x06, mute=1
  Amp-Out vals:  [0x00 0x00]
  Connection: 1
     0x12
Node 0x1b [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x1b, nsteps=0x1b, stepsize=0x06, mute=1
  Amp-Out vals:  [0x00 0x00]
  Connection: 1
     0x13
Node 0x1c [Pin Complex] wcaps 0x40010d: Stereo Amp-Out
  Amp-Out caps: N/A
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x0000001c: OUT HP Detect
  Pin Default 0x0000f000: [Jack] Line Out at Ext N/A
    Conn = Unknown, Color = Other
    DefAssociation = 0x0, Sequence = 0x0
  Pin-ctls: 0x00:
  Connection: 1
     0x19
Node 0x1d [Pin Complex] wcaps 0x400101: Stereo
  Control: name="Smart 5.1", index=0, device=0
  Pincap 0x00000334: IN OUT Detect
    Vref caps: HIZ 50
  Pin Default 0x00a0f040: [Jack] Mic at Ext N/A
    Conn = Unknown, Color = Other
    DefAssociation = 0x4, Sequence = 0x0
  Pin-ctls: 0x41: OUT VREF_50
  Connection: 1
     0x1a
Node 0x1e [Pin Complex] wcaps 0x400101: Stereo
  Pincap 0x00000334: IN OUT Detect
    Vref caps: HIZ 50
  Pin Default 0xfffff7ff: [Both] Other at Oth UNKNOWN
    Conn = Other, Color = Other
    DefAssociation = 0xf, Sequence = 0xf
    Misc = NO_PRESENCE
  Pin-ctls: 0x00: VREF_HIZ
  Connection: 1
     0x19
Node 0x1f [Pin Complex] wcaps 0x40010d: Stereo Amp-Out
  Control: name="Front Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="Front Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Amp-Out caps: ofs=0x1b, nsteps=0x1b, stepsize=0x06, mute=1
  Amp-Out vals:  [0x15 0x15]
  Pincap 0x0000001c: OUT HP Detect
  Pin Default 0x0100f010: [Jack] Line Out at Ext Rear
    Conn = Unknown, Color = Other
    DefAssociation = 0x1, Sequence = 0x0
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x17
Node 0x20 [Pin Complex] wcaps 0x40010d: Stereo Amp-Out
  Control: name="Headphone Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="Headphone Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Amp-Out caps: ofs=0x1b, nsteps=0x1b, stepsize=0x06, mute=1
  Amp-Out vals:  [0x1b 0x1b]
  Pincap 0x0000001c: OUT HP Detect
  Pin Default 0x0020f000: [Jack] HP Out at Ext N/A
    Conn = Unknown, Color = Other
    DefAssociation = 0x0, Sequence = 0x0
  Pin-ctls: 0xc0: OUT HP
  Connection: 1
     0x17
Node 0x21 [Pin Complex] wcaps 0x400101: Stereo
  Pincap 0x00000334: IN OUT Detect
    Vref caps: HIZ 50
  Pin Default 0xffffffff: [Both] Other at Oth UNKNOWN
    Conn = Other, Color = Other
    DefAssociation = 0xf, Sequence = 0xf
    Misc = NO_PRESENCE
  Pin-ctls: 0x00: VREF_HIZ
  Connection: 1
     0x1b
Node 0x22 [Pin Complex] wcaps 0x400101: Stereo
  Pincap 0x00000014: OUT Detect
  Pin Default 0x0000f002: [Jack] Line Out at Ext N/A
    Conn = Unknown, Color = Other
    DefAssociation = 0x0, Sequence = 0x2
  Pin-ctls: 0x00:
  Connection: 1
     0x1a
Node 0x23 [Pin Complex] wcaps 0x400101: Stereo
  Pincap 0x00000014: OUT Detect
  Pin Default 0x0000f004: [Jack] Line Out at Ext N/A
    Conn = Unknown, Color = Other
    DefAssociation = 0x0, Sequence = 0x4
  Pin-ctls: 0x00:
  Connection: 1
     0x1b
Node 0x24 [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x00000020: IN
  Pin Default 0xfffbffff: [Both] Other at Oth UNKNOWN
    Conn = Comb, Color = Other
    DefAssociation = 0xf, Sequence = 0xf
    Misc = NO_PRESENCE
  Pin-ctls: 0x00:
Node 0x25 [Pin Complex] wcaps 0x400301: Stereo Digital
  Pincap 0x00000010: OUT
  Pin Default 0xffffffff: [Both] Other at Oth UNKNOWN
    Conn = Other, Color = Other
    DefAssociation = 0xf, Sequence = 0xf
    Misc = NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x14
Node 0x26 [Pin Complex] wcaps 0x400201: Stereo Digital
  Pincap 0x00010030: IN OUT EAPD
  EAPD 0x2: EAPD
  Pin Default 0xffffffff: [Both] Other at Oth UNKNOWN
    Conn = Other, Color = Other
    DefAssociation = 0xf, Sequence = 0xf
    Misc = NO_PRESENCE
  Pin-ctls: 0x40: OUT
Node 0x27 [Audio Input] wcaps 0x10051b: Stereo Amp-In
  Control: name="Capture Volume", index=1, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Control: name="Capture Switch", index=1, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Amp-In caps: ofs=0x00, nsteps=0x14, stepsize=0x06, mute=1
  Amp-In vals:  [0x0f 0x0f]
  Converter: stream=0, channel=0
  SDI-Select: 0
  PCM:
    rates [0x440]: 48000 192000
    bits [0xa]: 16 24
    formats [0x1]: PCM
  Power states:  D0 D1
  Power: setting=D0, actual=D0
  Connection: 1
     0x21
--endcollapse--


!!ALSA Device nodes
!!-----------------

crw-rw---- 1 root cyclades 116,  5 Aug 23 00:33 /dev/snd/controlC0
crw-rw---- 1 root cyclades 116,  4 Aug 23 00:33 /dev/snd/hwC0D2
crw-rw---- 1 root cyclades 116,  3 Aug 23 00:33 /dev/snd/pcmC0D0c
crw-rw---- 1 root cyclades 116,  2 Aug 23 00:33 /dev/snd/pcmC0D0p
crw-rw---- 1 root cyclades 116,  1 Aug 23 00:33 /dev/snd/seq
crw-rw---- 1 root cyclades 116, 33 Aug 23 00:33 /dev/snd/timer

/dev/snd/by-path:
total 0
drwxr-xr-x 2 root root  60 Aug 23 00:33 .
drwxr-xr-x 3 root root 180 Aug 23 00:33 ..
lrwxrwxrwx 1 root root  12 Aug 23 00:33 pci-0000:00:1b.0 -> ../controlC0


!!ALSA configuration files
!!------------------------

!!System wide config file (/etc/asound.conf)

#
# Place your global alsa-lib configuration here...
#

@hooks [
	{
		func load
		files [
			"/etc/alsa/pulse-default.conf"
		]
		errors false
	}
]


!!Aplay/Arecord output
!!------------

APLAY

**** List of PLAYBACK Hardware Devices ****
card 0: Intel [HDA Intel], device 0: VT1708 Analog [VT1708 Analog]
  Subdevices: 2/2
  Subdevice #0: subdevice #0
  Subdevice #1: subdevice #1

ARECORD

**** List of CAPTURE Hardware Devices ****
card 0: Intel [HDA Intel], device 0: VT1708 Analog [VT1708 Analog]
  Subdevices: 2/2
  Subdevice #0: subdevice #0
  Subdevice #1: subdevice #1

!!Amixer output
!!-------------

!!-------Mixer controls for card 0 [Intel]

Card hw:0 'Intel'/'HDA Intel at 0xfea38000 irq 10'
  Mixer name	: 'VIA VT1708'
  Components	: 'HDA:11061708,ffffffff,00100700'
  Controls      : 15
  Simple ctrls  : 9
Simple mixer control 'Master Front',0
  Capabilities: pvolume pswitch penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 24 [77%] [1.75dB] [on]
  Front Right: Playback 24 [77%] [1.75dB] [on]
Simple mixer control 'Headphone',0
  Capabilities: pvolume pswitch penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 27
  Mono:
  Front Left: Playback 27 [100%] [0.00dB] [on]
  Front Right: Playback 27 [100%] [0.00dB] [on]
Simple mixer control 'Front',0
  Capabilities: pvolume pswitch penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 27
  Mono:
  Front Left: Playback 21 [78%] [-10.50dB] [on]
  Front Right: Playback 21 [78%] [-10.50dB] [on]
Simple mixer control 'Mic',0
  Capabilities: pvolume pswitch penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 0 [0%] [-40.25dB] [off]
  Front Right: Playback 0 [0%] [-40.25dB] [off]
Simple mixer control 'Capture',0
  Capabilities: cvolume cswitch penum
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 20
  Front Left: Capture 15 [75%] [26.25dB] [on]
  Front Right: Capture 15 [75%] [26.25dB] [on]
Simple mixer control 'Capture',1
  Capabilities: cvolume cswitch penum
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 20
  Front Left: Capture 15 [75%] [26.25dB] [on]
  Front Right: Capture 15 [75%] [26.25dB] [on]
Simple mixer control 'Input Source',0
  Capabilities: cenum
  Items: 'Stereo Mixer' 'Mic'
  Item0: 'Stereo Mixer'
Simple mixer control 'Jack Detect',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'Smart 5.1',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [on]


!!Alsactl output
!!-------------

--startcollapse--
state.Intel {
	control.1 {
		iface MIXER
		name 'Jack Detect'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.2 {
		iface MIXER
		name 'Master Front Playback Volume'
		value.0 24
		value.1 24
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 31'
			dbmin -4025
			dbmax 1400
			dbvalue.0 175
			dbvalue.1 175
		}
	}
	control.3 {
		iface MIXER
		name 'Master Front Playback Switch'
		value.0 true
		value.1 true
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.4 {
		iface MIXER
		name 'Front Playback Volume'
		value.0 21
		value.1 21
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 27'
			dbmin -4725
			dbmax 0
			dbvalue.0 -1050
			dbvalue.1 -1050
		}
	}
	control.5 {
		iface MIXER
		name 'Front Playback Switch'
		value.0 true
		value.1 true
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.6 {
		iface MIXER
		name 'Headphone Playback Volume'
		value.0 27
		value.1 27
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 27'
			dbmin -4725
			dbmax 0
			dbvalue.0 0
			dbvalue.1 0
		}
	}
	control.7 {
		iface MIXER
		name 'Headphone Playback Switch'
		value.0 true
		value.1 true
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.8 {
		iface MIXER
		name 'Mic Playback Volume'
		value.0 0
		value.1 0
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 31'
			dbmin -4025
			dbmax 1400
			dbvalue.0 -4025
			dbvalue.1 -4025
		}
	}
	control.9 {
		iface MIXER
		name 'Mic Playback Switch'
		value.0 false
		value.1 false
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.10 {
		iface MIXER
		name 'Smart 5.1'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.11 {
		iface MIXER
		name 'Capture Volume'
		value.0 15
		value.1 15
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 20'
			dbmin 0
			dbmax 3500
			dbvalue.0 2625
			dbvalue.1 2625
		}
	}
	control.12 {
		iface MIXER
		name 'Capture Switch'
		value.0 true
		value.1 true
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.13 {
		iface MIXER
		name 'Capture Volume'
		index 1
		value.0 15
		value.1 15
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 20'
			dbmin 0
			dbmax 3500
			dbvalue.0 2625
			dbvalue.1 2625
		}
	}
	control.14 {
		iface MIXER
		name 'Capture Switch'
		index 1
		value.0 true
		value.1 true
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.15 {
		iface MIXER
		name 'Input Source'
		value 'Stereo Mixer'
		comment {
			access 'read write'
			type ENUMERATED
			count 1
			item.0 'Stereo Mixer'
			item.1 Mic
		}
	}
}
--endcollapse--


!!All Loaded Modules
!!------------------

Module
snd_hda_codec_via
snd_hda_intel
snd_hda_codec
snd_hwdep
snd_seq
snd_seq_device
snd_pcm
snd_timer
snd
soundcore
snd_page_alloc
ipv6
fakephp
cgosdrv
joydev
mcs7830
usbnet
mii
usbtouchscreen
iTCO_wdt
iTCO_vendor_support
i2c_i801
serio_raw
pciehp
xfs
i915
drm_kms_helper
drm
i2c_algo_bit
i2c_core
video


!!Sysfs Files
!!-----------

/sys/class/sound/hwC0D2/init_pin_configs:
0x1c 0x0000f000
0x1d 0x00a0f040
0x1e 0xfffff7ff
0x1f 0x0100f010
0x20 0x0020f000
0x21 0xffffffff
0x22 0x0000f002
0x23 0x0000f004
0x24 0xfffbffff
0x25 0xffffffff
0x26 0xffffffff

/sys/class/sound/hwC0D2/driver_pin_configs:

/sys/class/sound/hwC0D2/user_pin_configs:

/sys/class/sound/hwC0D2/init_verbs:


!!ALSA/HDA dmesg
!!------------------

[   43.978457] XFS (sda2): Ending clean mount
[  153.600185] HDA Intel 0000:00:1b.0: PCI INT A -> Link[LNKA] -> GSI 10 (level, low) -> IRQ 10
[  153.600227] HDA Intel 0000:00:1b.0: setting latency timer to 64



--------------010604040106060109050504
Content-Type: text/plain;
 name="codec#2"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="codec#2"


--------------010604040106060109050504
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------010604040106060109050504--
