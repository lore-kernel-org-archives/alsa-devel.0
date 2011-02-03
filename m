From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/3] ASoC: mid-x86 machine driver - add
 jack detect support
Date: Thu, 3 Feb 2011 15:20:48 +0000
Message-ID: <20110203152048.GC2576@opensource.wolfsonmicro.com>
References: <1296732361-24172-1-git-send-email-priya.harsha@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 59E8E103868
	for <alsa-devel@alsa-project.org>; Thu,  3 Feb 2011 16:20:30 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1296732361-24172-1-git-send-email-priya.harsha@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Harsha Priya <priya.harsha@intel.com>
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Thu, Feb 03, 2011 at 04:56:01PM +0530, Harsha Priya wrote:

> +#define IRQ_BASE 0xFFFF7FCD
> +#define IRQ_SIZE 1

This looks like it should be coming in via a platform device or
something?

> +static struct snd_soc_jack_pin mfld_jack_pins[] = {
> +	{
> +		.pin = "Headphones",
> +		.mask = SND_JACK_HEADPHONE,
> +	},
> +	{
> +		.pin = "AMIC1",
> +		.mask = SND_JACK_MICROPHONE,
> +	},
> +};
> +/* jack detection voltage zones */

Blank line between these - in general it'd be worth checking into this.

> +	/* retrive the irq number */
> +	irq = platform_get_irq(pdev, 0);
> +	/*	audio interrupt base of SRAM location where
> +	*	interrupts are stored by System FW */
> +	mc_drv_ctx.int_base = ioremap_nocache(IRQ_BASE, IRQ_SIZE);
> +	if (!mc_drv_ctx.int_base) {
> +		pr_err("Mapping of cache failed\n");
> +		ret_val = -ENOMEM;
> +		goto unalloc;
> +	}
> +	/* create botoom half handler for interrupt */
> +	mc_drv_ctx.mfld_jack_wq = create_workqueue("mfld_jack_wq");
> +	if (!mc_drv_ctx.mfld_jack_wq) {
> +		pr_err("cannot create jack workqueue\n");
> +		ret_val = -ENOMEM;
> +		goto unalloc;
> +	}
> +	/* register for interrupt */
> +	ret_val = request_irq(irq, snd_mfld_jack_intr_handler,
> +				IRQF_SHARED, pdev->dev.driver->name,
> +				&mc_drv_ctx);

I suspect you can just use request_threaded_irq() here which would ave
open coding the workqueue.
