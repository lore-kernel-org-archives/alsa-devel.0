From: Thomas Wagner <thomas@thowabu.de>
Subject: Intel-HDA Realtek Codec // double matching PCI IDs
Date: Tue, 28 Dec 2010 16:49:03 +0100
Message-ID: <4D1A06EF.90706@thowabu.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090301010909000309090805"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.ips-amsel.de (mail.ips-amsel.de [85.10.202.234])
	by alsa0.perex.cz (Postfix) with ESMTP id 7D8111038E5
	for <alsa-devel@alsa-project.org>; Tue, 28 Dec 2010 15:49:10 +0100 (CET)
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
--------------090301010909000309090805
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable



I tried to patch, but it=B4s no solution !
It=B4s working for me.

Maybe someone have a look.
If the N63Jn=B4s ID is true there must be another difference to detect th=
e=20
right codec...


---
root@arthur:/usr/src/linux-2.6.37-rc7/sound/pci/hda# uname -r && diff -u=20
/usr/src/l2.6.37-rc7/sound/pci/hda/patch_realtek.c ./patch_realtek.c
2.6.37-rc7-git3



--- /usr/src/l2.6.37-rc7/sound/pci/hda/patch_realtek.c  2010-12-28=20
15:37:10.900000008 +0100
+++ ./patch_realtek.c   2010-12-28 15:23:09.390000004 +0100
@@ -14854,6 +14854,7 @@
         SND_PCI_QUIRK(0x1028, 0x0470, "Dell M101z",=20
ALC269_FIXUP_DELL_M101Z),
         SND_PCI_QUIRK(0x17aa, 0x21b8, "Thinkpad Edge 14",=20
ALC269_FIXUP_SKU_IGNORE),
         SND_PCI_QUIRK(0x17aa, 0x20f2, "Thinkpad SL410/510",=20
ALC269_FIXUP_SKU_IGNORE),
+       SND_PCI_QUIRK(0x1043, 0x1113, "Asus N53Jf",=20
ALC269_FIXUP_ASUS_G73JW),           // Connect Subwoofer "Asus Sonic Mast=
er"
         SND_PCI_QUIRK(0x1043, 0x1a13, "Asus G73Jw",=20
ALC269_FIXUP_ASUS_G73JW),
         {}
  };
@@ -14878,7 +14879,11 @@
         SND_PCI_QUIRK(0x1043, 0x8330, "ASUS Eeepc P703 P900A",
                       ALC269_AMIC),
         SND_PCI_QUIRK(0x1043, 0x1013, "ASUS N61Da", ALC269VB_AMIC),
-       SND_PCI_QUIRK(0x1043, 0x1113, "ASUS N63Jn", ALC269VB_AMIC),
+
+//     SND_PCI_QUIRK(0x1043, 0x1113, "ASUS N63Jn", ALC269VB_AMIC),    =20
// PCI ID Collide with Asus N53Jf
+                                                                        =
                                                      =20
// and spoil Codec
+       SND_PCI_QUIRK(0x1043, 0x1113, "ASUS N53Jf", ALC269_AUTO),
+
         SND_PCI_QUIRK(0x1043, 0x1143, "ASUS B53f", ALC269VB_AMIC),
         SND_PCI_QUIRK(0x1043, 0x1133, "ASUS UJ20ft", ALC269_AMIC),
         SND_PCI_QUIRK(0x1043, 0x1183, "ASUS K72DR", ALC269VB_AMIC),
root@arthur:/usr/src/linux-2.6.37-rc7/sound/pci/hda#

--

Alsa Info

!!################################
!!ALSA Information Script v 0.4.59
!!################################

!!Script ran on: Tue Dec 28 14:47:51 UTC 2010


!!Linux Distribution
!!------------------

Debian GNU/Linux 6.0 \n \l


!!DMI Information
!!---------------

Manufacturer:      ASUSTeK Computer Inc.
Product Name:      N53Jf


!!Kernel Information
!!------------------

Kernel release:    2.6.37-rc7-git3
Operating System:  GNU/Linux
Architecture:      i686
Processor:         unknown
SMP Enabled:       Yes


!!ALSA Version
!!------------

Driver version:     1.0.23
Library version:    1.0.23
Utilities version:  1.0.23


!!Loaded ALSA modules
!!-------------------

snd_hda_intel


!!Sound Servers on this system
!!----------------------------

aRts:
       Installed - Yes (/usr/bin/artsd)
       Running - No

Jack:
       Installed - Yes (/usr/bin/jackd)
       Running - No


!!Soundcards recognised by ALSA
!!-----------------------------

  0 [Intel          ]: HDA-Intel - HDA Intel
                       HDA Intel at 0xd9c00000 irq 49


!!PCI Soundcards installed in the system
!!--------------------------------------

00:1b.0 Audio device: Intel Corporation 5 Series/3400 Series Chipset High=
 Definition Audio (rev 06)


!!Advanced information - PCI Vendor/Device/Susbsystem ID's
!!--------------------------------------------------------

00:1b.0 0403: 8086:3b56 (rev 06)
	Subsystem: 1043:1113


!!Modprobe options (Sound related)
!!--------------------------------

