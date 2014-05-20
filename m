From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 11/17] ASoC: fsl-ssi: Move
 fsl_ssi_set_dai_sysclk above fsl_ssi_hw_params
Date: Tue, 20 May 2014 23:05:03 +0100
Message-ID: <20140520220503.GB12304@sirena.org.uk>
References: <1398682498-24357-1-git-send-email-mpa@pengutronix.de>
 <1398682498-24357-12-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7000104193442081186=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9BF3F2654EE
 for <alsa-devel@alsa-project.org>; Wed, 21 May 2014 00:05:17 +0200 (CEST)
In-Reply-To: <1398682498-24357-12-git-send-email-mpa@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Alexander Shiyan <shc_work@mail.ru>, Sascha Hauer <s.hauer@pengutronix.de>, Timur Tabi <timur@tabi.org>, "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>, kernel@pengutronix.de, Nicolin Chen <Guangyu.Chen@freescale.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============7000104193442081186==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8xmtxPcUdvCUW4aT"
Content-Disposition: inline


--8xmtxPcUdvCUW4aT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2014 at 12:54:52PM +0200, Markus Pargmann wrote:
> From: Sascha Hauer <s.hauer@pengutronix.de>
>=20
> fsl_ssi_set_dai_sysclk will be called from fsl_ssi_hw_params in the
> next patch. Move up to avoid forward declaration and to keep the next pat=
ch
> more readable. No functional change.

Applied, thanks.

--8xmtxPcUdvCUW4aT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTe9GMAAoJELSic+t+oim9HZIP/3xcnakmeCHwUQT7lOCWb8E2
Jk61EqnGOM3jns61G8+VGroHajjdU2OoeqJPI8q0oEvp7QTqz0BOKOHcCH/jGvlk
wBwi5vNkrXXfWrkbaHaib+l+2B77zbeZONNwjoQQ0qyywCRlxpIBbqeGlWqA+EXm
l8WhTBI4yQmxGcXs0s/R71CF3zs5PV2IRCZcfzjKu6Jbg8biIyprwjlPs+lV+P9A
HbnA9JFHtcT+DZY+y+kZXaTug8P252kQ6GCp6cEeP301qDBjDfVTYyiaihQ0UQlo
7sKKWReBYngBaMiyyvfUweBzEtKABA9mQalv/KQIV3FiOf5ZfTKYJsCBP2ks7/2Z
fOXF21s5M8l0sdkDotrrWCuBSIz3fq6TDyrp+B7WFaM8tPgYNiGeQjZYuBW0sgHt
lSkNZtSln75h1MdZ5VQIfRN+UZhm6qSHJpgK/NPnmICwZrqZX33ONYkuA5P9fzGV
CuXAvwVzk60ZdyDGWZp7QD9jmnSxbgH3GTnJoFx1oJEl3xRNba1FvPymJJTE0Ese
MLU1yruN6w7yho2R1X/fxTnMBu1Z78hAPaVK38etWIxPxjfsCmb+q+/97Po10Vih
iK/+c4ajCWIRTpOZBDuYiZwzGdzXEzRQtpFbrcHgSIpT6IBSeTLxzhyLGPD8RTWe
NDRVsFziP3AASh8WopXW
=T6yI
-----END PGP SIGNATURE-----

--8xmtxPcUdvCUW4aT--

--===============7000104193442081186==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7000104193442081186==--
