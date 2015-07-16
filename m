From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: rockchip: Add machine driver for max98090 codec
Date: Thu, 16 Jul 2015 20:57:23 +0100
Message-ID: <20150716195723.GC11162@sirena.org.uk>
References: <1436930143-31361-1-git-send-email-zhengxing@rock-chips.com>
 <1436930143-31361-2-git-send-email-zhengxing@rock-chips.com>
 <1437033944.27428.11.camel@tiscali.nl>
 <20150716110032.GU11162@sirena.org.uk>
 <1437047261.28351.6.camel@tiscali.nl>
 <20150716125529.GG4039@sirena.org.uk>
 <1437056116.28351.19.camel@tiscali.nl>
 <20150716150500.GO4039@sirena.org.uk>
 <1437063765.21215.18.camel@tiscali.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qwNWzpZrOR6kNuUY"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1437063765.21215.18.camel@tiscali.nl>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Bolle <pebolle@tiscali.nl>
Cc: Xing Zheng <zhengxing@rock-chips.com>, dgreid@chromium.org, dianders@chromium.org, heiko@sntech.de, sonnyrao@chromium.org, linux-rockchip@lists.infradead.org, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--qwNWzpZrOR6kNuUY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 16, 2015 at 06:22:45PM +0200, Paul Bolle wrote:
> On do, 2015-07-16 at 16:05 +0100, Mark Brown wrote:
> > Why would this not be the case - what is the difference you beleive
> > this driver has to other platform drivers?

> It's my believe that for MODULE_ALIAS("platform:[...]") to be useful
> there needs to be corresponding struct platform_device. For this patch
> that would be a platform device named "rockchip-snd-max98090". (This is
> something that I try to check rather carefully, because these devices
> can be generated on the fly.)

> I'm happy to drop this believe if someone shows me another way that
> MODULE_ALIAS("platform:[...]") can actually be used.

> So, in short, the difference between this driver and other platform
> drivers is that, as far as I'm aware, this platform driver lacks a
> corresponding platform device. Probably because OF support suffices to
> get this module autoloaded.

This is a patch adding a device driver.  We do not require that patches
adding device drivers also add architecture code to load the driver or
even be part of the same patch series since that isn't really helpful
for anything.  We don't even require that board code be part of mainline
at all, though obviously we do encourage it.

If you want to make a tree wide effort to remove MODULE_ALIAS()s that
do not have any in tree users please do that separately.  Right now it's
perfectly OK to do it.

--qwNWzpZrOR6kNuUY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVqAyeAAoJECTWi3JdVIfQ1SAH+wWm/ugO9MAroG+xxlwBaiuU
CqLlMcLOZTX0+J/nou6lByE37P9yqypTs1aiuq6iHJ+A6oSZXRd8dQHhwrirpyOG
YfkaLFUopaW85SbCVpqFutoAtp0J+Qi0wE/Cb/dE1BgW3YdyHoot1ze7psXYhNzk
O0BjQdth1/Lfg1/gPcJhv/dHRYAlhoImzm8jaFaCytosFvoWqBPudr5QYawoTRfY
o0tVg4QDA672wMb8XEmPrZiI480dSh7RhPz8zySG5DqrTJANOiPKPu1uL9O/Zbvp
TcCN6ZgY9K7l0fiO3R4XWdH517PcbFc1YYZ67pIhPeIgXi/+AcHX9guxPIF4wNI=
=LVeQ
-----END PGP SIGNATURE-----

--qwNWzpZrOR6kNuUY--
