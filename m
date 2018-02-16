From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 1/2] ASoC: codecs: Add support for
	AK5558 ADC driver
Date: Fri, 16 Feb 2018 12:14:45 +0000
Message-ID: <20180216121445.GH5886@sirena.org.uk>
References: <1518532174-11350-1-git-send-email-daniel.baluta@nxp.com>
 <1518532174-11350-2-git-send-email-daniel.baluta@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8158829309619776806=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 4DD80267E10
 for <alsa-devel@alsa-project.org>; Fri, 16 Feb 2018 13:14:48 +0100 (CET)
In-Reply-To: <1518532174-11350-2-git-send-email-daniel.baluta@nxp.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Baluta <daniel.baluta@nxp.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, robh@kernel.org, shengjiu.wang@nxp.com, linux-kernel@vger.kernel.org, wakasugi.jb@om.asahi-kasei.co.jp, cosmin.samoila@nxp.com, andy.shevchenko@gmail.com, daniel.baluta@gmail.com, linux-imx@nxp.com, fabio.estevam@nxp.com, Mihai Serban <mihai.serban@nxp.com>, mihai.serban@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============8158829309619776806==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="X+8siUETKMkW99st"
Content-Disposition: inline


--X+8siUETKMkW99st
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 13, 2018 at 04:29:33PM +0200, Daniel Baluta wrote:

> +++ b/sound/soc/codecs/ak5558.c
> @@ -0,0 +1,417 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*

Just make this a C++ commment, don't mix C and C++ - it looks neater.
Otherwise this looks good so I'll apply, please send a followup patch
for the above.

--X+8siUETKMkW99st
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqGyzUACgkQJNaLcl1U
h9DT7Af/Umwkug7QvVOl/p5SxKtPTAhEmUo7COO9Mf4yIYyVYDSMzfETYdtTz54v
JblysLH1WXtSw6E532leFC8EGn/3Na+Y5AcZRTWImf1Vzo2KFUji12MrWptK15W/
HdxwZZRFVgVGrvSZrfGju2h68bveFHQf+vh3QQH3Lx/bKQiWAcEnzS0M8upBIYd8
hHll8RqqAzc2so2P5O5tGWsK9TtNIAf18TnKo87xQ7+pJAv5ZBxcI59qxdnYXwQj
Rdss+sLVRF+93wff9KfShVOX8Yu4aUP1Sb9uQGqS6f5HcBxbe1Xz0189HW9GXoDQ
i3FCfAdV0ntR5HHmJpV+CId6tLsQdg==
=DTcU
-----END PGP SIGNATURE-----

--X+8siUETKMkW99st--

--===============8158829309619776806==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8158829309619776806==--
