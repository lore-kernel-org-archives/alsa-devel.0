From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: rt5651: Do not use rtd->codec
Date: Mon, 19 May 2014 17:16:19 +0100
Message-ID: <20140519161619.GA12304@sirena.org.uk>
References: <1400479384-19108-1-git-send-email-lars@metafoo.de>
 <1400479384-19108-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7333966432457450019=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 21B542610A8
 for <alsa-devel@alsa-project.org>; Mon, 19 May 2014 18:16:42 +0200 (CEST)
In-Reply-To: <1400479384-19108-2-git-send-email-lars@metafoo.de>
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
Cc: Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, Paul Handrigan <Paul.Handrigan@cirrus.com>, Liam Girdwood <lgirdwood@gmail.com>, Nicolin Chen <Guangyu.Chen@freescale.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============7333966432457450019==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="U7Bj1ghFXEpdfZh6"
Content-Disposition: inline


--U7Bj1ghFXEpdfZh6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 19, 2014 at 08:03:04AM +0200, Lars-Peter Clausen wrote:
> rtd->codec does not necessarily point to the CODEC instance for which the
> callback was called (e.g. for CODEC<->CODEC or multi-CODEC links). Use
> dai->codec instead.

Applied, thanks.

--U7Bj1ghFXEpdfZh6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTei5QAAoJELSic+t+oim9Rm0P/AwqTbS3zhsUJbynnVyUIp+3
69YpUJTXC5rdw/u+a5BzavIfO1Y5nYO2ZF+lYpItmWOgw9hlTmp5T61z/IN+UYOB
B3ZUXB/4zzesigbTZQUXIe53uRqNNRMgjMailx0JdeJtIpC80NlIzGoKj0dNo2Le
zNlUwmXbEQKR21pm2/deKIXcTc4gD6iYrFTq6Mo8we+m9tuDU61btyJKMBOl3Beu
0TuWZd/pe2XnyCzjXTdowzGF+1oMnq1Em0fWFR6SN6R6lG0Tot2s+jyStB4IbI7s
GCqFpWyEdNaWYY6tFDws+aFNSKfePp/2W5mi1dHVKScJqVF3KHL+hFlSkpVwRywz
Tq4KBRTXY/QzT3dFMVu1SXyp1tulXlmQ4hcSrhyr9bZOMguSexR4bt0l3wKFaDcL
1KctB5ptDYpw0x9N/tbBxz7IQULWVL6omEcaWVeuOJgQS5BKPuUcGo2QUqokY11Q
chtT0Bq+HZGOiHj6IOU7DVF1HvnUAfLq0dRQAEtjswiCKvy7no+Jhz8bCkkAPZ+I
nhg/XGQdwgRMf+mBM4r7VwR+K0kIyYDWWKvFhliSfCasNf1+GAJr3SlRC8eoKMHS
68HAMcq5gWJ4XRtbKiIHBD0ol3Cx8Oo15At4m5/wU11RlN6pINdeRaqXvQ6Dyu1a
c83DhFBOVDSf0UxlF1R7
=n3Nw
-----END PGP SIGNATURE-----

--U7Bj1ghFXEpdfZh6--

--===============7333966432457450019==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7333966432457450019==--
