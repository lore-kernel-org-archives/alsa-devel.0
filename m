From: Andrea Venturi <a.venturi@avalpa.com>
Subject: Dell Studio 15 - aka Inspiron 1535 sound problems: HDA
 intel and codec IDT (STAC) 92HD73C1X5
Date: Tue, 05 Aug 2008 17:23:51 +0200
Message-ID: <48987087.4040001@avalpa.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010906050501080507000902"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp5.aruba.it (smtpd4.aruba.it [62.149.128.209])
	by alsa0.perex.cz (Postfix) with SMTP id 12D27243A9
	for <alsa-devel@alsa-project.org>;
	Tue,  5 Aug 2008 17:24:16 +0200 (CEST)
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
--------------010906050501080507000902
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

hi, i own a brand new Dell laptop Studio 15

the audio speakers stay mute if i play an audio file. :-|

i'm using debian lenny kernel.

it seems to me a wrong port mapping. i put in place a newer Alsa 1.0.17
kernel modules with debug enabled, but still no sound.

i append some relevant info about HW, alsa dmesg and codec description

you can find more info about this laptop and the audio not workig here 
(look for audio support):
 
http://www.avalpa.com/assets/andrea/studio15/debian_on_dell_studio15.html


this is the dmesg detection WHEN i tried to remove the Subsystem Id:
0x10280254 autodetection (because it catches my subsystem albeit it says 
"unknown Dell"!)

i'd really like to help more and try to solve myself the quirks of this
new laptop but this NID stuff with the port/mixer configuration is
really beyond a casual user workload.

let me know if you need more info.

bye

andrea Venturi


[36685.486337] ALSA
/home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:2069: 


chipset global capabilities = 0x4401
[36685.514673] ALSA
/home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:754: 


codec_mask = 0x1
[36685.516706] ALSA
/home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/../../alsa-kernel/pci/hda/patch_sigmatel.c:3501: 


hda_codec: Unknown model for STAC92HD73XX, using BIOS defaults
[36685.516843] ALSA
/home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/../../alsa-kernel/pci/hda/patch_sigmatel.c:1813: 


hda_codec: pin nid 0a bios pin config 0321101f
[36685.516921] ALSA
/home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/../../alsa-kernel/pci/hda/patch_sigmatel.c:1813: 


hda_codec: pin nid 0b bios pin config 4f00000f
[36685.516992] ALSA
/home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/../../alsa-kernel/pci/hda/patch_sigmatel.c:1813: 


hda_codec: pin nid 0c bios pin config 4f0000f0
[36685.517068] ALSA
/home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/../../alsa-kernel/pci/hda/patch_sigmatel.c:1813: 


hda_codec: pin nid 0d bios pin config 90170110
[36685.517138] ALSA
/home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/../../alsa-kernel/pci/hda/patch_sigmatel.c:1813: 


hda_codec: pin nid 0e bios pin config 03a11020
[36685.517214] ALSA
/home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/../../alsa-kernel/pci/hda/patch_sigmatel.c:1813: 


hda_codec: pin nid 0f bios pin config 0321101f
[36685.517315] ALSA
/home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/../../alsa-kernel/pci/hda/patch_sigmatel.c:1813: 


hda_codec: pin nid 10 bios pin config 4f0000f0
[36685.517392] ALSA
/home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/../../alsa-kernel/pci/hda/patch_sigmatel.c:1813: 


hda_codec: pin nid 11 bios pin config 4f0000f0
[36685.517461] ALSA
/home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/../../alsa-kernel/pci/hda/patch_sigmatel.c:1813: 


hda_codec: pin nid 12 bios pin config 4f0000f0
[36685.517537] ALSA
/home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/../../alsa-kernel/pci/hda/patch_sigmatel.c:1813: 


hda_codec: pin nid 13 bios pin config 90a60160
[36685.517604] ALSA
/home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/../../alsa-kernel/pci/hda/patch_sigmatel.c:1813: 


hda_codec: pin nid 14 bios pin config 4f0000f0
[36685.517683] ALSA
/home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/../../alsa-kernel/pci/hda/patch_sigmatel.c:1813: 


hda_codec: pin nid 1e bios pin config 00000000
[36685.517752] ALSA
/home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/../../alsa-kernel/pci/hda/patch_sigmatel.c:1813: 


hda_codec: pin nid 22 bios pin config 4f0000f0
[36685.518466] ALSA
/home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/hda_codec.c:3030:
autoconfig: line_outs=1 (0xd/0x0/0x0/0x0/0x0)
[36685.518471] ALSA
/home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/hda_codec.c:3034:
speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[36685.518474] ALSA
/home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/hda_codec.c:3038:
hp_outs=2 (0xa/0xf/0x0/0x0/0x0)
[36685.518477] ALSA
/home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/hda_codec.c:3039:
mono: mono_out=0x0
[36685.518480] ALSA
/home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/hda_codec.c:3047:
inputs: mic=0xe, fmic=0x0, line=0x0, fline=0x0, cd=0x0, aux=0x0
[36685.518484] ALSA
/home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/../../alsa-kernel/pci/hda/patch_sigmatel.c:2249: 


