From: Mark Brown <broonie@kernel.org>
Subject: Re: Failed to set cache compression type
Date: Mon, 2 Jun 2014 15:10:17 +0100
Message-ID: <20140602141017.GF31751@sirena.org.uk>
References: <CAOMZO5Cj=qrrH_nWhCM4-63GPqfgpL1k=Q53z8cDDk3_TpUzBA@mail.gmail.com>
 <538C840A.2000307@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2830390155173777684=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F4C02654EC
 for <alsa-devel@alsa-project.org>; Mon,  2 Jun 2014 16:10:48 +0200 (CEST)
In-Reply-To: <538C840A.2000307@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============2830390155173777684==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z0eOaCaDLjvTGF2l"
Content-Disposition: inline


--z0eOaCaDLjvTGF2l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 02, 2014 at 05:02:50PM +0300, Jarkko Nikula wrote:

> If I understood commit 657254714ad2 ("ASoC: io: Remove support for ASoC
> cache in conjunction with regmap") right should we remove remaining
> soc-cache use? All codec drivers seems to include regmap.h although some of
> them are still calling soc_cache_sync().

Anything using both regmap and the ASoC cache is definitely broken, yes.

--z0eOaCaDLjvTGF2l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTjIXBAAoJELSic+t+oim9MQQP/A2H5D8f8Bm4batBR0ZD6Pl5
WTa5qMdYtCawwRKnJOW90tQoOzCzuXHIPYBL6ZI93TW4d4IvNVgVy9EgYf/Tovft
bQS+6ipRmpWL8TJpgia05apiE47YEsO5TFNdYj7+lpGsBjFoMfF/s1MKvzYyaiqZ
0aYxH7EvQbT+nj2X4K+IY4Fv74dN6bz72O5VTb1kLLiZInPYSAopXceJUXRQLiOW
9b3CeRBzkOzqEcXqhoe88Ckp4H2DW9ZRqKUep10ZFNtFaDMcUHGSLz0xOJ7Gx2jT
msBJjbCm8/V+3hnyABsl3R5LMHvb9luPslnoGls/ApniePwf1Qu18N6yOmVA2le1
AK42EAUHkAOibaOYo19uF+sf+MQmPZK+Ebbv7ArVkg8/Tx8QI8w3BknGh6TS4cDu
GrtHNQGqDiZvS2p1tjiAC/SMzUWkbtalb7xlZ/PBog8qxrsPe7rRxPMwxEwNOnME
Qjrf90GAw5cNQvWTE0wWRCse3IcXsHf/DWMizQlCwC2RsgfxnZVVy5LJIZHAb/Kq
zkpTidLsL+6qeRiPtE0T84iF6xT5NkpQkGdHJZnyE29bNnSUqsO5twXEPUzznPd7
G6fU1xKcis8wpy+zOr5L9qVBXWKd2ARTu8nUUNw78G/I9zF5liWQ8JkyB5Daz1kD
MHXbNdlg207j8+8cVFO3
=M8Tp
-----END PGP SIGNATURE-----

--z0eOaCaDLjvTGF2l--

--===============2830390155173777684==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2830390155173777684==--
