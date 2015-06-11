From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: tas2552: Use devm_gpiod_get_optional
 for enable-gpio
Date: Thu, 11 Jun 2015 11:42:06 +0100
Message-ID: <20150611104206.GS14071@sirena.org.uk>
References: <1433947565.19912.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8686245331850564631=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 74485261A5F
 for <alsa-devel@alsa-project.org>; Thu, 11 Jun 2015 12:42:19 +0200 (CEST)
In-Reply-To: <1433947565.19912.1.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Dan Murphy <dmurphy@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============8686245331850564631==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WXBLDYRe6ft2Yf8u"
Content-Disposition: inline


--WXBLDYRe6ft2Yf8u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 10, 2015 at 10:46:05PM +0800, Axel Lin wrote:
> commit ea178d1456dc ("ASoC: tas2552: Make the enable-gpio really optional")
> makes enable-gpio optional. devm_gpiod_get_optional() is the better
> function for optional gpio, so let's switch to use it.

Applied, thanks.

--WXBLDYRe6ft2Yf8u
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVeWX9AAoJECTWi3JdVIfQf2MH/1Zvz35RSm/irsyrJap6QCAW
Pnpw/Hd9Wv/WGZ15616S3NNNOH6d26sUhM5qoAeUiojarhlKdoOjOaI8mBDoXzL3
XP4oAEpaV4wD0xzCsuwdIeHypMmy3xUnCoAOJKEM3stlmkLHWPXvv17x/mqOLc4/
qIWfn414aw7RbhlXH3YlXEYzcnv7O83Cz+uNRN5dhfyhv32QnZ3rkLzGiqwLAlHl
fkF32sfobGlTEXkWZdFV0chw0hSPXx2m7pZ/tF0Ng8c+tdjMgGFwigD+9MHrRJ+t
6ZAXuGchZ7lmhuRDVYkBn08+Ne5mnT9+728ZwiuFgZQ5dNh7h6mDmrNTByVslfo=
=0an8
-----END PGP SIGNATURE-----

--WXBLDYRe6ft2Yf8u--

--===============8686245331850564631==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8686245331850564631==--