stac92xx_add_dyn_out_pins: total dac count=3
[36685.582821] ALSA
/home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/hda_codec.c:1136:
Cannot find slave Center Playback Volume, skipped
[36685.582828] ALSA
/home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/hda_codec.c:1136:
Cannot find slave LFE Playback Volume, skipped
[36685.582832] ALSA
/home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/hda_codec.c:1136:
Cannot find slave Side Playback Volume, skipped
[36685.582836] ALSA
/home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/hda_codec.c:1136:
Cannot find slave Speaker Playback Volume, skipped
[36685.582840] ALSA
/home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/hda_codec.c:1136:
Cannot find slave External Speaker Playback Volume, skipped
[36685.582843] ALSA
/home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/hda_codec.c:1136:
Cannot find slave Speaker2 Playback Volume, skipped
[36685.582850] ALSA
/home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/hda_codec.c:1136:
Cannot find slave Center Playback Switch, skipped
[36685.582854] ALSA
/home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/hda_codec.c:1136:
Cannot find slave LFE Playback Switch, skipped
[36685.582857] ALSA
/home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/hda_codec.c:1136:
Cannot find slave Side Playback Switch, skipped
[36685.582862] ALSA
/home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/hda_codec.c:1136:
Cannot find slave Speaker Playback Switch, skipped
[36685.582865] ALSA
/home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/hda_codec.c:1136:
Cannot find slave External Speaker Playback Switch, skipped
[36685.582869] ALSA
/home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/hda_codec.c:1136:
Cannot find slave Speaker2 Playback Switch, skipped
[36685.582872] ALSA
/home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/hda_codec.c:1136:
Cannot find slave IEC958 Playback Switch, skipped
[36685.585858] ACPI: PCI Interrupt 0000:01:00.1[B] -> GSI 17 (level,
low) -> IRQ 17
[36685.585886] PCI: Setting latency timer of device 0000:01:00.1 to 64
[36685.585891] ALSA
/home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:2069: 


chipset global capabilities = 0x1001
[36685.600103] ALSA
/home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:754: 


codec_mask = 0x1
[35851.601774] ALSA
/home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:1390: 


azx_pcm_prepare: bufsize=0x10000, format=0x31
[35851.601807] ALSA
/home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/hda_codec.c:725:
hda_codec_setup_stream: NID=0x15, stream=0x5, channel=0, format=0x31
[35851.609097] ALSA
/home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/hda_codec.c:725:
hda_codec_setup_stream: NID=0x17, stream=0x5, channel=0, format=0x31
[35851.617097] ALSA
/home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/hda_codec.c:725:
hda_codec_setup_stream: NID=0x16, stream=0x5, channel=0, format=0x31
[35851.628764] ALSA
/home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/hda_codec.c:725:
hda_codec_setup_stream: NID=0x17, stream=0x5, channel=0, format=0x31
[35855.924252] ALSA
/home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/hda_codec.c:737:
hda_codec_cleanup_stream: NID=0x15
[35855.924252] ALSA
/home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/hda_codec.c:737:
hda_codec_cleanup_stream: NID=0x16
[35855.924252] ALSA
/home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/hda_codec.c:737:
hda_codec_cleanup_stream: NID=0x17
[35855.924252] ALSA
/home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/hda_codec.c:737:
hda_codec_cleanup_stream: NID=0x17
andrea@nb-andrea:~/mp3$




--------------010906050501080507000902
Content-Type: text/plain;
 name="dell_studio_codec0.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dell_studio_codec0.txt"

Codec: IDT 92HD73C1X5
Address: 0
Vendor Id: 0x111d7675
Subsystem Id: 0x10280254
Revision Id: 0x100202
No Modem Function Group found
Default PCM:
    rates [0x5e0]: 44100 48000 88200 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Default Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
Default Amp-Out caps: ofs=0x7f, nsteps=0x7f, stepsize=0x02, mute=1
GPIO: io=8, o=0, i=0, unsolicited=1, wake=1
  IO[0]: enable=1, dir=1, wake=0, sticky=0, data=1
  IO[1]: enable=0, dir=0, wake=0, sticky=0, data=0
  IO[2]: enable=0, dir=0, wake=0, sticky=0, data=0
  IO[3]: enable=0, dir=0, wake=0, sticky=0, data=0
  IO[4]: enable=0, dir=0, wake=0, sticky=0, data=0
  IO[5]: enable=0, dir=0, wake=0, sticky=0, data=0
  IO[6]: enable=0, dir=0, wake=0, sticky=0, data=0
  IO[7]: enable=0, dir=0, wake=0, sticky=0, data=0
Node 0x0a [Pin Complex] wcaps 0x400183: Stereo Amp-In
  Amp-In caps: N/A
  Amp-In vals:  [0x00 0x00]
  Pincap 0x08173f: IN OUT HP Detect Trigger ImpSense
    Vref caps: HIZ 50 GRD 80
  Pin Default 0x0321101f: [Jack] HP Out at Ext Left
    Conn = 1/8, Color = Black
    DefAssociation = 0x1, Sequence = 0xf
  Pin-ctls: 0xc0: OUT HP VREF_HIZ
  Unsolicited: tag=30, enabled=1
  Connection: 4
     0x15 0x16* 0x17 0x1e
Node 0x0b [Pin Complex] wcaps 0x400183: Stereo Amp-In
  Amp-In caps: N/A
  Amp-In vals:  [0x00 0x00]
  Pincap 0x08173f: IN OUT HP Detect Trigger ImpSense
    Vref caps: HIZ 50 GRD 80
  Pin Default 0x4f00000f: [N/A] Line Out at Ext UNKNOWN
    Conn = Unknown, Color = Unknown
    DefAssociation = 0x0, Sequence = 0xf
  Pin-ctls: 0x00: VREF_HIZ
  Unsolicited: tag=00, enabled=0
  Connection: 4
     0x15* 0x16 0x17 0x1e
Node 0x0c [Pin Complex] wcaps 0x400183: Stereo Amp-In
  Amp-In caps: N/A
  Amp-In vals:  [0x00 0x00]
  Pincap 0x081737: IN OUT Detect Trigger ImpSense
    Vref caps: HIZ 50 GRD 80
  Pin Default 0x4f0000f0: [N/A] Line Out at Ext UNKNOWN
    Conn = Unknown, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0x00: VREF_HIZ
  Unsolicited: tag=00, enabled=0
  Connection: 4
     0x15* 0x16 0x17 0x1e
Node 0x0d [Pin Complex] wcaps 0x400183: Stereo Amp-In
  Amp-In caps: N/A
  Amp-In vals:  [0x00 0x00]
  Pincap 0x083f: IN OUT HP Detect Trigger ImpSense
  Pin Default 0x90170110: [Fixed] Speaker at Int N/A
    Conn = Analog, Color = Unknown
    DefAssociation = 0x1, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=00, enabled=0
  Connection: 4
     0x15* 0x16 0x17 0x1e
