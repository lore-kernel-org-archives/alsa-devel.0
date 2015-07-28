From: "Yang, Libin" <libin.yang@intel.com>
Subject: Re: [PATCH v2] ALSA: hda - Fix race condition between
 HDA driver and runtime PM
Date: Tue, 28 Jul 2015 05:20:08 +0000
Message-ID: <96A12704CE18D347B625EE2D4A099D196C8427@SHSMSX103.ccr.corp.intel.com>
References: <1438057171-18045-1-git-send-email-ullysses.a.eoff@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 49EE32651C0
 for <alsa-devel@alsa-project.org>; Tue, 28 Jul 2015 07:20:14 +0200 (CEST)
In-Reply-To: <1438057171-18045-1-git-send-email-ullysses.a.eoff@intel.com>
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
To: "Eoff, Ullysses A" <ullysses.a.eoff@intel.com>, "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "Lee, Zhuo-hao" <zhuo-hao.lee@intel.com>
List-Id: alsa-devel@alsa-project.org


Hi Ullysses,

> -----Original Message-----
> From: Eoff, Ullysses A
> Sent: Tuesday, July 28, 2015 12:20 PM
> To: tiwai@suse.de; alsa-devel@alsa-project.org
> Cc: Lee, Zhuo-hao; Yang, Libin; Eoff, Ullysses A
> Subject: [PATCH v2] ALSA: hda - Fix race condition between HDA driver
> and runtime PM
> 
> Don't execute runtime suspend if HDA is not finished initializing.
> Otherwise, the following errors can occur in hda:
> 
> snd_hda_intel 0000:00:1b.0: CORB reset timeout#2, CORBRP = 65535
> snd_hda_intel 0000:00:1b.0: no codecs initialized
> 
> Debugged and root-cause found by zhuo-hao.lee@intel.com
> 
> v2: remove unnecessary extra check for chip init (libin)
> 
> Signed-off-by: U. Artie Eoff <ullysses.a.eoff@intel.com>
> ---
>  sound/pci/hda/hda_intel.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> index b729b25a6ad6..15d4e28fc64e 100644
> --- a/sound/pci/hda/hda_intel.c
> +++ b/sound/pci/hda/hda_intel.c
> @@ -1017,17 +1017,19 @@ static int azx_runtime_idle(struct device
> *dev)
>  	struct snd_card *card = dev_get_drvdata(dev);
>  	struct azx *chip;
>  	struct hda_intel *hda;
> +	struct hdac_bus *bus;
> 
>  	if (!card)
>  		return 0;
> 
>  	chip = card->private_data;
>  	hda = container_of(chip, struct hda_intel, chip);
> +	bus = azx_bus(chip);
>  	if (chip->disabled || hda->init_failed || !chip->running)

I mean we don't need '!chip->running' either. Otherwise,
initialization may be interrupted.

>  		return 0;
> 
>  	if (!power_save_controller || !azx_has_pm_runtime(chip) ||
> -	    azx_bus(chip)->codec_powered)
> +	    bus->codec_powered || !bus->chip_init)
>  		return -EBUSY;
> 
>  	return 0;
> --
> 1.9.3
