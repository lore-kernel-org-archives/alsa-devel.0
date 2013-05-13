From: "Wang, Xingchao" <xingchao.wang@intel.com>
Subject: Re: [alsa-devel] [PATCH 5/5] ALSA/i915: Check power
 well API existense before calling
Date: Mon, 13 May 2013 11:55:14 +0000
Message-ID: <46B810F6945F7C4788E11DCE57EC489010E5C1B8@SHSMSX102.ccr.corp.intel.com>
References: <1368430648-2353-1-git-send-email-xingchao.wang@linux.intel.com>
	<1368430648-2353-6-git-send-email-xingchao.wang@linux.intel.com>
	<5190A43B.8040106@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <5190A43B.8040106@canonical.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
Errors-To: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
To: David Henningsson <david.henningsson@canonical.com>, Wang Xingchao <xingchao.wang@linux.intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Girdwood,
	Liam R" <liam.r.girdwood@intel.com>, "tiwai@suse.de" <tiwai@suse.de>, "Lin, Mengdong" <mengdong.lin@intel.com>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "Li, Jocelyn" <jocelyn.li@intel.com>, "Barnes,
	Jesse" <jesse.barnes@intel.com>, "Zanoni,
	Paulo R" <paulo.r.zanoni@intel.com>
List-Id: alsa-devel@alsa-project.org

Hi David,


> -----Original Message-----
> From: alsa-devel-bounces@alsa-project.org
> [mailto:alsa-devel-bounces@alsa-project.org] On Behalf Of David Henningsson
> Sent: Monday, May 13, 2013 4:29 PM
> To: Wang Xingchao
> Cc: alsa-devel@alsa-project.org; daniel@ffwll.ch; tiwai@suse.de; Lin,
> Mengdong; intel-gfx@lists.freedesktop.org; Li, Jocelyn; Barnes, Jesse;
> Girdwood, Liam R; Zanoni, Paulo R
> Subject: Re: [alsa-devel] [PATCH 5/5] ALSA/i915: Check power well API
> existense before calling
> 
> On 05/13/2013 09:37 AM, Wang Xingchao wrote:
> > I915 module maybe loaded after snd_hda_intel, the power-well API
> > doesnot exist in such case. This patch intended to avoid loading
> > dependency between snd-hda-intel and i915 module.
> 
> Hi Xingchao and thanks for working on this.
> 
> This patch seems to re-do some of the work done in other patches (a lot of lines
> removed), so it's a little hard to follow. But I'll try to write some overall
> comments on how I have envisioned things...
> 
> 1. I don't think there's any need to create an additional kernel module, we can
> just let hda_i915.c be in the snd-hda-intel.ko module, and only compile it if
> DRM_I915 is defined.
> 
> 2. We don't need an IS_HSW macro on the audio side. Instead declare a new
> AZX_DCAPS_NEED_I915_POWER (or similar) driver quirk.
> 
> 3. Somewhere in the beginning of the probing in hda_intel.c, we'll need
> something like:
> 
> if (driver_caps & AZX_DCAPS_NEED_I915_POWER)
>    hda_i915_init(chip);
> 
> 4. The hda_i915_init does not need to be exported (they're now both in the
> same module). hda_i915.h could have something like:
> 
> #ifdef DRM_I915
>    void hda_i915_init(chip);
> #else
>    #define hda_i915_init(chip) do {} while(0) #endif

Thanks your suggestions. Will change them in next version.
> 
> 5. You're saying this patch is about avoid loading dependency between
> snd-hda-intel and i915 module. That does not make sense to me, since the
> powerwell API is in the i915 module, snd-hda-intel must load it when it wants to
> enable power on haswell, right? Thus there is a loading dependency. If the i915
> module is not loaded at that point, we must wait for it to load, so we can have
> proper power, instead of continuing probing without the power well?
> 

If i915 module not loaded, snd-had-intel will load it in current code. 
The question is the tolerant delay of waiting for i915 loading.
Continuing probing would immediately fail. 

Thanks
--xingchao
 
