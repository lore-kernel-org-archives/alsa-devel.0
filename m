From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Add support for CS42L52 Codec
Date: Tue, 17 Apr 2012 12:14:00 +0100
Message-ID: <20120417111359.GB6652@opensource.wolfsonmicro.com>
References: <1334609938-11671-1-git-send-email-brian.austin@cirrus.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5661453391292812875=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6363724380
	for <alsa-devel@alsa-project.org>;
	Tue, 17 Apr 2012 13:14:03 +0200 (CEST)
In-Reply-To: <1334609938-11671-1-git-send-email-brian.austin@cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Brian Austin <brian.austin@cirrus.com>
Cc: mbizon@freebox.fr, alsa-devel@alsa-project.org, lrg@ti.com, joe@nucleusys.com
List-Id: alsa-devel@alsa-project.org


--===============5661453391292812875==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8GpibOaaTibBMecb"
Content-Disposition: inline


--8GpibOaaTibBMecb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 16, 2012 at 03:58:58PM -0500, Brian Austin wrote:
> This patch adds support for Cirrus Logic CS42L52 Low Power Stereo Codec

Overall this looks good, a few issues below...

> +static const struct reg_default cs42l52_reg_defaults[] = {
> +	{ 1, 0xE0 },	/* r01 ChipID */

You shouldn't provide a default for this, the whole point with a
register like this is that it gets read from the device so you can
confirm you're talking to the right device.  As things stand your code
in probe will just check that the cache is initialised with the expected
default.

> +	{ 49, 0x00 },	/* r31 Speaker Status */

Going on the name this (and possibly some of the other registers) ought
to be marked as volatile and not have a default.

> +static const char * const mic_bias_level_text[] = {
> +	"0.5 +VA", "0.6 +VA", "0.7 +VA",
> +	"0.8 +VA", "0.83 +VA", "0.91 +VA"
> +};

Normally this is a platform data type thing.

> +static const char * const cs42l52_mic_text[] = { "Single", "Differential" };

This too - it's usually determined by the schematic, not something that
gets varied at runtime.

> +static const char * const beep_pitch_text[] = {
> +	"C4", "C5", "D5", "E5", "F5", "G5", "A5", "B5",
> +	"C6", "D6", "E6", "F6", "G6", "A6", "B6", "C7"
> +};
> +
> +static const struct soc_enum beep_pitch_enum =
> +	SOC_ENUM_SINGLE(CS42L52_BEEP_FREQ, 4,
> +		ARRAY_SIZE(beep_pitch_text), beep_pitch_text);
> +
> +static const char * const beep_ontime_text[] = {
> +	"86 ms", "430 ms", "780 ms", "1.20 s", "1.50 s",
> +	"1.80 s", "2.20 s", "2.50 s", "2.80 s", "3.20 s",
> +	"3.50 s", "3.80 s", "4.20 s", "4.50 s", "4.80 s", "5.20 s"
> +};
> +
> +static const struct soc_enum beep_ontime_enum =
> +	SOC_ENUM_SINGLE(CS42L52_BEEP_FREQ, 0,
> +		ARRAY_SIZE(beep_ontime_text), beep_ontime_text);
> +
> +static const char * const beep_offtime_text[] = {
> +	"1.23 s", "2.58 s", "3.90 s", "5.20 s",
> +	"6.60 s", "8.05 s", "9.35 s", "10.80 s"
> +};
> +
> +static const struct soc_enum beep_offtime_enum =
> +	SOC_ENUM_SINGLE(CS42L52_BEEP_VOL, 5,
> +		ARRAY_SIZE(beep_offtime_text), beep_offtime_text);
> +
> +static const char * const beep_config_text[] = {
> +	"Off", "Single", "Multiple", "Continuous"
> +};
> +
> +static const struct soc_enum beep_config_enum =
> +	SOC_ENUM_SINGLE(CS42L52_BEEP_TONE_CTL, 6,
> +		ARRAY_SIZE(beep_config_text), beep_config_text);
> +
> +static const char * const beep_bass_text[] = {
> +	"50 Hz", "100 Hz", "200 Hz", "250 Hz"
> +};

All this beep stuff is really supposed to go through the input
subsystem, or at least have the hookup in there to trigger it.

> +static const char * const charge_pump_freq_text[] = {
> +	"0", "1", "2", "3", "4",
> +	"5", "6", "7", "8", "9",
> +	"10", "11", "12", "13", "14", "15" };
> +
> +static const struct soc_enum charge_pump_enum =
> +	SOC_ENUM_SINGLE(CS42L52_CHARGE_PUMP, 4,
> +		ARRAY_SIZE(charge_pump_freq_text), charge_pump_freq_text);

Should this be runtime configurable?

> +static const unsigned int swap_values[] = { 0, 1, 3 };

> +static const struct soc_enum adca_swap_enum =
> +	SOC_VALUE_ENUM_SINGLE(CS42L52_ADC_PCM_MIXER, 2, 1,
> +			      ARRAY_SIZE(left_swap_text),
> +			      left_swap_text,
> +			      swap_values);

This L/R swap stuff should probably go into DAPM, it's not so useful
right now but we're hopefully going to be able to get the ability to
figure out which of the channels on the DAI are active and power manage
appropriately.

> +	SND_SOC_DAPM_AIF_OUT("AIFOUTL", "Capture",  0,
> +			SND_SOC_NOPM, 0, 0),
> +	SND_SOC_DAPM_AIF_OUT("AIFOUTR", "Capture",  0,
> +			SND_SOC_NOPM, 0, 0),

You should use DAPM routes to hook the AIF widgets to the DAIs -
they're new as of 3.4 but ideally we'll be transitioning everything over
to this.  Some of the Wolfson drivers like wm8996 have been converted so
provide examples.

> +	switch (level) {
> +	case SND_SOC_BIAS_ON:
> +		snd_soc_update_bits(codec, CS42L52_PWRCTL1,
> +				    CS42L52_PWRCTL1_PDN_CODEC |
> +				    CS42L52_PWRCTL1_PDN_CHRG, 0);
> +		break;

This looks odd, especially having it in _ON - perhaps a comment
explaining why?

> +	case SND_SOC_BIAS_STANDBY:
> +		if (codec->dapm.bias_level == SND_SOC_BIAS_OFF) {
> +			regcache_cache_only(cs42l52->regmap, false);
> +			regcache_sync(cs42l52->regmap);
> +		}
> +		snd_soc_write(codec, CS42L52_PWRCTL1, CS42L52_PWRCTL1_PDN_ALL);
> +		break;
> +	case SND_SOC_BIAS_OFF:
> +		snd_soc_write(codec, CS42L52_PWRCTL1, CS42L52_PWRCTL1_PDN_ALL);
> +		break;

Should be setting cache_only when entering _OFF I think?

> +/* page 37 from cs42l52 datasheet */
> +static void cs42l52_required_setup(struct snd_soc_codec *codec)
> +{
> +	cs42l52_set_bias_level(codec, SND_SOC_BIAS_ON);
> +
> +	snd_soc_write(codec, CS42L52_FIX_BITS_CTL, 0x99);
> +	snd_soc_write(codec, CS42L52_FIX_BITS1, 0xBA);
> +	snd_soc_write(codec, CS42L52_FIX_BITS2, 0x80);
> +
> +	snd_soc_update_bits(codec, CS42L52_TEM_CTL, CS42L52_TEM_CTL_SET, 1);
> +	snd_soc_update_bits(codec, CS42L52_TEM_CTL, CS42L52_TEM_CTL_SET, 0);
> +
> +	snd_soc_write(codec, CS42L52_FIX_BITS_CTL, 0x00);
> +
> +	cs42l52_set_bias_level(codec, SND_SOC_BIAS_OFF);
> +}

You should use a regmap patch for this.  It's intended for this sort of
magic register write sequence on startup and is also integrated with the
cache sync code so the fixes will be automatically applies whenver you
sync.  With the code as it stands if the CODEC is powered off over
suspend then after resume these updates won't be applied.

> +	cs42l52->regmap = regmap_init_i2c(i2c_client, &cs42l52_regmap);
> +	if (IS_ERR(cs42l52->regmap)) {
> +		ret = PTR_ERR(cs42l52->regmap);
> +		dev_err(&i2c_client->dev, "regmap_init() failed: %d\n", ret);
> +		goto err;
> +	}

devm_regmap_init_i2c(), saves a small amount of error handling/cleanup
code.

> +
> +static int __init cs42l52_modinit(void)
> +{
> +	int ret;
> +	ret = i2c_add_driver(&cs42l52_i2c_driver);

module_i2c_driver().

--8GpibOaaTibBMecb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPjVBwAAoJEBus8iNuMP3d97oP/01ZeXD2SC6f1Wlr84kFTTAj
sK1SALH/F0kJqy7WYDUGY0oXz+609fGZcJATPV4rNofBN9nqHlMFtfOqumpHzv55
2b+aWxfrf26bF85UyNDDMmkhSezrYNB2iFnsRQs9qCMWY72ndb/FThmJa+PgHZjW
hf8AUQn9BHUzPWtnXPbsmL0F39RCldJRy3AXDNvbOWvaL22sqcB/9xy7vwHUyNX9
WuseZtXq2f1cCDqZGn2cvDs48KMFC8kDhwsG21omDs6WVc9AqW1gU6PAwIovifop
Hmh8VpiMUDD9vy5T2fQw557vSKVyvtB8LtGixsgaTkX58gTqrEQ8EYGJW9JNOWKt
G8ri4XsMoJ1v1i5E7UQWsidguoCMLM6qJIwgMF7pOpW+/pbL3Cffnl3lzRtgUtLo
EsDG9QkUbLSI4aFon9awYXIuBWrFltLeVJ4SB2JKSNbJ8iqXVy547UhwsPq2Kt03
QFcdlsqVttSaABNDcCDs5f+LgvdqeaScSRwNNwlCxbBn/En05m5QhJGb88bsUmfi
9PIXhX8WyNW5NTxYqA5/4fyRexmHqBRvkWMN/0+ZFZd607iCtrfXCRwUvD47qzGL
wJ79oNPsUsVJL94ULIs47rxQ3vVw7YLBYNZlqZ12WNk1L61R9aL1Ffaq7O11XBU4
sahoN6E6Ain7wA41AbOf
=w7P7
-----END PGP SIGNATURE-----

--8GpibOaaTibBMecb--

--===============5661453391292812875==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5661453391292812875==--