Node 0x0e [Pin Complex] wcaps 0x400183: Stereo Amp-In
  Amp-In caps: N/A
  Amp-In vals:  [0x00 0x00]
  Pincap 0x081737: IN OUT Detect Trigger ImpSense
    Vref caps: HIZ 50 GRD 80
  Pin Default 0x03a11020: [Jack] Mic at Ext Left
    Conn = 1/8, Color = Black
    DefAssociation = 0x2, Sequence = 0x0
  Pin-ctls: 0x24: IN VREF_80
  Unsolicited: tag=00, enabled=0
  Connection: 4
     0x15* 0x16 0x17 0x1e
Node 0x0f [Pin Complex] wcaps 0x400183: Stereo Amp-In
  Amp-In caps: N/A
  Amp-In vals:  [0x00 0x00]
  Pincap 0x0837: IN OUT Detect Trigger ImpSense
  Pin Default 0x0321101f: [Jack] HP Out at Ext Left
    Conn = 1/8, Color = Black
    DefAssociation = 0x1, Sequence = 0xf
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=35, enabled=1
  Connection: 4
     0x15 0x16 0x17* 0x1e
Node 0x10 [Pin Complex] wcaps 0x400183: Stereo Amp-In
  Amp-In caps: N/A
  Amp-In vals:  [0x00 0x00]
  Pincap 0x0837: IN OUT Detect Trigger ImpSense
  Pin Default 0x4f0000f0: [N/A] Line Out at Ext UNKNOWN
    Conn = Unknown, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0x00:
  Unsolicited: tag=00, enabled=0
  Connection: 4
     0x15* 0x16 0x17 0x1e
Node 0x11 [Pin Complex] wcaps 0x400183: Stereo Amp-In
  Amp-In caps: N/A
  Amp-In vals:  [0x00 0x00]
  Pincap 0x0837: IN OUT Detect Trigger ImpSense
  Pin Default 0x4f0000f0: [N/A] Line Out at Ext UNKNOWN
    Conn = Unknown, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0x00:
  Unsolicited: tag=00, enabled=0
  Connection: 4
     0x15* 0x16 0x17 0x1e
Node 0x12 [Pin Complex] wcaps 0x400081: Stereo
  Pincap 0x0824: IN Detect
  Pin Default 0x4f0000f0: [N/A] Line Out at Ext UNKNOWN
    Conn = Unknown, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0x00:
  Unsolicited: tag=00, enabled=0
Node 0x13 [Pin Complex] wcaps 0x400003: Stereo Amp-In
  Amp-In caps: N/A
  Amp-In vals:  [0x00 0x00]
  Pincap 0x0820: IN
  Pin Default 0x90a60160: [Fixed] Mic at Int N/A
    Conn = Digital, Color = Unknown
    DefAssociation = 0x6, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x20: IN
Node 0x14 [Pin Complex] wcaps 0x400003: Stereo Amp-In
  Amp-In caps: N/A
  Amp-In vals:  [0x00 0x00]
  Pincap 0x0820: IN
  Pin Default 0x4f0000f0: [N/A] Line Out at Ext UNKNOWN
    Conn = Unknown, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0x00:
Node 0x15 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out R/L
  Amp-Out caps: N/A
  Amp-Out vals:  [0x41 0x41]
  Converter: stream=5, channel=0
  Power: setting=D0, actual=D0
  Delay: 13 samples
Node 0x16 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out R/L
  Amp-Out caps: N/A
  Amp-Out vals:  [0x5a 0x5a]
  Converter: stream=5, channel=0
  Power: setting=D0, actual=D0
  Delay: 13 samples
Node 0x17 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out R/L
  Amp-Out caps: N/A
  Amp-Out vals:  [0x0f 0x0f]
  Converter: stream=5, channel=0
  Power: setting=D0, actual=D0
  Delay: 13 samples
Node 0x18 [Vendor Defined Widget] wcaps 0xfd0c05: Stereo Amp-Out R/L
  Amp-Out caps: N/A
  Amp-Out vals:  [0xff 0xff]
  Power: setting=D0, actual=D3
  Delay: 13 samples
Node 0x19 [Vendor Defined Widget] wcaps 0xfd0c05: Stereo Amp-Out R/L
  Amp-Out caps: N/A
  Amp-Out vals:  [0xff 0xff]
  Power: setting=D0, actual=D3
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
  Amp-In vals:  [0x97 0x97] [0x97 0x97] [0x97 0x97] [0x97 0x97] [0x97 0x97]
  Connection: 5
     0x28 0x29 0x2a 0x2b 0x12
Node 0x1e [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x9f 0x9f]
  Connection: 1
     0x1d
Node 0x1f [Volume Knob Widget] wcaps 0x600000: Mono
  Volume-Knob: delta=1, steps=127, direct=1, val=108
  Connection: 3
     0x15* 0x16 0x17
Node 0x20 [Audio Selector] wcaps 0x30090d: Stereo Amp-Out R/L
  Amp-Out caps: ofs=0x00, nsteps=0x0f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x80 0x80]
  Connection: 12
     0x0a 0x0b 0x0c 0x0d 0x0e 0x0f 0x10 0x11 0x12 0x13 0x14 0x1d*
Node 0x21 [Audio Selector] wcaps 0x30090d: Stereo Amp-Out R/L
  Amp-Out caps: ofs=0x00, nsteps=0x0f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x80 0x80]
  Connection: 12
     0x0a 0x0b 0x0c 0x0d 0x0e 0x0f 0x10 0x11 0x12 0x13 0x14 0x1d*
Node 0x22 [Pin Complex] wcaps 0x400301: Stereo Digital
  Pincap 0x0810: OUT
  Pin Default 0x4f0000f0: [N/A] Line Out at Ext UNKNOWN
    Conn = Unknown, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0x00:
  Connection: 3
     0x25* 0x20 0x21