snd-atiixp-modem: index=3D-2
snd-intel8x0m: index=3D-2
snd-via82xx-modem: index=3D-2
snd-pcsp: index=3D-2
snd-usb-audio: index=3D-2
snd-intel-hda: model=3Dauto
snd_intel_hda: model=3Dauto


!!Loaded sound module options
!!--------------------------

!!Module: snd_hda_intel
	bdl_pos_adj : 1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1=
,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	beep_mode : 2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,=
2,2
	enable : Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y
	enable_msi : -1
	id : (null),(null),(null),(null),(null),(null),(null),(null),(null),(nul=
l),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),=
(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(nu=
ll),(null)
	index : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-=
1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	model : (null),(null),(null),(null),(null),(null),(null),(null),(null),(=
null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(nul=
l),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),=
(null),(null)
	patch : (null),(null),(null),(null),(null),(null),(null),(null),(null),(=
null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(nul=
l),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),=
(null),(null)
	position_fix : 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0=
,0,0,0
	power_save : 0
	power_save_controller : Y
	probe_mask : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1=
,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	probe_only : 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0=
,0,0
	single_cmd : N


!!HDA-Intel Codec information
!!---------------------------
--startcollapse--

Codec: Realtek ALC269VB
Address: 0
AFG Function Id: 0x1 (unsol 1)
Vendor Id: 0x10ec0269
Subsystem Id: 0x10431113
Revision Id: 0x100100
No Modem Function Group found
Default PCM:
     rates [0x560]: 44100 48000 96000 192000
     bits [0xe]: 16 20 24
     formats [0x1]: PCM
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
GPIO: io=3D2, o=3D0, i=3D0, unsolicited=3D1, wake=3D0
   IO[0]: enable=3D0, dir=3D0, wake=3D0, sticky=3D0, data=3D0, unsol=3D0
   IO[1]: enable=3D0, dir=3D0, wake=3D0, sticky=3D0, data=3D0, unsol=3D0
Node 0x02 [Audio Output] wcaps 0x1d: Stereo Amp-Out
   Amp-Out caps: ofs=3D0x57, nsteps=3D0x57, stepsize=3D0x02, mute=3D0
   Amp-Out vals:  [0x00 0x00]
   Converter: stream=3D0, channel=3D0
   PCM:
     rates [0x560]: 44100 48000 96000 192000
     bits [0xe]: 16 20 24
     formats [0x1]: PCM
Node 0x03 [Audio Output] wcaps 0x1d: Stereo Amp-Out
   Control: name=3D"Speaker Playback Volume", index=3D0, device=3D0
     ControlAmp: chs=3D3, dir=3DOut, idx=3D0, ofs=3D0
   Device: name=3D"ALC269VB Analog", type=3D"Audio", device=3D0
   Amp-Out caps: ofs=3D0x57, nsteps=3D0x57, stepsize=3D0x02, mute=3D0
   Amp-Out vals:  [0x3b 0x3b]
   Converter: stream=3D5, channel=3D0
   PCM:
     rates [0x560]: 44100 48000 96000 192000
     bits [0xe]: 16 20 24
     formats [0x1]: PCM
Node 0x04 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x05 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x06 [Audio Output] wcaps 0x211: Stereo Digital
   Control: name=3D"IEC958 Playback Con Mask", index=3D0, device=3D0
   Control: name=3D"IEC958 Playback Pro Mask", index=3D0, device=3D0
   Control: name=3D"IEC958 Playback Default", index=3D0, device=3D0
   Control: name=3D"IEC958 Playback Switch", index=3D0, device=3D0
   Control: name=3D"IEC958 Default PCM Playback Switch", index=3D0, devic=
e=3D0
   Device: name=3D"ALC269VB Digital", type=3D"SPDIF", device=3D1
   Converter: stream=3D5, channel=3D0
   Digital: Enabled
   Digital category: 0x0
   PCM:
     rates [0x5e0]: 44100 48000 88200 96000 192000
     bits [0xe]: 16 20 24
     formats [0x1]: PCM
Node 0x07 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x08 [Audio Input] wcaps 0x10011b: Stereo Amp-In
   Control: name=3D"Capture Switch", index=3D0, device=3D0
   Control: name=3D"Capture Volume", index=3D0, device=3D0
   Device: name=3D"ALC269VB Analog", type=3D"Audio", device=3D0
   Amp-In caps: ofs=3D0x0b, nsteps=3D0x1f, stepsize=3D0x05, mute=3D1
   Amp-In vals:  [0x9e 0x9e]
   Converter: stream=3D0, channel=3D0
   SDI-Select: 0
   PCM:
     rates [0x560]: 44100 48000 96000 192000
     bits [0xe]: 16 20 24
     formats [0x1]: PCM
   Connection: 1
      0x23
Node 0x09 [Audio Input] wcaps 0x10011b: Stereo Amp-In
   Control: name=3D"Capture Switch", index=3D1, device=3D0
   Control: name=3D"Capture Volume", index=3D1, device=3D0
   Amp-In caps: ofs=3D0x0b, nsteps=3D0x1f, stepsize=3D0x05, mute=3D1
   Amp-In vals:  [0x17 0x17]
   Converter: stream=3D0, channel=3D0
   SDI-Select: 0
   PCM:
     rates [0x560]: 44100 48000 96000 192000
     bits [0xe]: 16 20 24
     formats [0x1]: PCM
   Connection: 1
      0x22
Node 0x0a [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x0b [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
   Amp-In caps: ofs=3D0x17, nsteps=3D0x1f, stepsize=3D0x05, mute=3D1
   Amp-In vals:  [0x97 0x97] [0x97 0x97] [0x97 0x97] [0x97 0x97] [0x97 0x=
97]
   Connection: 5
      0x18 0x19 0x1a 0x1b 0x1d
Node 0x0c [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
   Amp-In caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
   Amp-In vals:  [0x00 0x00] [0x00 0x00]
   Connection: 2
      0x02 0x0b
Node 0x0d [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
   Amp-In caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
   Amp-In vals:  [0x00 0x00] [0x00 0x00]
   Connection: 2
      0x03 0x0b
Node 0x0e [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x0f [Audio Mixer] wcaps 0x20010a: Mono Amp-In
   Amp-In caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
   Amp-In vals:  [0x00] [0x00]
   Connection: 2
      0x02 0x0b
Node 0x10 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x11 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x12 [Pin Complex] wcaps 0x40000b: Stereo Amp-In
   Amp-In caps: ofs=3D0x00, nsteps=3D0x03, stepsize=3D0x2f, mute=3D0
   Amp-In vals:  [0x00 0x00]
   Pincap 0x00000020: IN
   Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
     Conn =3D 1/8, Color =3D Black
     DefAssociation =3D 0xf, Sequence =3D 0x0
     Misc =3D NO_PRESENCE
   Pin-ctls: 0x00:
Node 0x13 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x14 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
   Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
   Amp-Out vals:  [0x00 0x00]
   Pincap 0x00010014: OUT EAPD Detect
   EAPD 0x2: EAPD
   Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
     Conn =3D 1/8, Color =3D Black
     DefAssociation =3D 0xf, Sequence =3D 0x0
     Misc =3D NO_PRESENCE
   Pin-ctls: 0x40: OUT
   Unsolicited: tag=3D00, enabled=3D0
   Connection: 2
      0x0c* 0x0d
Node 0x15 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x16 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x17 [Pin Complex] wcaps 0x40010c: Mono Amp-Out
   Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
   Amp-Out vals:  [0x00]
   Pincap 0x00000010: OUT
   Pin Default 0x99130111: [Fixed] Speaker at Int ATAPI
     Conn =3D ATAPI, Color =3D Unknown
     DefAssociation =3D 0x1, Sequence =3D 0x1
     Misc =3D NO_PRESENCE
   Pin-ctls: 0x40: OUT
   Connection: 1
      0x0f
Node 0x18 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
   Control: name=3D"Mic Boost", index=3D0, device=3D0
     ControlAmp: chs=3D3, dir=3DIn, idx=3D0, ofs=3D0
   Amp-In caps: ofs=3D0x00, nsteps=3D0x03, stepsize=3D0x2f, mute=3D0
   Amp-In vals:  [0x03 0x03]
   Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
   Amp-Out vals:  [0x80 0x80]
   Pincap 0x00001734: IN OUT Detect
     Vref caps: HIZ 50 GRD 80
   Pin Default 0x01a19830: [Jack] Mic at Ext Rear
     Conn =3D 1/8, Color =3D Pink
     DefAssociation =3D 0x3, Sequence =3D 0x0
   Pin-ctls: 0x24: IN VREF_80
   Unsolicited: tag=3D08, enabled=3D1
   Connection: 1
      0x0d
Node 0x19 [Pin Complex] wcaps 0x40008b: Stereo Amp-In
   Control: name=3D"Internal Mic Boost", index=3D1, device=3D0
     ControlAmp: chs=3D3, dir=3DIn, idx=3D0, ofs=3D0
   Amp-In caps: ofs=3D0x00, nsteps=3D0x03, stepsize=3D0x2f, mute=3D0
   Amp-In vals:  [0x03 0x03]
   Pincap 0x00001724: IN Detect
     Vref caps: HIZ 50 GRD 80
   Pin Default 0x99a3093f: [Fixed] Mic at Int ATAPI
     Conn =3D ATAPI, Color =3D Unknown
     DefAssociation =3D 0x3, Sequence =3D 0xf
     Misc =3D NO_PRESENCE
   Pin-ctls: 0x24: IN VREF_80
   Unsolicited: tag=3D00, enabled=3D0
Node 0x1a [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
   Amp-In caps: ofs=3D0x00, nsteps=3D0x03, stepsize=3D0x2f, mute=3D0
   Amp-In vals:  [0x00 0x00]
   Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
   Amp-Out vals:  [0x80 0x80]
   Pincap 0x0000003c: IN OUT HP Detect
   Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
     Conn =3D 1/8, Color =3D Black
     DefAssociation =3D 0xf, Sequence =3D 0x0
     Misc =3D NO_PRESENCE
   Pin-ctls: 0x20: IN
   Unsolicited: tag=3D00, enabled=3D0
   Connection: 2
      0x0c* 0x0d
Node 0x1b [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
   Control: name=3D"Speaker Playback Switch", index=3D0, device=3D0
     ControlAmp: chs=3D3, dir=3DOut, idx=3D0, ofs=3D0
   Amp-In caps: ofs=3D0x00, nsteps=3D0x03, stepsize=3D0x2f, mute=3D0
   Amp-In vals:  [0x00 0x00]
   Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
   Amp-Out vals:  [0x00 0x00]
   Pincap 0x00000034: IN OUT Detect
   Pin Default 0x99130110: [Fixed] Speaker at Int ATAPI
     Conn =3D ATAPI, Color =3D Unknown
     DefAssociation =3D 0x1, Sequence =3D 0x0
     Misc =3D NO_PRESENCE
   Pin-ctls: 0x40: OUT
   Unsolicited: tag=3D00, enabled=3D0
   Connection: 2
      0x0c 0x0d*
Node 0x1c [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x1d [Pin Complex] wcaps 0x400000: Mono
   Pincap 0x00000020: IN
   Pin Default 0x40079a2d: [N/A] Line Out at Ext N/A
     Conn =3D Analog, Color =3D Pink
     DefAssociation =3D 0x2, Sequence =3D 0xd
   Pin-ctls: 0x20: IN
Node 0x1e [Pin Complex] wcaps 0x400381: Stereo Digital
   Pincap 0x00000014: OUT Detect
   Pin Default 0x99430120: [Fixed] SPDIF Out at Int ATAPI
     Conn =3D ATAPI, Color =3D Unknown
     DefAssociation =3D 0x2, Sequence =3D 0x0
     Misc =3D NO_PRESENCE
   Pin-ctls: 0x40: OUT
   Unsolicited: tag=3D00, enabled=3D0
   Connection: 1
      0x06
Node 0x1f [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x20 [Vendor Defined Widget] wcaps 0xf00040: Mono
   Processing caps: benign=3D0, ncoeff=3D25
Node 0x21 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
   Control: name=3D"Headphone Playback Switch", index=3D0, device=3D0
     ControlAmp: chs=3D3, dir=3DOut, idx=3D0, ofs=3D0
   Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
   Amp-Out vals:  [0x00 0x00]
   Pincap 0x0000001c: OUT HP Detect
   Pin Default 0x0121401f: [Jack] HP Out at Ext Rear
     Conn =3D 1/8, Color =3D Green
     DefAssociation =3D 0x1, Sequence =3D 0xf
   Pin-ctls: 0xc0: OUT HP
   Unsolicited: tag=3D04, enabled=3D1
   Connection: 2
      0x0c 0x0d*
Node 0x22 [Audio Selector] wcaps 0x30010b: Stereo Amp-In
   Amp-In caps: N/A
   Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x=
00] [0x00 0x00] [0x00 0x00]
   Connection: 7
      0x18* 0x19 0x1a 0x1b 0x1d 0x0b 0x12
Node 0x23 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
   Amp-In caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
   Amp-In vals:  [0x80 0x80] [0x00 0x00] [0x80 0x80] [0x80 0x80] [0x80 0x=
80] [0x80 0x80]
   Connection: 6
      0x18 0x19 0x1a 0x1b 0x1d 0x0b
--endcollapse--


!!ALSA Device nodes
!!-----------------

crw-rw----  1 root audio 116, 8 Dec 28 15:28 /dev/snd/controlC0
crw-rw----  1 root audio 116, 7 Dec 28 15:28 /dev/snd/hwC0D0
crw-rw----  1 root audio 116, 6 Dec 28 15:28 /dev/snd/pcmC0D0c
crw-rw----  1 root audio 116, 5 Dec 28 15:33 /dev/snd/pcmC0D0p
crw-rw----  1 root audio 116, 4 Dec 28 15:28 /dev/snd/pcmC0D1p
crw-rw----  1 root audio 116, 3 Dec 28 15:28 /dev/snd/seq
crw-rw----  1 root audio 116, 2 Dec 28 15:28 /dev/snd/timer

/dev/snd/by-path:
total 0
drwxr-xr-x 2 root root  60 Dec 28 15:28 .
drwxr-xr-x 3 root root 200 Dec 28 15:28 ..
lrwxrwxrwx 1 root root  12 Dec 28 15:28 pci-0000:00:1b.0 ->  ../controlC0


!!Aplay/Arecord output
!!------------

APLAY

**** List of PLAYBACK Hardware Devices ****
card 0: Intel [HDA Intel], device 0: ALC269VB Analog [ALC269VB Analog]
   Subdevices: 0/1
   Subdevice #0: subdevice #0
card 0: Intel [HDA Intel], device 1: ALC269VB Digital [ALC269VB Digital]
   Subdevices: 1/1
   Subdevice #0: subdevice #0

ARECORD

**** List of CAPTURE Hardware Devices ****
card 0: Intel [HDA Intel], device 0: ALC269VB Analog [ALC269VB Analog]
   Subdevices: 1/1
   Subdevice #0: subdevice #0

!!Amixer output
!!-------------

!!-------Mixer controls for card 0 [Intel]

Card hw:0 'Intel'/'HDA Intel at 0xd9c00000 irq 49'
   Mixer name	: 'Realtek ALC269VB'
   Components	: 'HDA:10ec0269,10431113,00100100'
   Controls      : 18
   Simple ctrls  : 11
Simple mixer control 'Master',0
   Capabilities: pvolume pvolume-joined pswitch pswitch-joined penum
   Playback channels: Mono
   Limits: Playback 0 - 87
   Mono: Playback 60 [69%] [-20.25dB] [on]
Simple mixer control 'Headphone',0
   Capabilities: pswitch penum
   Playback channels: Front Left - Front Right
   Mono:
   Front Left: Playback [on]
   Front Right: Playback [on]
Simple mixer control 'Speaker',0
   Capabilities: pvolume pswitch penum
   Playback channels: Front Left - Front Right
   Limits: Playback 0 - 87
   Mono:
   Front Left: Playback 86 [99%] [0.75dB] [on]
   Front Right: Playback 86 [99%] [0.75dB] [on]
Simple mixer control 'PCM',0
   Capabilities: pvolume penum
   Playback channels: Front Left - Front Right
   Limits: Playback 0 - 255
   Mono:
   Front Left: Playback 255 [100%] [0.00dB]
   Front Right: Playback 255 [100%] [0.00dB]
Simple mixer control 'Mic Boost',0
   Capabilities: volume penum
   Playback channels: Front Left - Front Right
   Capture channels: Front Left - Front Right
   Limits: 0 - 3
   Front Left: 3 [100%]
   Front Right: 3 [100%]
Simple mixer control 'IEC958',0
   Capabilities: pswitch pswitch-joined penum
   Playback channels: Mono
   Mono: Playback [on]
Simple mixer control 'IEC958 Default PCM',0
   Capabilities: pswitch pswitch-joined penum
   Playback channels: Mono
   Mono: Playback [on]
Simple mixer control 'Capture',0
   Capabilities: cvolume cswitch penum
   Capture channels: Front Left - Front Right
   Limits: Capture 0 - 31
   Front Left: Capture 30 [97%] [28.50dB] [off]
   Front Right: Capture 30 [97%] [28.50dB] [off]
Simple mixer control 'Capture',1
   Capabilities: cvolume cswitch penum
   Capture channels: Front Left - Front Right
   Limits: Capture 0 - 31
   Front Left: Capture 23 [74%] [18.00dB] [on]
   Front Right: Capture 23 [74%] [18.00dB] [on]
Simple mixer control 'Digital',0
   Capabilities: cvolume penum
   Capture channels: Front Left - Front Right
   Limits: Capture 0 - 120
   Front Left: Capture 120 [100%] [30.00dB]
   Front Right: Capture 120 [100%] [30.00dB]
Simple mixer control 'Internal Mic Boost',1
   Capabilities: volume penum
   Playback channels: Front Left - Front Right
   Capture channels: Front Left - Front Right
   Limits: 0 - 3
   Front Left: 3 [100%]
   Front Right: 3 [100%]


!!Alsactl output
!!-------------

--startcollapse--
state.Intel {
	control.1 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 87'
		comment.dbmin -6525
		comment.dbmax 0
		iface MIXER
		name 'Speaker Playback Volume'
		value.0 86
		value.1 86
	}
	control.2 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Speaker Playback Switch'
		value.0 true
		value.1 true
	}
	control.3 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Headphone Playback Switch'
		value.0 true
		value.1 true
	}
	control.4 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 3'
		comment.dbmin 0
		comment.dbmax 3600
		iface MIXER
		name 'Mic Boost'
		value.0 3
		value.1 3
	}
	control.5 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 3'
		comment.dbmin 0
		comment.dbmax 3600
		iface MIXER
		name 'Internal Mic Boost'
		index 1
		value.0 3
		value.1 3
	}
	control.6 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Capture Switch'
		value.0 false
		value.1 false
	}
	control.7 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Capture Switch'
		index 1
		value.0 true
		value.1 true
	}
	control.8 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		comment.dbmin -1650
		comment.dbmax 3000
		iface MIXER
		name 'Capture Volume'
		value.0 30
		value.1 30
	}
	control.9 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		comment.dbmin -1650
		comment.dbmax 3000
		iface MIXER
		name 'Capture Volume'
		index 1
		value.0 23
		value.1 23
	}
	control.10 {
		comment.access read
		comment.type IEC958
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Con Mask'
		value '0fff000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.11 {
		comment.access read
		comment.type IEC958
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Pro Mask'
		value '0f00000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.12 {
		comment.access 'read write'
		comment.type IEC958
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Default'
		value '0400000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.13 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Switch'
		value true
	}
	control.14 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'IEC958 Default PCM Playback Switch'
		value true
	}
	control.15 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 87'
		comment.dbmin -6525
		comment.dbmax 0
		iface MIXER
		name 'Master Playback Volume'
		value 60
	}
	control.16 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Master Playback Switch'
		value true
	}
	control.17 {
		comment.access 'read write user'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 255'
		comment.tlv '0000000100000008ffffec1400000014'
		comment.dbmin -5100
		comment.dbmax 0
		iface MIXER
		name 'PCM Playback Volume'
		value.0 255
		value.1 255
	}
	control.18 {
		comment.access 'read write user'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 120'
		comment.tlv '0000000100000008fffff44800000032'
		comment.dbmin -3000
		comment.dbmax 3000
		iface MIXER
		name 'Digital Capture Volume'
		value.0 120
		value.1 120
	}
}
--endcollapse--


