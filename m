From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH 2/2] ASoC: PXA: Fix codec address on Zipit
	Z2
Date: Tue, 18 Jan 2011 16:05:47 +0100
Message-ID: <201101181605.47580.marek.vasut@gmail.com>
References: <1295362465-21794-1-git-send-email-anarsoul@gmail.com>
	<1295362465-21794-2-git-send-email-anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id B7FD7245D8
	for <alsa-devel@alsa-project.org>; Tue, 18 Jan 2011 16:02:54 +0100 (CET)
Received: by fxm5 with SMTP id 5so7337000fxm.38
	for <alsa-devel@alsa-project.org>; Tue, 18 Jan 2011 07:02:54 -0800 (PST)
In-Reply-To: <1295362465-21794-2-git-send-email-anarsoul@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vasily Khoruzhick <anarsoul@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tuesday 18 January 2011 15:54:25 Vasily Khoruzhick wrote:
> WM8750 address is 0x1b, not 0x1a. Without this fix
> ALSA detects no sound cards on Zipit
> 
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
>  sound/soc/pxa/z2.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/pxa/z2.c b/sound/soc/pxa/z2.c
> index 0da889d..62c77dc 100644
> --- a/sound/soc/pxa/z2.c
> +++ b/sound/soc/pxa/z2.c
> @@ -193,7 +193,7 @@ static struct snd_soc_dai_link z2_dai = {
>  	.cpu_dai_name	= "pxa2xx-i2s",
>  	.codec_dai_name	= "wm8750-hifi",
>  	.platform_name = "pxa-pcm-audio",
> -	.codec_name	= "wm8750-codec.0-001a",
> +	.codec_name	= "wm8750-codec.0-001b",
>  	.init		= z2_wm8750_init,
>  	.ops		= &z2_ops,
>  };

Acked-by: Marek Vasut <marek.vasut@gmail.com>

Mark, shall I/Eric pick it via pxa-linux-2.6 or are you taking care of these two 
?
