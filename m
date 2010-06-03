From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] AsoC/atmel: patch for the unnecessary
	variable removal
Date: Thu, 03 Jun 2010 13:14:23 +0100
Message-ID: <1275567263.3593.79.camel@odin>
References: <4C0686BE.8000402@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 2581524415
	for <alsa-devel@alsa-project.org>;
	Thu,  3 Jun 2010 14:14:26 +0200 (CEST)
Received: by wwf26 with SMTP id 26so14575wwf.38
	for <alsa-devel@alsa-project.org>; Thu, 03 Jun 2010 05:14:25 -0700 (PDT)
In-Reply-To: <4C0686BE.8000402@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Wan ZongShun <mcuos.com@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Nicolas Ferre <nicolas.ferre@atmel.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2010-06-03 at 00:28 +0800, Wan ZongShun wrote:
> The variable 'periods' of structure 'atmel_runtime_data'
> seems no use in whole atmel alsa driver,so I make a patch
> to remove the unnecessary variable.
> 
> Signed-off-by: Wan ZongShun <mcuos.com@gmail.com>
> ---
>  sound/soc/atmel/atmel-pcm.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/atmel/atmel-pcm.c b/sound/soc/atmel/atmel-pcm.c
> index f6b3cc0..dc5249f 100644
> --- a/sound/soc/atmel/atmel-pcm.c
> +++ b/sound/soc/atmel/atmel-pcm.c
> @@ -77,7 +77,6 @@ struct atmel_runtime_data {
>  	size_t period_size;
> 
>  	dma_addr_t period_ptr;		/* physical address of next period */
> -	int periods;			/* period index of period_ptr */
> 
>  	/* PDC register save */
>  	u32 pdc_xpr_save;

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