!!All Loaded Modules
!!------------------

Module
binfmt_misc
loop
i915
drm_kms_helper
drm
i2c_algo_bit
snd_hda_codec_realtek
snd_hda_intel
snd_hda_codec
snd_hwdep
snd_pcm_oss
snd_mixer_oss
snd_pcm
snd_seq
snd_timer
snd_seq_device
snd
iwlagn
video
asus_laptop
btusb
output
sparse_keymap
evdev
uvcvideo
psmouse
iwlcore
snd_page_alloc
wmi
usbhid
atl1c


!!Sysfs Files
!!-----------

/sys/class/sound/hwC0D0/init_pin_configs:
0x12 0x411111f0
0x14 0x411111f0
0x17 0x411111f0
0x18 0x01a19830
0x19 0x99a3093f
0x1a 0x411111f0
0x1b 0x99130110
0x1d 0x40079a2d
0x1e 0x99430120
0x21 0x0121401f

/sys/class/sound/hwC0D0/driver_pin_configs:
0x17 0x99130111

/sys/class/sound/hwC0D0/user_pin_configs:

/sys/class/sound/hwC0D0/init_verbs:


!!ALSA/HDA dmesg
!!------------------

[    7.140452] ieee80211 phy0: Selected rate control algorithm 'iwl-agn-r=
s'
[    7.760717] HDA Intel 0000:00:1b.0: PCI INT A ->  GSI 22 (level, low) =
->  IRQ 22
[    7.760839] HDA Intel 0000:00:1b.0: irq 49 for MSI/MSI-X
[    7.760902] HDA Intel 0000:00:1b.0: setting latency timer to 64
[    7.760912] ALSA sound/pci/hda/hda_intel.c:2530: chipset global capabi=
lities =3D 0x4401
[    7.839383] ALSA sound/pci/hda/hda_intel.c:913: codec_mask =3D 0x1
[    7.839687] ALSA sound/pci/hda/hda_intel.c:1351: codec #0 probed OK
[    8.018570] ALSA sound/pci/hda/patch_realtek.c:1524: SKU: Nid=3D0x1d s=
ku_cfg=3D0x40079a2d
[    8.018581] ALSA sound/pci/hda/patch_realtek.c:1526: SKU: port_connect=
ivity=3D0x1
[    8.018587] ALSA sound/pci/hda/patch_realtek.c:1527: SKU: enable_pcbee=
p=3D0x0
[    8.018594] ALSA sound/pci/hda/patch_realtek.c:1528: SKU: check_sum=3D=
0x00000007
[    8.018601] ALSA sound/pci/hda/patch_realtek.c:1529: SKU: customizatio=
n=3D0x0000009a
[    8.018608] ALSA sound/pci/hda/patch_realtek.c:1530: SKU: external_amp=
=3D0x5
[    8.018615] ALSA sound/pci/hda/patch_realtek.c:1531: SKU: platform_typ=
e=3D0x1
[    8.018621] ALSA sound/pci/hda/patch_realtek.c:1532: SKU: swap=3D0x0
[    8.018627] ALSA sound/pci/hda/patch_realtek.c:1533: SKU: override=3D0=
x1
[    8.019090] ALSA sound/pci/hda/hda_codec.c:3726: hda_codec: model 'aut=
o' is selected for config 1043:1113 (ASUS N53Jf)
[    8.019096] ALSA sound/pci/hda/patch_realtek.c:1712: hda_codec: ALC269=
VB: Apply pincfg for Asus N53Jf
[    8.019111] ALSA sound/pci/hda/hda_codec.c:4630: autoconfig: line_outs=
=3D2 (0x1b/0x17/0x0/0x0/0x0)
[    8.019116] ALSA sound/pci/hda/hda_codec.c:4634:    speaker_outs=3D0 (=
0x0/0x0/0x0/0x0/0x0)
[    8.019120] ALSA sound/pci/hda/hda_codec.c:4638:    hp_outs=3D1 (0x21/=
0x0/0x0/0x0/0x0)
[    8.019124] ALSA sound/pci/hda/hda_codec.c:4639:    mono: mono_out=3D0=
x0
[    8.019128] ALSA sound/pci/hda/hda_codec.c:4642:    dig-out=3D0x1e/0x0
[    8.019131] ALSA sound/pci/hda/hda_codec.c:4643:    inputs:
[    8.019134] ALSA sound/pci/hda/hda_codec.c:4647:  Mic=3D0x18
[    8.019138] ALSA sound/pci/hda/hda_codec.c:4647:  Internal Mic=3D0x19
[    8.019142] ALSA sound/pci/hda/hda_codec.c:4649:
[    8.020072] ALSA sound/pci/hda/patch_realtek.c:1581: realtek: No valid=
 SSID, checking pincfg 0x40079a2d for NID 0x1d
