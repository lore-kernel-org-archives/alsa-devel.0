From: Ladislav Michl <ladis@linux-mips.org>
Subject: Re: ASoC: How to write new (atmel) driver?
Date: Sun, 14 Jan 2018 22:53:49 +0100
Message-ID: <20180114215349.GA16051@lenoch>
References: <20180114115400.GA5867@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cvs.linux-mips.org (eddie.linux-mips.org [148.251.95.138])
 by alsa0.perex.cz (Postfix) with ESMTP id DBEED266CFE
 for <alsa-devel@alsa-project.org>; Sun, 14 Jan 2018 22:53:54 +0100 (CET)
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
 (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
 id S23992521AbeANVxuvXFCj (ORCPT
 <rfc822;alsa-devel@alsa-project.org>);
 Sun, 14 Jan 2018 22:53:50 +0100
Content-Disposition: inline
In-Reply-To: <20180114115400.GA5867@lenoch>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Liam Girdwood <lgirdwood@gmail.com>, Nicolas Ferre <nicolas.ferre@microchip.com>
List-Id: alsa-devel@alsa-project.org

On Sun, Jan 14, 2018 at 12:54:00PM +0100, Ladislav Michl wrote:
> Hi there!
> 
> I've got new at91sam9g20 board with max9867 codec (*), so I wanted to get
> inspiration from other drivers in sound/soc/atmel. Indeed, there are three
> of them:
> atmel_wm8904.c
> sam9g20_wm8731.c
> sam9x5_wm8731.c
> Now, looking at sound/soc/tegra, sound/soc/mediatek, etc. most drivers seems
> to be created by copy, modify (mostly find&replace), commit. There are so many
> of them, that it is probably impossible to fix them all (consider for
> example patch bellow to be done several times for different drivers) (**)

Okay, at least for atmel drivers, I'll just sent few cleanups/fixes, not
sure about the rest. Perhaps some coccinelle scripting would help.

> So is sound/soc/generic preferred solution these days? Btw, generic drivers
> are calling of_node_put before they are done dealing with that node.
> 
> And if above is preferred solution what about all those already created
> drivers? Fix them all or covert to generic one by introducing DT fixups
> for all those over the time created DT properties? At least for atmel
> drivers that seems to be doable as atmel_ssc_dai needs to be modified
> to get it work under generic framework and keeping old interface would
> needlesly complicate things - unless I miss something obvious of course :)

...and the obvious is drivers/misc/atmel-ssc.c and then simple-audio-card
should do the trick.

Well, remaining question is how is SND_SOC_MAX9768 expected to be selected?

> (*) for now I wrote driver using copy&modify, but that does not seem to be
>     the right solution anymore
> (**) almost two decades ago I rather wrote OSS driver for the very same
>      reasons, but now OSS is gone...
> 
> diff --git a/sound/soc/atmel/sam9x5_wm8731.c b/sound/soc/atmel/sam9x5_wm8731.c
> index 9db08826b32a..11e2c37a2e42 100644
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
> @@ -122,23 +121,20 @@ static int sam9x5_wm8731_driver_probe(struct platform_device *pdev)
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
>  	priv->ssc_id = of_alias_get_id(cpu_np, "ssc");
>  
> @@ -146,12 +142,9 @@ static int sam9x5_wm8731_driver_probe(struct platform_device *pdev)
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
> +out_put_codec:
> +	of_node_put(dai->codec_of_node);
>  out:
>  	return ret;
>  }
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
