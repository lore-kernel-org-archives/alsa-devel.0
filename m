From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 1/8] ASoC: core: Change
 soc_link_dai_widgets signature for multiple codecs
Date: Tue, 1 Jul 2014 18:17:35 +0100
Message-ID: <20140701171735.GB15028@sirena.org.uk>
References: <1404200881-32253-1-git-send-email-bcousson@baylibre.com>
 <1404200881-32253-2-git-send-email-bcousson@baylibre.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2533033590348867860=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6C5702650EE
 for <alsa-devel@alsa-project.org>; Tue,  1 Jul 2014 19:17:49 +0200 (CEST)
In-Reply-To: <1404200881-32253-2-git-send-email-bcousson@baylibre.com>
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
Cc: misael.lopez@ti.com, lars@metafoo.de, lgirdwood@gmail.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============2533033590348867860==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E39vaYmALEf/7YXx"
Content-Disposition: inline


--E39vaYmALEf/7YXx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 01, 2014 at 09:47:54AM +0200, Benoit Cousson wrote:
> Since multiple codecs DAI will be usable in the future, remove
> explicit unique codec_dai and cpu_dai parameters.
> Replace them with snd_soc_pcm_runtime pointer that will contain
> every instances.

Applied, thanks.

--E39vaYmALEf/7YXx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTsu0sAAoJELSic+t+oim9+9UP/1sCiSJ/6jVHzWHD7KXWO18C
KGhGVrWD1qdsJzBtrOm/p4zQCgB3CcMjMxx27bdOmGAKapVB3KAxiluTTgqXWV4O
FSsKgqCHyhQl2XULXnrI2iBJpF6kbSH0isDLWXsMpvQSXIb4bDH67jj5nbBpGcuI
Dp3vpARdy3lDMK0lrLhS6gTgdof1/jstSsPDEzsU8zTztHfBrqsuep6C2bTElmA8
O5IayBsrkHWeQlbD8yxnOhCGgrgoXAPEDX5N+0AquuIp6liNMX2/K6CjuOkfEu88
wj0g0QprwpFs+bGbrGyK9SatecC5WQDXVw3N8R5kT86caG0gdcK91eBLc/vrIWk5
IpzWESJV6d//arf3STXjWCUKLdi+XbG6Z2dSoXCBSq+qx/8gtsxod9ClPp1+TT+R
Mn5LhdoEpXb1L60L5ZmPHac8mwDizEeHWASzPQXi4MD74tYRY1Wrvwm7xVuVM2rD
9pPGS/tOcSY050XpDTV3SZDU9ORqq2NpDBb8cJBQAtAmzPUet6oQYgSYSDHUA4Nu
/xQxyUub5AQARknFBFg/H4y4R5KafaaJn9Vn14hu3jYgwBKird6dlwBeQi36WmyS
WCQb8RcF7Tn41nOxjm+6A/4C7yhwnbOhx0JQ76+3YG5KmtssgC80enFtEfguujv/
kRCSq5j0ugqPVeM53xAl
=JS7s
-----END PGP SIGNATURE-----

--E39vaYmALEf/7YXx--

--===============2533033590348867860==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2533033590348867860==--
