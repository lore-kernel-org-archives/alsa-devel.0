From: Mark Brown <broonie@kernel.org>
Subject: Re: Applied "ASoC: hdmi-codec: Add ELD control" to the
	asoc tree
Date: Wed, 27 Apr 2016 11:14:42 +0100
Message-ID: <20160427101442.GH3217@sirena.org.uk>
References: <1461142804-26728-4-git-send-email-p.zabel@pengutronix.de>
 <E1atHJ9-0003ey-9b@debutante>
 <20160427094219.GL19428@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0905494736294692479=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 21726265080
 for <alsa-devel@alsa-project.org>; Wed, 27 Apr 2016 12:15:01 +0200 (CEST)
In-Reply-To: <20160427094219.GL19428@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Jean-Francois Moine <moinejf@free.fr>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, kernel@pengutronix.de, Arnaud Pouliquen <arnaud.pouliquen@st.com>, Koro Chen <koro.chen@mediatek.com>, Jyri Sarha <jsarha@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-mediatek@lists.infradead.org, Daniel Kurtz <djkurtz@chromium.org>, Philipp Zabel <p.zabel@pengutronix.de>, PC Liao <pc.liao@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, Cawa Cheng <cawa.cheng@mediatek.com>
List-Id: alsa-devel@alsa-project.org


--===============0905494736294692479==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="30y3C67tAc+6DFNM"
Content-Disposition: inline


--30y3C67tAc+6DFNM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 27, 2016 at 10:42:19AM +0100, Russell King - ARM Linux wrote:

> It would have been good to have this as a generic ALSA control rather than
> an ASoC control.  The dw-hdmi driver is an ALSA driver, and now we have to
> re-invent this for ALSA...

We can always just incrementally move the code to the ALSA top level,
though it's so thin that I'm not sure it's really buying much.

--30y3C67tAc+6DFNM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXIJERAAoJECTWi3JdVIfQNKQH/3R+eJoWI5tGu0G54tU0Ledz
MIpky8D3ma9+Hu4zN7Yd/8Wz+Y+vexkUfcrG8K05BQSef3D35wTWPD3eWemUdl3U
1aFycxaO12njUssiDTCSCQkNN5WkGOe2rVXrOWDQBWooLQQwvejZL6fMWGW4ucBl
2+lESi1hduLEoPSf6qoC9U3a86KA6Mab8FFPqQxuBWoccCUKD3t3Bz7qGI4U+ZEJ
xxMeyuL4yK1zi4l7rXzQREcZYLm4plcXVixJvYq4eTzG24TD0D1pLnyROYwrOkj1
Wqm4h2saj2FT5LyL9w2wvGFA5reDuAx2IdnLB+9sG0+LEnGAjNxyJZpZUZnTwAs=
=zbnS
-----END PGP SIGNATURE-----

--30y3C67tAc+6DFNM--

--===============0905494736294692479==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0905494736294692479==--
