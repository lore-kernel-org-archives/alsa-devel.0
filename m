From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: add RT5640 CODEC driver
Date: Mon, 3 Jun 2013 16:35:42 +0100
Message-ID: <20130603153542.GM31367@sirena.org.uk>
References: <1369983899-13580-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6736352182295708948=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 04901261ADA
 for <alsa-devel@alsa-project.org>; Mon,  3 Jun 2013 17:35:48 +0200 (CEST)
In-Reply-To: <1369983899-13580-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: bardliao@realtek.com
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, swarren@nvidia.com, swarren@wwwdotorg.org, lgirdwood@gmail.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============6736352182295708948==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jRdC2OsRnuV8iIl8"
Content-Disposition: inline


--jRdC2OsRnuV8iIl8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2013 at 03:04:59PM +0800, bardliao@realtek.com wrote:

> From: Bard Liao <bardliao@realtek.com>

This looks pretty good, a few small things below and probably one actual
bug.

>=20
> * Use regmap_range_cfg to replace index read/write function.
> * Remove I2S3 related code since there is no I2S3 in ALC5640.
> * Remove Voice DSP related code since there is no Voice DSP in ALC5640.
> * Remove MICBIAS2 since there is no MICBIAS2 in ALC5640.
> * Change DMIC1/2 CLK to DMIC1/2 Power since it is for enable/disable DMIC=
1/2
> * Modify some texts for consistent coding style.
> * Merge sto adc l/r mux since it shares the same control bits.
> * Other minor changes.

Put stuff like this after the --- so it doesn't end up in the commit
log.

> +	switch (event) {
> +	case SND_SOC_DAPM_POST_PMU:
> +		snd_soc_update_bits(codec, RT5640_PWR_DIG1, 0x0001, 0x0001);
> +		regmap_update_bits(rt5640->regmap, 0x1c, 0xf000, 0xf000);
> +		break;

It's a bit weird to be using snd_soc_update_bits() and
regmap_update_bits()...

> +	SND_SOC_DAPM_SUPPLY("DMIC1 Power", SND_SOC_NOPM, 0, 0,
> +		rt5640_set_dmic1_event,
> +		SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
> +	SND_SOC_DAPM_SUPPLY("DMIC2 Power", SND_SOC_NOPM, 0, 0,
> +		rt5640_set_dmic2_event,
> +		SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),

The enable bits could be listed here - this would be a bit more
idiomatic, would save the PMD event and would enable the writes to be
combined.

> +	case SND_SOC_BIAS_STANDBY:
> +		if (SND_SOC_BIAS_OFF =3D=3D codec->dapm.bias_level) {
> +			snd_soc_update_bits(codec, RT5640_PWR_ANLG1,
> +				RT5640_PWR_VREF1 | RT5640_PWR_MB |
> +				RT5640_PWR_BG | RT5640_PWR_VREF2,
> +				RT5640_PWR_VREF1 | RT5640_PWR_MB |
> +				RT5640_PWR_BG | RT5640_PWR_VREF2);
> +			mdelay(10);
> +			snd_soc_update_bits(codec, RT5640_PWR_ANLG1,
> +				RT5640_PWR_FV1 | RT5640_PWR_FV2,
> +				RT5640_PWR_FV1 | RT5640_PWR_FV2);
> +			regcache_cache_only(rt5640->regmap, false);
> +			regcache_sync(rt5640->regmap);

This looks wrong - you're writing to the device before you take it out
of cache only mode so your delay in the above sequence will have no
effect.

> +	val =3D snd_soc_read(codec, RT5640_VENDOR_ID2);
> +	if ((val !=3D RT5640_DEVICE_ID)) {
> +		dev_err(codec->dev,
> +			"Device with ID register %x is not rt5640/39\n", val);
> +		return -ENODEV;
> +	}
> +
> +	rt5640_reset(codec);

Do these in the I2C probe function before you register the CODEC, that
way we don't try to start the sound card if we can't talk to the device.

> +	ret =3D regmap_register_patch(rt5640->regmap, init_list,
> +				    ARRAY_SIZE(init_list));
> +	if (ret !=3D 0)
> +		dev_warn(codec->dev, "Failed to apply regmap patch: %d\n",
> +			 ret);

This should also be in the I2C probe.

--jRdC2OsRnuV8iIl8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRrLfKAAoJELSic+t+oim9ijUP/iyA+Dzwp4eEi75sDVhyb74w
+BMhpl61Q/mqkZW2QBiWu0l79BQWzydRcLI1gHiIZpPofMM7n11oUk6gnz+UB2kC
v51kxB2UEEwl0eZyEHWW+Y5OgFeUHQS4Wdtq+D6ZJDlhE/pwjd4xPPSMYhoDOnqK
/t2Y7vF9KJ/qSJ9d5Eb1Qvb6LogxG/uec6SZpQ5JExPR0LC6CfY0kQTZ89avIyp+
n1pbbYNf5ThimRS+lnrcbQRBf+DxKLMR2WGqUEPcqpbNitqAxDrouETkT1eTxvYm
RW01CwE3XBHqgwzcApOO5zCHuTxTiak4llArrFPcd4Aorr3kxuS/4M+X/FCN9v9r
c43FSQK/VW6R36NcBOQ2gDT6coua7zU4BIoPBMaI7DrFfKTh1LZO0bLhdGIr3v3B
yOKXBoO7DtJz/6zsw4bpMVSmywu8GVmQ7P2ZMOaxKefftljADLtOHqzROvj76fBX
c+UQr0hZJS0ciKK/7Tb2ERczONccUnYhQefCmINBeZoduAL6B1gXScGSZBh1LGxf
OynOsWWi8Ax5La7cbtOLgxCPhJcf3REIgohjlZJEO7x5WUjwMbejqH4v5fQ6Qyre
eBj6rttzU8SwVWmoW9GN1JBdetv0A+hutU/salddZhauopos+x4YVowcYL54C/FE
s+HkGtirDFFk2Dc/W64w
=agJP
-----END PGP SIGNATURE-----

--jRdC2OsRnuV8iIl8--

--===============6736352182295708948==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6736352182295708948==--
