From: "Yang, Libin" <libin.yang@intel.com>
Subject: Re: [PATCH v2] ALSA: hda - Fix Skylake codec timeout
Date: Thu, 16 Jul 2015 15:14:31 +0000
Message-ID: <96A12704CE18D347B625EE2D4A099D19687270@SHSMSX103.ccr.corp.intel.com>
References: <1437035964-5658-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id DB15F260574
 for <alsa-devel@alsa-project.org>; Thu, 16 Jul 2015 17:16:09 +0200 (CEST)
In-Reply-To: <1437035964-5658-1-git-send-email-david.henningsson@canonical.com>
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
To: David Henningsson <david.henningsson@canonical.com>, "tiwai@suse.de" <tiwai@suse.de>, "hui.wang@canonical.com" <hui.wang@canonical.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Lin, Mengdong" <mengdong.lin@intel.com>, "Lu, Han" <han.lu@intel.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: David Henningsson [mailto:david.henningsson@canonical.com]
> Sent: Thursday, July 16, 2015 4:39 PM
> To: tiwai@suse.de; hui.wang@canonical.com; alsa-devel@alsa-
> project.org; Yang, Libin; Lin, Mengdong
> Cc: David Henningsson
> Subject: [PATCH v2] ALSA: hda - Fix Skylake codec timeout
> 
> When the controller is powered up but the HDMI codec is powered
> down
> on Skylake, the power well is turned off. When the codec is then
> powered up again, we need to poke the codec a little extra to make
> sure it wakes up. Otherwise we'll get sad "no response from codec"
> messages and broken audio.

Thanks for finding this issue.

Could you please give us you test case? We didn't meet such issue
before. I would like do a full test on it.

> 
> This also changes azx_runtime_resume to actually call
> snd_hdac_set_codec_wakeup for Skylake (before STATETS read).
> (Otherwise it would only have been called for Haswell and Broadwell,
> which both do not need it, so this probably was not the author's
> intention.)
> 
> Signed-off-by: David Henningsson <david.henningsson@canonical.com>
> ---
>  sound/hda/hdac_i915.c     |  5 ++++-
>  sound/pci/hda/hda_intel.c | 18 ++++++++++--------
>  2 files changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/sound/hda/hdac_i915.c b/sound/hda/hdac_i915.c
> index 442500e..5676b84 100644
> --- a/sound/hda/hdac_i915.c
> +++ b/sound/hda/hdac_i915.c
> @@ -56,8 +56,11 @@ int snd_hdac_display_power(struct hdac_bus
> *bus, bool enable)
>  		enable ? "enable" : "disable");
> 
>  	if (enable) {
> -		if (!bus->i915_power_refcount++)
> +		if (!bus->i915_power_refcount++) {
>  			acomp->ops->get_power(acomp->dev);
> +			snd_hdac_set_codec_wakeup(bus, true);
> +			snd_hdac_set_codec_wakeup(bus, false);

Mostly we have called snd_hdac_set_codec_wakeup() after calling
Snd_hdac_display_power(true). It seems we missed it in the 
link_power().

I agree moving snd_hdac_set_codec_wakeup() to here is better.
I would like do a full test on this patch.

> +		}
>  	} else {
>  		WARN_ON(!bus->i915_power_refcount);
>  		if (!--bus->i915_power_refcount)
> diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> index ca151b4..9962237 100644
> --- a/sound/pci/hda/hda_intel.c
> +++ b/sound/pci/hda/hda_intel.c
> @@ -979,14 +979,16 @@ static int azx_runtime_resume(struct device
> *dev)
>  	if (!azx_has_pm_runtime(chip))
>  		return 0;
> 
> -	if (chip->driver_caps & AZX_DCAPS_I915_POWERWELL
> -		&& hda->need_i915_power) {
> -		bus =  azx_bus(chip);
> -		snd_hdac_display_power(bus, true);
> -		haswell_set_bclk(hda);
> -		/* toggle codec wakeup bit for STATESTS read */
> -		snd_hdac_set_codec_wakeup(bus, true);
> -		snd_hdac_set_codec_wakeup(bus, false);
> +	if (chip->driver_caps & AZX_DCAPS_I915_POWERWELL) {
> +		bus = azx_bus(chip);
> +		if (hda->need_i915_power) {
> +			snd_hdac_display_power(bus, true);
> +			haswell_set_bclk(hda);
> +		} else {
> +			/* toggle codec wakeup bit for STATESTS read
> */
> +			snd_hdac_set_codec_wakeup(bus, true);
> +			snd_hdac_set_codec_wakeup(bus, false);
> +		}
>  	}
> 
>  	/* Read STATESTS before controller reset */
> --
> 1.9.1
