From: Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: iec958 regression with alsa 1.0.22 and kernel
 2.6.33 on Intel DG45FC motherboard
Date: Thu, 6 May 2010 18:20:17 +0800
Message-ID: <20100506102017.GA19051@localhost>
References: <20100505230516.GA4765@hardeman.nu>
	<20100506005509.GC5335@localhost>
	<0c7a6777d7b1bd6032e87a5955efb7cd.squirrel@www.hardeman.nu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="xHFwDpU9dbj6ez1V"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 49C572466D
	for <alsa-devel@alsa-project.org>;
	Thu,  6 May 2010 12:20:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <0c7a6777d7b1bd6032e87a5955efb7cd.squirrel@www.hardeman.nu>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David =?utf-8?B?SMOkcmRlbWFu?= <david@hardeman.nu>
Cc: "alsa-user@lists.sourceforge.net" <alsa-user@lists.sourceforge.net>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Alexey Fisher <bug-track@fisher-privat.net>
List-Id: alsa-devel@alsa-project.org


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

David,

The attached patch should fix your broken SPDIF output.

Also attached more data for possible future reference.

Thanks,
Fengguang
--

On Thu, May 06, 2010 at 03:42:27PM +0800, David H=C3=A4rdeman wrote:
> On Thu, May 6, 2010 02:55, Wu Fengguang wrote:
> > On Thu, May 06, 2010 at 07:05:16AM +0800, David H=C3=83=C2=A4rdeman w=
rote:
> >> A recent upgrade to kernel 2.6.33.x and alsa 1.0.22 broke spdif (iec=
958)
> >
> > Upgraded from which kernel?
>=20
> 2.6.32.something, can check exact version later if you want. alsa
> userspace bits were upgraded at the same time (can also check from whic=
h
> version later if necessary).
>=20
> >> output on my Intel DG45FC motherboard (IDT 92HD73E1X5 codec,
> >> snd-hda-intel driver).
> >>
> >> After playing around a bit with module params, it turns out that loa=
ding
> >> snd-hda-intel with model=3Dno-jd fixes this problem (previously the =
module
> >> worked without any model option at all, note also that model=3Dintel=
 does
> >> not work which is kinda weird).
> >
> > You mean model=3Dintel never worked?
>=20
> No, I mean that I've never used a model=3D parameter before, and in try=
ing
> to debug this new problem I tried model=3Dintel which did not fix it bu=
t
> model=3Dno-jd does. So model=3Dintel might have worked before.
>=20
> On a related note, why is model=3Dintel even there (and why is the end-=
user
> expected to set it)? The docs says it's for DG45FC and DG45ID
> motherboards, but shouldn't those motherboards be possible to autodetec=
t
> in the driver via DMI info?
>=20
> --=20
> David H=C3=A4rdeman

--xHFwDpU9dbj6ez1V
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment; filename="alsa-dg45id-spdif-fix.patch"
Content-Transfer-Encoding: quoted-printable

Subject: hda - fix DG45ID SPDIF output
From: Wu Fengguang <fengguang.wu@intel.com>
Date: Thu May 06 18:11:57 CST 2010

This reverts part of commit 52dc438606d1e.

  2.6.32 (OK)							  |  2.6.34 (broken)
-------------------------------------------------------------------------=
------------------------------------------------------------
  Node 0x22 [Pin Complex] wcaps 0x400301: Stereo Digital          |  Node=
 0x22 [Pin Complex] wcaps 0x400301: Stereo Digital
    Pincap 0x00000010: OUT                                        |    Pi=
ncap 0x00000010: OUT
    Pin Default 0x40f000f0: [N/A] Other at Ext N/A                |    Pi=
n Default 0x014510a0: [Jack] SPDIF Out at Ext Rear         =20
      Conn =3D Unknown, Color =3D Unknown                             |  =
    Conn =3D Optical, Color =3D Black                              =20
      DefAssociation =3D 0xf, Sequence =3D 0x0                        |  =
    DefAssociation =3D 0xa, Sequence =3D 0x0                       =20
    Pin-ctls: 0x00:                                               |    Pi=
n-ctls: 0x40: OUT                                          =20
    Connection: 3                                                 |    Co=
