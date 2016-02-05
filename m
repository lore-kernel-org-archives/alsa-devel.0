From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [RFC v2 3/6] ASoC: core: add code to complete dai
 init after pcm creation
Date: Fri, 5 Feb 2016 11:58:19 +0200
Message-ID: <56B4723B.4000505@ti.com>
References: <1453484912-24547-1-git-send-email-arnaud.pouliquen@st.com>
 <1453484912-24547-4-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id EB2D62605D2
 for <alsa-devel@alsa-project.org>; Fri,  5 Feb 2016 10:58:26 +0100 (CET)
In-Reply-To: <1453484912-24547-4-git-send-email-arnaud.pouliquen@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>, alsa-devel@alsa-project.org
Cc: Jean-Francois Moine <moinejf@free.fr>, Lars-Peter Clausen <lars@metafoo.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@linux.ie>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>, Benjamin Gaignard <benjamin.gaignard@linaro.org>
List-Id: alsa-devel@alsa-project.org

On 01/22/16 19:48, Arnaud Pouliquen wrote:
> Some Controls defined in DAI need to be associated to PCM device (e.g. IEC60958).
>
> This allows to perform post initialization in DAI after PCM device creation.
>

Sorry for my late reaction to this series (I was on vacation)...

I do not follow why you need this? The rest of the codecs create their 
mixer elements in static struct snd_soc_codec_driver's probe-callback. I 
can not see why it could not be used with hdmi-codec (then again I have 
not tried it).

I'll try to test the patches that affects my Beaglebone-black hdmia 
audio series anyway, I just need to rebase my branch in order to apply 
this patch. For some reason "ASoc: hdmi-codec: add IEC control." did not 
apply out of the box either...

Best regards,
Jyri

> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> ---
>   include/sound/soc-dai.h |  7 +++++++
>   sound/soc/soc-core.c    | 14 ++++++++++++++
>   2 files changed, 21 insertions(+)
>
> diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
> index 964b7de..6969c83 100644
> --- a/include/sound/soc-dai.h
> +++ b/include/sound/soc-dai.h
> @@ -205,6 +205,13 @@ struct snd_soc_dai_ops {
>   	 */
>   	snd_pcm_sframes_t (*delay)(struct snd_pcm_substream *,
>   		struct snd_soc_dai *);
> +
> +	/*
> +	 * function called by soc_probe_link_dais to post initialize DAI
> +	 * after pcm device creation.
> +	 * As example, can be used to link a controls to the pcm device
> +	 */
> +	int (*pcm_new)(struct snd_soc_pcm_runtime *, struct snd_soc_dai *);
>   };
>
>   /*
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index 790ee2b..cf1d312 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -1587,6 +1587,7 @@ static int soc_probe_link_dais(struct snd_soc_card *card,
>   {
>   	struct snd_soc_dai_link *dai_link = rtd->dai_link;
>   	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
> +	const struct snd_soc_dai_ops *ops;
>   	int i, ret;
>
>   	dev_dbg(card->dev, "ASoC: probe %s dai link %d late %d\n",
> @@ -1662,6 +1663,19 @@ static int soc_probe_link_dais(struct snd_soc_card *card,
>   		}
>   	}
>
> +	for (i = 0; i < rtd->num_codecs; i++) {
> +		ops = rtd->codec_dais[i]->driver->ops;
> +		if (ops->pcm_new)
> +			ret = ops->pcm_new(rtd, rtd->codec_dais[i]);
> +		if (ret)
> +			return ret;
> +	}
> +	ops = cpu_dai->driver->ops;
> +	if (ops->pcm_new)
> +		ret = ops->pcm_new(rtd, rtd->codec_dais[i]);
> +	if (ret)
> +		return ret;
> +
>   	return 0;
>   }
>
>
