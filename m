From: Mark Brown <broonie@kernel.org>
Subject: Re: [RESEND RFC PATCH 1/3] ASoC: mediatek: Add binding support for
 AFE driver
Date: Tue, 21 Apr 2015 11:56:23 +0100
Message-ID: <20150421105623.GG22845@sirena.org.uk>
References: <1428653649-38200-1-git-send-email-koro.chen@mediatek.com>
 <1428653649-38200-2-git-send-email-koro.chen@mediatek.com>
 <20150418173407.GE26185@sirena.org.uk>
 <20150420043747.GH6325@pengutronix.de>
 <20150420204849.GJ14892@sirena.org.uk>
 <20150421094926.GU6325@pengutronix.de>
 <1429611306.23823.52.camel@mtksdaap41>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ahP6B03r4gLOj5uD"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1429611306.23823.52.camel@mtksdaap41>
Sender: linux-kernel-owner@vger.kernel.org
To: Koro Chen <koro.chen@mediatek.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, robh+dt@kernel.org, matthias.bgg@gmail.com, perex@perex.cz, tiwai@suse.de, srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org, galak@codeaurora.org, lgirdwood@gmail.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--ahP6B03r4gLOj5uD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2015 at 06:15:06PM +0800, Koro Chen wrote:
> On Tue, 2015-04-21 at 11:49 +0200, Sascha Hauer wrote:

> > there are two programmable hardware gain blocks which can be inserted to
> > the digital audio path using the crossbar switch. There must be some
> > mechanism to configure them into different places.

> Maybe in DPCM, they can be "widgets", and we can define "routes" and
> corresponding controls for them.=20

Yes, exactly - it's basically just like a CODEC.

--ahP6B03r4gLOj5uD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVNizXAAoJECTWi3JdVIfQThcH/inMRPhH27+o4/rXhIl3j7DX
gCQNfqI0DC2iXXQfU7WagXj/4NBeoe7Zv/3I17RnSvMzf0vzpEoSbeLpKiFuY0PX
REGyKvt1WPyrzKuZhXZe3Kc4lWe+XpBGqjNW1MUBWMyjWZYdOeKcrqJyL+XWUYGF
nH4wOtLwwHiGAYWmUdYRWcNUWHhe3NL+VYjDNDvI4zRRCvdcckk5Z71k3boduGDQ
gauqxEyThK9GaSg6sh9oEOWeC2G3jTPlOZA8q/qABNvI5ySBMGsqRVjlbcwBXjrO
hoq0zfVUOaBA3i9W445hLHClJl+dfpSYdd+nVkN9Zaf3ujSIBT+tWclK20pWmXM=
=d1vG
-----END PGP SIGNATURE-----

--ahP6B03r4gLOj5uD--
