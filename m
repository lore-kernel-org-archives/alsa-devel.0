From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH RFC 1/1] ASoC: TI WL1273 FM Radio Codec.
Date: Tue, 20 Jul 2010 13:50:16 +0100
Message-ID: <20100720125014.GH7002@sirena.org.uk>
References: <1279629718-14903-1-git-send-email-matti.j.aaltonen@nokia.com>
	<1279629718-14903-2-git-send-email-matti.j.aaltonen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 8AC5F103913
	for <alsa-devel@alsa-project.org>;
	Tue, 20 Jul 2010 14:50:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1279629718-14903-2-git-send-email-matti.j.aaltonen@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Matti J. Aaltonen" <matti.j.aaltonen@nokia.com>
Cc: hverkuil@xs4all.nl, alsa-devel@alsa-project.org, peter.ujfalusi@nokia.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 20, 2010 at 03:41:58PM +0300, Matti J. Aaltonen wrote:

> +#undef DEBUG

This shouldn't be here.

> +static int snd_wl1273_set_audio_route(struct snd_kcontrol *kcontrol,
> +				      struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
> +	struct wl1273_priv *wl1273 = snd_soc_codec_get_drvdata(codec);
> +
> +	/* Do not allow changes while stream is running */
> +	if (codec->active)
> +		return -EPERM;
> +
> +	wl1273->mode = ucontrol->value.integer.value[0];

You're not doing any validation of the supplied value here.

> +static const struct soc_enum wl1273_enum[] = {
> +	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(wl1273_audio_route), wl1273_audio_route),
> +};

Don't put your enums in arrays, it just makes things harder to maintain
since you have to reference an index into an array rather than a named
value.

> +static int snd_wl1273_fm_audio_put(struct snd_kcontrol *kcontrol,

> +static const struct snd_kcontrol_new wl1273_controls[] = {
> +	SOC_ENUM_EXT("Codec Mode", wl1273_enum[0],
> +		     snd_wl1273_get_audio_route, snd_wl1273_set_audio_route),
> +	SOC_ENUM_EXT("Audio Switch", wl1273_audio_enum[0],
> +		     snd_wl1273_fm_audio_get,  snd_wl1273_fm_audio_put),
> +	SOC_SINGLE_EXT("Volume", 0, 0, WL1273_MAX_VOLUME, 0,
> +		       snd_wl1273_fm_volume_get, snd_wl1273_fm_volume_put),
> +};

My major comment about this driver is that it'd probably make sense to
redo it on top of Liam's multi-component branch, though it shouldn't be
a pressing concern for merge.

> +	switch (wl1273->mode) {
> +	case WL1273_MODE_BT:
> +		pcm->info_flags &= ~SNDRV_PCM_INFO_HALF_DUPLEX;
> +		break;

Wouldn't it be nicer to do this stuff with the ALSA constraint APIs
rather than futzing with the constant data?

> +static int wl1273_set_dai_fmt(struct snd_soc_dai *codec_dai,
> +			      unsigned int fmt)
> +{
> +	return 0;
> +}

Remove unused functions.

> +enum wl1273_mode wl1273_get_codec_mode(struct snd_soc_codec *codec)
> +{
> +	struct wl1273_priv *wl1273 = snd_soc_codec_get_drvdata(codec);
> +	return wl1273->mode;
> +}
> +EXPORT_SYMBOL_GPL(wl1273_get_codec_mode);

Why is this being exported?

> +static int wl1273_soc_suspend(struct platform_device *pdev, pm_message_t state)
> +{
> +	return 0;
> +}
> +
> +static int wl1273_soc_resume(struct platform_device *pdev)
> +{
> +	return 0;
> +}

Remove unused functions.