Node 0x23 [Pin Complex] wcaps 0x400301: Stereo Digital
  Pincap 0x0810: OUT
  Pin Default 0x4f00000f: [N/A] Line Out at Ext UNKNOWN
    Conn = Unknown, Color = Unknown
    DefAssociation = 0x0, Sequence = 0xf
  Pin-ctls: 0x00:
  Connection: 3
     0x26* 0x20 0x21
Node 0x24 [Pin Complex] wcaps 0x400681: Stereo Digital
  Pincap 0x0810024: IN EAPD Detect
  EAPD 0x0:
  Pin Default 0x4f00000f: [N/A] Line Out at Ext UNKNOWN
    Conn = Unknown, Color = Unknown
    DefAssociation = 0x0, Sequence = 0xf
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
  Connection: 3
     0x15* 0x16 0x17



--------------010906050501080507000902
Content-Type: text/plain;
 name="dmesg-alsa-debug.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg-alsa-debug.txt"

[28308.279209] ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 21 (level, low) -> IRQ 21
[28308.279241] PCI: Setting latency timer of device 0000:00:1b.0 to 64
[28308.279248] ALSA /home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:2069: chipset global capabilities = 0x4401
[28308.311620] ALSA /home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:754: codec_mask = 0x1
[28308.313776] ALSA /home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/hda_codec.c:2359: hda_codec: model 'dell-m6' is selected for config 1028:254 (unknown Dell)
[28308.313926] ALSA /home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/../../alsa-kernel/pci/hda/patch_sigmatel.c:1840: hda_codec: pin nid 0a pin config 0321101f
[28308.314064] ALSA /home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/../../alsa-kernel/pci/hda/patch_sigmatel.c:1840: hda_codec: pin nid 0b pin config 4f00000f
[28308.314227] ALSA /home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/../../alsa-kernel/pci/hda/patch_sigmatel.c:1840: hda_codec: pin nid 0c pin config 4f0000f0
[28308.314355] ALSA /home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/../../alsa-kernel/pci/hda/patch_sigmatel.c:1840: hda_codec: pin nid 0d pin config 90170110
[28308.314499] ALSA /home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/../../alsa-kernel/pci/hda/patch_sigmatel.c:1840: hda_codec: pin nid 0e pin config 03a11020
[28308.314670] ALSA /home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/../../alsa-kernel/pci/hda/patch_sigmatel.c:1840: hda_codec: pin nid 0f pin config 0321101f
[28308.314810] ALSA /home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/../../alsa-kernel/pci/hda/patch_sigmatel.c:1840: hda_codec: pin nid 10 pin config 4f0000f0
[28308.314986] ALSA /home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/../../alsa-kernel/pci/hda/patch_sigmatel.c:1840: hda_codec: pin nid 11 pin config 4f0000f0
[28308.315122] ALSA /home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/../../alsa-kernel/pci/hda/patch_sigmatel.c:1840: hda_codec: pin nid 12 pin config 4f0000f0
[28308.315298] ALSA /home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/../../alsa-kernel/pci/hda/patch_sigmatel.c:1840: hda_codec: pin nid 13 pin config 90a60160
[28308.315607] ALSA /home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/../../alsa-kernel/pci/hda/patch_sigmatel.c:1840: hda_codec: pin nid 14 pin config 4f0000f0
[28308.315750] ALSA /home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/../../alsa-kernel/pci/hda/patch_sigmatel.c:1840: hda_codec: pin nid 1e pin config 00000000
[28308.315896] ALSA /home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/../../alsa-kernel/pci/hda/patch_sigmatel.c:1840: hda_codec: pin nid 22 pin config 4f0000f0
[28308.316125] ALSA /home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/../../alsa-kernel/pci/hda/patch_sigmatel.c:1840: hda_codec: pin nid 13 pin config 90a60160
[28308.316771] ALSA /home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/hda_codec.c:3030: autoconfig: line_outs=1 (0xd/0x0/0x0/0x0/0x0)
[28308.316778] ALSA /home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/hda_codec.c:3034:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[28308.316783] ALSA /home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/hda_codec.c:3038:    hp_outs=2 (0xa/0xf/0x0/0x0/0x0)
[28308.316789] ALSA /home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/hda_codec.c:3039:    mono: mono_out=0x0
[28308.316793] ALSA /home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/hda_codec.c:3047:    inputs: mic=0xe, fmic=0x0, line=0x0, fline=0x0, cd=0x0, aux=0x0
[28308.316800] ALSA /home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/../../alsa-kernel/pci/hda/patch_sigmatel.c:2249: stac92xx_add_dyn_out_pins: total dac count=3
[28308.385231] ALSA /home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/hda_codec.c:1136: Cannot find slave Center Playback Volume, skipped
[28308.385237] ALSA /home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/hda_codec.c:1136: Cannot find slave LFE Playback Volume, skipped
[28308.385241] ALSA /home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/hda_codec.c:1136: Cannot find slave Side Playback Volume, skipped
[28308.385245] ALSA /home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/hda_codec.c:1136: Cannot find slave Speaker Playback Volume, skipped
[28308.385249] ALSA /home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/hda_codec.c:1136: Cannot find slave External Speaker Playback Volume, skipped
[28308.385252] ALSA /home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/hda_codec.c:1136: Cannot find slave Speaker2 Playback Volume, skipped
[28308.385260] ALSA /home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/hda_codec.c:1136: Cannot find slave Center Playback Switch, skipped
[28308.385264] ALSA /home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/hda_codec.c:1136: Cannot find slave LFE Playback Switch, skipped
[28308.385268] ALSA /home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/hda_codec.c:1136: Cannot find slave Side Playback Switch, skipped
[28308.385274] ALSA /home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/hda_codec.c:1136: Cannot find slave Speaker Playback Switch, skipped
[28308.385278] ALSA /home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/hda_codec.c:1136: Cannot find slave External Speaker Playback Switch, skipped
[28308.385283] ALSA /home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/hda_codec.c:1136: Cannot find slave Speaker2 Playback Switch, skipped
[28308.385287] ALSA /home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/hda_codec.c:1136: Cannot find slave IEC958 Playback Switch, skipped
[28308.385838] ACPI: PCI Interrupt 0000:01:00.1[B] -> GSI 17 (level, low) -> IRQ 17
[28308.385865] PCI: Setting latency timer of device 0000:01:00.1 to 64
[28308.385870] ALSA /home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:2069: chipset global capabilities = 0x1001
[28308.401066] ALSA /home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:754: codec_mask = 0x1
[28967.997654] ALSA /home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:1390: azx_pcm_prepare: bufsize=0x10000, format=0x31
[28967.997678] ALSA /home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/hda_codec.c:725: hda_codec_setup_stream: NID=0x15, stream=0x5, channel=0, format=0x31
[28968.004577] ALSA /home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/hda_codec.c:725: hda_codec_setup_stream: NID=0x17, stream=0x5, channel=0, format=0x31
[28968.016553] ALSA /home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/hda_codec.c:725: hda_codec_setup_stream: NID=0x16, stream=0x5, channel=0, format=0x31
[28968.024471] ALSA /home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/hda_codec.c:725: hda_codec_setup_stream: NID=0x17, stream=0x5, channel=0, format=0x31
[29032.180075] ALSA /home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/hda_codec.c:737: hda_codec_cleanup_stream: NID=0x15
[29032.180075] ALSA /home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/hda_codec.c:737: hda_codec_cleanup_stream: NID=0x16
[29032.180075] ALSA /home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/hda_codec.c:737: hda_codec_cleanup_stream: NID=0x17
[29032.180075] ALSA /home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/hda_codec.c:737: hda_codec_cleanup_stream: NID=0x17
[29429.525365] ALSA /home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:1390: azx_pcm_prepare: bufsize=0xff00, format=0x15
[29429.525395] ALSA /home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/hda_codec.c:725: hda_codec_setup_stream: NID=0x15, stream=0x5, channel=0, format=0x15
[29429.529905] ALSA /home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/hda_codec.c:725: hda_codec_setup_stream: NID=0x17, stream=0x5, channel=0, format=0x15
[29429.537901] ALSA /home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/hda_codec.c:725: hda_codec_setup_stream: NID=0x16, stream=0x5, channel=2, format=0x15
[29429.557564] ALSA /home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/hda_codec.c:725: hda_codec_setup_stream: NID=0x17, stream=0x5, channel=4, format=0x15
[28761.447729] ALSA /home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/hda_codec.c:737: hda_codec_cleanup_stream: NID=0x15
[28761.447729] ALSA /home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/hda_codec.c:737: hda_codec_cleanup_stream: NID=0x16
[28761.447729] ALSA /home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/hda_codec.c:737: hda_codec_cleanup_stream: NID=0x17
[28761.447729] ALSA /home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/hda_codec.c:737: hda_codec_cleanup_stream: NID=0x17
[28761.447729] ALSA /home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/hda_codec.c:737: hda_codec_cleanup_stream: NID=0x15
[28761.447729] ALSA /home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/hda_codec.c:737: hda_codec_cleanup_stream: NID=0x16
[28761.447729] ALSA /home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/hda_codec.c:737: hda_codec_cleanup_stream: NID=0x17
[28761.447729] ALSA /home/andrea/src/alsa/alsa-driver-1.0.17/pci/hda/hda_codec.c:737: hda_codec_cleanup_stream: NID=0x17