nnection: 3
       0x25* 0x20 0x21                                            |      =
 0x25* 0x20 0x21
  Node 0x23 [Pin Complex] wcaps 0x400301: Stereo Digital          |  Node=
 0x23 [Pin Complex] wcaps 0x400301: Stereo Digital
    Pincap 0x00000010: OUT                                        |    Pi=
ncap 0x00000010: OUT
    Pin Default 0x01451140: [Jack] SPDIF Out at Ext Rear          |    Pi=
n Default 0x074510b0: [Jack] SPDIF Out at Ext Rear Panel   =20
      Conn =3D Optical, Color =3D Black                               |  =
    Conn =3D Optical, Color =3D Black
      DefAssociation =3D 0x4, Sequence =3D 0x0                        |  =
    DefAssociation =3D 0xb, Sequence =3D 0x0                       =20
      Misc =3D NO_PRESENCE                                          |    =
Pin-ctls: 0x00:                                              =20
    Pin-ctls: 0x40: OUT                                           |  ----=
------------------------------------------------------------
    Connection: 3                                                 |    Co=
nnection: 3
       0x26* 0x20 0x21                                            |      =
 0x26* 0x20 0x21

Reported-by: David H=C3=A4rdeman <david@hardeman.nu>
CC: Alexey Fisher <bug-track@fisher-privat.net>
Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
---
 sound/pci/hda/patch_sigmatel.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- sound-2.6.orig/sound/pci/hda/patch_sigmatel.c	2010-05-06 18:10:30.000=
000000 +0800
+++ sound-2.6/sound/pci/hda/patch_sigmatel.c	2010-05-06 18:11:54.00000000=
0 +0800
@@ -1546,9 +1546,7 @@ static unsigned int alienware_m17x_pin_c
=20
 static unsigned int intel_dg45id_pin_configs[14] =3D {
 	0x02214230, 0x02A19240, 0x01013214, 0x01014210,
-	0x01A19250, 0x01011212, 0x01016211, 0x40f000f0,
-	0x40f000f0, 0x40f000f0, 0x40f000f0, 0x014510A0,
-	0x074510B0, 0x40f000f0
+	0x01A19250, 0x01011212, 0x01016211
 };
=20
 static unsigned int *stac92hd73xx_brd_tbl[STAC_92HD73XX_MODELS] =3D {

--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dg45fc-configs-2.6.32"

/sys/class/sound/card0/hwC0D2/init_pin_configs:0x0a 0x0221401f
/sys/class/sound/card0/hwC0D2/init_pin_configs:0x0b 0x02a19020
/sys/class/sound/card0/hwC0D2/init_pin_configs:0x0c 0x01113014
/sys/class/sound/card0/hwC0D2/init_pin_configs:0x0d 0x01114010
/sys/class/sound/card0/hwC0D2/init_pin_configs:0x0e 0x01a19030
/sys/class/sound/card0/hwC0D2/init_pin_configs:0x0f 0x01111012
/sys/class/sound/card0/hwC0D2/init_pin_configs:0x10 0x01116011
/sys/class/sound/card0/hwC0D2/init_pin_configs:0x11 0x40f000f0
/sys/class/sound/card0/hwC0D2/init_pin_configs:0x12 0x40f000f0
/sys/class/sound/card0/hwC0D2/init_pin_configs:0x13 0x40f000f0
/sys/class/sound/card0/hwC0D2/init_pin_configs:0x14 0x40f000f0
/sys/class/sound/card0/hwC0D2/init_pin_configs:0x22 0x40f000f0
/sys/class/sound/card0/hwC0D2/init_pin_configs:0x23 0x01451140
/sys/class/sound/card0/hwC0D2/init_pin_configs:0x24 0x40f000f0

--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dg45fc-2.6.32"

Codec: IDT 92HD73E1X5
Address: 2
Function Id: 0x1
Vendor Id: 0x111d7676
Subsystem Id: 0x80865003
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
  Pin Default 0x0221401f: [Jack] HP Out at Ext Front
    Conn = 1/8, Color = Green
    DefAssociation = 0x1, Sequence = 0xf
  Pin-ctls: 0x00: VREF_HIZ
  Unsolicited: tag=01, enabled=1
  Connection: 6
     0x15 0x16 0x17 0x18 0x19* 0x1e
Node 0x0b [Pin Complex] wcaps 0x400183: Stereo Amp-In
  Amp-In caps: N/A
  Amp-In vals:  [0x00 0x00]
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
  Amp-In caps: N/A
  Amp-In vals:  [0x00 0x00]
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
  Amp-Out caps: N/A
  Amp-Out vals:  [0x7f 0x7f]
  Converter: stream=0, channel=0
  Power: setting=D0, actual=D0
  Delay: 13 samples
Node 0x16 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out R/L
  Amp-Out caps: N/A
  Amp-Out vals:  [0xff 0xff]
  Converter: stream=0, channel=0
  Power: setting=D0, actual=D0
  Delay: 13 samples
Node 0x17 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out R/L
  Amp-Out caps: N/A
  Amp-Out vals:  [0xf7 0xf7]
  Converter: stream=0, channel=0
  Power: setting=D0, actual=D0
  Delay: 13 samples
Node 0x18 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out R/L
  Amp-Out caps: N/A
  Amp-Out vals:  [0xff 0xff]
  Converter: stream=0, channel=0
  Power: setting=D0, actual=D0
  Delay: 13 samples
Node 0x19 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out R/L
  Amp-Out caps: N/A
  Amp-Out vals:  [0xff 0xff]
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
  Amp-Out caps: ofs=0x00, nsteps=0x0f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x80 0x80]
  Connection: 12
     0x0a 0x0b 0x0c 0x0d 0x0e* 0x0f 0x10 0x11 0x12 0x13 0x14 0x1d
