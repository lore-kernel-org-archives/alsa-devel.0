From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH] [ALSA] hda - bug fix on references without
 checking CONFIG_SND_HDA_POWER_SAVE
Date: Fri, 24 Aug 2012 02:52:53 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F81D57B0@SHSMSX101.ccr.corp.intel.com>
References: <1345776504-28931-1-git-send-email-mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 2993D2665C6
 for <alsa-devel@alsa-project.org>; Fri, 24 Aug 2012 04:53:04 +0200 (CEST)
In-Reply-To: <1345776504-28931-1-git-send-email-mengdong.lin@intel.com>
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
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "Wu, Fengguang" <fengguang.wu@intel.com>
List-Id: alsa-devel@alsa-project.org

Sorry, please ignore this patch. The bug fix is not enough.

Thanks
Mengdong

> -----Original Message-----
> From: Lin, Mengdong
> Sent: Friday, August 24, 2012 10:48 AM
> To: alsa-devel@alsa-project.org
> Cc: tiwai@suse.de; Wu, Fengguang; Lin, Mengdong
> Subject: [PATCH] [ALSA] hda - bug fix on references without checking
> CONFIG_SND_HDA_POWER_SAVE
> 
> From: Mengdong Lin <mengdong.lin@intel.com>
> 
> The patch to support runtime PM introduced a bug:
> Module parameter 'power_save_controller', and the codec flag 'd3_stop_clk'
> 'd3_stop_clk_ok' are defined only when HDA power save is enabled in config.
> But there are references to them without checking macro
> CONFIG_SND_HDA_POWER_SAVE.
> 
> This patch is to fix the bug.
> 
> Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>
> ---
>  sound/pci/hda/hda_intel.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c index
> 2baa3ee..97307df 100644
> --- a/sound/pci/hda/hda_intel.c
> +++ b/sound/pci/hda/hda_intel.c
> @@ -2515,8 +2515,10 @@ static int azx_runtime_suspend(struct device
> *dev)
>  	struct snd_card *card = dev_get_drvdata(dev);
>  	struct azx *chip = card->private_data;
> 
> +#ifdef CONFIG_SND_HDA_POWER_SAVE
>  	if (!power_save_controller)
>  		return -EAGAIN;
> +#endif
> 
>  	azx_stop_chip(chip);
>  	azx_clear_irq_pending(chip);
> --
> 1.7.9.5
