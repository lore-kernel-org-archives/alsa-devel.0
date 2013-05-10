From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3] ASoC: sgtl5000: Fix driver probe after
 reset
Date: Fri, 10 May 2013 10:10:34 +0100
Message-ID: <20130510091034.GI3200@sirena.org.uk>
References: <1368120063-20655-1-git-send-email-fabio.estevam@freescale.com>
 <518BDFF4.2070403@metafoo.de>
 <CAOMZO5Awf2YG0b1S5inTDDs5yYf4TyPM5GWvB+5ys=k1bFe5Hw@mail.gmail.com>
 <518BE699.6050409@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3262050298415012803=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 488F72610D7
 for <alsa-devel@alsa-project.org>; Fri, 10 May 2013 11:10:45 +0200 (CEST)
In-Reply-To: <518BE699.6050409@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, matt@genesi-usa.com, eric.nelson@boundarydevices.com, troy.kisky@boundarydevices.com, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============3262050298415012803==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q59ABw34pTSIagmi"
Content-Disposition: inline


--Q59ABw34pTSIagmi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 09, 2013 at 08:10:33PM +0200, Lars-Peter Clausen wrote:

> I think what Mark suggested was to take the register defaults and write them
> to the registers in your probe function, so you'll always end up in the same
> state.

Yes, exactly.

--Q59ABw34pTSIagmi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRjLmGAAoJELSic+t+oim9KcsP/RPKH8laaCrsTcTpg5cSIPGB
a8uhfUhWCykNEu4FAlKaEY2rH3j1QT3TevP+/cCv5w65yynivtNuvafjMWW550/7
4YCBgVmpb+h6TBrLS04eqtbh/hPh15IbZP+4vpI3Gdx/5Jjsaumq+MrLZql2C9+s
/gJzR28vIq9JsIHq3XdKQxxcMkR01JOPwZDQMg6BreF9UfqTyQxDXgqIPN1OiMLl
/Ew53H+Xib4xFNDhPYLEKLImAhPh+KpS1mUMHy1nqwkDCdvY9/Dpn2C77TlTNp4v
xJ4nboylnt94lU0QjSmVh7NbCwWKNsfFpB1mjcSA3zXyRcSEGoZTPXqcj2YmTG3p
03m+Ksc3ws5NYqBcjcUz3YdL9mhYLIlR9iUafxkN+hAzIGltm4xuaFf+rTyjGE3u
b5M/zEEneCQdYWlir36EyfbvtG0AFWNxxb8XH7u75AA2WpG99JUufJL8htwn8ZUL
aqiZRIfXZAV+DypCVeG8GqUJSggf7yMt1Is6mxLuAEn+noq3wbbBve2jbUBsKO5T
/Zg2W8QBSoIJH128WzSnAurN4njh2/g1DX2XDrqElr6lMTYHpzqDNlneK47qW+Zz
AEGzvLDMk8xVaxhPYMJAM21LHJWauAj5lcQ+aSRVPx7ZnIAWYHmuHkLLY1v9SmtM
2eAQL219P3FrVghwtfq1
=iHvJ
-----END PGP SIGNATURE-----

--Q59ABw34pTSIagmi--

--===============3262050298415012803==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3262050298415012803==--
