From: Olivier MOYSAN <olivier.moysan@st.com>
Subject: Re: [PATCH] ASoC: stm32: simplify dai driver initialisation
Date: Tue, 23 Apr 2019 13:29:37 +0000
Message-ID: <9cb0aea8-81d3-3122-da55-2ee0c90809e8@st.com>
References: <1554456387-3088-1-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1554456387-3088-1-git-send-email-arnaud.pouliquen@st.com>
Content-Language: en-US
Content-ID: <7BA1FD71D75DC14A8BA5064AFB8FBA14@st.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnaud POULIQUEN <arnaud.pouliquen@st.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: "linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hello Arnaud,

On 4/5/19 11:26 AM, Arnaud Pouliquen wrote:
> Suppress the useless dynamic allocation of the dai driver structure.
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> ---
>   sound/soc/stm/stm32_sai_sub.c | 43 +++++++++----------------------------------
>   1 file changed, 9 insertions(+), 34 deletions(-)
> 
> diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
> index 3dd54bc..e3b021c 100644
> --- a/sound/soc/stm/stm32_sai_sub.c
> +++ b/sound/soc/stm/stm32_sai_sub.c
> @@ -109,7 +109,7 @@ struct stm32_sai_sub_data {
>   	struct regmap *regmap;
>   	const struct regmap_config *regmap_config;
>   	struct snd_dmaengine_dai_dma_data dma_params;
> -	struct snd_soc_dai_driver *cpu_dai_drv;
> +	struct snd_soc_dai_driver cpu_dai_drv;
>   	struct snd_soc_dai *cpu_dai;
>   	struct snd_pcm_substream *substream;
>   	struct stm32_sai_data *pdata;
> @@ -1204,8 +1204,7 @@ static const struct snd_pcm_hardware stm32_sai_pcm_hw = {
>   	.periods_max = 8,
>   };
>   
> -static struct snd_soc_dai_driver stm32_sai_playback_dai[] = {
> -{
> +static struct snd_soc_dai_driver stm32_sai_playback_dai = {
>   		.probe = stm32_sai_dai_probe,
>   		.pcm_new = stm32_sai_pcm_new,
>   		.id = 1, /* avoid call to fmt_single_name() */
> @@ -1222,11 +1221,9 @@ static struct snd_soc_dai_driver stm32_sai_playback_dai[] = {
>   				SNDRV_PCM_FMTBIT_S32_LE,
>   		},
>   		.ops = &stm32_sai_pcm_dai_ops,
> -	}
>   };
>   
> -static struct snd_soc_dai_driver stm32_sai_capture_dai[] = {
> -{
> +static struct snd_soc_dai_driver stm32_sai_capture_dai = {
>   		.probe = stm32_sai_dai_probe,
>   		.id = 1, /* avoid call to fmt_single_name() */
>   		.capture = {
> @@ -1242,7 +1239,6 @@ static struct snd_soc_dai_driver stm32_sai_capture_dai[] = {
>   				SNDRV_PCM_FMTBIT_S32_LE,
>   		},
>   		.ops = &stm32_sai_pcm_dai_ops,
> -	}
>   };
>   
>   static const struct snd_dmaengine_pcm_config stm32_sai_pcm_config = {
> @@ -1411,29 +1407,6 @@ static int stm32_sai_sub_parse_of(struct platform_device *pdev,
>   	return 0;
>   }
>   
> -static int stm32_sai_sub_dais_init(struct platform_device *pdev,
> -				   struct stm32_sai_sub_data *sai)
> -{
> -	sai->cpu_dai_drv = devm_kzalloc(&pdev->dev,
> -					sizeof(struct snd_soc_dai_driver),
> -					GFP_KERNEL);
> -	if (!sai->cpu_dai_drv)
> -		return -ENOMEM;
> -
> -	if (STM_SAI_IS_PLAYBACK(sai)) {
> -		memcpy(sai->cpu_dai_drv, &stm32_sai_playback_dai,
> -		       sizeof(stm32_sai_playback_dai));
> -		sai->cpu_dai_drv->playback.stream_name = sai->cpu_dai_drv->name;
> -	} else {
> -		memcpy(sai->cpu_dai_drv, &stm32_sai_capture_dai,
> -		       sizeof(stm32_sai_capture_dai));
> -		sai->cpu_dai_drv->capture.stream_name = sai->cpu_dai_drv->name;
> -	}
> -	sai->cpu_dai_drv->name = dev_name(&pdev->dev);
> -
> -	return 0;
> -}
> -
>   static int stm32_sai_sub_probe(struct platform_device *pdev)
>   {
>   	struct stm32_sai_sub_data *sai;
> @@ -1465,9 +1438,11 @@ static int stm32_sai_sub_probe(struct platform_device *pdev)
>   	if (ret)
>   		return ret;
>   
> -	ret = stm32_sai_sub_dais_init(pdev, sai);
> -	if (ret)
> -		return ret;
> +	if (STM_SAI_IS_PLAYBACK(sai))
> +		sai->cpu_dai_drv = stm32_sai_playback_dai;
> +	else
> +		sai->cpu_dai_drv = stm32_sai_capture_dai;
> +	sai->cpu_dai_drv.name = dev_name(&pdev->dev);
>   
>   	ret = devm_request_irq(&pdev->dev, sai->pdata->irq, stm32_sai_isr,
>   			       IRQF_SHARED, dev_name(&pdev->dev), sai);
> @@ -1477,7 +1452,7 @@ static int stm32_sai_sub_probe(struct platform_device *pdev)
>   	}
>   
>   	ret = devm_snd_soc_register_component(&pdev->dev, &stm32_component,
> -					      sai->cpu_dai_drv, 1);
> +					      &sai->cpu_dai_drv, 1);
>   	if (ret)
>   		return ret;
>   
> 

Just one comment. sai is missing in commit message.

Reviewed-by: Olivier Moysan <olivier.moysan@st.com>

BRs
olivier
