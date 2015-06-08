From: Michele Curti <michele.curti@gmail.com>
Subject: Re: writing an alsa driver
Date: Mon, 8 Jun 2015 10:26:54 +0200
Message-ID: <20150608082654.GA7140@dellaz>
References: <20150527201320.GA309@asus> <1432812668.2726.18.camel@loki>
 <20150528125325.GA418@asus> <1432819294.2726.33.camel@loki>
 <20150528191721.GA608@asus> <1432892521.2732.14.camel@loki>
 <20150529131753.GA339@asus> <1433156768.2642.21.camel@loki>
 <20150604193922.GA627@asus> <55714922.1080906@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f169.google.com (mail-wi0-f169.google.com
 [209.85.212.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 694DA260574
 for <alsa-devel@alsa-project.org>; Mon,  8 Jun 2015 10:26:59 +0200 (CEST)
Received: by wifx6 with SMTP id x6so77678540wif.0
 for <alsa-devel@alsa-project.org>; Mon, 08 Jun 2015 01:26:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <55714922.1080906@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@intel.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 05, 2015 at 10:00:50AM +0300, Jarkko Nikula wrote:
> Hi
> 
> On 06/04/2015 10:39 PM, Michele Curti wrote:
> >
> >So, 6 possible IRQs for the LPE core, from 0x18 to 0x1D?
> >
> 2 for DMA, 3 for SSP ports and 1 for host IPC. I don't know does
> Windows use those others as BIOS is exposing them but Linux needs
> only the host IPC irq 0x1d and Linux DSP FW is managing itself the
> rest.
> 
> >Changed the code and tried all six
> >
> >diff --git a/sound/soc/intel/common/sst-acpi.c b/sound/soc/intel/common/sst-acpi.c
> >index bb28e84..a306502 100644
> >--- a/sound/soc/intel/common/sst-acpi.c
> >+++ b/sound/soc/intel/common/sst-acpi.c
> >@@ -149,8 +149,12 @@ static int sst_acpi_probe(struct platform_device *pdev)
> >  		sst_pdata->dma_size = desc->dma_size;
> >  	}
> >
> >-	if (desc->irqindex_host_ipc >= 0)
> >-		sst_pdata->irq = platform_get_irq(pdev, desc->irqindex_host_ipc);
> >+	if (desc->irqindex_host_ipc >= 0) {
> >+		sst_pdata->irq = 0x1D; /* acpi-dump, from 0x18 to 0x1D */
> >+		pr_info("audio dsp: IRQ # was %d, force to %d\n",
> >+				platform_get_irq(pdev, desc->irqindex_host_ipc),
> >+				sst_pdata->irq);
> >+	}
> >
> >  	if (desc->resindex_lpe_base >= 0) {
> >  		mmio = platform_get_resource(pdev, IORESOURCE_MEM,
> >
> >without success, I get always the "dsp boot timeout".
> >
> Above probably won't work as it doesn't set the trigger flags as
> platform_get_irq() does and the Linux irq number is not necessarily
> the same than the HW irq number through the IOAPIC routing.

Good to know, thanks!

> 
> Your earlier irqindex_host_ipc change should get the right interrupt
> for Linux on your machine.
> 
> -	.irqindex_host_ipc = 5,
> +	.irqindex_host_ipc = 0,
> 
> Unfortunately this index is machine specific and when I looked a few
> DSDT tables earlier I didn't figure out a clean way at which index
> the interrupt should be used in runtime. Probably having quirks for
> index 5 needs least amount of quirks as index 0 seems to be
> constantly used on newer machines.
>

Oh, understood..  Well, so for my tests I can restore this change 
thanks :)


Michele
