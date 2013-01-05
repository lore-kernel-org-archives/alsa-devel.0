From: Vincent Blut <vincent.debian@free.fr>
Subject: Re: [3.6.9 -> 3.7.1 regression] sound: snd_hda_intel codec probing
 issue?
Date: Sat, 05 Jan 2013 22:24:03 +0100
Message-ID: <1357421043.3912.13.camel@lamella>
References: <1356704740.3953.26.camel@lamella>
	 <s5hvcber5cz.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hvcber5cz.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Le jeudi 03 janvier 2013 =C3=A0 10:19 +0100, Takashi Iwai a =C3=A9crit =
:
> At Fri, 28 Dec 2012 15:25:40 +0100,
> Vincent Blut wrote:
> >=20
> > Hi,
> >=20
> > Since I updated to Linux 3.7.1, listening to some audio/video bits
> > frequently cause the following:
> >=20
> > [ 7896.166946] hda-intel: azx_get_response timeout, switching to po=
lling
> > mode: last cmd=3D0x020c0000
> > [ 7897.173444] hda-intel: No response from codec, disabling MSI: la=
st
> > cmd=3D0x020c0000
> > [ 7898.179932] hda_intel: azx_get_response timeout, switching to
> > single_cmd mode: last cmd=3D0x020c0000
> > [ 7898.179983] hda-codec: out of range cmd 0:0:20:400:fffff7ff
> > [ 9445.034371] plugin-containe[5873]: segfault at 7f44bb95e639 ip
> > 00007f44e454bca0 sp 00007f44c91165f8 error 4 in
> > libc-2.13.so[7f44e442c000+180000]
> >=20
> > It seems to be a codec probing failure (?). This is really fatal be=
cause
> > the sound become very choppy and can't recover until I reboot.
> > I'll try to play with 'probe_mask' kernel parameter to see if I can
> > narrow the correct codec slots!
> >=20
> > By the way I can't reproduce this on 3.6.9, so is there something t=
hat
> > changed in this area in 3.7.1?
>=20
> If it's new in 3.7, this could be a regression by runtime D3.
> Try to pass power_save_controller=3D0 option to snd-hda-intel module
> (or change it via sysfs dynamically).
>=20
>=20
> thanks,
>=20
> Takashi

Hi Takashi,

Well, power_save_controller=3D0 seems to do the trick but I get plenty =
of:


[   15.389270] pci_pm_runtime_suspend(): azx_runtime_suspend+0x0/0x37
[snd_hda_intel] returns -11
[   25.178725] pci_pm_runtime_suspend(): azx_runtime_suspend+0x0/0x37
[snd_hda_intel] returns -11
[   72.296536] pci_pm_runtime_suspend(): azx_runtime_suspend+0x0/0x37
[snd_hda_intel] returns -11
[ 2318.147505] pci_pm_runtime_suspend(): azx_runtime_suspend+0x0/0x37
[snd_hda_intel] returns -11
[ 6086.029839] pci_pm_runtime_suspend(): azx_runtime_suspend+0x0/0x37
[snd_hda_intel] returns -11
[ 7390.772818] pci_pm_runtime_suspend(): azx_runtime_suspend+0x0/0x37
[snd_hda_intel] returns -11


which I think is fixed in 3.8 by commit 6eb827d23577

So what's the next step? Adding a quirk for this sound card? Or is ther=
e
a way to fix the root cause?=20

Cheers,
Vincent
