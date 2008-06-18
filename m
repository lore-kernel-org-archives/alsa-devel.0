From: randall <lists_rlr@roadrunner.com>
Subject: question on hda_codec.c behavior
Date: Wed, 18 Jun 2008 10:24:52 -0700
Message-ID: <200806181024.53034.lists_rlr@roadrunner.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mta16.adelphia.net (mta16.mail.adelphia.net [68.168.78.211])
	by alsa0.perex.cz (Postfix) with ESMTP id 60D83244B1
	for <alsa-devel@alsa-project.org>;
	Wed, 18 Jun 2008 19:24:55 +0200 (CEST)
Received: from [192.168.1.100] (really [76.176.117.148]) by mta16.adelphia.net
	(InterMail vM.6.01.05.04 201-2131-123-105-20051025) with ESMTP
	id <20080618172427.DUHS10601.mta16.adelphia.net@[192.168.1.100]>
	for <alsa-devel@alsa-project.org>; Wed, 18 Jun 2008 13:24:27 -0400
Content-Disposition: inline
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

I've not yet been able to get the Nvidia MCP61 (RealTek ALC662) onboard sou=
nd =

working (EliteGroup Computer Systems) on the Athlon 64 3200+ motherboard.

A hwinfo is enclosed:

21: PCI 05.0: 0403 Audio device
=A0 [Created at pci.301]
=A0 UDI: /org/freedesktop/Hal/devices/pci_10de_3f0
=A0 Unique ID: CvwD.9hpqWdunz16
=A0 SysFS ID: /devices/pci0000:00/0000:00:05.0
=A0 SysFS BusID: 0000:00:05.0
=A0 Hardware Class: sound
=A0 Model: "Elitegroup MCP61 High Definition Audio"
=A0 Vendor: pci 0x10de "nVidia Corporation"
=A0 Device: pci 0x03f0 "MCP61 High Definition Audio"
=A0 SubVendor: pci 0x1019 "Elitegroup Computer Systems"
=A0 SubDevice: pci 0x2151
=A0 Revision: 0xa2
=A0 Driver: "HDA Intel"
=A0 Driver Modules: "snd_hda_intel"
=A0 Memory Range: 0xfe028000-0xfe02bfff (rw,non-prefetchable)
=A0 IRQ: 22 (409 events)
=A0 Module Alias: "pci:v000010DEd000003F0sv00001019sd00002151bc04sc03i00"
=A0 Driver Info #0:
=A0 =A0 Driver Status: snd_hda_intel is active
=A0 =A0 Driver Activation Cmd: "modprobe snd_hda_intel"
=A0 Config Status: cfg=3Dno, avail=3Dyes, need=3Dno, active=3Dunknown

and the pastebin is http://pastebin.ca/1048637 for all the information on t=
he =

sound setup.

YaST2 does the typical sound card editing, and you can hear the speakers cl=
ick =

when the card is (de)activated. =A0But no sound is available, even using th=
e =

speaker-test command or running alsaconf.

I've gradually worked my way up from v1.0.14 to the current v1.0.17rl1 but =

have no success yet in getting the sound modules to work for the Nvidia MCP=
61 =

setup.

After posting in the install newsgroup one of the persons trying to help me =

out suggested that I send a note to the developer's group for the following =

reason, the /var/log/message file contains the following upon booting up

> hda_codec: Unknown model for ALC662, trying auto-probe from BIOS...
> ALSA sound/pci/hda/hda_codec.c:2333: autoconfig: line_outs=3D1 =

> (0x14/0x0/0x0/0x0/0x0)
> ALSA sound/pci/hda/hda_codec.c:2337: =A0 =A0speaker_outs=3D0 (0x0/0x0/0x0=
/0x0/0x0)
> ALSA sound/pci/hda/hda_codec.c:2341: =A0 =A0hp_outs=3D1 (0x1b/0x0/0x0/0x0=
/0x0)
> ALSA sound/pci/hda/hda_codec.c:2349: =A0 =A0inputs: mic=3D0x18, fmic=3D0x=
19, =

> line=3D0x1a, fline=3D0x0, cd=3D0x0, aux=3D0x0
> hda_codec: num_steps =3D 0 for NID=3D0xc

And the thought was that "Unknown model" should not be occurring.  =

The /etc/modprobe.d/sound file has one of the allowed models for this codec.

Any ideas?  Does hda_codec.c need a patch?

Randall
