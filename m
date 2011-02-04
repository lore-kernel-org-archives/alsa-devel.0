From: "Harsha, Priya" <priya.harsha@intel.com>
Subject: Re: [PATCH 2/3] ASoC: mid-x86 machine driver - add
 jack detect support
Date: Fri, 4 Feb 2011 09:24:24 +0530
Message-ID: <98769532B4BB14429434178695419EAE08C107FB35@bgsmsx501.gar.corp.intel.com>
References: <1296732361-24172-1-git-send-email-priya.harsha@intel.com>
	<20110203152048.GC2576@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 8DE6C103922
	for <alsa-devel@alsa-project.org>; Fri,  4 Feb 2011 04:55:08 +0100 (CET)
In-Reply-To: <20110203152048.GC2576@opensource.wolfsonmicro.com>
Content-Language: en-US
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
Cc: "Koul, Vinod" <vinod.koul@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

>> +#define IRQ_BASE 0xFFFF7FCD
>> +#define IRQ_SIZE 1
>
>This looks like it should be coming in via a platform device or
>something?
I can make it a part of platform data.

>
>> +static struct snd_soc_jack_pin mfld_jack_pins[] = {
>> +	{
>> +		.pin = "Headphones",
>> +		.mask = SND_JACK_HEADPHONE,
>> +	},
>> +	{
>> +		.pin = "AMIC1",
>> +		.mask = SND_JACK_MICROPHONE,
>> +	},
>> +};
>> +/* jack detection voltage zones */
>
>Blank line between these - in general it'd be worth checking into this.
Will add it

>
>> +	/* retrive the irq number */
>> +	irq = platform_get_irq(pdev, 0);
>> +	/*	audio interrupt base of SRAM location where
>> +	*	interrupts are stored by System FW */
>> +	mc_drv_ctx.int_base = ioremap_nocache(IRQ_BASE, IRQ_SIZE);
>> +	if (!mc_drv_ctx.int_base) {
>> +		pr_err("Mapping of cache failed\n");
>> +		ret_val = -ENOMEM;
>> +		goto unalloc;
>> +	}
>> +	/* create botoom half handler for interrupt */
>> +	mc_drv_ctx.mfld_jack_wq = create_workqueue("mfld_jack_wq");
>> +	if (!mc_drv_ctx.mfld_jack_wq) {
>> +		pr_err("cannot create jack workqueue\n");
>> +		ret_val = -ENOMEM;
>> +		goto unalloc;
>> +	}
>> +	/* register for interrupt */
>> +	ret_val = request_irq(irq, snd_mfld_jack_intr_handler,
>> +				IRQF_SHARED, pdev->dev.driver->name,
>> +				&mc_drv_ctx);
>
>I suspect you can just use request_threaded_irq() here which would ave
>open coding the workqueue.
I will try this out .

-Harsha
