From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/5] ASoC: fsl_ssi: use flat regmap cache
Date: Thu, 22 Sep 2016 11:45:30 +0100
Message-ID: <20160922104530.GL7994@sirena.org.uk>
References: <20160919193029.8119-1-marex@denx.de>
 <20160919193029.8119-4-marex@denx.de>
 <57E2B53C.6080708@maciej.szmigiero.name>
 <b54cd59a-97d0-e02d-16be-7aa6752bbb35@denx.de>
 <57E3074E.4070601@maciej.szmigiero.name>
 <8d5ad78b-3850-93bd-e299-215f001da9c2@denx.de>
 <57E318DB.3040600@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4657890806116347855=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2C304267064
 for <alsa-devel@alsa-project.org>; Thu, 22 Sep 2016 12:45:45 +0200 (CEST)
In-Reply-To: <57E318DB.3040600@maciej.szmigiero.name>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Marek Vasut <marex@denx.de>, alsa-devel@alsa-project.org, Xiubo Li <Xiubo.Lee@gmail.com>, Timur Tabi <timur@tabi.org>, Liam Girdwood <lgirdwood@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>
List-Id: alsa-devel@alsa-project.org


--===============4657890806116347855==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="V3eawNQxI9TAjvgi"
Content-Disposition: inline


--V3eawNQxI9TAjvgi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 22, 2016 at 01:33:47AM +0200, Maciej S. Szmigiero wrote:

> In you patch 5/5 there is backtrace with flat cache, but I meant a
> backtrace with original RB tree cache code when warning about allocation
> being done in atomic context was generated.

I think the conclusion of this and some IRC discussion yesterday is that
removing patch 5 fixes things - is that right?

--V3eawNQxI9TAjvgi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJX47ZHAAoJECTWi3JdVIfQCmwH/AwcN4IRteOfcQqfTBBwJpQc
MqgDJE5o2zZ1YsGbGgZqgB+XkGKXeu3t1iVp6aE0z7K5/9yQSQ+7EQeOyvYX/WVf
esdQV1HWo/xG5XBRJ8yOrK0Za5iJ/izxYkQoJbQhAHflUaio+EO4WHo2gTEN9M2P
7GJthTflC1+Amz9tVT9LEIA+Fo4Bk3sX7u+Plz+HS07jc03xQpK1MxvpxYcLl+2W
f0FSv5rxshmGT71Qpph63CO8LNvgO5NfAlx6gLNbHb8NOyr72JepLCYYdp47Dppo
cISZlin6vGlwl03Eg8P0zxgYGlckZg1/Vwda6io67BiuP7+wPZItRcp58gOSS1k=
=z4Y0
-----END PGP SIGNATURE-----

--V3eawNQxI9TAjvgi--

--===============4657890806116347855==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4657890806116347855==--
