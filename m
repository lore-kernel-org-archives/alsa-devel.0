From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: max98090: Correct pclk divisor
	settings
Date: Tue, 4 Nov 2014 19:59:31 +0000
Message-ID: <20141104195931.GY3815@sirena.org.uk>
References: <1415039337-28026-1-git-send-email-dgreid@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2555993201479953821=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D66B3260625
 for <alsa-devel@alsa-project.org>; Tue,  4 Nov 2014 21:00:47 +0100 (CET)
In-Reply-To: <1415039337-28026-1-git-send-email-dgreid@chromium.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dylan Reid <dgreid@chromium.org>
Cc: alsa-devel@alsa-project.org, ralph.birt@maximintegrated.com, jerry.wong@maximintegrated.com
List-Id: alsa-devel@alsa-project.org


--===============2555993201479953821==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XBU0trS4VUTrVXJk"
Content-Disposition: inline


--XBU0trS4VUTrVXJk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 03, 2014 at 10:28:56AM -0800, Dylan Reid wrote:
> The Baytrail-based chromebooks have a 20MHz mclk, the code was setting
> the divisor incorrectly in this case.  According to the 98090
> datasheet, the divisor should be set to DIV1 for 10 <= mclk <= 20.
> Correct this and the surrounding clock ranges as well to match the
> datasheet.

Applied both, thanks.

--XBU0trS4VUTrVXJk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUWTAiAAoJECTWi3JdVIfQaf0H/1je73vucf3DcULWKpPAGhd2
wsNLjcmuj+nfKCH5X36vDsbiTgCOplcsHOmELUNVjqJncJWzc7Ma5kAJfZD6hBaT
3ZGJOXgVHegbtEEv3POHyWh9AslOcsLdJGLpK6ftDbWxHhrTb4ggPJtANvjTRjuL
Ljthf0pJqvOK8pRR6rcboNbsgQNE1R1q/KnSYgT6ecTMx06b/UAxe5F068ZGKDWS
Vh1R1PhR68OVbiXr5PuV75rSEVp0YRrvAd4MkZAxEh5xcfkM4J+oOQ8YgALa5Fia
ljq5O54hBhRiUtqGqkDjCGlCtAT60fF0XwSPOHeVaolrqubm8UJSleYvlezYLEQ=
=2wkx
-----END PGP SIGNATURE-----

--XBU0trS4VUTrVXJk--

--===============2555993201479953821==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2555993201479953821==--