[    8.020077] ALSA sound/pci/hda/patch_realtek.c:1597: realtek: Enabling=
 init ASM_ID=3D0x9a2d CODEC_ID=3D10ec0269
[    8.020082] ALSA sound/pci/hda/patch_realtek.c:1411: realtek: Enable H=
P auto-muting on NID 0x21
[    8.020088] ALSA sound/pci/hda/patch_realtek.c:1456: realtek: Enable a=
uto-mic switch on NID 0x18/0x19
[    8.023742] ALSA sound/pci/hda/hda_codec.c:2164: Cannot find slave Fro=
nt Playback Volume, skipped
[    8.023747] ALSA sound/pci/hda/hda_codec.c:2164: Cannot find slave Sur=
round Playback Volume, skipped
[    8.023751] ALSA sound/pci/hda/hda_codec.c:2164: Cannot find slave Cen=
ter Playback Volume, skipped
[    8.023756] ALSA sound/pci/hda/hda_codec.c:2164: Cannot find slave LFE=
 Playback Volume, skipped
[    8.023760] ALSA sound/pci/hda/hda_codec.c:2164: Cannot find slave Sid=
e Playback Volume, skipped
[    8.023764] ALSA sound/pci/hda/hda_codec.c:2164: Cannot find slave Hea=
dphone Playback Volume, skipped
[    8.023770] ALSA sound/pci/hda/hda_codec.c:2164: Cannot find slave Mon=
o Playback Volume, skipped
[    8.023774] ALSA sound/pci/hda/hda_codec.c:2164: Cannot find slave Lin=
e-Out Playback Volume, skipped
[    8.023778] ALSA sound/pci/hda/hda_codec.c:2164: Cannot find slave PCM=
 Playback Volume, skipped
