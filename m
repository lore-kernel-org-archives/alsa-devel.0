From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 2/2] ASoC: add support for TAS6424
	digital amplifier
Date: Wed, 19 Jul 2017 12:08:42 +0100
Message-ID: <20170719110842.lb2f5cqawnkenhsb@sirena.org.uk>
References: <1500405604-23511-1-git-send-email-m-stecklein@ti.com>
 <1500405604-23511-3-git-send-email-m-stecklein@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6252302597426377999=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 468AC266998
 for <alsa-devel@alsa-project.org>; Wed, 19 Jul 2017 13:09:00 +0200 (CEST)
In-Reply-To: <1500405604-23511-3-git-send-email-m-stecklein@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Michael Stecklein <m-stecklein@ti.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, "Andrew F . Davis" <afd@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============6252302597426377999==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dhu4rczr3qhcndvx"
Content-Disposition: inline


--dhu4rczr3qhcndvx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 18, 2017 at 02:20:04PM -0500, Michael Stecklein wrote:

> +	if (!tx_mask) {
> +		dev_err(codec->dev, "tdm mask must not be 0\n");
> +		return -EINVAL;
> +	}

Setting the mask to 0 is used when turning off TDM.

> +	if ((reg & TAS6424_WARN_VDD_UV) && !(tas6424->last_warn & TAS6424_WARN_VDD_UV))
> +		dev_warn(dev, "experienced a VDD under voltage condition\n");
> +
> +	if ((reg & TAS6424_WARN_VDD_POR) && !(tas6424->last_warn & TAS6424_WARN_VDD_POR))
> +		dev_warn(dev, "experienced a VDD POR condition\n");

These look like they are errors rather than warnings and should be
critical prints like the other errors.

> +	/* Store current warn value so we can detect any changes next time */
> +	tas6424->last_warn = reg;

It would be better to clear these at some point, perhaps after a delay.
Especially with thermal issues they could come and go over device
operation.

> +static int tas6424_codec_probe(struct snd_soc_codec *codec)
> +{
> +	struct tas6424_data *tas6424 = snd_soc_codec_get_drvdata(codec);
> +	int ret;
> +
> +	tas6424->codec = codec;
> +
> +	ret = regulator_bulk_enable(ARRAY_SIZE(tas6424->supplies),
> +				    tas6424->supplies);
> +	if (ret != 0) {
> +		dev_err(codec->dev, "failed to enable supplies: %d\n", ret);
> +		return ret;
> +	}

This init stuff should be in either the main I2C probe, DAPM or bias
level management.  The CODEC probe should be very minimal.

> +	if (event & SND_SOC_DAPM_POST_PMU) {

> +	} else if (event & SND_SOC_DAPM_PRE_PMD) {

You're trying to write a switch statement here.

> +	switch (level) {
> +	case SND_SOC_BIAS_ON:
> +	case SND_SOC_BIAS_PREPARE:
> +		msleep(500);
> +		break;

You need a 500ms sleep in all these cases?  That's a lot of sleeping.

> +	case SND_SOC_BIAS_STANDBY:
> +		ret = snd_soc_update_bits(codec, TAS6424_CH_STATE_CTRL_REG,
> +					  0xff, TAS6424_CH1_STATE_MUTE | TAS6424_CH2_STATE_MUTE |
> +					  TAS6424_CH3_STATE_MUTE | TAS6424_CH4_STATE_MUTE);
> +
> +		if (ret < 0) {
> +			dev_err(codec->dev, "error resuming device: %d\n", ret);
> +			return ret;
> +		}
> +		break;
> +	case SND_SOC_BIAS_OFF:
> +		ret = snd_soc_update_bits(codec, TAS6424_CH_STATE_CTRL_REG,
> +					  0xff, TAS6424_CH1_STATE_HIZ | TAS6424_CH2_STATE_HIZ |
> +					  TAS6424_CH3_STATE_HIZ | TAS6424_CH4_STATE_HIZ);
> +
> +		if (ret < 0) {
> +			dev_err(codec->dev, "error suspending device: %d\n", ret);
> +			return ret;
> +		}

These mutes seem very random disassociated from anything else?

--dhu4rczr3qhcndvx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAllvPbkACgkQJNaLcl1U
h9Dxugf/eJpPWVzXAnLcrdkQ2IJqfzWjJ4RSDiykX8ScdeYpR5osQswoiuWrwJFg
2o6/3MXHlYZOhpJSKQhkJJqG6nNlrBCFuTd7Jyz8ugl2Lei7qTwD1dzsNCfjTcNz
t2zekW6RjvMya+7j/6j1qNXS1+cNup5rSTQdv1/iYXsWsNtSG2PT+aDhLHTHd8OV
TnMuRObJO5Iz2DHjKklKKE3NpvpW5I+naD2ssT97evp6Fds2GQSazW98fuPu00LZ
5FZFANZMdCMvrcGzgSsvFgYu33R+t7SyS3RlamnWxcSTU+n3jFpz2e8wyDxl9TbL
862VOQQAkM6ANHKcrEtYVDhf6OiNcQ==
=d82M
-----END PGP SIGNATURE-----

--dhu4rczr3qhcndvx--

--===============6252302597426377999==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6252302597426377999==--