> >
> > Signed-off-by: Wang Xingchao <xingchao.wang@linux.intel.com>
> > ---
> >   drivers/gpu/drm/i915/i915_dma.c  |    3 ++
> >   drivers/gpu/drm/i915/intel_drv.h |    2 ++
> >   drivers/gpu/drm/i915/intel_pm.c  |   12 +++++++
> >   include/drm/i915_powerwell.h     |    1 +
> >   sound/pci/hda/hda_i915.c         |   69
> ++++++++++++++++++++++++--------------
> >   sound/pci/hda/hda_i915.h         |    5 +++
> >   sound/pci/hda/hda_intel.c        |    8 +++--
> >   7 files changed, 72 insertions(+), 28 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/i915/i915_dma.c
> > b/drivers/gpu/drm/i915/i915_dma.c index a1648eb..307ca4b 100644
> > --- a/drivers/gpu/drm/i915/i915_dma.c
> > +++ b/drivers/gpu/drm/i915/i915_dma.c
> > @@ -1671,6 +1671,9 @@ int i915_driver_load(struct drm_device *dev,
> unsigned long flags)
> >   	if (IS_GEN5(dev))
> >   		intel_gpu_ips_init(dev_priv);
> >
> > +	if (IS_HASWELL(dev))
> > +		intel_gpu_audio_init();
> > +
> >   	return 0;
> >
> >   out_gem_unload:
> > diff --git a/drivers/gpu/drm/i915/intel_drv.h
> > b/drivers/gpu/drm/i915/intel_drv.h
> > index dfcf546..f159f12 100644
> > --- a/drivers/gpu/drm/i915/intel_drv.h
> > +++ b/drivers/gpu/drm/i915/intel_drv.h
> > @@ -758,6 +758,8 @@ extern void intel_update_fbc(struct drm_device
> *dev);
> >   /* IPS */
> >   extern void intel_gpu_ips_init(struct drm_i915_private *dev_priv);
> >   extern void intel_gpu_ips_teardown(void);
> > +/* Display audio */
> > +extern void intel_gpu_audio_init(void);
> >
> >   extern bool intel_using_power_well(struct drm_device *dev);
> >   extern void intel_init_power_well(struct drm_device *dev); diff
> > --git a/drivers/gpu/drm/i915/intel_pm.c
> > b/drivers/gpu/drm/i915/intel_pm.c index 642c4b6..8c1df21 100644
> > --- a/drivers/gpu/drm/i915/intel_pm.c
> > +++ b/drivers/gpu/drm/i915/intel_pm.c
> > @@ -29,6 +29,7 @@
> >   #include "i915_drv.h"
> >   #include "intel_drv.h"
> >   #include "../../../platform/x86/intel_ips.h"
> > +#include "../../../../sound/pci/hda/hda_i915.h"
> >   #include <linux/module.h>
> >
> >   #define FORCEWAKE_ACK_TIMEOUT_MS 2
> > @@ -4393,6 +4394,17 @@ struct i915_power_well_user {
> >   	struct list_head list;
> >   };
> >
> > +void intel_gpu_audio_init(void)
> > +{
> > +	void (*link)(void);
> > +
> > +	link = symbol_get(audio_link_to_i915_driver);
> > +	if (link) {
> > +		link();
> > +		symbol_put(audio_link_to_i915_driver);
> > +	}
> > +}
> > +
> >   void i915_request_power_well(const char *name)
> >   {
> >   	struct i915_power_well_user *user;
> > diff --git a/include/drm/i915_powerwell.h
> > b/include/drm/i915_powerwell.h index 87e0a2e..de03dc8 100644
> > --- a/include/drm/i915_powerwell.h
> > +++ b/include/drm/i915_powerwell.h
> > @@ -33,6 +33,7 @@
> >   #ifndef _I915_POWERWELL_H_
> >   #define _I915_POWERWELL_H_
> >
> > +/* For use by hda_i915 driver */
> >   extern void i915_request_power_well(const char *name);
> >   extern void i915_release_power_well(const char *name);
> >
> > diff --git a/sound/pci/hda/hda_i915.c b/sound/pci/hda/hda_i915.c index
> > edf1a08..d11f255 100644
> > --- a/sound/pci/hda/hda_i915.c
> > +++ b/sound/pci/hda/hda_i915.c
> > @@ -22,54 +22,71 @@
> >   #include <drm/i915_powerwell.h>
> >   #include "hda_i915.h"
> >
> > -const char *name = "i915";
> > -static void (*get_power)(const char *name); -static void
> > (*put_power)(const char *name);
> > +char *module_name = "i915";
> > +void (*get_power)(const char *);
> > +void (*put_power)(const char *);
> > +static bool hsw_i915_load;
> > +
> > +void audio_link_to_i915_driver(void)
> > +{
> > +	/* it's time to try getting the symbols again.*/
> > +	hsw_i915_load = true;
> > +}
> > +EXPORT_SYMBOL_GPL(audio_link_to_i915_driver);
> >
> >   /* Power well has impact on Haswell controller and codecs */
> >   void hda_display_power(bool enable)
> >   {
> > -	snd_printk(KERN_INFO "HDA display power %s \n", enable ? "Enable" :
> "Disable");
> > -
> > -	if (!get_power || !put_power)
> > -		return;
> > +	if (!get_power || !put_power) {
> > +		if (hsw_i915_load) {
> > +			get_power = i915_request_power_well;
> > +			put_power = i915_release_power_well;
> > +		} else
> > +			return;
> > +	}
> >
> > +	snd_printk(KERN_DEBUG "HDA display power %s \n",
> > +			enable ? "Enable" : "Disable");
> >   	if (enable)
> >   		get_power("hda");
> >   	else
> >   		put_power("hda");
> >   }
> > -EXPORT_SYMBOL(hda_display_power);
> > +EXPORT_SYMBOL_GPL(hda_display_power);
> >
> > -static int __init hda_i915_init(void)
> > +/* In case i915 module loaded first, the APIs are there.
> > + * Otherwise wait until i915 module notify us. */ int
> > +hda_i915_init(void)
> >   {
> > -	struct module *i915;
> > -	mutex_lock(&module_mutex);
> > -	i915 = find_module(name);
> > -	mutex_unlock(&module_mutex);
> > +	struct module *i915;
> >
> > -	if (!i915)
> > -		request_module_nowait(name);
> > +	mutex_lock(&module_mutex);
> > +	i915 = find_module(module_name);
> > +	mutex_unlock(&module_mutex);
> >
> > -	if (!try_module_get(i915))
> > -		return -EFAULT;
> > +	if (!i915)
> > +		request_module_nowait(module_name);
> >
> >   	get_power = symbol_get(i915_request_power_well);
> > +	if (!get_power)
> > +		goto out;
> > +
> >   	put_power = symbol_get(i915_release_power_well);
> > +	if (!put_power)
> > +		goto out;
> >
> > -	module_put(i915);
> > +	snd_printk(KERN_DEBUG "HDA driver get symbol successfully from i915
> > +module\n");
> > +out:
> >   	return 0;
> >   }
> > +EXPORT_SYMBOL_GPL(hda_i915_init);
> >
> > -#if 0
> > -static void __exit hda_i915_exit(void)
> > +int hda_i915_exit(void)
> >   {
> > -	drm_pci_exit(&driver, &i915_pci_driver);
> > +	symbol_put(i915_request_power_well);
> > +	symbol_put(i915_release_power_well);
> >   }
> > +EXPORT_SYMBOL_GPL(hda_i915_exit);
> >
> > -module_init(hda_i915_init);
> > -module_exit(hda_i915_exit);
> > -#endif
> > -module_init(hda_i915_init);
> > -MODULE_DESCRIPTION("HDA power well");
> > +MODULE_DESCRIPTION("HDA power well For Haswell");
> >   MODULE_LICENSE("GPL");
> > diff --git a/sound/pci/hda/hda_i915.h b/sound/pci/hda/hda_i915.h index
> > a7e5324..b0516ab 100644
> > --- a/sound/pci/hda/hda_i915.h
> > +++ b/sound/pci/hda/hda_i915.h
> > @@ -3,8 +3,13 @@
> >
> >   #ifdef CONFIG_SND_HDA_I915
> >   void hda_display_power(bool enable);
> > +int hda_i915_init(void);
> > +int hda_i915_exit(void);
> >   #else
> >   void hda_display_power(bool enable) {}
> > +int hda_i915_init(void) {}
> > +int hda_i915_exit(void) {}
> >   #endif
> >
> > +void audio_link_to_i915_driver(void);
> >   #endif
> > diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> > index 8bb6075..431027d 100644
> > --- a/sound/pci/hda/hda_intel.c
> > +++ b/sound/pci/hda/hda_intel.c
> > @@ -3684,8 +3684,10 @@ static int azx_probe(struct pci_dev *pci,
> >   		return -ENOENT;
> >   	}
> >
> > -	if (IS_HSW(pci))
> > +	if (IS_HSW(pci)) {
> > +		hda_i915_init();
> >   		hda_display_power(true);
> > +	}
> >
> >   	err = snd_card_create(index[dev], id[dev], THIS_MODULE, 0, &card);
> >   	if (err < 0) {
> > @@ -3822,8 +3824,10 @@ static void azx_remove(struct pci_dev *pci)
> >   	if (card)
> >   		snd_card_free(card);
> >   	pci_set_drvdata(pci, NULL);
> > -	if (IS_HSW(pci))
> > +	if (IS_HSW(pci)) {
> >   		hda_display_power(false);
> > +		hda_i915_exit();
> > +	}
> >   }
> >
> >   /* PCI IDs */
> >
> 
> 
> 
> --
> David Henningsson, Canonical Ltd.
> https://launchpad.net/~diwic
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
