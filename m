From: Leandro Lucarella <luca@llucax.com.ar>
Subject: Re: Regression 2.6.35: Intel N10/ICH 7 Family HDA (Realtek ALC662
 rev1) beep broken
Date: Tue, 3 Aug 2010 10:44:09 -0300
Message-ID: <20100803134409.GA3508@llucax.com.ar>
References: <20100803040054.GX3508@llucax.com.ar>
 <s5h39uw6ymf.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5h39uw6ymf.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, Kailang Yang <kailang@realtek.com>, Daniel T Chen <crimsun@ubuntu.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai, el  3 de agosto a las 07:42 me escribiste:
> At Tue, 3 Aug 2010 01:00:54 -0300,
> Leandro Lucarella wrote:
> >=20
> > Hi. I've upgraded from kernel 2.6.34 to 2.6.35 and the beep through=
 the
> > sound card stopped working. I found a very similar problem[1]
> > (commit[2]).
> >=20
> > [1] http://lkml.org/lkml/2010/7/28/228
> > [2] http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.=
git;a=3Dcommitdiff;h=3Ddc1eae256cfac03bf17bf3eb016e3a6423d3f9d5
> >=20
> > I've tried to manually enabling the beep with the steps in the e-ma=
il
> > thread I found:
> >=20
> > # echo -n 1 > /sys/class/sound/hwC0D2/subsystem_id
> > # echo -n 1 > /sys/class/sound/hwC0D2/reconfig
> >=20
> > But it didn't work (the beep still goes through the pcspkr).
>=20
> So, you want to hook the beep over codec but it doesn't work, right.
> Do you get "Beep" mixer elements and the dedicated input device?

No, I don't think I have any of them (cat cat /proc/bus/input/devices a=
t the
end).


> Please give alsa-info.sh output.

I didn't know where to find the script, Google gave me this:
http://git.alsa-project.org/?p=3Dalsa-driver.git;a=3Dblob_plain;f=3Duti=
ls/alsa-info.sh
So this is what I've use. I've shared the results at:
http://www.alsa-project.org/db/?f=3D6a051da2475c7246f40c493a310fecb0a1a=
289f5

> > I've tried to naively (I'm not a kernel hacker, so I was just guess=
ing) add a
> > new entry with the quirks beep_white_list by copying the entry for =
ASUS like
> > this:
> >=20
> > diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_re=
altek.c
> > index 596ea2f..ca3ed12 100644
> > --- a/sound/pci/hda/patch_realtek.c
> > +++ b/sound/pci/hda/patch_realtek.c
> > @@ -5183,6 +5183,7 @@ static void fillup_priv_adc_nids(struct hda_c=
odec *codec, hda_nid_t *nid
> > =20
> >  static struct snd_pci_quirk beep_white_list[] =3D {
> >         SND_PCI_QUIRK(0x1043, 0x829f, "ASUS", 1),
> > +       SND_PCI_QUIRK(0x8086, 0xd613, "INTEL", 1),
> >         {}
> >  };
> > =20
> > But it didn't work either.
>=20
> Hm, this should work.  At least, you should have beep mixer & co with
> this.

Well, my bad, I booted the wrong kernel when trying the patch. The patc=
h
works correctly, so I'll be very glad if it hits Linus kernel soon :)

I could send you the patch but I don't know exactly what to put in the
commit message. The problem is the same as the one with the ASUS P5-V?

> > Then I noticed, if I'm understanding the source code
> > (sound/pci/hda/patch_realtek.c) and documentation
> > (Documentation/sound/alsa/HD-Audio-Models.txt) right, that my card =
is not
> > present in the models listing, but it worked fine in 2.6.34 (and pr=
evious)
> > kernel(s).
>=20
> This is no problem.  The model entry is only for special cases.
> For normal machines, no quirks are needed.

OK, thanks for the help.

I hope the patch is committed into the main kernel soon.



# cat /proc/bus/input/devices
I: Bus=3D0011 Vendor=3D0001 Product=3D0001 Version=3Dab41
N: Name=3D"AT Translated Set 2 keyboard"
P: Phys=3Disa0060/serio0/input0
S: Sysfs=3D/devices/platform/i8042/serio0/input/input0
U: Uniq=3D
H: Handlers=3Dsysrq kbd event0=20
B: EV=3D120013
B: KEY=3D402000000 3803078f800d001 feffffdfffefffff fffffffffffffffe
B: MSC=3D10
B: LED=3D7

I: Bus=3D0010 Vendor=3D001f Product=3D0001 Version=3D0100
N: Name=3D"PC Speaker"
P: Phys=3Disa0061/input0
S: Sysfs=3D/devices/platform/pcspkr/input/input1
U: Uniq=3D
H: Handlers=3Dkbd event1=20
B: EV=3D40001
B: SND=3D6

I: Bus=3D0019 Vendor=3D0000 Product=3D0001 Version=3D0000
N: Name=3D"Power Button"
P: Phys=3DPNP0C0C/button/input0
S: Sysfs=3D/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input2
U: Uniq=3D
H: Handlers=3Dkbd event2=20
B: EV=3D3
B: KEY=3D10000000000000 0

I: Bus=3D0019 Vendor=3D0000 Product=3D0001 Version=3D0000
N: Name=3D"Power Button"
P: Phys=3DLNXPWRBN/button/input0
S: Sysfs=3D/devices/LNXSYSTM:00/LNXPWRBN:00/input/input3
U: Uniq=3D
H: Handlers=3Dkbd event3=20
B: EV=3D3
B: KEY=3D10000000000000 0

I: Bus=3D0003 Vendor=3D09da Product=3D022b Version=3D0110
N: Name=3D"A4Tech Wireless Battery Free Optical Mouse"
P: Phys=3Dusb-0000:00:1d.2-1/input0
S: Sysfs=3D/devices/pci0000:00/0000:00:1d.2/usb4/4-1/4-1:1.0/input/inpu=
t4
U: Uniq=3D
H: Handlers=3Dmouse0 event4=20
B: EV=3D17
B: KEY=3Dff0000 0 0 0 0
B: REL=3D303
B: MSC=3D10

I: Bus=3D0019 Vendor=3D0000 Product=3D0006 Version=3D0000
N: Name=3D"Video Bus"
P: Phys=3DLNXVIDEO/video/input0
S: Sysfs=3D/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/inpu=
t/input5
U: Uniq=3D
H: Handlers=3Dkbd event5=20
B: EV=3D3
B: KEY=3D3e000b00000000 0 0 0

--=20
Leandro Lucarella (AKA luca)                     http://llucax.com.ar/
----------------------------------------------------------------------
GPG Key: 5F5A8D05 (F8CD F9A7 BF00 5431 4145  104C 949E BFB6 5F5A 8D05)
----------------------------------------------------------------------
Demasiado lento para una estrella fugaz
Demasiado limpio para lo que vos acostumbras
Demasiado claro para tanta oscuridad
Demasiados sue=C3=B1os, poca realidad
