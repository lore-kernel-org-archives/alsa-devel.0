From: "Jie, Yang" <yang.jie@intel.com>
Subject: Re: [PATCH v3] ASoC: rt286: add jack detection
 enable/disable APIs and export
Date: Fri, 6 Feb 2015 10:23:44 +0000
Message-ID: <E7B1D079BA13FB44A978CC8F69C7D6A901BB4C45@SHSMSX101.ccr.corp.intel.com>
References: <1423204800-6448-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id AD396260584
 for <alsa-devel@alsa-project.org>; Fri,  6 Feb 2015 11:23:54 +0100 (CET)
In-Reply-To: <1423204800-6448-1-git-send-email-yang.jie@intel.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "broonie@kernel.org" <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org


Hi, Mark,

Please hold on and not review this patch ATM, seems it can't disable the irq with this implement. 
Sorry for the confusing.

~Keyon


> -----Original Message-----
> From: Jie, Yang
> Sent: Friday, February 06, 2015 2:40 PM
> To: broonie@kernel.org
> Cc: alsa-devel@alsa-project.org; Girdwood, Liam R; Jie, Yang
> Subject: [PATCH v3] ASoC: rt286: add jack detection enable/disable APIs and
> export
> 
> Some platforms, e.g. WSB, don't need jack detection when system is in Suspend,
> for power save reason.
> 
> Here add jack detection enable/disable APIs and export them, when disabled, it
> will ignore interrupt, and disable LDO1, which is used for jack detection when
> headphone is plugged in.
> 
> Signed-off-by: Jie Yang <yang.jie@intel.com>
> Reviewed-by: Bard Liao <bardliao@realtek.com>
> ---
>  sound/soc/codecs/rt286.c | 29 +++++++++++++++++++++++++++++
> sound/soc/codecs/rt286.h |  2 ++
>  2 files changed, 31 insertions(+)
> 
> diff --git a/sound/soc/codecs/rt286.c b/sound/soc/codecs/rt286.c index
> d5cc1bc..1a0c250f 100644
> --- a/sound/soc/codecs/rt286.c
> +++ b/sound/soc/codecs/rt286.c
> @@ -402,6 +402,33 @@ int rt286_mic_detect(struct snd_soc_codec *codec,
> struct snd_soc_jack *jack)  }  EXPORT_SYMBOL_GPL(rt286_mic_detect);
> 
> +int rt286_enable_jack_detection(struct snd_soc_codec *codec, struct
> +snd_soc_jack *jack) {
> +	struct rt286_priv *rt286 = snd_soc_codec_get_drvdata(codec);
> +
> +	if (!jack)
> +		return -EINVAL;
> +	rt286->jack = jack;
> +	if (jack->status | SND_JACK_HEADPHONE)
> +		snd_soc_dapm_force_enable_pin(&rt286->codec->dapm, "LDO1");
> +	snd_soc_dapm_sync(&rt286->codec->dapm);
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(rt286_enable_jack_detection);
> +
> +int rt286_disable_jack_detection(struct snd_soc_codec *codec, struct
> +snd_soc_jack *jack) {
> +	struct rt286_priv *rt286 = snd_soc_codec_get_drvdata(codec);
> +
> +	if (!jack)
> +		return -EINVAL;
> +	rt286->jack = NULL;
> +	snd_soc_dapm_disable_pin(&rt286->codec->dapm, "LDO1");
> +	snd_soc_dapm_sync(&rt286->codec->dapm);
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(rt286_disable_jack_detection);
> +
>  static int is_mclk_mode(struct snd_soc_dapm_widget *source,
>  			 struct snd_soc_dapm_widget *sink)
>  {
> @@ -1012,6 +1039,8 @@ static irqreturn_t rt286_irq(int irq, void *data)
>  	bool mic = false;
>  	int status = 0;
> 
> +	if (!rt286->jack)
> +		return IRQ_HANDLED;
>  	rt286_jack_detect(rt286, &hp, &mic);
> 
>  	/* Clear IRQ */
> diff --git a/sound/soc/codecs/rt286.h b/sound/soc/codecs/rt286.h index
> 7130edb..d793185 100644
> --- a/sound/soc/codecs/rt286.h
> +++ b/sound/soc/codecs/rt286.h
> @@ -200,6 +200,8 @@ enum {
>  };
> 
>  int rt286_mic_detect(struct snd_soc_codec *codec, struct snd_soc_jack
> *jack);
> +int rt286_enable_jack_detection(struct snd_soc_codec *codec, struct
> +snd_soc_jack *jack); int rt286_disable_jack_detection(struct
> +snd_soc_codec *codec, struct snd_soc_jack *jack);
> 
>  #endif /* __RT286_H__ */
> 
> --
> 1.9.1
