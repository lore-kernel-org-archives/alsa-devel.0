From: Mike Frysinger <vapier@gentoo.org>
Subject: Re: [PATCH v2 7/7] ASoC: SigmaDSP: Add regmap support
Date: Tue, 29 Nov 2011 00:17:03 -0500
Message-ID: <201111290017.05980.vapier@gentoo.org>
References: <1322469860-8210-1-git-send-email-lars@metafoo.de>
	<1322469860-8210-7-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8363164826746204051=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.gentoo.org (smtp.gentoo.org [140.211.166.183])
	by alsa0.perex.cz (Postfix) with ESMTP id DB4132440F
	for <alsa-devel@alsa-project.org>; Tue, 29 Nov 2011 06:17:08 +0100 (CET)
In-Reply-To: <1322469860-8210-7-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: drivers@analog.com, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

--===============8363164826746204051==
Content-Type: multipart/signed;
  boundary="nextPart2450757.PcOoelOeIC";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2450757.PcOoelOeIC
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Monday 28 November 2011 03:44:20 Lars-Peter Clausen wrote:
> --- a/sound/soc/codecs/sigmadsp.h
> +++ b/sound/soc/codecs/sigmadsp.h
>=20
>  extern int process_sigma_firmware(struct i2c_client *client, const char
> *name);
> +extern int process_sigma_firmware_regmap(struct device *dev,
> +		struct regmap *regmap, const char *name);

having the deprecated name be renamed and the "_regmap" one not have that=20
suffix, but eh

Acked-by: Mike Frysinger <vapier@gentoo.org>
=2Dmike

--nextPart2450757.PcOoelOeIC
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJO1GrRAAoJEEFjO5/oN/WB9mwP/ixAQTOh6m/tNsdhXD8A0SbR
ZWTpmMZ/bpr9BnCtWP08lDjoVkZ8KHSvY4/wsJqejKmP+FX2Db2SSatv81U+xVXI
Q8vZ4Jg5aTvNgeW5yGZtwkKcf2B09lazOVmi9CQR+xWRI+jfZ5lSc1R3Wcg3WX4b
pUXOhrU8nmeJTAWHyj6937sjp09V8cqWQ40FAE1T18fdFJM+urdbWkDfokOYuMdq
QeAYXloD6C6PG+150CHV986kUwSsm19ilGPSHdGhH/HBGgMsaH7wpC4YQpwC+0VI
YNNOQkzhlxf/SoHJtzpjLEHi2tz6pNI9EqfkmnswGWznGjvIlyzSVCZQO8NYkQTi
R1Zejxi3BYeQavtEXNFeUhDzwd6Kj8O7g46HoVhemhsReiy3msDRlnoMexnLBglM
DBN56ewMWijh2ohO3p9uraPGKcW9yRHF8068wGeU3P+UXqdK0mQA66opcLv/+fw/
NLkte1F3n993fKg8uhFNnvUrkmf4cx8YHbOzalf1HxqXdRDbePptYKnuvmpTHWcA
z9TEmKGRy3Ih82MOjSXg0vlL6GcPCg4dLttVYx7TfyLs6qu9azcFW4EWLjtTHVQD
F+bWiIo9XGUmUdJWdtw6behelQIFsv8TKcU5X1ReZ5GwM05Z8l9XAFoYegs4h8Lf
06GnUVYBf2s4u+6Ca25l
=EFXo
-----END PGP SIGNATURE-----

--nextPart2450757.PcOoelOeIC--

--===============8363164826746204051==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8363164826746204051==--
