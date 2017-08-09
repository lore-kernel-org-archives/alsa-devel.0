From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] ASoC: cs43130: Add support for CS43130 codec
Date: Wed, 9 Aug 2017 17:11:01 +0100
Message-ID: <20170809161101.iab74ibtcjat4q3v@sirena.org.uk>
References: <f5ea5455-b359-4f55-bf73-ee69a7c5d54d@EX3.ad.cirrus.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qc23qm7agzcyzfc4"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <f5ea5455-b359-4f55-bf73-ee69a7c5d54d-XU/xxMRwCJnfk+Ne4bZl5AC/G2K4zDHf@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Li Xu <li.xu-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org, Paul.Handrigan-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--qc23qm7agzcyzfc4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 09, 2017 at 10:00:21AM -0500, Li Xu wrote:

> +	if (cs43130->dev_id == CS43131_CHIP_ID ||
> +	    cs43130->dev_id == CS43198_CHIP_ID) {
> +		if (val >= 2)

Throughout the driver you're doing lots of ID checks like this with if
statements, these are better written with switch statements so it's
easier to add new cases in (eg, if a new chip variant gets made) and so
that it's clear that the default case is being handled properly.

> +static const char * const enum_texts[] = {
> +	"Off",
> +	"On",
> +};
> +
> +static SOC_ENUM_SINGLE_DECL(pcm_phs_enum, CS43130_PCM_FILT_OPT, 6, enum_texts);
> +
> +static SOC_ENUM_SINGLE_DECL(pcm_nos_enum, CS43130_PCM_FILT_OPT, 5, enum_texts);
> +
> +static SOC_ENUM_SINGLE_DECL(pcm_high_enum, CS43130_PCM_FILT_OPT, 1, enum_texts);
> +
> +static SOC_ENUM_SINGLE_DECL(pcm_dmp_enum, CS43130_PCM_FILT_OPT, 0, enum_texts);

These look like simple on/off switches, why are they enums?

> +static int cs43130_pcm_mute(struct snd_soc_dai *dai, int mute)
> +{
> +	struct snd_soc_codec *codec = dai->codec;
> +	struct cs43130_private *cs43130 = snd_soc_codec_get_drvdata(codec);
> +
> +	if (mute) {
> +		if (cs43130->dev_id == CS43130_CHIP_ID ||
> +		    cs43130->dev_id == CS4399_CHIP_ID) {
> +			regmap_multi_reg_write(cs43130->regmap, mute_seq,
> +					       ARRAY_SIZE(mute_seq));
> +			regmap_update_bits(cs43130->regmap,
> +					   CS43130_PCM_PATH_CTL_1,
> +					   CS43130_MUTE_MASK, CS43130_MUTE_EN);
> +			/*
> +			 * PCM Power Down Sequence
> +			 * According to Design, 130ms is preferred.
> +			 */
> +			msleep(130);

Powering down doesn't sound like muting, shouldn't this be DAPM stuff
(especially with the very long 130ms delay)?  What is this actually
doing at the chip level, the register names do sound like muting might
be part of it but it looks like there's more?

> +static char *hpload_msgs[] = {
> +	"HPLOAD_DC_L:%u\n",
> +	"HPLOAD_DC_R:%u\n",
> +};
> +
> +static char *hpload_ac_msgs[] = {
> +	"HPLOAD_AC_L:%u:%u\n",
> +	"HPLOAD_AC_R:%u:%u\n",
> +};

> +	if (cs43130->ac_meas) {
> +		for (k = 0; k < CS43130_AC_FREQ; k++) {
> +			for (j = 0; j < ARRAY_SIZE(hpload_ac_msgs); j++) {

The loops are wrapping their iterators in the order i, k, j not i, j, k.

> +				ret = scnprintf(buf + i, PAGE_SIZE - i,
> +						hpload_ac_msgs[j],
> +						cs43130->ac_freq[k],
> +						cs43130->hpload_ac[k][j]);

We're not using ARRAY_SIZE() for the k iteration, this whole thing feels
risky.  In any case...

> +static DEVICE_ATTR(hpload, S_IRUGO, cs43130_show_hpload, NULL);

...you're adding device attributes that aren't just single values (which
is a requirement for all sysfs files).  It'd be a lot simpler and
compliant with the sysfs ABI to just make four appropriately named files
with the individual values in them if they exist.

> +	cs43130->idle_bias_off = of_property_read_bool(np,
> +						       "cirrus,idle-bias-off");

This should not be in the DT - either the device can reasonably power
down when idle or it can't but that's not machine specific configuration
and is a Linux specific implementation detail anyway.

> +static const struct i2c_device_id cs43130_i2c_id[] = {
> +	{"cs43130", 0},
> +	{}
> +};

Since the driver supports multiple parts I'd expect to see all the parts
individually recognized as I2C IDs, and similarly for DT compatible
strings.  This makes it easier for people to do system integration and
means that if it turns out we need the data it's there.

--qc23qm7agzcyzfc4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmLNBQACgkQJNaLcl1U
h9DDIQf/evHwOiYpGGWqhm5Cy9AGtZ1hsJNPUkETmac8fLzbqMp8wm4RL1B/T3j2
sYa1DHfzBZE/9+tPvSA8fXSEN27dlk1n2EOyFy8zAnEgIM+aLovfi/A2peg4Oii4
2MLCCRXwWwGFO1X8QQrhLeUA9Tb3yGVRavN2SLWstzGB+RX9W7poa1s9MOdJCKdc
8Sz9Fr4hddQQXR0tpfaSM2xjnbxVMsaFh9LsYUUEcjJvP9jvym4te+J/9iqzRCE9
LAp/oQmC5iOsPUcOTeKtbnhLZUMAmaroEwpuX6OXVV/bpxUh0FYBb/nzhctBiRXe
ejy0B6DL4lRevxo4ct4qDmA8n205Ag==
=tbKh
-----END PGP SIGNATURE-----

--qc23qm7agzcyzfc4--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
