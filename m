From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: codec: tlv320aic32x4: Fix regmap
	range config
Date: Mon, 13 Jan 2014 12:35:19 +0000
Message-ID: <20140113123519.GU29039@sirena.org.uk>
References: <1389448111-17064-1-git-send-email-mpa@pengutronix.de>
 <1389448111-17064-2-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1494730296111830044=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 421042608B7
 for <alsa-devel@alsa-project.org>; Mon, 13 Jan 2014 13:35:27 +0100 (CET)
In-Reply-To: <1389448111-17064-2-git-send-email-mpa@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org


--===============1494730296111830044==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TgCXP+xznsSrEyty"
Content-Disposition: inline


--TgCXP+xznsSrEyty
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jan 11, 2014 at 02:48:30PM +0100, Markus Pargmann wrote:
> This codec driver fails to probe because it has a higher regmap
> range_max value than max_register. This patch sets the range_max to the
> max_register value as described in the for struct regmap_range_cfg:
> "@range_max: Address of the highest register in virtual range."

Applied, thanks.

--TgCXP+xznsSrEyty
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS092EAAoJELSic+t+oim9AvgQAIW5kJ1pfD94Uvy5jyoW3ZNx
7idzW/ulZdOxOHY/qo2qTeQp1UUP3llCwLUUoWZWGB2EPeun+J+JzgiQhmHYTmQN
GG8IdKRDJ3XlMB87r9BdZoJxL1WK9tQ7sB2EgmxRZlFliNl0NxLzL271ZKTmLgZ9
7GA88BN/AzlzrM0J5smiOdvPn9JZaW4Tozr3YrC8el3q1a6jpJmmue0fIL/b1ymf
aKa50JIKg/gNvZXG7Nq7EAhQYyvhYK/5ddbpVH/mDBpPNf9K+XSatIFo4nx1tPQx
RScz2uzW0Qq3g2dySAAOPqDa95bJ1zYeCJqt5UnWJAJQV9NApKRnwux3cXg/HjNy
aHdfe2OzFPuiuN6oEQlFGode+KANh9/p7ikl0vMdEjypyCy6a7JLfRvJrT4+2OoG
76SDWWS/vGwpYJ9MsJdV+yVAUEkjEHI5v/87T8a/bCsL5P539wX/s+j/1kM92Iqk
iVR7QLFYB1L7exeNK2dwUxsk29Jg/TRX/+mFxzsrseGux0/f/8yd2NIMkk3LXsaK
E+l6gQH6KGcO/wdZ/0vuhqfa7kUtYTBT2JRGWA6qN6xr47i+2J3v7M2fn6/6oDal
fjbWkwyLssKDWtKFLX8LH8w9GupxF3EQ5f3ZferGB5eRrtuT3HHI1T1GYI2vt+p/
JjI+dbqc84mEeB8KV7ai
=bqVP
-----END PGP SIGNATURE-----

--TgCXP+xznsSrEyty--

--===============1494730296111830044==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1494730296111830044==--
