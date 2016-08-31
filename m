From: Danny Milosavljevic <dannym-bxPqe3T81XXwRsdMLXbzog@public.gmane.org>
Subject: Re: Re: [PATCH v9 2/2] Add mixer controls: Line-In,
 FM-In, Mic 2, Capture Source, Differential Line-In.
Date: Wed, 31 Aug 2016 09:40:44 +0200
Message-ID: <20160831094044.1c3227d6@scratchpost.org>
References: <20160830054403.7878-1-dannym@scratchpost.org>
	<20160830054403.7878-3-dannym@scratchpost.org>
	<CAGb2v64zA3iSOe7ku=pF0RhJkvErxt_tbPWG4H8D6r5UEUJAMQ@mail.gmail.com>
Reply-To: dannym-bxPqe3T81XXwRsdMLXbzog@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCPKHTHNWIPBB74TTK7AKGQEDQ3INQI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <CAGb2v64zA3iSOe7ku=pF0RhJkvErxt_tbPWG4H8D6r5UEUJAMQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

> And what about microphone bias?

Would this be OK?

static int sun4i_codec_handle_mic_bias_event(struct snd_soc_dapm_widget *w,
                                             struct snd_kcontrol *k, int event)
{
        struct sun4i_codec *scodec = snd_soc_card_get_drvdata(w->dapm->card);
        if (SND_SOC_DAPM_EVENT_ON(event))
                regmap_update_bits(scodec->regmap,
                                   SUN4I_CODEC_ADC_ACTL,
                                   BIT(SUN4I_CODEC_ADC_ACTL_VMICEN),
                                   BIT(SUN4I_CODEC_ADC_ACTL_VMICEN));
        else
                regmap_update_bits(scodec->regmap,
                                   SUN4I_CODEC_ADC_ACTL,
                                   BIT(SUN4I_CODEC_ADC_ACTL_VMICEN),
                                   0);
}

static const struct snd_soc_dapm_widget sun4i_codec_codec_dapm_widgets[] = {
...
        SND_SOC_DAPM_MIC("Mic1", sun4i_codec_handle_mic_bias_event),
        SND_SOC_DAPM_MIC("Mic2", sun4i_codec_handle_mic_bias_event),

Do I then remove

         SND_SOC_DAPM_SUPPLY("VMIC", SUN4I_CODEC_ADC_ACTL,
                            SUN4I_CODEC_ADC_ACTL_VMICEN, 0, NULL, 0),

completely? What about the routes?
