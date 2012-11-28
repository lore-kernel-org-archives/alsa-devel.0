From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 06/14] ASoC: da7210: Use
	devm_regmap_init_i2c()
Date: Wed, 28 Nov 2012 17:43:19 +0000
Message-ID: <20121128174318.GY32691@opensource.wolfsonmicro.com>
References: <1353930587-12907-1-git-send-email-sachin.kamat@linaro.org>
 <1353930587-12907-7-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5859528733106624408=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 432942625DD
 for <alsa-devel@alsa-project.org>; Wed, 28 Nov 2012 18:43:20 +0100 (CET)
In-Reply-To: <1353930587-12907-7-git-send-email-sachin.kamat@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lrg@ti.com, patches@linaro.org
List-Id: alsa-devel@alsa-project.org


--===============5859528733106624408==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="B7FF+pnjRCrp0ISR"
Content-Disposition: inline


--B7FF+pnjRCrp0ISR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 26, 2012 at 05:19:39PM +0530, Sachin Kamat wrote:
> devm_regmap_init_i2c() is device managed and makes error
> handling and code cleanup simpler.

Applied, thanks.

--B7FF+pnjRCrp0ISR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQtk0vAAoJELSic+t+oim9mf8P/ilcaJXr7GBJLcExw8WnxHcs
C7FT5dd2qp9VGNLaqN4g2Qz+cRLrvkL1sf3wlAblkFvfC4Z/4FGIsfVCirNv09em
nb9OxGYSm3CKJla3GHYuN5t5MpJQ3S7ugkbzZlXbhxCCZJlDMXR1ABT8HkUDX+o3
Ijy4wCndfpho9DDqtWdE83noAoPO0/IWvyOOSiYJsESg9TFNGVHvuKuT3MX810IL
j/Ir51FTaJjsOvAIRCoFIzy5ROMoqsIWNVdPlsNruLrYeaEihaHqKnwmWTep4rBN
32sEB+/Z4iRslIpgwO3webkSsUDrqxVkMbmXJOFh8xIQ8G08nDcsEFcOh7xM0T74
HvhV6ZcC3hwP0eXRf5K91BvS+ZDXRgsOugmHmp6HeudrbF7UBVf1Tu0XO4Fr0E7q
bXRyyE5qZTbKdgQWHMn+kPNanVxa5NxTrxJ7b8UtpnLTyPPa/UVyXbvcpVEX8Tgo
vXirk1Q7J5ilzc/SbcjhpFuvTiwvIsI8xNjRylEmR4zlnFL4Je+lc/uWTwYvYUdo
ZEdbIQhKjOMcVL+DKuiu4JbE9LRPc+ty6rGpfv3mRQlckm5qXwle2jsxP//UmBKX
Lrt4UMDhtXdpACRaRxWqJ7BgGqv+OHwKRIRV6sPSjX+moX+YZAAYgqn2rsZPUgOd
IfxgRLf1vfWE6gcqeoMW
=y9F/
-----END PGP SIGNATURE-----

--B7FF+pnjRCrp0ISR--

--===============5859528733106624408==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5859528733106624408==--
