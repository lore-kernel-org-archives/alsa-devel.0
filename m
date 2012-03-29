From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: sgtl5000: Enable VAG when DAC/ADC up
Date: Thu, 29 Mar 2012 12:16:05 +0100
Message-ID: <20120329111605.GK3668@opensource.wolfsonmicro.com>
References: <1333000305-27280-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5300905099514721159=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 39FE41043D2
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Mar 2012 13:16:08 +0200 (CEST)
In-Reply-To: <1333000305-27280-1-git-send-email-shawn.guo@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: alsa-devel@alsa-project.org, Zeng Zhaoming <zengzm.kernel@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============5300905099514721159==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="P7Tqkd/m/Jnohiaz"
Content-Disposition: inline


--P7Tqkd/m/Jnohiaz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 29, 2012 at 01:51:45PM +0800, Shawn Guo wrote:

> +	SND_SOC_DAPM_ADC_E("ADC", "Capture", SGTL5000_CHIP_ANA_POWER, 1, 0,
> +			power_vag_event,
> +			SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
> +	SND_SOC_DAPM_DAC_E("DAC", "Playback", SGTL5000_CHIP_ANA_POWER, 3, 0,
> +			power_vag_event,
> +			SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),

What would be more idiomatic here would be to make VAG a supply widget
and then connect it to DAC and ADC rather than have the event on both -
It looks like with your current code simultaneous playback and capture
will break, you'll run through the power sequences twice and if you stop
one stream it'll power down the other.

> +	{"Mic Bias", NULL, "MIC_IN"},		/* mic_in --> mic bias */
> +	{"Capture Mux", "MIC_IN", "Mic Bias"},	/* mic bias --> adc_mux */

This should be in the machine driver.

--P7Tqkd/m/Jnohiaz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPdERuAAoJEBus8iNuMP3dLHwP/0Ux/iqHzISjrS35JUF6Z/vb
Ag82i8KkmU8lUHxqukXJpI5UP3/HvBmn3YWSgwMIZU2rdRzpXO122p+0kWIgFzDf
5s4iXzlRN3x0Ht/enRi0z+agncWAMkONCnery90kRzevjRQPl98CI599hIVrUIFs
y2FqHG8hrid0JkwIJ8gTrSzfzYLMCjqqdigsELT3jy/symgbszT3FPeBj3U+GY5K
e2cSfB531s/xyWHrSEQKvsehaHjK3HNYL8+1u0PpnC/tMP/VwNzK+Meo9OVjHFGg
xJ4DXkryz1J+SsriBzi39Uko+wMMGWQHPbO7X+g1wBbysMXK29q8ElbphkTBKytQ
Wtjoa83NNva/xsB4MubhgIy9p4dhve9FZBBqlUJwkh/rVrHDVywekqZOuUuDYIhN
Xnilr3NAP12xFIQnrF7z5GRGf4gIDw8BK7uAWVJe9OYHY5qzgRsTey8nFeGA8TzF
g1fl7UP/egloDbgU010zvcpHNE7z2bp4qTnlJ2yJB47mCRF7zP4ffepSrEVdLtJD
LJVLh84OoAX3bdiVlM3n61rFraTswaQkseDrTMd/x9XuvmF9KmWKPZsphRW2PzuE
H1PmZ64JwOFTTeGbc622tBcreuSLlycxRutxoBaB3m8kQf205/3qL3GXnfMCZP8m
dJyZPiB+lyhMaxxb4Tjg
=DFZR
-----END PGP SIGNATURE-----

--P7Tqkd/m/Jnohiaz--

--===============5300905099514721159==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5300905099514721159==--
