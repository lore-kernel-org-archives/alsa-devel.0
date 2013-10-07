From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: fsl: imx-ssi: fix probe on imx31
Date: Mon, 7 Oct 2013 11:17:55 +0100
Message-ID: <20131007101755.GC21581@sirena.org.uk>
References: <1380630971-11431-1-git-send-email-philippe.retornaz@epfl.ch>
 <1380630971-11431-2-git-send-email-philippe.retornaz@epfl.ch>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4076966373813984231=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 2F448261B13
 for <alsa-devel@alsa-project.org>; Mon,  7 Oct 2013 12:18:24 +0200 (CEST)
In-Reply-To: <1380630971-11431-2-git-send-email-philippe.retornaz@epfl.ch>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Philippe =?iso-8859-1?Q?R=E9tornaz?= <philippe.retornaz@epfl.ch>
Cc: fabio.estevam@freescale.com, s.hauer@pengutronix.de, shawn.guo@linaro.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============4076966373813984231==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8NvZYKFJsRX2Djef"
Content-Disposition: inline


--8NvZYKFJsRX2Djef
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 01, 2013 at 02:36:10PM +0200, Philippe R=E9tornaz wrote:
> On imx31 with mc13783 codec the FIQ is not necessary and not enabled
> as DMA transfer is available.
> Change the probe() function to fail only if both FIQ and DMA are not
> available.

Applied, thanks.

--8NvZYKFJsRX2Djef
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSUopPAAoJELSic+t+oim9mkkP/jG3NzMeK+fhqbNnfZMsTBWZ
emzYf3cWJo0H+yWf6MRDmAt7Ux3wqvkDFvMLnp/OFlQBUwtgDbLgLv514HtrhZFq
ODM7Y4irT6huNZF2jyd/k9SxPniG8V7b++kyMgduxlWCYyaGBur/8R6YIxu0m5ov
hzBFcmSUKUmbS9qWwmSiv0z9hQls04W0CU7D40ePgpdg4zsBlKGzCD8jQmQvmvzA
W+r2AICoEDRps8FZsiUSEEmaJGXAkmACNhZxsa+33rkbbNQXZ2KE+NAmaAmz43z2
aR2ax/toMPaQLLoiN1/gzn3WNd/OzWRZaDnBY78UsgNbSwF+QXCwi/n9+BqEzhaG
HKO46t/V/ZeHn4266FTjRssU5uXNnXt8yWVqb2pt5dSzPrzX6J4WTz60C5Hhd5vT
I1DY126M3AT0oL8bt0pqgJTv0KNT6mKWIK+RxXBJebiGFsBq7Oh0x4XAlG/Rxto3
4OKEd3Osdv4VSJoRivLvjLXOW2wsmgcdtsu90r17wT0cwNR05bUoSIPZgDMy2/l0
ZVC6qh3GJhMFSyEYwiU5yKGRvI9fMANDKQTZcXTLPeIgW2UOQ1DsFcllP+SijPgg
+p4pdij53kF35yh6IomkSP0sDBl+/QJFd9Qk4dqzsg9r1byVYx945o+S8tQ6Kx5W
ki4FATX055h92Z/izoM7
=PQoX
-----END PGP SIGNATURE-----

--8NvZYKFJsRX2Djef--

--===============4076966373813984231==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4076966373813984231==--