[    8.023787] ALSA sound/pci/hda/hda_codec.c:2164: Cannot find slave Fro=
nt Playback Switch, skipped
[    8.023792] ALSA sound/pci/hda/hda_codec.c:2164: Cannot find slave Sur=
round Playback Switch, skipped
[    8.023796] ALSA sound/pci/hda/hda_codec.c:2164: Cannot find slave Cen=
ter Playback Switch, skipped
[    8.023800] ALSA sound/pci/hda/hda_codec.c:2164: Cannot find slave LFE=
 Playback Switch, skipped
[    8.023804] ALSA sound/pci/hda/hda_codec.c:2164: Cannot find slave Sid=
e Playback Switch, skipped
[    8.023812] ALSA sound/pci/hda/hda_codec.c:2164: Cannot find slave Mon=
o Playback Switch, skipped
[    8.023819] ALSA sound/pci/hda/hda_codec.c:2164: Cannot find slave Lin=
e-Out Playback Switch, skipped
[    8.023823] ALSA sound/pci/hda/hda_codec.c:2164: Cannot find slave PCM=
 Playback Switch, skipped
[    8.024352] input: HDA Intel Mic as /devices/pci0000:00/0000:00:1b.0/s=
ound/card0/input9
[    8.024487] input: HDA Intel Headphone as /devices/pci0000:00/0000:00:=
1b.0/sound/card0/input10
[   10.004618] Adding 3905532k swap on /dev/sda5.  Priority:-1 extents:1 =
across:3905532k
--
[   19.543476] NFSD: starting 90-second grace period
[   24.032281] ALSA sound/pci/hda/hda_intel.c:1675: azx_pcm_prepare: bufs=
ize=3D0x10000, format=3D0x31
[   24.032301] ALSA sound/pci/hda/hda_codec.c:1227: hda_codec_setup_strea=
m: NID=3D0x6, stream=3D0x5, channel=3D0, format=3D0x31
[   24.032511] ALSA sound/pci/hda/hda_codec.c:1227: hda_codec_setup_strea=
m: NID=3D0x3, stream=3D0x5, channel=3D0, format=3D0x31
[   24.062896] ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_str=
eam: NID=3D0x3
[   24.062904] ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_str=
eam: NID=3D0x6
[   25.845885] apm: BIOS not found.
--
[   59.055664] CPUFREQ: Per core ondemand sysfs interface is deprecated -=
 up_threshold
