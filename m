From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/2] ASoC: add es8316 codec driver
Date: Fri, 19 May 2017 18:20:18 +0100
Message-ID: <20170519172018.ei7dpijifrjfwoeo@sirena.org.uk>
References: <20170516202035.27590-1-drake@endlessm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6674064734274697881=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CB96D2667A5
 for <alsa-devel@alsa-project.org>; Fri, 19 May 2017 19:20:29 +0200 (CEST)
In-Reply-To: <20170516202035.27590-1-drake@endlessm.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Drake <drake@endlessm.com>
Cc: alsa-devel@alsa-project.org, linux@endlessm.com, lgirdwood@gmail.com, yangxiaohua@everest-semi.com, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org


--===============6674064734274697881==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bszsqf45jnaj6dp5"
Content-Disposition: inline


--bszsqf45jnaj6dp5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 16, 2017 at 02:20:34PM -0600, Daniel Drake wrote:

> +static const char * const alc_func_txt[] = { "Off", "On" };
> +static const struct soc_enum alc_func =
> +	SOC_ENUM_SINGLE(ES8316_ADC_ALC1, 6, 2, alc_func_txt);

Use normal boolean controls for simple on/off switches, just a _SINGLE
control with a name ending Switch.  This applies to many controls in
this driver.

> +static const struct snd_kcontrol_new es8316_snd_controls[] = {
> +	SOC_DOUBLE_TLV("HP Playback Volume", ES8316_CPHP_ICAL_VOL,
> +		       4, 0, 0, 1, hpout_vol_tlv),
> +	SOC_DOUBLE_TLV("HPMixer Gain", ES8316_HPMIX_VOL,
> +		       0, 4, 7, 0, hpmixer_gain_tlv),

All volume controls should end in Volume so that UIs know what to do
with them.  This is also a repeated problem.

> +static int es8316_set_bias_level(struct snd_soc_codec *codec,
> +				 enum snd_soc_bias_level level)
> +{
> +	switch (level) {
> +	case SND_SOC_BIAS_ON:
> +		snd_soc_write(codec, ES8316_RESET, 0xC0);

Writing to the reset register doens't reset the chip?

> +		snd_soc_write(codec, ES8316_CPHP_OUTEN, 0x66);
> +		snd_soc_write(codec, ES8316_DAC_PDN, 0x00);
> +		snd_soc_write(codec, ES8316_CPHP_LDOCTL, 0x30);
> +		snd_soc_write(codec, ES8316_CPHP_PDN2, 0x10);
> +		snd_soc_write(codec, ES8316_CPHP_PDN1, 0x03);
> +		snd_soc_write(codec, ES8316_HPMIX_PDN, 0x00);
> +		snd_soc_update_bits(codec, ES8316_ADC_PDN_LINSEL, 0xc0, 0x00);
> +		snd_soc_write(codec, ES8316_SYS_PDN, 0x00);
> +		snd_soc_write(codec, ES8316_SYS_LP1, 0x04);
> +		snd_soc_write(codec, ES8316_SYS_LP2, 0x0c);

This all looks like it should be managed by DAPM.

> +		break;
> +	case SND_SOC_BIAS_PREPARE:
> +		break;
> +	case SND_SOC_BIAS_STANDBY:
> +		break;

Transitioning to ON should be undone when we go back down to standby.

> +static int es8316_probe(struct snd_soc_codec *codec)

> +	snd_soc_write(codec, ES8316_CLKMGR_CLKSEL, 0x08);
> +	snd_soc_write(codec, ES8316_CLKMGR_ADCOSR, 0x32);
> +	snd_soc_write(codec, ES8316_CLKMGR_ADCDIV1, 0x11);
> +	snd_soc_write(codec, ES8316_CLKMGR_ADCDIV2, 0x00);
> +	snd_soc_write(codec, ES8316_CLKMGR_DACDIV1, 0x11);
> +	snd_soc_write(codec, ES8316_CLKMGR_DACDIV2, 0x00);
> +	snd_soc_write(codec, ES8316_CLKMGR_CPDIV, 0x00);
> +	snd_soc_write(codec, ES8316_SERDATA1, 0x04);
> +	snd_soc_write(codec, ES8316_CLKMGR_CLKSW, 0x7f);
> +	snd_soc_write(codec, ES8316_CAL_TYPE, 0x0F);
> +	snd_soc_write(codec, ES8316_CAL_HPLIV, 0x90);
> +	snd_soc_write(codec, ES8316_CAL_HPRIV, 0x90);
> +	snd_soc_write(codec, ES8316_ADC_VOLUME, 0x00);

No big undocumented magic register write sequences in probe please,
especially not ones that look like they change the default values of
user visible controls.  The chip should use the hardware defaults where
possible to avoid having to decide which use cases to support in the
driver.  Let userspace pick what works for a given system.

> +static const struct i2c_device_id es8316_i2c_id[] = {
> +	{"ESSX8316", 0 },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, es8316_i2c_id);

Linux I2C device IDs are generally lower case.

--bszsqf45jnaj6dp5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlkfKVEACgkQJNaLcl1U
h9A4sgf9FM2Bjc27b34K1g2h1d6OuQmMkZICCkjaSerBqew55OvgBcFtGGeRMc2w
UHtZvaV//Yu1K/n9WynsMwHgm8k1Xpvpy/ikItlRaHFYyvzFpTTrg+Gi8rCeUW5U
yxB3TNjdDTwLDPVocuQ3C+tgB5BZYrCj+WT7qhEBT3Q+hkbgVHBWg5opxt3lR0VY
3/L6jiprt2UKkz1Ws8M3aNQz+dZQ6aqIUaCd6sUiXF7NL0tuOehhg7vQXGjPHt56
BeVyT1bU7295Hax+Qz9+29FPHp/ssAVsKBIcdjCmjrYlFhqQfG8pJ73noVxCkdJE
u2P/Yp/tt9OvHuq/9Y0QwO5JeAueFA==
=gK8k
-----END PGP SIGNATURE-----

--bszsqf45jnaj6dp5--

--===============6674064734274697881==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6674064734274697881==--