--------------010906050501080507000902
Content-Type: text/plain;
 name="lshw.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lshw.txt"

nb-andrea
    description: Portable Computer
    product: Studio 1535
    vendor: Dell Inc.
    serial: BWZ7T3J
    width: 32 bits
    capabilities: smbios-2.4 dmi-2.4
    configuration: boot=normal chassis=portable uuid=44454C4C-5700-105A-8037-C2C04F54334A
  *-core
       description: Motherboard
       product: 0F700C
       vendor: Dell Inc.
       physical id: 0
       serial: .BWZ7T3J.CN486438673307.
       slot: @
     *-firmware
          description: BIOS
          vendor: Dell Inc.
          physical id: 0
          version: A03 (07/02/2008)
          size: 64KiB
          capacity: 1984KiB
          capabilities: isa pci pcmcia pnp upgrade shadowing cdboot bootselect int13floppy720 int5printscreen int9keyboard int14serial int17printer int10video acpi usb agp smartbattery biosbootspecification netboot
     *-cpu
          description: CPU
          product: Intel(R) Core(TM)2 Duo CPU     T8100  @ 2.10GHz
          vendor: Intel Corp.
          physical id: 400
          bus info: cpu@0
          version: 6.7.6
          serial: 0001-0676-0000-0000-0000-0000
          slot: Microprocessor
          size: 2101MHz
          capacity: 2101MHz
          width: 64 bits
          clock: 200MHz
          capabilities: fpu fpu_exception wp vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx x86-64 constant_tsc arch_perfmon pebs bts pni monitor ds_cpl vmx est tm2 ssse3 cx16 xtpr sse4_1 lahf_lm ida cpufreq
          configuration: id=0
        *-cache:0
             description: L1 cache
             physical id: 700
             size: 32KiB
             capacity: 32KiB
             capabilities: internal write-back data
        *-cache:1
             description: L2 cache
             physical id: 701
             size: 3MiB
             capacity: 3MiB
             clock: 66MHz (15.0ns)
             capabilities: pipeline-burst internal varies unified
        *-logicalcpu:0
             description: Logical CPU
             physical id: 0.1
             width: 64 bits
             capabilities: logical
        *-logicalcpu:1
             description: Logical CPU
             physical id: 0.2
             width: 64 bits
             capabilities: logical
     *-memory
          description: System Memory
          physical id: 1000
          slot: System board or motherboard
          size: 4GiB
        *-bank:0
             description: DIMM DDR Synchronous 667 MHz (1.5 ns)
             product: HYMP125S64CP8-Y5
             vendor: AD00000000000000
             physical id: 0
             serial: 00001106
             slot: DIMM_A
             size: 2GiB
             width: 64 bits
             clock: 667MHz (1.5ns)
        *-bank:1
             description: DIMM DDR Synchronous 667 MHz (1.5 ns)
             product: HYMP125S64CP8-Y5
             vendor: AD00000000000000
             physical id: 1
             serial: 00001045
             slot: DIMM_B
             size: 2GiB
             width: 64 bits
             clock: 667MHz (1.5ns)
     *-pci
          description: Host bridge
          product: Mobile PM965/GM965/GL960 Memory Controller Hub
          vendor: Intel Corporation
          physical id: 100
          bus info: pci@0000:00:00.0
          version: 03
          width: 32 bits
          clock: 33MHz
        *-pci:0
             description: PCI bridge
             product: Mobile PM965/GM965/GL960 PCI Express Root Port
             vendor: Intel Corporation
             physical id: 1
             bus info: pci@0000:00:01.0
             version: 03
             width: 32 bits
             clock: 33MHz
             capabilities: pci pm msi pciexpress bus_master cap_list
             configuration: driver=pcieport-driver
           *-display UNCLAIMED
                description: VGA compatible controller
                product: Mobilitiy Radeon HD 3400 Series
                vendor: ATI Technologies Inc
                physical id: 0
                bus info: pci@0000:01:00.0
                version: 00
                width: 32 bits
                clock: 33MHz
                capabilities: pm pciexpress msi bus_master cap_list
                configuration: latency=0
           *-multimedia
                description: Audio device
                product: RV620 Audio device [Radeon HD 34xx Series]
                vendor: ATI Technologies Inc
                physical id: 0.1
                bus info: pci@0000:01:00.1
                version: 00
                width: 32 bits
                clock: 33MHz
                capabilities: pm pciexpress msi bus_master cap_list
                configuration: driver=HDA Intel latency=0 module=snd_hda_intel
        *-usb:0
             description: USB Controller
             product: 82801H (ICH8 Family) USB UHCI Controller #4
             vendor: Intel Corporation
             physical id: 1a
             bus info: pci@0000:00:1a.0
             version: 03
             width: 32 bits
             clock: 33MHz
             capabilities: bus_master
             configuration: driver=uhci_hcd latency=0 module=uhci_hcd
           *-usbhost
                product: UHCI Host Controller
                vendor: Linux 2.6.25-2-686 uhci_hcd
                physical id: 1
                bus info: usb@1
                logical name: usb1
                version: 2.06
                capabilities: usb-1.10
                configuration: driver=hub slots=2 speed=12.0MB/s
        *-usb:1
             description: USB Controller
             product: 82801H (ICH8 Family) USB UHCI Controller #5
             vendor: Intel Corporation
             physical id: 1a.1
             bus info: pci@0000:00:1a.1
             version: 03
             width: 32 bits
             clock: 33MHz
             capabilities: bus_master
             configuration: driver=uhci_hcd latency=0 module=uhci_hcd
           *-usbhost
                product: UHCI Host Controller
                vendor: Linux 2.6.25-2-686 uhci_hcd
                physical id: 1
                bus info: usb@2
                logical name: usb2
                version: 2.06
                capabilities: usb-1.10
                configuration: driver=hub slots=2 speed=12.0MB/s
        *-usb:2
             description: USB Controller
             product: 82801H (ICH8 Family) USB2 EHCI Controller #2
             vendor: Intel Corporation
             physical id: 1a.7
             bus info: pci@0000:00:1a.7
             version: 03
             width: 32 bits
             clock: 33MHz
             capabilities: pm debug bus_master cap_list
             configuration: driver=ehci_hcd latency=0 module=ehci_hcd
           *-usbhost
                product: EHCI Host Controller
                vendor: Linux 2.6.25-2-686 ehci_hcd
                physical id: 1
                bus info: usb@6
                logical name: usb6
                version: 2.06
                capabilities: usb-2.00
                configuration: driver=hub slots=4 speed=480.0MB/s
        *-multimedia
             description: Audio device
             product: 82801H (ICH8 Family) HD Audio Controller
             vendor: Intel Corporation
             physical id: 1b
             bus info: pci@0000:00:1b.0
             version: 03
             width: 64 bits
             clock: 33MHz
             capabilities: pm msi pciexpress bus_master cap_list
             configuration: driver=HDA Intel latency=0 module=snd_hda_intel
        *-pci:1
             description: PCI bridge
             product: 82801H (ICH8 Family) PCI Express Port 1
             vendor: Intel Corporation
             physical id: 1c
             bus info: pci@0000:00:1c.0
             version: 03
             width: 32 bits
             clock: 33MHz
             capabilities: pci pciexpress msi pm bus_master cap_list
             configuration: driver=pcieport-driver
        *-pci:2
             description: PCI bridge
             product: 82801H (ICH8 Family) PCI Express Port 2
             vendor: Intel Corporation
             physical id: 1c.1
             bus info: pci@0000:00:1c.1
             version: 03
             width: 32 bits
             clock: 33MHz
             capabilities: pci pciexpress msi pm bus_master cap_list
             configuration: driver=pcieport-driver
           *-network UNCLAIMED
                description: Network controller
                product: BCM4322 802.11a/b/g/n Wireless LAN Controller
                vendor: Broadcom Corporation
                physical id: 0
                bus info: pci@0000:0c:00.0
                version: 01
                width: 64 bits
                clock: 33MHz
                capabilities: pm msi pciexpress bus_master cap_list
                configuration: latency=0
        *-pci:3
             description: PCI bridge
             product: 82801H (ICH8 Family) PCI Express Port 4
             vendor: Intel Corporation
             physical id: 1c.3
             bus info: pci@0000:00:1c.3
             version: 03
             width: 32 bits
             clock: 33MHz
             capabilities: pci pciexpress msi pm bus_master cap_list
             configuration: driver=pcieport-driver
        *-pci:4
             description: PCI bridge
             product: 82801H (ICH8 Family) PCI Express Port 6
             vendor: Intel Corporation
             physical id: 1c.5
             bus info: pci@0000:00:1c.5
             version: 03
             width: 32 bits
             clock: 33MHz
             capabilities: pci pciexpress msi pm bus_master cap_list
             configuration: driver=pcieport-driver
           *-network
                description: Ethernet interface
                product: NetLink BCM5784M Gigabit Ethernet PCIe
                vendor: Broadcom Corporation
                physical id: 0
                bus info: pci@0000:09:00.0
                logical name: eth0
                version: 10
                serial: 00:21:70:71:70:82
                capacity: 1GB/s
                width: 64 bits
                clock: 33MHz
                capabilities: pm vpd msi pciexpress bus_master cap_list ethernet physical tp 10bt 10bt-fd 100bt 100bt-fd 1000bt 1000bt-fd autonegotiation
                configuration: autonegotiation=on broadcast=yes driver=tg3 driverversion=3.91 latency=0 link=no module=tg3 multicast=yes port=twisted pair
        *-usb:3
             description: USB Controller
             product: 82801H (ICH8 Family) USB UHCI Controller #1
             vendor: Intel Corporation
             physical id: 1d
             bus info: pci@0000:00:1d.0
             version: 03
             width: 32 bits
             clock: 33MHz
             capabilities: bus_master
             configuration: driver=uhci_hcd latency=0 module=uhci_hcd
           *-usbhost
                product: UHCI Host Controller
                vendor: Linux 2.6.25-2-686 uhci_hcd
                physical id: 1
                bus info: usb@3
                logical name: usb3
                version: 2.06
                capabilities: usb-1.10
                configuration: driver=hub slots=2 speed=12.0MB/s
        *-usb:4
             description: USB Controller
             product: 82801H (ICH8 Family) USB UHCI Controller #2
             vendor: Intel Corporation
             physical id: 1d.1
             bus info: pci@0000:00:1d.1
             version: 03
             width: 32 bits
             clock: 33MHz
             capabilities: bus_master
             configuration: driver=uhci_hcd latency=0 module=uhci_hcd
           *-usbhost
                product: UHCI Host Controller
                vendor: Linux 2.6.25-2-686 uhci_hcd
                physical id: 1
                bus info: usb@4
                logical name: usb4
                version: 2.06
                capabilities: usb-1.10
                configuration: driver=hub slots=2 speed=12.0MB/s
        *-usb:5
             description: USB Controller
             product: 82801H (ICH8 Family) USB UHCI Controller #3
             vendor: Intel Corporation
             physical id: 1d.2
             bus info: pci@0000:00:1d.2
             version: 03
             width: 32 bits
             clock: 33MHz
             capabilities: bus_master
             configuration: driver=uhci_hcd latency=0 module=uhci_hcd
           *-usbhost
                product: UHCI Host Controller
                vendor: Linux 2.6.25-2-686 uhci_hcd
                physical id: 1
                bus info: usb@5
                logical name: usb5
                version: 2.06
                capabilities: usb-1.10
                configuration: driver=hub slots=2 speed=12.0MB/s
        *-usb:6
             description: USB Controller
             product: 82801H (ICH8 Family) USB2 EHCI Controller #1
             vendor: Intel Corporation
             physical id: 1d.7
             bus info: pci@0000:00:1d.7
             version: 03
             width: 32 bits
             clock: 33MHz
             capabilities: pm debug bus_master cap_list
             configuration: driver=ehci_hcd latency=0 module=ehci_hcd
           *-usbhost
                product: EHCI Host Controller
                vendor: Linux 2.6.25-2-686 ehci_hcd
                physical id: 1
                bus info: usb@7
                logical name: usb7
                version: 2.06
                capabilities: usb-2.00
                configuration: driver=hub slots=6 speed=480.0MB/s
              *-usb:0
                   description: Generic USB device
                   product: Compact Wireless-G USB Adapter
                   vendor: Cisco-Linksys
                   physical id: 3
                   bus info: usb@7:3
                   version: 0.01
                   capabilities: usb-2.00
                   configuration: driver=rt73usb maxpower=300mA speed=480.0MB/s
              *-usb:1 UNCLAIMED
                   description: Video
                   product: Laptop_Integrated_Webcam_2M
                   vendor: SONiX Technology Inc.
                   physical id: 5
                   bus info: usb@7:5
                   version: 82.29
                   serial: CN0TX613724878570GRK
                   capabilities: usb-2.00
                   configuration: maxpower=168mA speed=480.0MB/s
        *-pci:5
             description: PCI bridge
             product: 82801 Mobile PCI Bridge
             vendor: Intel Corporation
             physical id: 1e
             bus info: pci@0000:00:1e.0
             version: f3
             width: 32 bits
             clock: 33MHz
             capabilities: pci bus_master cap_list
           *-firewire
                description: FireWire (IEEE 1394)
                product: R5C832 IEEE 1394 Controller
                vendor: Ricoh Co Ltd
                physical id: 1
                bus info: pci@0000:03:01.0
                version: 05
                width: 32 bits
                clock: 33MHz
                capabilities: pm bus_master cap_list
                configuration: driver=firewire_ohci latency=64 maxlatency=4 mingnt=2 module=firewire_ohci
           *-system:0
                description: SD Host controller
                product: R5C822 SD/SDIO/MMC/MS/MSPro Host Adapter
                vendor: Ricoh Co Ltd
                physical id: 1.1
                bus info: pci@0000:03:01.1
                version: 22
                width: 32 bits
                clock: 33MHz
                capabilities: pm bus_master cap_list
                configuration: driver=sdhci latency=64 module=sdhci
           *-system:1
                description: System peripheral
                product: R5C592 Memory Stick Bus Host Adapter
                vendor: Ricoh Co Ltd
                physical id: 1.2
                bus info: pci@0000:03:01.2
                version: 12
                width: 32 bits
                clock: 33MHz
                capabilities: pm bus_master cap_list
                configuration: driver=ricoh-mmc latency=64 module=ricoh_mmc
           *-system:2 UNCLAIMED
                description: System peripheral
                product: xD-Picture Card Controller
                vendor: Ricoh Co Ltd
                physical id: 1.3
                bus info: pci@0000:03:01.3
                version: 12
                width: 32 bits
                clock: 33MHz
                capabilities: pm bus_master cap_list
                configuration: latency=64
           *-generic UNCLAIMED
                product: Illegal Vendor ID
                vendor: Illegal Vendor ID
                physical id: 1.4
                bus info: pci@0000:03:01.4
                version: ff
                width: 32 bits
                clock: 66MHz
                capabilities: bus_master vga_palette cap_list
                configuration: latency=255 maxlatency=255 mingnt=255
        *-isa
             description: ISA bridge
             product: 82801HEM (ICH8M) LPC Interface Controller
             vendor: Intel Corporation
             physical id: 1f
             bus info: pci@0000:00:1f.0
             version: 03
             width: 32 bits
             clock: 33MHz
             capabilities: isa bus_master cap_list
             configuration: latency=0
        *-storage
             description: SATA controller
             product: 82801HBM/HEM (ICH8M/ICH8M-E) SATA AHCI Controller
             vendor: Intel Corporation
             physical id: 1f.2
             bus info: pci@0000:00:1f.2
             logical name: scsi0
             logical name: scsi1
             version: 03
             width: 32 bits
             clock: 66MHz
             capabilities: storage msi pm bus_master cap_list emulated
             configuration: driver=ahci latency=0 module=ahci
           *-disk
                description: ATA Disk
                product: WDC WD2500BEVS-7
                vendor: Western Digital
                physical id: 0
                bus info: scsi@0:0.0.0
                logical name: /dev/sda
                version: 01.0
                serial: WD-WXC508631049
                size: 232GiB (250GB)
                capabilities: partitioned partitioned:dos
                configuration: ansiversion=5 signature=d0000000
              *-volume:0
                   description: Windows FAT volume
                   vendor: Dell 8.0
                   physical id: 1
                   bus info: scsi@0:0.0.0,1
                   logical name: /dev/sda1
                   version: FAT16
                   serial: 07d8-070e
                   size: 133MiB
                   capacity: 133MiB
                   capabilities: primary fat initialized
                   configuration: FATs=2 filesystem=fat label=DellUtility
              *-volume:1
                   description: Windows NTFS volume
                   physical id: 2
                   bus info: scsi@0:0.0.0,2
                   logical name: /dev/sda2
                   version: 3.1
                   serial: 14ca05d0-bd30-df49-ac54-ceb855b49101
                   size: 10233MiB
                   capacity: 10GiB
                   capabilities: primary ntfs initialized
                   configuration: clustersize=4096 created=2008-07-15 04:39:34 filesystem=ntfs label=RECOVERY state=clean
              *-volume:2
                   description: Windows NTFS volume
                   physical id: 3
                   bus info: scsi@0:0.0.0,3
                   logical name: /dev/sda3
                   version: 3.1
                   serial: 12b8b13e-70d7-f94e-8145-d15e37ccf210
                   size: 123GiB
                   capacity: 123GiB
                   capabilities: primary bootable ntfs initialized
                   configuration: clustersize=4096 created=2008-07-15 04:39:39 filesystem=ntfs label=OS state=clean
              *-volume:3
                   description: Extended partition
                   physical id: 4
                   bus info: scsi@0:0.0.0,4
                   logical name: /dev/sda4
                   size: 99GiB
                   capacity: 99GiB
                   capabilities: primary extended partitioned partitioned:extended
                 *-logicalvolume:0
                      description: Linux filesystem partition
                      physical id: 5
                      logical name: /dev/sda5
                      capacity: 9538MiB
                 *-logicalvolume:1
                      description: Linux filesystem partition
                      physical id: 6
                      logical name: /dev/sda6
                      logical name: /
                      capacity: 9538MiB
                      configuration: mount.fstype=ext3 mount.options=rw,noatime,errors=remount-ro,data=ordered state=mounted
                 *-logicalvolume:2
                      description: Linux filesystem partition
                      physical id: 7
                      logical name: /dev/sda7
                      logical name: /home
                      capacity: 80GiB
                      configuration: mount.fstype=ext3 mount.options=rw,errors=continue,data=ordered state=mounted
           *-cdrom
                description: DVD-RAM writer
                product: DVDRWBD BC-5600S
                vendor: Optiarc
                physical id: 1
                bus info: scsi@1:0.0.0
                logical name: /dev/cdrom
                logical name: /dev/cdrw
                logical name: /dev/dvd
                logical name: /dev/dvdrw
                logical name: /dev/scd0
                logical name: /dev/sr0
                version: 103B
                capabilities: removable audio cd-r cd-rw dvd dvd-r dvd-ram
                configuration: ansiversion=5 status=open
        *-serial
             description: SMBus
             product: 82801H (ICH8 Family) SMBus Controller
             vendor: Intel Corporation
             physical id: 1f.3
             bus info: pci@0000:00:1f.3
             version: 03
             width: 32 bits
             clock: 33MHz
             configuration: driver=i801_smbus latency=0 module=i2c_i801
  *-battery
       product: DELL WU94687
       vendor: Samsung SDI
       physical id: 1
       slot: Sys. Battery Bay
       capacity: 52000mWh
       configuration: voltage=11.1V
  *-network
       description: Wireless interface
       physical id: 2
       logical name: wlan0
       serial: 00:1d:7e:97:83:82
       capabilities: ethernet physical wireless
       configuration: broadcast=yes ip=192.168.1.69 multicast=yes wireless=IEEE 802.11g



--------------010906050501080507000902
Content-Type: text/x-vcard; charset=utf-8;
 name="a_venturi.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="a_venturi.vcf"

begin:vcard
fn:Andrea Venturi
n:;Andrea Venturi
org:Avalpa Digital Engineering SRL
adr;dom:;;Via dell'Arcoveggio 49/5;Bologna;BO;40129
email;internet:a.venturi@avalpa.com
title:CEO
tel;work:+39 0514187531
tel;cell:+39 3477142994
url:www.avalpa.com
version:2.1
end:vcard


--------------010906050501080507000902
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------010906050501080507000902--
