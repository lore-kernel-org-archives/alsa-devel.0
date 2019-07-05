From: Ladislav Michl <ladis@linux-mips.org>
Subject: Re: [alsa-devel] [PATCH] sound: soc: codecs: wcd9335: add irqflag
 IRQF_ONESHOT flag
Date: Fri, 5 Jul 2019 22:10:06 +0200
Message-ID: <20190705201006.GA22085@lenoch>
References: <20190704191026.GA20732@hari-Inspiron-1545>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190704191026.GA20732@hari-Inspiron-1545>
Sender: linux-kernel-owner@vger.kernel.org
To: Hariprasad Kelam <hariprasad.kelam@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Vinod Koul <vkoul@kernel.org>, Gen Zhang <blackgod016574@gmail.com>, Dan Carpenter <dan.carpenter@oracle.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 05, 2019 at 12:40:26AM +0530, Hariprasad Kelam wrote:
> Add IRQF_ONESHOT to ensure "Interrupt is not reenabled after the hardirq
> handler finished".
> 
> fixes below issue reported by coccicheck
> 
> sound/soc/codecs/wcd9335.c:4068:8-33: ERROR: Threaded IRQ with no
> primary handler requested without IRQF_ONESHOT
> 
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
> ---
>  sound/soc/codecs/wcd9335.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/codecs/wcd9335.c b/sound/soc/codecs/wcd9335.c
> index 85737fe..7ab9bf6f 100644
> --- a/sound/soc/codecs/wcd9335.c
> +++ b/sound/soc/codecs/wcd9335.c
> @@ -4056,6 +4056,9 @@ static struct wcd9335_irq wcd9335_irqs[] = {
>  static int wcd9335_setup_irqs(struct wcd9335_codec *wcd)
>  {
>  	int irq, ret, i;
> +	unsigned long irqflags;
> +
> +	irqflags = IRQF_TRIGGER_RISING | IRQF_ONESHOT;

Why does this change trigger adding a variable?

>  	for (i = 0; i < ARRAY_SIZE(wcd9335_irqs); i++) {
>  		irq = regmap_irq_get_virq(wcd->irq_data, wcd9335_irqs[i].irq);
> @@ -4067,7 +4070,7 @@ static int wcd9335_setup_irqs(struct wcd9335_codec *wcd)
>  
>  		ret = devm_request_threaded_irq(wcd->dev, irq, NULL,
>  						wcd9335_irqs[i].handler,
> -						IRQF_TRIGGER_RISING,
> +						irqflags,
>  						wcd9335_irqs[i].name, wcd);
>  		if (ret) {
>  			dev_err(wcd->dev, "Failed to request %s\n",
> -- 
> 2.7.4
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
