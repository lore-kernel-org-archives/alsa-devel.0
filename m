From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/4] ASoC: mop500_ab8500: Replace instances
 of rtd->codec->card with rtd->card
Date: Tue, 20 May 2014 22:55:53 +0100
Message-ID: <20140520215553.GX12304@sirena.org.uk>
References: <1400492508-2732-1-git-send-email-lars@metafoo.de>
 <1400492508-2732-4-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7457692528430303270=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1E5232654B7
 for <alsa-devel@alsa-project.org>; Tue, 20 May 2014 23:56:12 +0200 (CEST)
In-Reply-To: <1400492508-2732-4-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@wwwdotorg.org>, Fabio Baltieri <fabio.baltieri@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org


--===============7457692528430303270==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qQLEtraMxXHZwsst"
Content-Disposition: inline


--qQLEtraMxXHZwsst
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 19, 2014 at 11:41:48AM +0200, Lars-Peter Clausen wrote:
> No need to go via the CODEC to get a pointer to the card. This will help to
> eventually remove the card field from the snd_soc_codec struct.

Applied, thanks.

--qQLEtraMxXHZwsst
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTe89mAAoJELSic+t+oim9r/AP/iY5N+k3tw0KFeI7pv3xB71R
yfN0IjPrG2czCNSWwojSK3RfZdSwtWSFi8z/gJXgPRag7jYxGVRKYuZDUEOFMTp7
yJC/amffftxSwN11LGxoFFzf66npZYwljBocqKWNOim5OtHsfmvN+LzYq6Ps/rJq
4HGHqpTUp4M0+WYIP32F/ILA2x33jQhbwf6Q18xLUF/YENG/qAnKVO2+5ehGCMLL
mwWlvyXAQQYoKeIpBLFJKcRNrds4Llb8Ut/aJX6FUMPe3K/6Z13MiMGael6uD8W9
nL3t2ngtwAeJ9nf7wPnZ8azWI8TB46WT0M8PUQCwwtktfgdOe9DPCR2E7IHHThN6
3mddM9UDD8HJdnk0ZsIcpWpVs6eSQx8SFeUSUXVtyP4ee2ZRfA1uI4uNoEvv5OGb
eMBvQK5mp7GxZR/+OZ+1zJ1jBTnERE01ZN3JrtogAOkyLUp8mL9wAKEcuD1/Ctfn
M9rZlrY2xhjIos8sGXITLrXJg3IYdwNf5aJNE513O87lOWsrqJgaTN59nduiU9nb
aSXuhCwtDf//fzQ8KX+l3h+Ugh70t+iv3a2/H90gltdE6HpRJWdutqmwY8f9zvnX
+XRuPjI1HCRkajqRk32XAn5dheQG5HHt8v0CksULRg8d3C08cDCf0CxHSGNHj+v7
YAY+x0LCv0xY3leR/3Ay
=4+MQ
-----END PGP SIGNATURE-----

--qQLEtraMxXHZwsst--

--===============7457692528430303270==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7457692528430303270==--
