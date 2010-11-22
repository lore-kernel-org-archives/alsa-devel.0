From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH] ASoC: atmel: test wrong variable
Date: Mon, 22 Nov 2010 09:43:53 +0200
Message-ID: <20101122094353.f76830b5.jhnikula@gmail.com>
References: <1290361216-15166-1-git-send-email-segoon@openwall.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 738FE103885
	for <alsa-devel@alsa-project.org>; Mon, 22 Nov 2010 08:43:57 +0100 (CET)
Received: by ewy2 with SMTP id 2so3631524ewy.38
	for <alsa-devel@alsa-project.org>; Sun, 21 Nov 2010 23:43:57 -0800 (PST)
In-Reply-To: <1290361216-15166-1-git-send-email-segoon@openwall.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vasiliy Kulikov <segoon@openwall.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Timur Tabi <timur@freescale.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Sun, 21 Nov 2010 20:40:14 +0300
Vasiliy Kulikov <segoon@openwall.com> wrote:

> After clk_get() mclk is checked second time instead of pllb check.
> 
> Signed-off-by: Vasiliy Kulikov <segoon@openwall.com>
> ---
>  Cannot compile this driver, so it is not tested.
> 
>  sound/soc/atmel/sam9g20_wm8731.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/atmel/sam9g20_wm8731.c b/sound/soc/atmel/sam9g20_wm8731.c
> index da9c303..68072a2 100644
> --- a/sound/soc/atmel/sam9g20_wm8731.c
> +++ b/sound/soc/atmel/sam9g20_wm8731.c
> @@ -223,7 +223,7 @@ static int __init at91sam9g20ek_init(void)
>  	}
>  
>  	pllb = clk_get(NULL, "pllb");
> -	if (IS_ERR(mclk)) {
> +	if (IS_ERR(pllb)) {
>  		printk(KERN_ERR "ASoC: Failed to get PLLB\n");
>  		ret = PTR_ERR(mclk);

Update also PTR_ERR as otherwise we don't return any error code
(mclk is ok at this point but pllb has an error).

-- 
Jarkko
