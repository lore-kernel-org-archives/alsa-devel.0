From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH] drm/i915, HD-audio: Don't continue probing when
 nomodeset is given
Date: Fri, 13 Jun 2014 18:07:06 +0200
Message-ID: <20140613160705.GT5821@phenom.ffwll.local>
References: <1402674962-18189-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <1402674962-18189-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mengdong Lin <mengdong.lin@intel.com>, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, Daniel Vetter <daniel.vetter@ffwll.ch>
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 13, 2014 at 05:56:02PM +0200, Takashi Iwai wrote:
> When a machine is booted with nomodeset option, i915 driver skips the
> whole initialization.  Meanwhile, HD-audio tries to bind wth i915 just
> by request_symbol() without knowing that the initialization was
> skipped, and eventually it hits WARN_ON() in i915_request_power_well()
> and i915_release_power_well() wrongly but still continues probing,
> even though it doesn't work at all.
> 
> In this patch, both functions are changed to return an error in case
> of uninitialized state instead of WARN_ON(), so that HD-audio driver
> can give up HDMI controller initialization at the right time.
> 
> Cc: <stable@vger.kernel.org> [3.15]
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

I guess you'll merge this through the sound tree?
-Daniel

> ---
> 
> The bug actually exists since 3.11, but this commit will be applicable
> only to recent kernels due to ALSA and i915 code changes, that's why
> marked with [3.15] for stable.
> 
>  drivers/gpu/drm/i915/intel_pm.c | 14 ++++++++------
>  include/drm/i915_powerwell.h    |  4 ++--
>  sound/pci/hda/hda_i915.c        | 12 ++++++------
>  sound/pci/hda/hda_i915.h        |  4 ++--
>  sound/pci/hda/hda_intel.c       |  7 ++++++-
>  5 files changed, 24 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/intel_pm.c b/drivers/gpu/drm/i915/intel_pm.c
> index d93dcf683e8c..0d6bd247009b 100644
> --- a/drivers/gpu/drm/i915/intel_pm.c
> +++ b/drivers/gpu/drm/i915/intel_pm.c
> @@ -5706,30 +5706,32 @@ void intel_display_power_put(struct drm_i915_private *dev_priv,
>  static struct i915_power_domains *hsw_pwr;
>  
>  /* Display audio driver power well request */
> -void i915_request_power_well(void)
> +int i915_request_power_well(void)
>  {
>  	struct drm_i915_private *dev_priv;
>  
> -	if (WARN_ON(!hsw_pwr))
> -		return;
> +	if (!hsw_pwr)
> +		return -ENODEV;
>  
>  	dev_priv = container_of(hsw_pwr, struct drm_i915_private,
>  				power_domains);
>  	intel_display_power_get(dev_priv, POWER_DOMAIN_AUDIO);
> +	return 0;
>  }
>  EXPORT_SYMBOL_GPL(i915_request_power_well);
>  
>  /* Display audio driver power well release */
> -void i915_release_power_well(void)
> +int i915_release_power_well(void)
>  {
>  	struct drm_i915_private *dev_priv;
>  
> -	if (WARN_ON(!hsw_pwr))
> -		return;
> +	if (!hsw_pwr)
> +		return -ENODEV;
>  
>  	dev_priv = container_of(hsw_pwr, struct drm_i915_private,
>  				power_domains);
>  	intel_display_power_put(dev_priv, POWER_DOMAIN_AUDIO);
> +	return 0;
>  }
>  EXPORT_SYMBOL_GPL(i915_release_power_well);
>  
> diff --git a/include/drm/i915_powerwell.h b/include/drm/i915_powerwell.h
> index cfdc884405b7..2baba9996094 100644
> --- a/include/drm/i915_powerwell.h
> +++ b/include/drm/i915_powerwell.h
> @@ -30,7 +30,7 @@
>  #define _I915_POWERWELL_H_
>  
>  /* For use by hda_i915 driver */
> -extern void i915_request_power_well(void);
> -extern void i915_release_power_well(void);
> +extern int i915_request_power_well(void);
> +extern int i915_release_power_well(void);
>  
>  #endif				/* _I915_POWERWELL_H_ */
> diff --git a/sound/pci/hda/hda_i915.c b/sound/pci/hda/hda_i915.c
> index 9d07e4edacdb..e9e8a4a4a9a1 100644
> --- a/sound/pci/hda/hda_i915.c
> +++ b/sound/pci/hda/hda_i915.c
> @@ -22,20 +22,20 @@
>  #include <drm/i915_powerwell.h>
>  #include "hda_i915.h"
>  
> -static void (*get_power)(void);
> -static void (*put_power)(void);
> +static int (*get_power)(void);
> +static int (*put_power)(void);
>  
> -void hda_display_power(bool enable)
> +int hda_display_power(bool enable)
>  {
>  	if (!get_power || !put_power)
> -		return;
> +		return -ENODEV;
>  
>  	pr_debug("HDA display power %s \n",
>  			enable ? "Enable" : "Disable");
>  	if (enable)
> -		get_power();
> +		return get_power();
>  	else
> -		put_power();
> +		return put_power();
>  }
>  
>  int hda_i915_init(void)
> diff --git a/sound/pci/hda/hda_i915.h b/sound/pci/hda/hda_i915.h
> index 5a63da2c53e5..bfd835f8f1aa 100644
> --- a/sound/pci/hda/hda_i915.h
> +++ b/sound/pci/hda/hda_i915.h
> @@ -17,11 +17,11 @@
>  #define __SOUND_HDA_I915_H
>  
>  #ifdef CONFIG_SND_HDA_I915
> -void hda_display_power(bool enable);
> +int hda_display_power(bool enable);
>  int hda_i915_init(void);
>  int hda_i915_exit(void);
>  #else
> -static inline void hda_display_power(bool enable) {}
> +static inline int hda_display_power(bool enable) { return 0; }
>  static inline int hda_i915_init(void)
>  {
>  	return -ENODEV;
> diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> index bb65a124e006..23fd6b9aecca 100644
> --- a/sound/pci/hda/hda_intel.c
> +++ b/sound/pci/hda/hda_intel.c
> @@ -1656,8 +1656,13 @@ static int azx_probe_continue(struct azx *chip)
>  				"Error request power-well from i915\n");
>  			goto out_free;
>  		}
> +		err = hda_display_power(true);
> +		if (err < 0) {
> +			dev_err(chip->card->dev,
> +				"Cannot turn on display power on i915\n");
> +			goto out_free;
> +		}
>  #endif
> -		hda_display_power(true);
>  	}
>  
>  	err = azx_first_init(chip);
> -- 
> 1.9.3
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
