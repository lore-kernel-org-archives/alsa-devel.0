From: Vincent Blut <vincent.debian@free.fr>
Subject: Re: [3.6.9 -> 3.7.1 regression] sound: snd_hda_intel codec probing
 issue?
Date: Tue, 08 Jan 2013 13:28:55 +0100
Message-ID: <1357648135.3849.7.camel@lamella>
References: <1356704740.3953.26.camel@lamella>
	 <s5hvcber5cz.wl%tiwai@suse.de> <1357421043.3912.13.camel@lamella>
	 <s5h38ydpf45.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5h38ydpf45.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Le lundi 07 janvier 2013 =C3=A0 09:32 +0100, Takashi Iwai a =C3=A9crit =
:
> At Sat, 05 Jan 2013 22:24:03 +0100,
> Vincent Blut wrote:
> >=20
> > Le jeudi 03 janvier 2013 =C3=A0 10:19 +0100, Takashi Iwai a =C3=A9c=
rit :
> > > At Fri, 28 Dec 2012 15:25:40 +0100,
> > > Vincent Blut wrote:
> > > >=20
> > > > Hi,
> > > >=20
> > > > Since I updated to Linux 3.7.1, listening to some audio/video b=
its
> > > > frequently cause the following:
> > > >=20
> > > > [ 7896.166946] hda-intel: azx_get_response timeout, switching t=
o polling
> > > > mode: last cmd=3D0x020c0000
> > > > [ 7897.173444] hda-intel: No response from codec, disabling MSI=
: last
> > > > cmd=3D0x020c0000
> > > > [ 7898.179932] hda_intel: azx_get_response timeout, switching t=
o
> > > > single_cmd mode: last cmd=3D0x020c0000
> > > > [ 7898.179983] hda-codec: out of range cmd 0:0:20:400:fffff7ff
> > > > [ 9445.034371] plugin-containe[5873]: segfault at 7f44bb95e639 =
ip
> > > > 00007f44e454bca0 sp 00007f44c91165f8 error 4 in
> > > > libc-2.13.so[7f44e442c000+180000]
> > > >=20
> > > > It seems to be a codec probing failure (?). This is really fata=
l because
> > > > the sound become very choppy and can't recover until I reboot.
> > > > I'll try to play with 'probe_mask' kernel parameter to see if I=
 can
> > > > narrow the correct codec slots!
> > > >=20
> > > > By the way I can't reproduce this on 3.6.9, so is there somethi=
ng that
> > > > changed in this area in 3.7.1?
> > >=20
> > > If it's new in 3.7, this could be a regression by runtime D3.
> > > Try to pass power_save_controller=3D0 option to snd-hda-intel mod=
ule
> > > (or change it via sysfs dynamically).
> > >=20
> > >=20
> > > thanks,
> > >=20
> > > Takashi
> >=20
> > Hi Takashi,
> >=20
> > Well, power_save_controller=3D0 seems to do the trick but I get ple=
nty of:
> >=20
> >=20
> > [   15.389270] pci_pm_runtime_suspend(): azx_runtime_suspend+0x0/0x=
37
> > [snd_hda_intel] returns -11
> > [   25.178725] pci_pm_runtime_suspend(): azx_runtime_suspend+0x0/0x=
37
> > [snd_hda_intel] returns -11
> > [   72.296536] pci_pm_runtime_suspend(): azx_runtime_suspend+0x0/0x=
37
> > [snd_hda_intel] returns -11
> > [ 2318.147505] pci_pm_runtime_suspend(): azx_runtime_suspend+0x0/0x=
37
> > [snd_hda_intel] returns -11
> > [ 6086.029839] pci_pm_runtime_suspend(): azx_runtime_suspend+0x0/0x=
37
> > [snd_hda_intel] returns -11
> > [ 7390.772818] pci_pm_runtime_suspend(): azx_runtime_suspend+0x0/0x=
37
> > [snd_hda_intel] returns -11
> >=20
> >=20
> > which I think is fixed in 3.8 by commit 6eb827d23577
>=20
> Yes, and should be merged in the next stable release.
>=20
> > So what's the next step? Adding a quirk for this sound card? Or is =
there
> > a way to fix the root cause?=20
>=20
> One more thing to test is whether azx_runtime_resume() is properly
> called before this error happens.  Could you put a debug print and
> check it?  If it's not called, it implies that the refcount or
> something else got broken.  If it's called but the device doesn't
> respond, it's a hardware-specific issue, and the likely solution is t=
o
> add a device-specific quirk.
>=20

Ok, I added a debug printk() which is called:

$ dmesg | grep -i debug
[ 5330.371523] [debug] Probably needs a device-specific quirk!

As usual, when it is called the sound become very choppy.

I'll test with enable_msi=3D0 later.

>=20
> thanks,
>=20
> Takashi

Thanks,
Vincent
