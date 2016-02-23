From: "Yang, Libin" <libin.yang@intel.com>
Subject: Re: [RFC: PATCH] ALSA: hda - clear IRQ statu twice on
 some Intel platforms
Date: Tue, 23 Feb 2016 08:57:13 +0000
Message-ID: <96A12704CE18D347B625EE2D4A099D1904670652@SHSMSX103.ccr.corp.intel.com>
References: <1456126790-13480-1-git-send-email-libin.yang@linux.intel.com>
 <s5h60xhw2wp.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id A5CF2260535
 for <alsa-devel@alsa-project.org>; Tue, 23 Feb 2016 09:57:18 +0100 (CET)
In-Reply-To: <s5h60xhw2wp.wl-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, "libin.yang@linux.intel.com" <libin.yang@linux.intel.com>
Cc: "Lin, Mengdong" <mengdong.lin@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

I'm testing your patch in stress level. So far, it seems to works smoothly.

Which patch do you like? And your patch seems to impact on all the platforms?

Regards,
Libin

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Monday, February 22, 2016 4:44 PM
> To: libin.yang@linux.intel.com
> Cc: alsa-devel@alsa-project.org; Lin, Mengdong; Yang, Libin
> Subject: Re: [alsa-devel] [RFC: PATCH] ALSA: hda - clear IRQ statu twice on
> some Intel platforms
> 
> On Mon, 22 Feb 2016 08:39:50 +0100,
> libin.yang@linux.intel.com wrote:
> >
> > From: Libin Yang <libin.yang@linux.intel.com>
> >
> > On some Intel platforms, we found the interrupt issue in
> > the below scenario:
> > 1. driver is in irq handler
> > 2. there is another interrupt from HW after interrupt status
> >    is cleared and before exiting from interrupt handler
> > 3. exit from the current irq handling
> >
> > After exiting the irq handler, it should raise another
> > interrupt for driver to handle the new interrupt. But actually,
> > it failed to raise the interrupt and driver will never have
> > chance to clear the interrupt status.
> >
> > The patch clears the interrupt status again just before exiting
> > for interrupt handler. This can reduce the contest dramatically.
> >
> > Signed-off-by: Libin Yang <libin.yang@linux.intel.com>
> 
> An alternative way is to loop while the status bit is reenabled.  An
> untested patch is below.  Not sure which is better yet.  Just an idea.
> 
> 
> Takashi
> 
> ---
> diff --git a/include/sound/hdaudio.h b/include/sound/hdaudio.h
> index e2b712c90d3f..b74d9c8dceff 100644
> --- a/include/sound/hdaudio.h
> +++ b/include/sound/hdaudio.h
> @@ -343,7 +343,7 @@ void snd_hdac_bus_enter_link_reset(struct
> hdac_bus *bus);
>  void snd_hdac_bus_exit_link_reset(struct hdac_bus *bus);
> 
>  void snd_hdac_bus_update_rirb(struct hdac_bus *bus);
> -void snd_hdac_bus_handle_stream_irq(struct hdac_bus *bus, unsigned
> int status,
> +bool snd_hdac_bus_handle_stream_irq(struct hdac_bus *bus, unsigned
> int status,
>  				    void (*ack)(struct hdac_bus *,
>  						struct hdac_stream *));
> 
> diff --git a/sound/hda/hdac_controller.c b/sound/hda/hdac_controller.c
> index b5a17cb510a0..448cd8c990f0 100644
> --- a/sound/hda/hdac_controller.c
> +++ b/sound/hda/hdac_controller.c
> @@ -427,17 +427,19 @@
> EXPORT_SYMBOL_GPL(snd_hdac_bus_stop_chip);
>   * @status: INTSTS register value
>   * @ask: callback to be called for woken streams
>   */
> -void snd_hdac_bus_handle_stream_irq(struct hdac_bus *bus, unsigned
> int status,
> +bool snd_hdac_bus_handle_stream_irq(struct hdac_bus *bus, unsigned
> int status,
>  				    void (*ack)(struct hdac_bus *,
>  						struct hdac_stream *))
>  {
>  	struct hdac_stream *azx_dev;
>  	u8 sd_status;
> +	bool handled = false;
> 
>  	list_for_each_entry(azx_dev, &bus->stream_list, list) {
>  		if (status & azx_dev->sd_int_sta_mask) {
>  			sd_status = snd_hdac_stream_readb(azx_dev,
> SD_STS);
>  			snd_hdac_stream_writeb(azx_dev, SD_STS,
> SD_INT_MASK);
> +			handled = true;
>  			if (!azx_dev->substream || !azx_dev->running
> ||
>  			    !(sd_status & SD_INT_COMPLETE))
>  				continue;
> @@ -445,6 +447,7 @@ void snd_hdac_bus_handle_stream_irq(struct
> hdac_bus *bus, unsigned int status,
>  				ack(bus, azx_dev);
>  		}
>  	}
> +	return handled;
>  }
>  EXPORT_SYMBOL_GPL(snd_hdac_bus_handle_stream_irq);
> 
> diff --git a/sound/pci/hda/hda_controller.c
> b/sound/pci/hda/hda_controller.c
> index 37cf9cee9835..a4226026b1dc 100644
> --- a/sound/pci/hda/hda_controller.c
> +++ b/sound/pci/hda/hda_controller.c
> @@ -930,6 +930,7 @@ irqreturn_t azx_interrupt(int irq, void *dev_id)
>  	struct azx *chip = dev_id;
>  	struct hdac_bus *bus = azx_bus(chip);
>  	u32 status;
> +	bool handled = false;
> 
>  #ifdef CONFIG_PM
>  	if (azx_has_pm_runtime(chip))
> @@ -944,28 +945,35 @@ irqreturn_t azx_interrupt(int irq, void *dev_id)
>  		return IRQ_NONE;
>  	}
> 
> -	status = azx_readl(chip, INTSTS);
> -	if (status == 0 || status == 0xffffffff) {
> -		spin_unlock(&bus->reg_lock);
> -		return IRQ_NONE;
> -	}
> +	for (;;) {
> +		bool active;
> 
> -	snd_hdac_bus_handle_stream_irq(bus, status, stream_update);
> +		status = azx_readl(chip, INTSTS);
> +		if (status == 0 || status == 0xffffffff)
> +			break;
> 
> -	/* clear rirb int */
> -	status = azx_readb(chip, RIRBSTS);
> -	if (status & RIRB_INT_MASK) {
> -		if (status & RIRB_INT_RESPONSE) {
> -			if (chip->driver_caps &
> AZX_DCAPS_CTX_WORKAROUND)
> -				udelay(80);
> -			snd_hdac_bus_update_rirb(bus);
> +		active = snd_hdac_bus_handle_stream_irq(bus, status,
> stream_update);
> +
> +		/* clear rirb int */
> +		status = azx_readb(chip, RIRBSTS);
> +		if (status & RIRB_INT_MASK) {
> +			active = true;
> +			if (status & RIRB_INT_RESPONSE) {
> +				if (chip->driver_caps &
> AZX_DCAPS_CTX_WORKAROUND)
> +					udelay(80);
> +				snd_hdac_bus_update_rirb(bus);
> +			}
> +			azx_writeb(chip, RIRBSTS, RIRB_INT_MASK);
>  		}
> -		azx_writeb(chip, RIRBSTS, RIRB_INT_MASK);
> +
> +		if (!active)
> +			break;
> +		handled = true;
>  	}
> 
>  	spin_unlock(&bus->reg_lock);
> 
> -	return IRQ_HANDLED;
> +	return IRQ_RETVAL(handled);
>  }
>  EXPORT_SYMBOL_GPL(azx_interrupt);
> 
