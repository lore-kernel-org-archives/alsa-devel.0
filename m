From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] ASoC: Add support for TI LM49453 Audio
	codec
Date: Sat, 4 Feb 2012 17:00:35 +0000
Message-ID: <20120204170034.GD8042@opensource.wolfsonmicro.com>
References: <4F2C0DBC.50100@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7477962852234103077=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 15310243A0
	for <alsa-devel@alsa-project.org>; Sat,  4 Feb 2012 18:00:40 +0100 (CET)
In-Reply-To: <4F2C0DBC.50100@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: M R Swami Reddy <MR.Swami.Reddy@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Girdwood,
	Liam" <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============7477962852234103077==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oj4kGyHlBMXGt3Le"
Content-Disposition: inline


--oj4kGyHlBMXGt3Le
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 03, 2012 at 10:09:24PM +0530, M R Swami Reddy wrote:

> ---
> Changes made in V2
> o Removed fll and vco reference frequency settings from _set_dai_pll()
> o Reworked chip enable and disable in _STANDBY and _OFF modes in
> m49453_set_bias_level, as per the review comments.

You say this is version 2 but there's been rather more than two versions
posted...

> +static int lm49453_set_dai_pll(struct snd_soc_dai *codec_dai, int pll_id,
> +                              int source, unsigned int freq_in,
> +                              unsigned int freq_out)
> +{

This is now a bit odd.

> +       state->in = freq_in;
> +       state->out = freq_out;

It stores but otherwise ignores the configuration which was passed in
(which seems more than a little odd).

> +       /* Always disable the PLL - it is not safe to leave it running
> +        * while reprogramming it.
> +        */
> +       snd_soc_update_bits(codec, LM49453_P0_PMC_SETUP_REG,
> +                           LM49453_PMC_SETUP_PLL_EN, 0);
> +
> +       if (!freq_in || !freq_out)
> +               return 0;
> +
> +
> +       /* All done, turn it on */
> +       snd_soc_update_bits(codec, LM49453_P0_PMC_SETUP_REG, pwr_mask,
> +                           pwr_mask);

Then if the PLL was already enabled it bounces the power briefly.
Really it seems like this should just be merged in with set_sysclk() -
you're not actually configuring the PLL at all, just turning it on and
off, at which point it's just another SYSCLK source.

Otherwise this seems good, just this clock configuration stuff to sort
out.

--oj4kGyHlBMXGt3Le
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPLWQsAAoJEBus8iNuMP3d4QMP/1UOJiOwW8ymuTDc7dh+frkm
+9XxQCgo1blcXSQTjcwLqCuYdkTFVJhXmrolOpEezE0OPnbTgcGI9hxqbNJlu80a
227tS6Z4ZGHIEa++vqvyyEPE2aSyuQUYajP/q4AZhKaItGwMjKnzNJbwTnNsuyP0
uAucjpce1nbNTqxl285gLCF7sjBwqFxoboMk1abkW0NrkVnPeB9wNGClpY7Mih94
OL+UaMwPgsVEeKTKQHhv8ofEGC/FHjEnC09FRDL/1fpfF1/nClieeu8GUiujbuJy
c5z+w86gQgno8f+Eg6GHqGf8CQ4Vh/e7nU3evyWVqdd3Atl8E6Fr7mYZBkeVCi7f
WnTgK6fmhXvgB2iKqd1k2S3mqPfGpsxPE+JoLJJDterroBrTDcL1uno8OOlvWAAq
/LC2ptfHPu1OjUaPSKGlIXopKpzAPQ1QREUVwy5jcmRQJQ2tnyX3FduA7suJ4N4e
HrAVoD2FWYVy4Byjz1PnxOTBLtbRQhoz/GseDVNKCfVMRUcjaOOb1cXMNzy15HXo
PWH2ZMKxY+tZb85kcYtHAPZAzI8PoZI8IlESL3DiMq7N6DKqxapknwgICsWpBLx+
9GMaXiyWkrOzRuRsBfJm8OAhxJzijs2mqjS2Glfv/L0+bX3VrtVn3Sr/cLvzfGdN
hbpIsRsr+X3lOQbge3y1
=QJb/
-----END PGP SIGNATURE-----

--oj4kGyHlBMXGt3Le--

--===============7477962852234103077==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7477962852234103077==--
