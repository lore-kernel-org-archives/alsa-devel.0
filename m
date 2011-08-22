From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: Optimise WM8996 no interrupt path
Date: Mon, 22 Aug 2011 11:22:10 +0100
Message-ID: <4E522DD2.1090304@ti.com>
References: <1313865189-3037-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 0C2961038A9
	for <alsa-devel@alsa-project.org>;
	Mon, 22 Aug 2011 12:22:13 +0200 (CEST)
In-Reply-To: <1313865189-3037-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

On 20/08/11 19:33, Mark Brown wrote:
> This occurs frequently if we are in edge triggered mode as we must poll the
> interrupt status register until we get no more interrupts so it's worth
> the effort - it means we skip writing null acknowledgements to the chip.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/codecs/wm8996.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/soc/codecs/wm8996.c b/sound/soc/codecs/wm8996.c
> index d3277d1..73a1588 100644
> --- a/sound/soc/codecs/wm8996.c
> +++ b/sound/soc/codecs/wm8996.c
> @@ -2416,6 +2416,9 @@ static irqreturn_t wm8996_irq(int irq, void *data)
>  	}
>  	irq_val &= ~snd_soc_read(codec, WM8996_INTERRUPT_STATUS_2_MASK);
>  
> +	if (!irq_val)
> +		return IRQ_NONE;
> +
>  	snd_soc_write(codec, WM8996_INTERRUPT_STATUS_2, irq_val);
>  
>  	if (irq_val & (WM8996_DCS_DONE_01_EINT | WM8996_DCS_DONE_23_EINT)) {
> @@ -2434,10 +2437,7 @@ static irqreturn_t wm8996_irq(int irq, void *data)
>  	if (irq_val & WM8996_MICD_EINT)
>  		wm8996_micd(codec);
>  
> -	if (irq_val)
> -		return IRQ_HANDLED;
> -	else
> -		return IRQ_NONE;
> +	return IRQ_HANDLED;
>  }
>  
>  static irqreturn_t wm8996_edge_irq(int irq, void *data)

Acked-by: Liam Girdwood <lrg@ti.com>
