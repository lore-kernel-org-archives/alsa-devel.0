From: Jani Nikula <jani.nikula@intel.com>
Subject: Re: [PATCH v2 1/2] drm/i915: provide interface for
	audio	driver to query cdclk
Date: Thu, 03 Jul 2014 10:32:38 +0300
Message-ID: <87mwcqew2x.fsf@intel.com>
References: <1404363651-4388-1-git-send-email-mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <1404363651-4388-1-git-send-email-mengdong.lin@intel.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: mengdong.lin@intel.com, alsa-devel@alsa-project.org, tiwai@suse.de, intel-gfx@lists.freedesktop.org
List-Id: alsa-devel@alsa-project.org

On Thu, 03 Jul 2014, mengdong.lin@intel.com wrote:
> From: Jani Nikula <jani.nikula@intel.com>

I wrote this as a quick hack patch to try as an alternative to [1] which
ended up not working on Haswell. Please reassure me that this is going
to be a temporary solution until we get a more generic interface between
the audio and display drivers. I don't much like this, but at least it's
isolated and small.

I'd like the commit message amended with something like:

"""
If the display power well has been disabled, the display audio
controller divider values EM4 MVALUE and EM5 NVALUE will have been
lost. The CDCLK frequency is required for reprogramming them. Provide a
private interface for the audio driver to query CDCLK.

This is a stopgap solution until a more generic interface between audio
and display drivers has been implemented.
"""

I'd also like to have an additional Reviewed-by from the i915
side. After that, I'm fine with merging this through alsa.

BR,
Jani.


[1] http://mid.gmane.org/cover.1404222047.git.jani.nikula@intel.com


>
> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
> Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>
>
> diff --git a/drivers/gpu/drm/i915/intel_pm.c b/drivers/gpu/drm/i915/intel_pm.c
> index a90fdbd..21170e5 100644
> --- a/drivers/gpu/drm/i915/intel_pm.c
> +++ b/drivers/gpu/drm/i915/intel_pm.c
> @@ -6256,6 +6256,27 @@ int i915_release_power_well(void)
>  }
>  EXPORT_SYMBOL_GPL(i915_release_power_well);
>  
> +/*
> + * Private interface for the audio driver to get CDCLK in kHz.
> + *
> + * Caller must request power well using i915_request_power_well() prior to
> + * making the call.
> + */
> +int i915_get_cdclk_freq(void)
> +{
> +	struct drm_i915_private *dev_priv;
> +
> +	if (!hsw_pwr)
> +		return -ENODEV;
> +
> +	dev_priv = container_of(hsw_pwr, struct drm_i915_private,
> +				power_domains);
> +
> +	return intel_ddi_get_cdclk_freq(dev_priv);
> +}
> +EXPORT_SYMBOL_GPL(i915_get_cdclk_freq);
> +
> +
>  #define POWER_DOMAIN_MASK (BIT(POWER_DOMAIN_NUM) - 1)
>  
>  #define HSW_ALWAYS_ON_POWER_DOMAINS (			\
> diff --git a/include/drm/i915_powerwell.h b/include/drm/i915_powerwell.h
> index 2baba99..baa6f11 100644
> --- a/include/drm/i915_powerwell.h
> +++ b/include/drm/i915_powerwell.h
> @@ -32,5 +32,6 @@
>  /* For use by hda_i915 driver */
>  extern int i915_request_power_well(void);
>  extern int i915_release_power_well(void);
> +extern int i915_get_cdclk_freq(void);
>  
>  #endif				/* _I915_POWERWELL_H_ */
> -- 
> 1.8.1.2
>
> _______________________________________________
> Intel-gfx mailing list
> Intel-gfx@lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/intel-gfx

-- 
Jani Nikula, Intel Open Source Technology Center