[   81.168959] ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_str=
eam: NID=3D0x6
[   81.230804] ALSA sound/pci/hda/hda_intel.c:1675: azx_pcm_prepare: bufs=
ize=3D0x10000, format=3D0x31
[   81.230824] ALSA sound/pci/hda/hda_codec.c:1227: hda_codec_setup_strea=
m: NID=3D0x6, stream=3D0x5, channel=3D0, format=3D0x31
[   81.230831] ALSA sound/pci/hda/hda_codec.c:1227: hda_codec_setup_strea=
m: NID=3D0x3, stream=3D0x5, channel=3D0, format=3D0x31
[   81.233247] ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_str=
eam: NID=3D0x3
[   81.233251] ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_str=
eam: NID=3D0x6
[   81.570625] ALSA sound/pci/hda/hda_intel.c:1675: azx_pcm_prepare: bufs=
ize=3D0x10000, format=3D0x31
[   81.570649] ALSA sound/pci/hda/hda_codec.c:1227: hda_codec_setup_strea=
m: NID=3D0x6, stream=3D0x5, channel=3D0, format=3D0x31
[   81.570659] ALSA sound/pci/hda/hda_codec.c:1227: hda_codec_setup_strea=
m: NID=3D0x3, stream=3D0x5, channel=3D0, format=3D0x31
[   81.572936] ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_str=
eam: NID=3D0x3
[   81.572943] ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_str=
eam: NID=3D0x6
[   81.575200] ALSA sound/pci/hda/hda_intel.c:1675: azx_pcm_prepare: bufs=
ize=3D0x10000, format=3D0x31
[   81.575219] ALSA sound/pci/hda/hda_codec.c:1227: hda_codec_setup_strea=
m: NID=3D0x6, stream=3D0x5, channel=3D0, format=3D0x31
[   81.575229] ALSA sound/pci/hda/hda_codec.c:1227: hda_codec_setup_strea=
m: NID=3D0x3, stream=3D0x5, channel=3D0, format=3D0x31
[   81.575642] ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_str=
eam: NID=3D0x3
[   81.575648] ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_str=
eam: NID=3D0x6
[   82.096033] ALSA sound/pci/hda/hda_intel.c:1675: azx_pcm_prepare: bufs=
ize=3D0x10000, format=3D0x31
[   82.096057] ALSA sound/pci/hda/hda_codec.c:1227: hda_codec_setup_strea=
m: NID=3D0x6, stream=3D0x5, channel=3D0, format=3D0x31
[   82.096067] ALSA sound/pci/hda/hda_codec.c:1227: hda_codec_setup_strea=
m: NID=3D0x3, stream=3D0x5, channel=3D0, format=3D0x31
[   90.411144] ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_str=
eam: NID=3D0x3
[   90.411152] ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_str=
eam: NID=3D0x6
[  326.983324] ALSA sound/pci/hda/hda_intel.c:1675: azx_pcm_prepare: bufs=
ize=3D0x10000, format=3D0x31
[  326.983343] ALSA sound/pci/hda/hda_codec.c:1227: hda_codec_setup_strea=
m: NID=3D0x6, stream=3D0x5, channel=3D0, format=3D0x31
[  326.983348] ALSA sound/pci/hda/hda_codec.c:1227: hda_codec_setup_strea=
m: NID=3D0x3, stream=3D0x5, channel=3D0, format=3D0x31
[  329.306843] hda-intel: IRQ timing workaround is activated for card #0.=
 Suggest a bigger bdl_pos_adj.
