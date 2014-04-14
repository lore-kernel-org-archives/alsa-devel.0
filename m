From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFT v2 5/6] ASoC: core: Add helpers for dai link
 and aux dev init
Date: Mon, 14 Apr 2014 20:39:06 +0100
Message-ID: <20140414193906.GL25182@sirena.org.uk>
References: <1395415650-20045-1-git-send-email-bcousson@baylibre.com>
 <1395415650-20045-6-git-send-email-bcousson@baylibre.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8750835511932041491=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 140DE26574F
 for <alsa-devel@alsa-project.org>; Mon, 14 Apr 2014 21:39:19 +0200 (CEST)
In-Reply-To: <1395415650-20045-6-git-send-email-bcousson@baylibre.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Benoit Cousson <bcousson@baylibre.com>
Cc: Fabien Parent <fparent@baylibre.com>, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============8750835511932041491==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IuJpT0rwbUevm2bB"
Content-Disposition: inline


--IuJpT0rwbUevm2bB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 21, 2014 at 04:27:29PM +0100, Benoit Cousson wrote:
> From: Misael Lopez Cruz <misael.lopez@ti.com>
>=20
> Separate DAI link and aux dev initialization in preparation for
> DAI multicodec support.
> Since aux dev will remain using single codecs but DAI links
> will be able to support multiple codecs.

I applied everything up to here.  This one didn't apply, probably due to
context changes but I didn't make any real effort to understand the
issue.

--IuJpT0rwbUevm2bB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTTDlXAAoJELSic+t+oim9nEsQAJxW9IFgInP5jLve9uxYS/6y
1edS3PF4k2PzBfcha4Gru5QYMf/qm2dQGMJSf1egFZOCOxClNIshGFsEPYmVEinX
FAR3HeYWSJiErsxUHAkoyonpHM7ItzNsPnRuCBPRIm+CPCYAexBvh9fY2BQJcHiR
+QAD5+a+gb5pA86hTgY5aYUSpg5QBRpZPwaVIJWXHkG7ivfLvQ3tzcdI/umEisFe
sAXSjkTNRaCfDccXB2Yq+lBuC0OpaMTX7vBqFTDmPRGfl/KLozn77hBF9FbByYOk
lOU1zahI9u1bWLx3izMvEYTy87oxHVTa9QB6XY53X1gYL1Er737DT1e3fg/KIylo
bMEe55hX4SyJMSq39y7FrQxGYRh+CXowQgijmxqqUNiSHpXvZDGoh2kV6fhvE6Ki
aDCZVInlgJub/Z/37EdnhthB1oe+MQdYwAa7wFn8DTpGbcovs1e+gapnmGf8gfES
GGwNF2qkcguXoyrChOVWiGdxprA3ZwU9ZUalfVe2dok7cmCJrOtpTVKx0JXxs3H+
i3H+eH3JRlRUYBc91JCF63va/vLmlJphHkvrBAIeXIAsRV9BX9Aw6klSJcokc0FC
/p+5lJrLMR/P9ISBQzGXbm/TAF/OLc59u2wmvBWXreJjLYfi+Gta55cTPUzeWouG
IOrRDq6t63bP/wg76VQ9
=ck8v
-----END PGP SIGNATURE-----

--IuJpT0rwbUevm2bB--

--===============8750835511932041491==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8750835511932041491==--
