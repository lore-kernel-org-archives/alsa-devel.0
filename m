From: Mark Brown <broonie@kernel.org>
Subject: Re: [v5 1/2] ASoC: Add support for Cirrus Logic
	CS35L35 Amplifier
Date: Mon, 6 Mar 2017 11:28:58 +0100
Message-ID: <20170306102858.5r4idptgqebatgr7@sirena.org.uk>
References: <4c9a1ffa-ce09-46f5-a55d-19c81c377f85@EX3.ad.cirrus.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0803988299791303328=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id BD5F7261740
 for <alsa-devel@alsa-project.org>; Mon,  6 Mar 2017 11:29:11 +0100 (CET)
In-Reply-To: <4c9a1ffa-ce09-46f5-a55d-19c81c377f85@EX3.ad.cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Brian Austin <brian.austin@cirrus.com>
Cc: alsa-devel@alsa-project.org, robh+dt@kernel.org, ckeepax@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============0803988299791303328==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="udzvmcc5kjivejbe"
Content-Disposition: inline


--udzvmcc5kjivejbe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 03, 2017 at 08:09:31AM -0600, Brian Austin wrote:

> +		regmap_update_bits(cs35l35->regmap, CS35L35_PWRCTL1,
> +					CS35L35_PDN_ALL_MASK, 0);
> +	break;
> +	case SND_SOC_DAPM_POST_PMD:

Coding style: break should be indented along with the code block (as it
is in the rest of the driver).

> +static const struct snd_kcontrol_new cs35l35_aud_controls[] = {
> +	SOC_SINGLE_SX_TLV("Digital Audio Volume", CS35L35_AMP_DIG_VOL,
> +		      0, 0x34, 0xE4, dig_vol_tlv),
> +	SOC_SINGLE_TLV("AMP Audio Gain", CS35L35_AMP_GAIN_AUD_CTL, 0, 19, 0,
> +			amp_gain_tlv),

Volume controls should always end in Volume so that userspace knows how
to handle them.

> +			case CS35L35_SP_SCLKS_32FS:
> +			case CS35L35_SP_SCLKS_64FS:
> +			break;
> +			default:

Indentation again.

> +err:
> +	regulator_bulk_disable(cs35l35->num_supplies,
> +			       cs35l35->supplies);
> +	/* should we release reset-gpio? */

Probably best to leave the device in reset, it'll make things a bit more
robust.

--udzvmcc5kjivejbe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAli9OekACgkQJNaLcl1U
h9C0Qgf8DVMhScXtGv+QRaMUK+zObZRqrk4U37omrrAt3c+uqTP8unyjuMpEitLM
xLoLs9zU1kuKw3iTgGVziyBS9f8g3RL3k4wMVZhqEgod/zNdJH1Oz8wI/lR6vWkR
A2GDmFDbhkeZh/Bmty8wi7ZyBXalPELG42mgl1xeMwFCjJnDomJHzdjvJPdFnJkr
Z0OAPRXu5lalNhP8BEEDoX7j39gVtnFpa+7KJ6lO40BL/hxSkDyvjtemI7FR53a7
gX5NtAwsN5HCjwDER4PHNvpJkAvpeBZJ6Qg47K5nOHxXaOfnIY+sHMqYl/oivrUY
cCluY6lvjkR76koT6E6WdjgJw3bjxw==
=FEEJ
-----END PGP SIGNATURE-----

--udzvmcc5kjivejbe--

--===============0803988299791303328==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0803988299791303328==--
