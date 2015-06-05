From: Jarkko Nikula <jarkko.nikula@intel.com>
Subject: Re: writing an alsa driver
Date: Fri, 05 Jun 2015 10:00:50 +0300
Message-ID: <55714922.1080906@intel.com>
References: <20150527085440.GA4445@dellaz> <1432752116.8235.25.camel@loki>
 <20150527201320.GA309@asus> <1432812668.2726.18.camel@loki>
 <20150528125325.GA418@asus> <1432819294.2726.33.camel@loki>
 <20150528191721.GA608@asus> <1432892521.2732.14.camel@loki>
 <20150529131753.GA339@asus> <1433156768.2642.21.camel@loki>
 <20150604193922.GA627@asus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id EF91426672E
 for <alsa-devel@alsa-project.org>; Fri,  5 Jun 2015 09:00:54 +0200 (CEST)
In-Reply-To: <20150604193922.GA627@asus>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Michele Curti <michele.curti@gmail.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi

On 06/04/2015 10:39 PM, Michele Curti wrote:
>                  Interrupt (ResourceConsumer, Level, ActiveLow, Exclusive, ,, )
>                  {
>                      0x0000001D,
>                  }
>                  Interrupt (ResourceConsumer, Level, ActiveLow, Exclusive, ,, )
>                  {
>                      0x00000018,
>                  }
>                  Interrupt (ResourceConsumer, Level, ActiveLow, Exclusive, ,, )
>                  {
>                      0x00000019,
>                  }
>                  Interrupt (ResourceConsumer, Level, ActiveLow, Exclusive, ,, )
>                  {
>                      0x0000001A,
>                  }
>                  Interrupt (ResourceConsumer, Level, ActiveLow, Exclusive, ,, )
>                  {
>                      0x0000001B,
>                  }
>                  Interrupt (ResourceConsumer, Level, ActiveLow, Exclusive, ,, )
>                  {
>                      0x0000001C,
>                  }
...
>
> So, 6 possible IRQs for the LPE core, from 0x18 to 0x1D?
>
2 for DMA, 3 for SSP ports and 1 for host IPC. I don't know does Windows 
use those others as BIOS is exposing them but Linux needs only the host 
IPC irq 0x1d and Linux DSP FW is managing itself the rest.

> Changed the code and tried all six
>
> diff --git a/sound/soc/intel/common/sst-acpi.c b/sound/soc/intel/common/sst-acpi.c
> index bb28e84..a306502 100644
> --- a/sound/soc/intel/common/sst-acpi.c
> +++ b/sound/soc/intel/common/sst-acpi.c
> @@ -149,8 +149,12 @@ static int sst_acpi_probe(struct platform_device *pdev)
>   		sst_pdata->dma_size = desc->dma_size;
>   	}
>
> -	if (desc->irqindex_host_ipc >= 0)
> -		sst_pdata->irq = platform_get_irq(pdev, desc->irqindex_host_ipc);
> +	if (desc->irqindex_host_ipc >= 0) {
> +		sst_pdata->irq = 0x1D; /* acpi-dump, from 0x18 to 0x1D */
> +		pr_info("audio dsp: IRQ # was %d, force to %d\n",
> +				platform_get_irq(pdev, desc->irqindex_host_ipc),
> +				sst_pdata->irq);
> +	}
>
>   	if (desc->resindex_lpe_base >= 0) {
>   		mmio = platform_get_resource(pdev, IORESOURCE_MEM,
>
> without success, I get always the "dsp boot timeout".
>
Above probably won't work as it doesn't set the trigger flags as 
platform_get_irq() does and the Linux irq number is not necessarily the 
same than the HW irq number through the IOAPIC routing.

Your earlier irqindex_host_ipc change should get the right interrupt for 
Linux on your machine.

-	.irqindex_host_ipc = 5,
+	.irqindex_host_ipc = 0,

Unfortunately this index is machine specific and when I looked a few 
DSDT tables earlier I didn't figure out a clean way at which index the 
interrupt should be used in runtime. Probably having quirks for index 5 
needs least amount of quirks as index 0 seems to be constantly used on 
newer machines.

-- 
Jarkko
---------------------------------------------------------------------
Intel Finland Oy
Registered Address: PL 281, 00181 Helsinki 
Business Identity Code: 0357606 - 4 
Domiciled in Helsinki 

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.
