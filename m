From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH 4/5] ASoC: sam9x5_wm8731: Fix OF node
	reference counting
Date: Mon, 15 Jan 2018 09:46:07 +0100
Message-ID: <20180115084607.GR2678@piout.net>
References: <20180115075213.GA10762@lenoch>
 <20180115075430.GE10762@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.free-electrons.com (mail.free-electrons.com [62.4.15.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 8D8A5266FBD
 for <alsa-devel@alsa-project.org>; Mon, 15 Jan 2018 09:46:18 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20180115075430.GE10762@lenoch>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ladislav Michl <ladis@linux-mips.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, SF Markus Elfring <elfring@users.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On 15/01/2018 at 08:54:30 +0100, Ladislav Michl wrote:
> of_node_release() is called as the destructor on a dynamically
> allocated node in of_node_put(), but node pointer is still in use.
> Fix that by moving of_node_put() into the error path.
> 
> Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
> ---
>  sound/soc/atmel/sam9x5_wm8731.c | 27 ++++++++++++---------------
>  1 file changed, 12 insertions(+), 15 deletions(-)
> 
> diff --git a/sound/soc/atmel/sam9x5_wm8731.c b/sound/soc/atmel/sam9x5_wm8731.c
> index 9db08826b32a..bcfb474ee0e8 100644
> --- a/sound/soc/atmel/sam9x5_wm8731.c
> +++ b/sound/soc/atmel/sam9x5_wm8731.c
> @@ -78,7 +78,6 @@ static const struct snd_soc_dapm_widget sam9x5_dapm_widgets[] = {
>  static int sam9x5_wm8731_driver_probe(struct platform_device *pdev)
>  {
>  	struct device_node *np = pdev->dev.of_node;
> -	struct device_node *codec_np, *cpu_np;
>  	struct snd_soc_card *card;
>  	struct snd_soc_dai_link *dai;
>  	struct sam9x5_drvdata *priv;
> @@ -122,36 +121,30 @@ static int sam9x5_wm8731_driver_probe(struct platform_device *pdev)
>  		goto out;
>  	}
>  
> -	codec_np = of_parse_phandle(np, "atmel,audio-codec", 0);
> -	if (!codec_np) {
> +	dai->codec_of_node = of_parse_phandle(np, "atmel,audio-codec", 0);
> +	if (!dai->codec_of_node) {
>  		dev_err(&pdev->dev, "atmel,audio-codec node missing\n");
>  		ret = -EINVAL;
>  		goto out;
>  	}
>  
> -	dai->codec_of_node = codec_np;
> -
> -	cpu_np = of_parse_phandle(np, "atmel,ssc-controller", 0);
> -	if (!cpu_np) {
> +	dai->cpu_of_node = of_parse_phandle(np, "atmel,ssc-controller", 0);
> +	if (!dai->cpu_of_node) {
>  		dev_err(&pdev->dev, "atmel,ssc-controller node missing\n");
>  		ret = -EINVAL;
> -		goto out;
> +		goto out_put_codec;
>  	}
> -	dai->cpu_of_node = cpu_np;
> -	dai->platform_of_node = cpu_np;
> +	dai->platform_of_node = dai->cpu_of_node;
>  
> -	priv->ssc_id = of_alias_get_id(cpu_np, "ssc");
> +	priv->ssc_id = of_alias_get_id(dai->cpu_of_node, "ssc");
>  
>  	ret = atmel_ssc_set_audio(priv->ssc_id);
>  	if (ret != 0) {
>  		dev_err(&pdev->dev, "Failed to set SSC %d for audio: %d\n",
>  			ret, priv->ssc_id);
> -		goto out;
> +		goto out_put_cpu;
>  	}
>  
> -	of_node_put(codec_np);
> -	of_node_put(cpu_np);
> -
>  	ret = snd_soc_register_card(card);
>  	if (ret) {
>  		dev_err(&pdev->dev, "Platform device allocation failed\n");
> @@ -164,6 +157,10 @@ static int sam9x5_wm8731_driver_probe(struct platform_device *pdev)
>  
>  out_put_audio:
>  	atmel_ssc_put_audio(priv->ssc_id);
> +out_put_cpu:
> +	of_node_put(dai->cpu_of_node);

Should'nt they be put in sam9x5_wm8731_driver_remove then? Did you test
any of those changes?

> +out_put_codec:
> +	of_node_put(dai->codec_of_node);
>  out:
>  	return ret;
>  }
> -- 
> 2.15.1
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
