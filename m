From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [alsa-devel] [PATCH v4 3/3] ALSA: hda: Disabled unused audio
 controller for Dell platforms with Switchable Graphics
Date: Mon, 23 Apr 2018 10:29:28 +0200
Message-ID: <20180423082928.po6tgq7gbz36pe7b@pali>
References: <20180420094432.13133-1-kai.heng.feng@canonical.com>
 <20180420094432.13133-3-kai.heng.feng@canonical.com>
 <s5hbmeew01d.wl-tiwai@suse.de>
 <E5D0F76C-0A83-4D2C-81F7-BD5768C0A7DC@canonical.com>
 <20180423080844.yh6ndicpu6mwy336@pali>
 <FF30493D-012C-41E8-B379-85138E1EDE05@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <FF30493D-012C-41E8-B379-85138E1EDE05@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kai Heng Feng <kai.heng.feng@canonical.com>
Cc: Takashi Iwai <tiwai@suse.de>, mjg59@srcf.ucam.org, dvhart@infradead.org, andy@infradead.org, Mario Limonciello <mario.limonciello@dell.com>, tiwai@suse.com, alsa-devel@alsa-project.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Monday 23 April 2018 16:18:35 Kai Heng Feng wrote:
>=20
>=20
> > On Apr 23, 2018, at 4:08 PM, Pali Roh=C3=A1r <pali.rohar@gmail.com> wro=
te:
> >=20
> > On Monday 23 April 2018 16:04:55 Kai Heng Feng wrote:
> > > > On Apr 20, 2018, at 8:10 PM, Takashi Iwai <tiwai@suse.de> wrote:
> > > >=20
> > > > On Fri, 20 Apr 2018 11:44:32 +0200,
> > > > Kai-Heng Feng wrote:
> > > > > Now it's a typical discrete-only system. HDMI audio comes from AM=
D audio
> > > > > controller, others from Intel audio controller.
> > > > >=20
> > > > > When SG is enabled, the unused AMD audio contoller still exposes =
its
> > > > > sysfs, so userspace still opens the control file and stream. If
> > > > > userspace tries to output sound through the stream, it hangs the =
system.
> > > >=20
> > > > Hm, could you give more information about how it hangs?
> > >=20
> > > Well, I should say "it hangs the userspace process" instead.
> > >=20
> > > $ speaker-test -t wav -c 2 -D hw:CARD=3DHDMI,DEV=3D3
> > > ...and it just stopped. Can't Ctrl+C to break it.
> >=20
> > So userspace process cannot be killed at all? Then it is different bug
> > in kernel and disabling pci device is just a workaround. Not a real fix.
> >=20
> > I would propose to find out what happen and why it cannot be killed
> > (probably it stuck somewhere in kernel) and fix it properly.
>=20
> That's because the audio device got runtime suspended by the graphics.
>=20
> In this case, if we really want to use the the discrete audio, then we al=
so
> need to wake up the graphics.
> The discrete audio is totally useless when SG is enabled, so my approach =
is
> just to disable it.

I'm not saying that disabling PCI should not be done.

I'm saying that if userspace process which opened that audio device
cannot be killed, then you found different kernel bug and that should be
fixed.

> Kai-Heng
>=20
> >=20
> > > > > @@ -1627,6 +1629,42 @@ static void check_msi(struct azx *chip)
> > > > >  	}
> > > > >  }
> > > > >=20
> > > > > +#if IS_ENABLED(CONFIG_DELL_LAPTOP)
> > > >=20
> > > > This should be IS_REACHABLE(), as both dell-laptop and HD-audio are
> > > > tristate.
> > >=20
> > > Thanks, will update in next version.
> > >=20
> > > > > +static bool check_dell_switchable_gfx(struct pci_dev *pdev)
> > > >=20
> > > > I'd remove "_dell" word here.  Such a check would be likely needed =
for
> > > > other vendors, and it's quite possible that the function will be
> > > > extended to cover a wider DMI table.
> > >=20
> > > Makes sense. Will also update this one.
> > >=20
> > > Kai-Heng
> > >=20
> > > > thanks,
> > > >=20
> > > > Takashi
> >=20
> > --=20
> > Pali Roh=C3=A1r
> > pali.rohar@gmail.com

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
