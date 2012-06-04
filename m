From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 2/2] ASoC: codecs: Add DA732x codec
	driver
Date: Mon, 4 Jun 2012 15:30:44 +0100
Message-ID: <20120604143043.GI7538@opensource.wolfsonmicro.com>
References: <201205311426.q4VEQOpN009947@sw-eng-lt-apt-vm1>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7682414564333974295=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 676B824338
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Jun 2012 16:30:45 +0200 (CEST)
In-Reply-To: <201205311426.q4VEQOpN009947@sw-eng-lt-apt-vm1>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Adam Thomson <Adam.Thomson@diasemi.com>
Cc: alsa-devel@alsa-project.org, Michal Hajduk <Michal.Hajduk@diasemi.com>
List-Id: alsa-devel@alsa-project.org


--===============7682414564333974295==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mhOzvPhkurUs4vA9"
Content-Disposition: inline


--mhOzvPhkurUs4vA9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 31, 2012 at 03:18:01PM +0100, Adam Thomson wrote:
> This patch adds support for the Dialog DA732x audio codec.

A few small things below, very minor and easy to correct though.

> +	{ DA732X_REG_STATUS_EXT		, 0x00 },
> +	{ DA732X_REG_STATUS		, 0x00 },

> +	{ DA732X_REG_MBOX0		, 0x00 },
> +	{ DA732X_REG_MBOX1		, 0x00 },
> +	{ DA732X_REG_MBOX2		, 0x00 },
> +	{ DA732X_REG_MBOX_STATUS	, 0x00 },

> +	{ DA732X_REG_ID			, 0x00 },

> +	{ DA732X_REG_DMA_STATUS		, 0x00 },
> +	{ DA732X_REG_BROWNOUT		, 0x00 },

I would be very surprised if some or all of the above regsters aren't
volatile and therefore shouldn't have default specified.

> +static int da732x_hpf_set(struct snd_kcontrol *kcontrol,
> +			  struct snd_ctl_elem_value *ucontrol)

Why doesn't a standard enum work for this?

> +	/* High Pass Filters */
> +	SOC_ENUM_EXT("DAC1 High Pass Filter Mode Switch",
> +		     da732x_dac1_hpf_mode_enum, da732x_hpf_get, da732x_hpf_set),

This shouldn't be a Switch, it's an enumeration.  Switches are plain
boolean controls.

> +	SOC_SINGLE("ADC1 Equalizer Switch", DA732X_REG_ADC1_EQ5,
> +		   DA732X_EQ_EN_SHIFT, DA732X_EQ_EN_MAX, DA732X_NO_INVERT),
> +	SOC_SINGLE_TLV("ADC1 EQ Band 1 Volume", DA732X_REG_ADC1_EQ12,
> +		       DA732X_EQ_BAND1_SHIFT, DA732X_EQ_VOL_VAL_MAX,
> +		       DA732X_INVERT, eq_band_pga_tlv),

I'd suggest calling the Switch "ADC1 EQ Switch" for consistency with the
gains for the bands (or expanding EQ in the gains but that'll make for a
lot of really long control names).

> +	case SND_SOC_DAPM_POST_PMU:
> +		if (w->reg == DA732X_REG_ADC1_PD)
> +			snd_soc_update_bits(codec, DA732X_REG_CLK_EN3,
> +					    DA732X_ADCA_BB_CLK_EN,
> +					    DA732X_ADCA_BB_CLK_EN);
> +		else
> +			snd_soc_update_bits(codec, DA732X_REG_CLK_EN3,
> +					    DA732X_ADCC_BB_CLK_EN,
> +					    DA732X_ADCC_BB_CLK_EN);

This reads like it should be a switch statement.  The effect will be the
same but it's a bit clearer.

> +	da732x->regmap = devm_regmap_init_i2c(i2c, &da732x_regmap);
> +	if (IS_ERR(da732x->regmap)) {
> +		ret = PTR_ERR(da732x->regmap);
> +		dev_err(&i2c->dev, "Failed to initialize regmap\n");
> +		goto err;
> +	}
> +
> +	ret = snd_soc_register_codec(&i2c->dev, &soc_codec_dev_da732x,
> +				     da732x_dai, ARRAY_SIZE(da732x_dai));

The register cache defaults make it look like there's a device ID
(or possibly chip revision?) register - it'd be good practice to read it
here and either verify that it has the expected value or log it
depending on which it is.

> +static const struct i2c_device_id da732x_i2c_id[] = {
> +	{ "da732x", 0},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, da732x_i2c_id);

Good practice would be to enumerate all the device IDs (so users can
just register devices) but it doesn't really matter.

--mhOzvPhkurUs4vA9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPzMaNAAoJEBus8iNuMP3d6+QP/2DlrfVLrmr6zqjH5xWKeZT5
fLQgpQzHmLqRu5PsQOYY/2q34VvshuB1iQjTjXgAY6uukAzN13Y4JaTG68mj0+AM
P9sy/7vpH9ZHX4lyhSb1jpklj+EuMNLfxm76x7DgzfhKeXFwXPpuGVw7xksxsK7U
717j0zDHOsXylw8HckvkCEK1vEDJBSbSgWSl/ZhO8Emoza7ZJYg0EsV+2Tnmj2uh
I0H+nH+OOzxz8fZj3aRUyHeN1ZuUeZ8J4dCVulqTKQgKATvBnh7ggPIZFD2gzT+M
1l8nPt8fdCSnMgpbjgcTF0XYB92cnHaR4pIpukFzuIs4GeVZ616uXyqkGqGUDH0J
4yp4Gm46HtvvTUNghCrwNrsYq5wzSDNNnyO+0YldbBDUYHKL4KFjVSfi9jfwgzaU
52fYcYt6bkwo4BGC3p8zX9q0w2l7uJ0xoCh2DYZXV2l5kksNFRR0HKNbgC7anB97
qbOPEdj5c/sUl+w0JXQtHkLM6kc71BzkDwX7aqVIzT3Bx3HhdPGv+Eo0Hsrcsh8Q
KuX9FyUeA3qqQv8KfjyzWJcuKnOyLxcb3D32NgH0WkJNmOjKLvblBfFiCYTqi5gO
U5KRHNjwK0ht7fQCZ1dxBh1Ie47U3YlrgD5evBOXc7zph8dfLQry8AZ2/PZzmdyT
wJksn0lMFXGDpCnD1ujS
=zWwW
-----END PGP SIGNATURE-----

--mhOzvPhkurUs4vA9--

--===============7682414564333974295==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7682414564333974295==--
