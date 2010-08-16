From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 1/2] ASoC: Fix WM8580 CLKSEL mask selection
Date: Mon, 16 Aug 2010 19:37:27 +0100
Message-ID: <1281983847.3065.344.camel@odin>
References: <1281983313-4636-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 8D50F103838
	for <alsa-devel@alsa-project.org>;
	Mon, 16 Aug 2010 20:37:28 +0200 (CEST)
Received: by wyb42 with SMTP id 42so6024643wyb.38
	for <alsa-devel@alsa-project.org>; Mon, 16 Aug 2010 11:37:28 -0700 (PDT)
In-Reply-To: <1281983313-4636-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Seungwhan Youn <claude.youn@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 2010-08-16 at 19:28 +0100, Mark Brown wrote:
> The RX and TX directions were inverted.
> 
> Reported-by: Seungwhan Youn <claude.youn@gmail.com>
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/codecs/wm8580.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/codecs/wm8580.c b/sound/soc/codecs/wm8580.c
> index af4517e..42a6699 100644
> --- a/sound/soc/codecs/wm8580.c
> +++ b/sound/soc/codecs/wm8580.c
> @@ -703,12 +703,12 @@ static int wm8580_set_sysclk(struct snd_soc_dai *dai, int clk_id,
>  	int sel, sel_mask, sel_shift;
>  
>  	switch (dai->driver->id) {
> -	case WM8580_DAI_PAIFTX:
> +	case WM8580_DAI_PAIFRX:
>  		sel_mask = 0x3;
>  		sel_shift = 0;
>  		break;
>  
> -	case WM8580_DAI_PAIFRX:
> +	case WM8580_DAI_PAIFTX:
>  		sel_mask = 0xc;
>  		sel_shift = 2;
>  		break;

Both 

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
