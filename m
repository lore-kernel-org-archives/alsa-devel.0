From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 06/12] ASoC: dapm: Remove special DAI
 widget power check functions
Date: Wed, 22 Oct 2014 12:12:50 +0100
Message-ID: <20141022111250.GV2344@sirena.org.uk>
References: <1413826604-3212-1-git-send-email-lars@metafoo.de>
 <1413826604-3212-7-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1252807790028468760=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DA96E26512F
 for <alsa-devel@alsa-project.org>; Wed, 22 Oct 2014 13:13:10 +0200 (CEST)
In-Reply-To: <1413826604-3212-7-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1252807790028468760==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pkBzO0lo80FoaZii"
Content-Disposition: inline


--pkBzO0lo80FoaZii
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 20, 2014 at 07:36:38PM +0200, Lars-Peter Clausen wrote:
> dapm_adc_check_power() checks if the widget is active, if yes it only checks
> whether there are any connected input paths. Otherwise it calls
> dapm_generic_check_power() which will check for both connected input and
> output paths. But the function that checks for connected output paths will
> return true if the widget is a active sink. Which means the generic power
> check function will work just fine and there is no need for a special power
> check function.

Applied, thanks.  IIRC it did make a difference when we weren't hooking
things into DAPM properly but that's bitrot now.

--pkBzO0lo80FoaZii
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUR5ExAAoJECTWi3JdVIfQfqwH+wc1LMZHLH7L1NFms6MO5Uzo
AsI7dsb3dUMxeZ0qeNSIESnHQPjoCff7mu07DUA5N4JEIFtC73x444GQVU6EL5hD
tDhzq+nEZprcUQvBrGHKYrFRFGOx2psRK3R+8tTPOWPY1BLId8o0Vq8TYf+Ma70y
r2oB/zSN9NbMf9ANQkAbNQJ7N/8F/Ly1lmzMWw7/KraiQc238lkVQufDrcmNT12w
GZNTA3BqA/agynzXibv2OCjJmvfq/CeTtzceV0Bs06foa1quPBbvFp+I3oVRvwUb
WWCeK7HqyvlVBB7ZNS/7cbduNn6+xu9IEd4xqetAn0mdyyXAZ8rvn2yCkNLMoDY=
=vIZb
-----END PGP SIGNATURE-----

--pkBzO0lo80FoaZii--

--===============1252807790028468760==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1252807790028468760==--