Node 0x21 [Audio Selector] wcaps 0x30090d: Stereo Amp-Out R/L
  Amp-Out caps: ofs=0x00, nsteps=0x0f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x80 0x80]
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

--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dg45fc-configs-2.6.34-rc2"

/sys/class/sound/card0/hwC0D2/driver_pin_configs:0x0a 0x02214230
/sys/class/sound/card0/hwC0D2/driver_pin_configs:0x0b 0x02a19240
/sys/class/sound/card0/hwC0D2/driver_pin_configs:0x0c 0x01013214
/sys/class/sound/card0/hwC0D2/driver_pin_configs:0x0d 0x01014210
/sys/class/sound/card0/hwC0D2/driver_pin_configs:0x0e 0x01a19250
/sys/class/sound/card0/hwC0D2/driver_pin_configs:0x0f 0x01011212
/sys/class/sound/card0/hwC0D2/driver_pin_configs:0x10 0x01016211
/sys/class/sound/card0/hwC0D2/driver_pin_configs:0x11 0x40f000f0
/sys/class/sound/card0/hwC0D2/driver_pin_configs:0x12 0x40f000f0
/sys/class/sound/card0/hwC0D2/driver_pin_configs:0x13 0x40f000f0
/sys/class/sound/card0/hwC0D2/driver_pin_configs:0x14 0x40f000f0
/sys/class/sound/card0/hwC0D2/driver_pin_configs:0x22 0x014510a0
/sys/class/sound/card0/hwC0D2/driver_pin_configs:0x23 0x074510b0
/sys/class/sound/card0/hwC0D2/init_pin_configs:0x0a 0x0221401f
/sys/class/sound/card0/hwC0D2/init_pin_configs:0x0b 0x02a19020
/sys/class/sound/card0/hwC0D2/init_pin_configs:0x0c 0x01113014
/sys/class/sound/card0/hwC0D2/init_pin_configs:0x0d 0x01114010
/sys/class/sound/card0/hwC0D2/init_pin_configs:0x0e 0x01a19030
/sys/class/sound/card0/hwC0D2/init_pin_configs:0x0f 0x01111012
/sys/class/sound/card0/hwC0D2/init_pin_configs:0x10 0x01116011
/sys/class/sound/card0/hwC0D2/init_pin_configs:0x11 0x40f000f0
/sys/class/sound/card0/hwC0D2/init_pin_configs:0x12 0x40f000f0
/sys/class/sound/card0/hwC0D2/init_pin_configs:0x13 0x40f000f0
/sys/class/sound/card0/hwC0D2/init_pin_configs:0x14 0x40f000f0
/sys/class/sound/card0/hwC0D2/init_pin_configs:0x22 0x40f000f0
/sys/class/sound/card0/hwC0D2/init_pin_configs:0x23 0x01451140
/sys/class/sound/card0/hwC0D2/init_pin_configs:0x24 0x40f000f0