[ 1180.124078] atl1c 0000:06:00.0: vpd r/w failed.  This is likely a firm=
ware bug on this device.  Contact the card vendor for a firmware update.




--------------090301010909000309090805
Content-Type: text/x-diff;
 name="patch_realtek.c-ausu--n53jf.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="patch_realtek.c-ausu--n53jf.patch"

--- /usr/src/l2.6.37-rc7/sound/pci/hda/patch_realtek.c	2010-12-28 15:37:10.900000008 +0100
+++ ./patch_realtek.c	2010-12-28 15:23:09.390000004 +0100
@@ -14854,6 +14854,7 @@
 	SND_PCI_QUIRK(0x1028, 0x0470, "Dell M101z", ALC269_FIXUP_DELL_M101Z),
 	SND_PCI_QUIRK(0x17aa, 0x21b8, "Thinkpad Edge 14", ALC269_FIXUP_SKU_IGNORE),
 	SND_PCI_QUIRK(0x17aa, 0x20f2, "Thinkpad SL410/510", ALC269_FIXUP_SKU_IGNORE),
+	SND_PCI_QUIRK(0x1043, 0x1113, "Asus N53Jf", ALC269_FIXUP_ASUS_G73JW),		// Connect Subwoofer "Asus Sonic Master"
 	SND_PCI_QUIRK(0x1043, 0x1a13, "Asus G73Jw", ALC269_FIXUP_ASUS_G73JW),
 	{}
 };
@@ -14878,7 +14879,11 @@
 	SND_PCI_QUIRK(0x1043, 0x8330, "ASUS Eeepc P703 P900A",
 		      ALC269_AMIC),
 	SND_PCI_QUIRK(0x1043, 0x1013, "ASUS N61Da", ALC269VB_AMIC),
-	SND_PCI_QUIRK(0x1043, 0x1113, "ASUS N63Jn", ALC269VB_AMIC),
+
+//	SND_PCI_QUIRK(0x1043, 0x1113, "ASUS N63Jn", ALC269VB_AMIC),	// PCI ID Collide with Asus N53Jf
+																// and spoil Codec
+	SND_PCI_QUIRK(0x1043, 0x1113, "ASUS N53Jf", ALC269_AUTO),
+
 	SND_PCI_QUIRK(0x1043, 0x1143, "ASUS B53f", ALC269VB_AMIC),
 	SND_PCI_QUIRK(0x1043, 0x1133, "ASUS UJ20ft", ALC269_AMIC),
 	SND_PCI_QUIRK(0x1043, 0x1183, "ASUS K72DR", ALC269VB_AMIC),


--------------090301010909000309090805
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------090301010909000309090805--
