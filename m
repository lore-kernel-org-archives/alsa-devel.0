From: Adrian Bunk <bunk@stusta.de>
Subject: Re: 2.6.16-rc6: known regressions (v2)
Date: Mon, 20 Mar 2006 11:47:08 +0100
Message-ID: <20060320104708.GA22317@stusta.de>
References: <Pine.LNX.4.64.0603111551330.18022@g5.osdl.org> <s5hmzfost2h.wl%tiwai@suse.de> <200603181427.14393.kernel-stuff@comcast.net> <200603181446.23034.kernel-stuff@comcast.net> <s5hacbl2z1h.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751066AbWCTKrP@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5hacbl2z1h.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Parag Warudkar <kernel-stuff@comcast.net>, Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "S. Umar" <umar@compsci.cas.vanderbilt.edu>, perex@suse.cz, alsa-devel@lists.sourceforge.net, Marcus Hartig <m.f.h@web.de>
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 20, 2006 at 11:25:30AM +0100, Takashi Iwai wrote:
> At Sat, 18 Mar 2006 14:46:22 -0500,
> Parag Warudkar wrote:
> >=20
> > On Saturday 18 March 2006 14:27, Parag Warudkar wrote:
> > > On Friday 17 March 2006 15:40, Takashi Iwai wrote:
> > > > The last patch seems incomplete. =A0Please try the patch below =
instead.
> > > > (This time with a changelog :)
> > > >
> > > >
> > > > Takashi
> >=20
> > Additionally I get  azx_get_response timeout in dmesg with the new =
patch.
> > Sound works ok despite of that though.
>=20
> That's why jack sensing doesn't work for you.  The jack sensing and
> auto-muting requies unsolicited events.
>=20
> It's likely a problem of ACPI or whatever related with irq routing.

Both reporters said it worked in 2.6.15, so if the regression is relate=
d=20
to irq routing it should be visible in the dmesg.

Parag, Marcus, please send an email with both a dmesg of 2.6.15 and a=20
dmesg of 2.6.16-rc6 (or 2.6.16) attached.

> Takashi

cu
Adrian

--=20

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
