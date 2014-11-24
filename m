From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 12/32] ASoC: wm8804: Cleanup manual bias
	level transitions
Date: Mon, 24 Nov 2014 18:25:53 +0000
Message-ID: <20141124182553.GF7712@sirena.org.uk>
References: <1416746269-4935-1-git-send-email-lars@metafoo.de>
 <1416746269-4935-12-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0579544547348221453=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 51DB62652C1
 for <alsa-devel@alsa-project.org>; Mon, 24 Nov 2014 19:27:48 +0100 (CET)
In-Reply-To: <1416746269-4935-12-git-send-email-lars@metafoo.de>
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
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============0579544547348221453==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Fo9oDfH89je183NY"
Content-Disposition: inline


--Fo9oDfH89je183NY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Nov 23, 2014 at 01:37:28PM +0100, Lars-Peter Clausen wrote:
> Since the ASoC core now takes care of setting the bias level to
> SND_SOC_BIAS_OFF when removing the CODEC there is no need to do it manually
> anymore either.

Applied, thanks.

--Fo9oDfH89je183NY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUc3gwAAoJECTWi3JdVIfQCf0H/RGazBmTBRz+FkPkT5fimtQj
RjmjjKrwqI64lXpTot7S5s6MhSPqsajMnfy9Zqn0y01buGknbMOODl/ShFdcQA3H
oo9U7rroRSc+AshZsvgz7tmsayvj57RhY9YM1Uh6pVtcwUfVKOQKt+mnFMxvZVn/
+IMkYJ327MUSXqUnniS/RnEg3XjHzbg7LJa07PwSSNc7e5Da7O8rgnaJbzlAh3Uk
2G/EsqfcBZ4bVrdVyNRa4R60lntizWGTL5qNqk9Sr7trp7jE9UsngnkUbyPj3US/
f93dmc7BaPsO+4GcxRYXk8FQc1c1iiAPk+h3h2q/5vGVXYcPOw5tCmaJPWkvbDU=
=phIW
-----END PGP SIGNATURE-----

--Fo9oDfH89je183NY--

--===============0579544547348221453==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0579544547348221453==--