--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dg45fc-2.6.34-rc2"

Codec: IDT 92HD73E1X5
Address: 2
Function Id: 0x1
Vendor Id: 0x111d7676
Subsystem Id: 0x80865003
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
  Control: name="Front Mic Jack Mode", index=0, device=0
    ControlAmp: chs=0, dir=In, idx=0, ofs=0
  Control: name="Front Mic Capture Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
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
  Pin Default 0x01013214: [Jack] Line Out at Ext Rear
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
  Pin Default 0x01014210: [Jack] Line Out at Ext Rear
    Conn = 1/8, Color = Green
    DefAssociation = 0x1, Sequence = 0x0
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=05, enabled=1
  Connection: 6
     0x15* 0x16 0x17 0x18 0x19 0x1e
Node 0x0e [Pin Complex] wcaps 0x400183: Stereo Amp-In
  Control: name="Mic Jack Mode", index=0, device=0
    ControlAmp: chs=0, dir=In, idx=0, ofs=0
  Control: name="Mic Capture Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Amp-In caps: N/A
  Amp-In vals:  [0x00 0x00]
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
  Pin Default 0x01011212: [Jack] Line Out at Ext Rear
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
  Pin Default 0x01016211: [Jack] Line Out at Ext Rear
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
  Control: name="Front Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=63
  Control: name="Front Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Device: name="STAC92xx Analog", type="Audio", device=0
  Amp-Out caps: N/A
  Amp-Out vals:  [0xc5 0xc5]
  Converter: stream=0, channel=0
  Power: setting=D0, actual=D0
  Delay: 13 samples
Node 0x16 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out R/L
  Control: name="Surround Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=63
  Control: name="Surround Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Amp-Out caps: N/A
  Amp-Out vals:  [0xf7 0xf7]
  Converter: stream=0, channel=0
  Power: setting=D0, actual=D0
  Delay: 13 samples
Node 0x17 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out R/L
  Control: name="Center Playback Volume", index=0, device=0
    ControlAmp: chs=1, dir=Out, idx=0, ofs=63
  Control: name="Center Playback Switch", index=0, device=0
    ControlAmp: chs=1, dir=Out, idx=0, ofs=0
  Control: name="LFE Playback Volume", index=0, device=0
    ControlAmp: chs=2, dir=Out, idx=0, ofs=63
  Control: name="LFE Playback Switch", index=0, device=0
    ControlAmp: chs=2, dir=Out, idx=0, ofs=0
  Control: name="Swap Center/LFE Playback Switch", index=0, device=0
    ControlAmp: chs=0, dir=In, idx=0, ofs=0
  Amp-Out caps: N/A
  Amp-Out vals:  [0xf7 0xf7]
  Converter: stream=0, channel=0
  Power: setting=D0, actual=D0
  Delay: 13 samples
Node 0x18 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out R/L
  Control: name="Side Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=63
  Control: name="Side Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Amp-Out caps: N/A
  Amp-Out vals:  [0xf7 0xf7]
  Converter: stream=0, channel=0
  Power: setting=D0, actual=D0
  Delay: 13 samples
Node 0x19 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out R/L
  Control: name="Headphone Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=63
  Control: name="Headphone Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Amp-Out caps: N/A
  Amp-Out vals:  [0xff 0xff]
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
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="Capture Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Amp-Out caps: ofs=0x00, nsteps=0x0f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x80 0x80]
  Connection: 12
     0x0a 0x0b 0x0c 0x0d 0x0e* 0x0f 0x10 0x11 0x12 0x13 0x14 0x1d
Node 0x21 [Audio Selector] wcaps 0x30090d: Stereo Amp-Out R/L
  Control: name="Capture Volume", index=1, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="Capture Switch", index=1, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
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

--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--xHFwDpU9dbj6ez1V--
