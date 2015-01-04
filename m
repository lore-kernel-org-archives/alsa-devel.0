From: Bo Shen <voice.shen@atmel.com>
Subject: Re: [PATCH 01/21] ASoC: sam9g20_wm8731: Use static DAI
	format setup
Date: Sun, 4 Jan 2015 09:11:01 +0800
Message-ID: <54A89325.9030708@atmel.com>
References: <1420128990-6872-1-git-send-email-lars@metafoo.de>
 <1420128990-6872-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eusmtp01.atmel.com (eusmtp01.atmel.com [212.144.249.243])
 by alsa0.perex.cz (Postfix) with ESMTP id C736826058D
 for <alsa-devel@alsa-project.org>; Sun,  4 Jan 2015 02:11:07 +0100 (CET)
In-Reply-To: <1420128990-6872-2-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Sangbeom Kim <sbkim73@samsung.com>, Denis Carikli <denis@eukrea.com>, Manuel Lauss <manuel.lauss@googlemail.com>, Shawn Guo <shawn.guo@linaro.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org

Hi Lars-Peter Clausen,

On 01/02/2015 12:16 AM, Lars-Peter Clausen wrote:
> Set the dai_fmt field in the dai_link struct instead of manually calling
> snd_soc_dai_fmt(). This makes the code cleaner and shorter.
>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

Thanks.
Acked-by: Bo Shen <voice.shen@atmel.com>

> ---
>   sound/soc/atmel/sam9g20_wm8731.c | 30 ++----------------------------
>   1 file changed, 2 insertions(+), 28 deletions(-)
>
> diff --git a/sound/soc/atmel/sam9g20_wm8731.c b/sound/soc/atmel/sam9g20_wm8731.c
> index 66b66d0..98ca634 100644
> --- a/sound/soc/atmel/sam9g20_wm8731.c
> +++ b/sound/soc/atmel/sam9g20_wm8731.c
> @@ -64,33 +64,6 @@
>
>   static struct clk *mclk;
>
> -static int at91sam9g20ek_hw_params(struct snd_pcm_substream *substream,
> -	struct snd_pcm_hw_params *params)
> -{
> -	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> -	struct snd_soc_dai *codec_dai = rtd->codec_dai;
> -	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
> -	int ret;
> -
> -	/* set codec DAI configuration */
> -	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
> -		SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBM_CFM);
> -	if (ret < 0)
> -		return ret;
> -
> -	/* set cpu DAI configuration */
> -	ret = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S |
> -		SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBM_CFM);
> -	if (ret < 0)
> -		return ret;
> -
> -	return 0;
> -}
> -
> -static struct snd_soc_ops at91sam9g20ek_ops = {
> -	.hw_params = at91sam9g20ek_hw_params,
> -};
> -
>   static int at91sam9g20ek_set_bias_level(struct snd_soc_card *card,
>   					struct snd_soc_dapm_context *dapm,
>   					enum snd_soc_bias_level level)
> @@ -173,7 +146,8 @@ static struct snd_soc_dai_link at91sam9g20ek_dai = {
>   	.init = at91sam9g20ek_wm8731_init,
>   	.platform_name = "at91rm9200_ssc.0",
>   	.codec_name = "wm8731.0-001b",
> -	.ops = &at91sam9g20ek_ops,
> +	.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
> +		   SND_SOC_DAIFMT_CBM_CFM,
>   };
>
>   static struct snd_soc_card snd_soc_at91sam9g20ek = {
>

Best Regards,
Bo Shen
