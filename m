From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ALSA: ASoC: uda134x: fix codec driver
Date: Tue, 30 Jul 2013 12:17:02 +0100
Message-ID: <20130730111701.GN9858@sirena.org.uk>
References: <E1V4712-0007sg-Dw@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1643347191287913624=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 45E71260729
 for <alsa-devel@alsa-project.org>; Tue, 30 Jul 2013 13:17:15 +0200 (CEST)
In-Reply-To: <E1V4712-0007sg-Dw@rmk-PC.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============1643347191287913624==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nrMdRvlEwnI0AOsB"
Content-Disposition: inline


--nrMdRvlEwnI0AOsB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 30, 2013 at 11:18:52AM +0100, Russell King wrote:
> For some reason, the DAC/ADCs are not being powered up when I try and
> use the UDA1341 driver; this used to work.  Looking back in the git
> history, I don't see anything obvious which would cause this
> regression.

Applied, thanks.  I've applied it for v3.12 for now rather than v3.11
since it's a relatively large change but obviously it's a fix and the
driver doesn't work anyway without it so I'm likely to pull it over for
v3.11.

--nrMdRvlEwnI0AOsB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR96CqAAoJELSic+t+oim9FRQP+wXWHW+3rWaBWYinLOs5usMM
UL+AKh3IEOZK1dZ0HiAmN4wZjY2xp2TOk13GWcEC3/HGasp0GtXfoGTXnO8c4JTR
npHoZCMgJYDSUFo6AiY5y6p+bmgaqHd7KgnFUtQ7kvWzMgmy+zHwzDONRe9pWudp
nJ4AuH1Fpqqo+mvfae9uBJrDxTbi5nDlirvt7rcKJudqPRNzqfl3CpoColhgVVJu
BHD/4av+ZDxiBL+8g9JI2ugQO4YC2zLIc5SP/xzvddQMmQzbfLiy5QBPxkJ0ICXb
LImrBIQimXgDju8+QTfcA3iioKZJSuPIWD2kd236zDwLih1fyVNN+xfDaD6xcYtG
QdRIvt3sa1QhvQBJqAGh3v5zhY1Nx2MFe270148gAowFqq4TvY/nBJ02Y8D0GD8/
ZK64tFUsvw6sakL95dhVncKfSPU5nr6Wb5CK0X98d/PIiciPk7aC/90O69sJQM4x
HXobT9sqA3wzQ4v0F3V9iJiqam/l0ejRyyhZ5xcZg7NiyRcC7CTuSr1XivBTNyWw
aRa6VBpOU+7zGaVBC2xBFtGJKyI5tVSUoPhKbt2BGGFUjJVLH2wT97xyxUYXC2Zz
5MQfP8FXvXPPkbhhijm4ZrhUoGRK5Fq9WbWiZJodiAv5o6oT7kFNAAGaZoLShFP0
4R6D66ob/Su16RC99gLG
=Y4Du
-----END PGP SIGNATURE-----

--nrMdRvlEwnI0AOsB--

--===============1643347191287913624==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1643347191287913624==--
