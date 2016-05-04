From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH 1/7] ALSA: ac97: split out the generic ac97 registers
Date: Wed, 4 May 2016 10:07:02 +0100
Message-ID: <20160504090702.GV6292@sirena.org.uk>
References: <1462050939-27940-1-git-send-email-robert.jarzmik@free.fr>
 <1462050939-27940-2-git-send-email-robert.jarzmik@free.fr>
 <20160503115159.GP6292@sirena.org.uk>
 <87y47roski.fsf@belgarion.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1J4USyVh4Jt5OGCL"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87y47roski.fsf@belgarion.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org


--1J4USyVh4Jt5OGCL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 03, 2016 at 09:22:05PM +0200, Robert Jarzmik wrote:
> Mark Brown <broonie@kernel.org> writes:

> > On Sat, Apr 30, 2016 at 11:15:33PM +0200, Robert Jarzmik wrote:

> >> Split out from the ac97_codec.h the ac97 generic registers, which can be
> >> used by a codec, typically a generic ac97 codec, and by the ac97 bus, to
> >> scan an ac97 AC-Link.

> > I don't entirely see the value in this one but equally it does no harm.

> Oh that's to have the defines AC97_VENDOR_ID1 and AC97_VENDOR_ID2, but without
> including ac97_codec.h in sound/ac97/bus.c.

I see that, I just don't know why that helps.

--1J4USyVh4Jt5OGCL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXKbu1AAoJECTWi3JdVIfQB9oIAIRMtDQUGLLuldOzon/AP3ey
EN62XgpfoES9IOYTf/EIj7xuNv7R6QoDXyBFnQeGtrmtlfyToyYL17ih8x1YIn88
PW4m8yT83UN8pmf+YhGxJxwJc1vTt+bxAO0wXKfsawntOBpp48zO+Qr/swqh14Rd
Pw6FuHT7a11fGdUE+dEeY9Uo7EPOtoMtoXspAwJtHYCa2DmlIgAIz7AvlTguIuFG
cvA2wkbhhzRNC5v9t/97+P1y1o2BX8/br8BcEti6uxxL8ou4E2ACrLr9dI0N1x4D
8H177VffZal8pma7FylifVLqm4t6H2tCF1XmSANht01zej9WCW+uxSit5Yb98F4=
=KB3K
-----END PGP SIGNATURE-----

--1J4USyVh4Jt5OGCL--
