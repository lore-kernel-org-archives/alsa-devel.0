From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [RFC PATCH] ALSA: hda - add support for runtime
	power management
Date: Fri, 17 Aug 2012 14:41:17 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F818B4E4@SHSMSX101.ccr.corp.intel.com>
References: <1345195814-2287-1-git-send-email-mengdong.lin@intel.com>
 <s5hsjblvo9s.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id D330D266135
 for <alsa-devel@alsa-project.org>; Fri, 17 Aug 2012 16:11:49 +0200 (CEST)
In-Reply-To: <s5hsjblvo9s.wl%tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> ... Basically the patch below should do almost
> equivalently.  It doesn't free/reacquire irq, which I'm not quite sure whether
> mandatory for power-saving.
> 
> @@ -2402,11 +2402,14 @@ static void azx_power_notify(struct hda_bus
> *bus)
>  			break;
>  		}
>  	}
> -	if (power_on)
> +	if (power_on) {
> +		pci_set_power_state(chip->pci, PCI_D0);
>  		azx_init_chip(chip, 1);
> -	else if (chip->running && power_save_controller &&
> -		 !bus->power_keep_link_on)
> +	} else if (chip->running && power_save_controller &&
> +		   !bus->power_keep_link_on) {
>  		azx_stop_chip(chip);
> +		pci_set_power_state(chip->pci, PCI_D3hot);
> +	}
>  }
>  #endif /* CONFIG_SND_HDA_POWER_SAVE */
> 

Hi Takashi,

Thanks for your comments. 

I think that adding runtime PM support can bring some benefits:
(1) Make the HD-A devices become part of system runtime PM and can bring more power saving. When the HD-A controller is suspended via runtime PM API, the runtime PM subsystem will also try to suspend the parent device. 
(2) PCI subsystem has implemented a framework for runtime PM, supporting both PCI PM and ACPI PM. When the HD-A controller is to be suspended, it can choose the lowest power state the device can signal wake up from. This state can be D3cold if the platform can support via ACPI. This also means more power saving.
(3) Provide a general sysfs interface to upper level policy manager.

Thanks
Mengdong
