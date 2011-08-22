From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: Report IRQ_NONE when we don't see an
 interrupt from WM8962
Date: Mon, 22 Aug 2011 11:25:17 +0100
Message-ID: <4E522E8D.1000003@ti.com>
References: <1313927925-11523-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 8617A24530
	for <alsa-devel@alsa-project.org>;
	Mon, 22 Aug 2011 12:25:23 +0200 (CEST)
In-Reply-To: <1313927925-11523-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On 21/08/11 12:58, Mark Brown wrote:
> This should never happen with level triggered IRQs.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/codecs/wm8962.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
> index 0c61c2f..b877fa9 100644
> --- a/sound/soc/codecs/wm8962.c
> +++ b/sound/soc/codecs/wm8962.c
> @@ -3577,6 +3577,9 @@ static irqreturn_t wm8962_irq(int irq, void *data)
>  	active = snd_soc_read(codec, WM8962_INTERRUPT_STATUS_2);
>  	active &= ~mask;
>  
> +	if (!active)
> +		return IRQ_NONE;
> +
>  	/* Acknowledge the interrupts */
>  	snd_soc_write(codec, WM8962_INTERRUPT_STATUS_2, active);
>  

Acked-by: Liam Girdwood <lrg@ti.com>
