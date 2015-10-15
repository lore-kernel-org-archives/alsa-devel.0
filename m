From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [RFC PATCH] ASoC: Modify check condition of
 multiple bindings of components
Date: Thu, 15 Oct 2015 13:10:35 +0100
Message-ID: <20151015121035.GE14956@sirena.org.uk>
References: <1444743477-48819-1-git-send-email-koro.chen@mediatek.com>
 <561D0AA9.5080702@metafoo.de>
 <1444745902.26493.2.camel@mtksdaap41>
 <561D1843.1020007@metafoo.de>
 <1444785549.26493.12.camel@mtksdaap41>
 <561E1991.1050705@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LNKrWK8T5LDJo+fl"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <561E1991.1050705@metafoo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Koro Chen <koro.chen@mediatek.com>, alsa-devel@alsa-project.org, srv_heupstream@mediatek.com, tiwai@suse.de, s.hauer@pengutronix.de, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, linux-mediatek@lists.infradead.org, p.zabel@pengutronix.de, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--LNKrWK8T5LDJo+fl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 14, 2015 at 11:00:01AM +0200, Lars-Peter Clausen wrote:

> It was never intended that it is possible to bind a component to multiple
> cards. That it was possible was a bug that was overlooked and some people
> tried to do it which caused apparently random crashes later on, caused by
> the data structure corruption. This is why we added the check to catch this
> kind of mistake early and to avoid the crashes.

This is true, but I do think it's something that we should have some
story on supporting for some of this hardware that has a bunch of
channels in one IP block that can't really interact with each other.
It's going to make it a lot easier for people to think about the
hardware and how to describe it.

--LNKrWK8T5LDJo+fl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWH5e6AAoJECTWi3JdVIfQ2g4H/Ar5dygi0Ept7WJZxTow6M4O
kPKsXIrb9X+n4mAd8Q5Od/mIR5A7OBw9ethut+gV5joU/1ajcrvmucbWMgKl1B5R
VcKWDKdvXAIETf6m3w+qMRV0HwlVM+w+o60cfAzLEGS5NVswLRopcCdlzorac4c/
TYHuEZabOSMv93ifg/WncFtIWJ93AcoWPkwcUFjdYheVipU4TPgQ4Pt/3wCwpjcz
o8+sB3r6wbwle1xM9Yepa3qGpj8rjLt4f5oYpZwPWMZqUtYq3z0gvBfXl5bGPQnP
06RGfBgf/XGSsuG0chnRFJ1C4i2cJkwRZyJO4HsXUj0qeVl4DvY3PWjMVdBLf/s=
=93Ch
-----END PGP SIGNATURE-----

--LNKrWK8T5LDJo+fl--
