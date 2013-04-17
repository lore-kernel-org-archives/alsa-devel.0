From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 05/17] ASoC: tegra: Use generic dmaengine
	PCM
Date: Wed, 17 Apr 2013 14:25:31 +0100
Message-ID: <20130417132530.GH13687@opensource.wolfsonmicro.com>
References: <1366046404-8759-1-git-send-email-lars@metafoo.de>
 <1366046404-8759-6-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3934259665075507326=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D114C2616BC
 for <alsa-devel@alsa-project.org>; Wed, 17 Apr 2013 15:25:32 +0200 (CEST)
In-Reply-To: <1366046404-8759-6-git-send-email-lars@metafoo.de>
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
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, alsa-devel@alsa-project.org, Rajeev Kumar <rajeev-dlh.kumar@st.com>, Russell King <linux@arm.linux.org.uk>, Ryan Mallon <rmallon@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>, Vinod Koul <vinod.koul@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Hartley Sweeten <hsweeten@visionengravers.com>, Laxman Dewangan <ldewangan@nvidia.com>, Sebastien Guiriec <s-guiriec@ti.com>, Markus Pargmann <mpa@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, Lee Jones <lee.jones@linaro.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org


--===============3934259665075507326==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HuscSE0D68UGttcd"
Content-Disposition: inline


--HuscSE0D68UGttcd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 15, 2013 at 07:19:52PM +0200, Lars-Peter Clausen wrote:
> Use the generic dmaengine PCM driver instead of a custom implementation.

Applied, thanks.

--HuscSE0D68UGttcd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRbqLEAAoJELSic+t+oim9trAQAJRlBHU54tb0LPanrWnpri9v
5nbYWhhs/jkMJAt72xna/04Q83qmv6quA957rHXCrhTusv9kHgJu8Jz4EqgmvxtJ
ECD0xEj3k/s9f/LjvAS9CMjIu0vOfORgCi8Jaaxr19mqiFh0rfkDjI5L5D6ijtiv
lmwlaP0YhVlv2Oim7Fu3GGewZ1RLOh8IGjDhx5khluAFfjOns0qBg8Mz/QdZ1AC+
VXm7NSrCziaBnDdmiRxMJIq+SR8VmxmTCwMZay/Yc7rKhKjLx5aiiD7p+EOnkQEr
ct1Z3e0TGldaIXIgp0fGHCxyYUoJdjF/x99ljvMYOtACjdt/5XIgRUDN+MDeI/s2
9QpqmKQeU8ZT5kmzJKCSi9D+hSLNrUe61+c7zT87xn1t5jJmKhXpFEZDzA9ZKXVd
YLECw4WMHv1OFlrstksGL0fYTeHGEkZG8KFzxIIcr7rDEYUuadZ5wNxb16avBMv5
RJCGwxwrVzcsCDXQG0HxXgC6zEhhftgXVyJBILIhHXQLdpcczXT7xtR/58vnhdsK
5ln7/7an7xwMx6Uk52yuTWBPLH3/XAUT+RLRpz0o8Dmf9zHpWQ7cQJRWXS9XK7GY
GTGBbSPMkaLArtqK1rbegFbFRIRLX/nvOr7NNUg04orgnNTkUDb5rl8rLnMEPWpt
wGjQpuK5dZCTcK0L+Omo
=XQ5u
-----END PGP SIGNATURE-----

--HuscSE0D68UGttcd--

--===============3934259665075507326==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3934259665075507326==--
