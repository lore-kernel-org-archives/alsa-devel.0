From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5677: Reintroduce I2C device IDs
Date: Thu, 24 Aug 2017 14:41:47 +0100
Message-ID: <20170824134147.2a5noeas4or33d2p@sirena.org.uk>
References: <1503453106-5564-1-git-send-email-trini@konsulko.com>
 <1503498573.25945.69.camel@linux.intel.com>
 <20170823173912.GN17193@bill-the-cat>
 <20170824000525.GY17193@bill-the-cat>
 <1503560349.25945.72.camel@linux.intel.com>
 <20170824111547.GA17193@bill-the-cat>
 <1503577560.25945.84.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="e5chi6jsxmwai27x"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1503577560.25945.84.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Tom Rini <trini@konsulko.com>, linux-kernel@vger.kernel.org, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: alsa-devel@alsa-project.org


--e5chi6jsxmwai27x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 24, 2017 at 03:26:00PM +0300, Andy Shevchenko wrote:

> Thus, I'm suspecting that your user space helper either has some hard
> coded values for previous case, or just broken.
>=20
> Can you also check is the codec module loaded (lsmod) and, if it's not,
> load it manually and check if sound works again.

Not sure what userspace helper you mean here?  The kernel is oopsing,
userspace shouldn't be able to do that.

> P.S. In any case you need the patch mentioned in bug #196397

What is that?

--e5chi6jsxmwai27x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlme15oACgkQJNaLcl1U
h9CgkggAgBwi1PZM73FGE7blwoOUb3EWRwWE4dltbKbwwLOT9jylC570lgcPGXSH
g2sfgHssfZIIMEvYnHlCtfp1rT34iw213zS9KszVpkRbkpAoiDbfWinvrFNP474Y
3G6ZahzsGop6oo2Gp78un+HbMEcRvLOJg60wbgA/H3QAngKhdT90GHJpJPOCQk/9
8ZB1akE9s5rR4w4fRm7OFEEK4hlHEopR3V6b7F/h6CYfWMHYNWb1UtsFEkiQVu3I
XjYU8K85bwxCf45xXOGweSXDH1UMnNExIhGmpNDtiaVzhhYah87RDsnGVOpmSLJC
BBTSEFV5hbDjKmvtPm1RgOpt8H1+mQ==
=KRoI
-----END PGP SIGNATURE-----

--e5chi6jsxmwai27x--
