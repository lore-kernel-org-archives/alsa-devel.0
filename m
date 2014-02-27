From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4-resend 1/7] ASoC: sirf: Add SiRF
 internal audio codec driver
Date: Thu, 27 Feb 2014 14:33:39 +0900
Message-ID: <20140227053339.GU9383@sirena.org.uk>
References: <1393399342-31177-1-git-send-email-rongjun.ying@csr.com>
 <1393399342-31177-2-git-send-email-rongjun.ying@csr.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6272753849768629997=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id F1CAD2657DF
 for <alsa-devel@alsa-project.org>; Thu, 27 Feb 2014 08:46:57 +0100 (CET)
In-Reply-To: <1393399342-31177-2-git-send-email-rongjun.ying@csr.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: RongJun Ying <rjying@gmail.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, workgroup.linux@csr.com, Rongjun Ying <rongjun.ying@csr.com>
List-Id: alsa-devel@alsa-project.org


--===============6272753849768629997==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z+AhoeLdLI498vdY"
Content-Disposition: inline


--z+AhoeLdLI498vdY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 26, 2014 at 03:22:16PM +0800, RongJun Ying wrote:

Overall looks fairly good, a few issues below but they're quite small.

> +static struct sirf_audio_codec_reg_bits sirf_audio_codec_reg_bits_prima2 = {
> +	.dig_mic_en_bits = 20,
> +	.dig_mic_freq_bits = 21,
> +	.adc14b_12_bits = 22,
> +	.firdac_hsl_en_bits = 23,
> +	.firdac_hsr_en_bits = 24,
> +	.firdac_lout_en_bits = 25,
> +	.por_bits = 26,
> +	.codec_clk_en_bits = 27,
> +};

This looks like the sort of thing that the regmap_field layer was
supposed to hide?

> +static int adc_event(struct snd_soc_dapm_widget *w,
> +		struct snd_kcontrol *kcontrol, int event)
> +{
> +	struct snd_soc_codec *codec = w->codec;
> +	struct sirf_audio_codec *sirf_audio_codec = dev_get_drvdata(codec->dev);
> +	u32 val;
> +
> +	val = sirfsoc_rtc_iobrg_readl(sirf_audio_codec->sys_pwrc_reg_base +
> +			PWRC_PDN_CTRL_OFFSET);
> +	switch (event) {
> +	case SND_SOC_DAPM_POST_PMU:
> +		/* Enable capture power of codec*/
> +		val |= (1 << AUDIO_POWER_EN_BIT);
> +		break;

Looking at this code (and many of the other controls) I can't help but
feel that there's some room for more abstraction here.  The controls are
all setting two bits rather than just one but for example...

> +	case SND_SOC_DAPM_PRE_PMU:
> +		val = (1 << sirf_audio_codec->reg_bits->firdac_hsl_en_bits);
> +		break;

...this looks like a supply widget could be used to manage the bits
controlled by the pre and post PMU events?  The same is true for most of
the events.

> +	dn = of_find_compatible_node(dn, NULL, "sirf,prima2-pwrc");
> +	if (!dn) {
> +		dev_err(&pdev->dev, "Failed to get sirf,prima2-pwrc  node!\n");
> +		return -ENODEV;
> +	}
> +
> +	ret = of_property_read_u32(dn, "reg", &sirf_audio_codec->sys_pwrc_reg_base);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "Failed tp get pwrc register base address\n");
> +		return -EINVAL;
> +	}

Should prima2-pwrc be a syscon?  Not a blocker for merging this.

> +#ifdef CONFIG_PM_RUNTIME
> +static int sirf_audio_codec_runtime_suspend(struct device *dev)
> +{
> +	struct sirf_audio_codec *sirf_audio_codec = dev_get_drvdata(dev);
> +	regmap_update_bits(sirf_audio_codec->regmap, AUDIO_IC_CODEC_CTRL1,
> +		(1 << sirf_audio_codec->reg_bits->codec_clk_en_bits),
> +		0);
> +	return 0;
> +}

Can you disable the clock in the clock API as well?  This might allow
further supply clocks to be disabled and is genarally good practice.

> +static int sirf_audio_codec_suspend(struct device *dev)
> +{
> +	struct sirf_audio_codec *sirf_audio_codec = dev_get_drvdata(dev);
> +
> +	regmap_read(sirf_audio_codec->regmap, AUDIO_IC_CODEC_CTRL0,
> +		&sirf_audio_codec->reg_ctrl0);
> +	regmap_read(sirf_audio_codec->regmap, AUDIO_IC_CODEC_CTRL1,
> +		&sirf_audio_codec->reg_ctrl1);
> +	sirf_audio_codec_runtime_suspend(dev);

Have you seen the series Ulf has been posting regarding the integration
of runtime PM and system suspend?  There's all sorts of nasty cases with
this stuff unfortunately.  Not sure it should be a blocker for merging
though since we haven't really figured out how this stuff is supposed to
work.

--z+AhoeLdLI498vdY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTDs4qAAoJELSic+t+oim9Y/MP/1YbgXZpV/MGzp/Go7JzIq3p
Zi5ijfySnofosmwDDlquA9Ic8laa67V2xqgKPIzy6Pi0Dyp73a4Np60WBjpqlgH5
+Dr3i3LDWmAoVlKGtguzW61wErfCvOxcKG09eaTe3hErSQ22Suutlgx7aevPJawX
JEku/hJMCeQ+Jd6AAvozmpOOzcV9eeRcY8IvhItYSUM5bPNnnkRfAtpwPgmC5mSr
9e1AwLSnkMIuhHdFQxvBq0hA5F1MFmu1VheTycrRHEFYgE0Ss38Q9HFyUjHjt93U
jOTVGNyTxD70OdmqYHAAjlo8YrU3v3NZC+SR38ZiOVp052fvANCVff1MGkx+gWoK
me69CdKTlInWg00cmGIoDCwTEiEhSu/lQQbxpd0EJ/XGct4H+s81HrXyhTNiXVQ/
wxTY20wvEvZaEFm7w/xsn891ZSqCs35ahJGpXC+YSdSzhG4X+cX+PpQE0BfvKQOz
jjpoLonQw8DpaVQK/kX08j7vSg4gIjm/V1lAwEU89pHbdEbvjrTv9JsvueH886+u
tN9+8u69eDYhAj2sy8NOOpp+afgmbetfFSWfJ92aTqm/vOlSDDYdQj6kdB3/W2vV
e/4k7iOCReJ4moEI5AYxMu+MYfwt2ohsiDCiOUP0tS4GpPX20wiPuhpp5BWP4c8q
hiGWnybAjKsVP/pOI3NR
=oQdJ
-----END PGP SIGNATURE-----

--z+AhoeLdLI498vdY--

--===============6272753849768629997==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6272753849768629997==--
