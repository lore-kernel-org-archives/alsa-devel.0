From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH] ASoC: atmel: Remove check for node pointer
Date: Sat, 27 Jan 2018 22:53:36 +0100
Message-ID: <20180127215336.GC5842@piout.net>
References: <20180122141557.GA29226@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.free-electrons.com (mail.free-electrons.com [62.4.15.54])
 by alsa0.perex.cz (Postfix) with ESMTP id EE388266FD1
 for <alsa-devel@alsa-project.org>; Sat, 27 Jan 2018 22:53:37 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20180122141557.GA29226@lenoch>
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
Cc: alsa-devel@alsa-project.org, Nicolas Ferre <nicolas.ferre@microchip.com>, Peter Rosin <peda@axentia.se>
List-Id: alsa-devel@alsa-project.org

On 22/01/2018 at 15:15:57 +0100, Ladislav Michl wrote:
> Probe function is called only after DT compatible is matched,
> thus node pointer cannot be NULL.
> 
> Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

> ---
>  Note: this patch replaces previously sent
>  "ASoC: sam9x5_wm8731: Return -ENODEV when probe does not find OF node" and
>  "ASoC: atmel_wm8904: Return -ENODEV when probe does not find OF node"
>  while taking Alexandre Belloni's advice into account and extending it for
>  the rest of Atmel's drivers.
> 
>  sound/soc/atmel/atmel_wm8904.c   | 5 -----
>  sound/soc/atmel/sam9g20_wm8731.c | 4 ----
>  sound/soc/atmel/sam9x5_wm8731.c  | 5 -----
>  sound/soc/atmel/tse850-pcm5142.c | 5 -----
>  4 files changed, 19 deletions(-)
> 
> diff --git a/sound/soc/atmel/atmel_wm8904.c b/sound/soc/atmel/atmel_wm8904.c
> index fbc10f61eb55..0619a9961e0c 100644
> --- a/sound/soc/atmel/atmel_wm8904.c
> +++ b/sound/soc/atmel/atmel_wm8904.c
> @@ -85,11 +85,6 @@ static int atmel_asoc_wm8904_dt_init(struct platform_device *pdev)
>  	struct snd_soc_dai_link *dailink = &atmel_asoc_wm8904_dailink;
>  	int ret;
>  
> -	if (!np) {
> -		dev_err(&pdev->dev, "only device tree supported\n");
> -		return -EINVAL;
> -	}
> -
>  	ret = snd_soc_of_parse_card_name(card, "atmel,model");
>  	if (ret) {
>  		dev_err(&pdev->dev, "failed to parse card name\n");
> diff --git a/sound/soc/atmel/sam9g20_wm8731.c b/sound/soc/atmel/sam9g20_wm8731.c
> index 98f93e79c654..a53f3ee82d30 100644
> --- a/sound/soc/atmel/sam9g20_wm8731.c
> +++ b/sound/soc/atmel/sam9g20_wm8731.c
> @@ -163,10 +163,6 @@ static int at91sam9g20ek_audio_probe(struct platform_device *pdev)
>  	struct snd_soc_card *card = &snd_soc_at91sam9g20ek;
>  	int ret;
>  
> -	if (!np) {
> -		return -ENODEV;
> -	}
> -
>  	ret = atmel_ssc_set_audio(0);
>  	if (ret) {
>  		dev_err(&pdev->dev, "ssc channel is not valid\n");
> diff --git a/sound/soc/atmel/sam9x5_wm8731.c b/sound/soc/atmel/sam9x5_wm8731.c
> index 920f72565ff2..b177524f5926 100644
> --- a/sound/soc/atmel/sam9x5_wm8731.c
> +++ b/sound/soc/atmel/sam9x5_wm8731.c
> @@ -83,11 +83,6 @@ static int sam9x5_wm8731_driver_probe(struct platform_device *pdev)
>  	struct sam9x5_drvdata *priv;
>  	int ret;
>  
> -	if (!np) {
> -		dev_err(&pdev->dev, "No device node supplied\n");
> -		return -EINVAL;
> -	}
> -
>  	card = devm_kzalloc(&pdev->dev, sizeof(*card), GFP_KERNEL);
>  	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
>  	dai = devm_kzalloc(&pdev->dev, sizeof(*dai), GFP_KERNEL);
> diff --git a/sound/soc/atmel/tse850-pcm5142.c b/sound/soc/atmel/tse850-pcm5142.c
> index 3a1393283156..73b327e781ab 100644
> --- a/sound/soc/atmel/tse850-pcm5142.c
> +++ b/sound/soc/atmel/tse850-pcm5142.c
> @@ -327,11 +327,6 @@ static int tse850_dt_init(struct platform_device *pdev)
>  	struct device_node *codec_np, *cpu_np;
>  	struct snd_soc_dai_link *dailink = &tse850_dailink;
>  
> -	if (!np) {
> -		dev_err(&pdev->dev, "only device tree supported\n");
> -		return -EINVAL;
> -	}
> -
>  	cpu_np = of_parse_phandle(np, "axentia,cpu-dai", 0);
>  	if (!cpu_np) {
>  		dev_err(&pdev->dev, "failed to get cpu dai\n");
> -- 
> 2.15.1
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
