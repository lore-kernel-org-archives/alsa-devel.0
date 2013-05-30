From: "Wang, Xingchao" <xingchao.wang@intel.com>
Subject: Re: [PATCH 4/4 V6] i915/drm: Add private api for power
 well usage
Date: Thu, 30 May 2013 11:21:50 +0000
Message-ID: <46B810F6945F7C4788E11DCE57EC48901181A427@SHSMSX104.ccr.corp.intel.com>
References: <1369646116-11942-1-git-send-email-xingchao.wang@linux.intel.com>
	<1369646116-11942-5-git-send-email-xingchao.wang@linux.intel.com>
	<20130529181030.GA29716@strange.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <20130529181030.GA29716@strange.amr.corp.intel.com>
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
To: "Lespiau, Damien" <damien.lespiau@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "tiwai@suse.de" <tiwai@suse.de>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "Li,
	Jocelyn" <jocelyn.li@intel.com>, "Girdwood,
	Liam R" <liam.r.girdwood@intel.com>, "david.henningsson@canonical.com" <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Hi Damien,

Thanks your review, comments inline. :)


> -----Original Message-----
> From: intel-gfx-bounces+xingchao.wang=intel.com@lists.freedesktop.org
> [mailto:intel-gfx-bounces+xingchao.wang=intel.com@lists.freedesktop.org] On
> Behalf Of Damien Lespiau
> Sent: Thursday, May 30, 2013 2:11 AM
> To: Wang Xingchao
> Cc: alsa-devel@alsa-project.org; Girdwood, Liam R; tiwai@suse.de;
> intel-gfx@lists.freedesktop.org; Li, Jocelyn; david.henningsson@canonical.com
> Subject: Re: [Intel-gfx] [PATCH 4/4 V6] i915/drm: Add private api for power well
> usage
> 
> On Mon, May 27, 2013 at 05:15:16PM +0800, Wang Xingchao wrote:
> > Haswell Display audio depends on power well in graphic side, it should
> > request power well before use it and release power well after use.
> > I915 will not shutdown power well if it detects audio is using.
> > This patch protects display audio crash for Intel Haswell C3 stepping board.
> >
> > Signed-off-by: Wang Xingchao <xingchao.wang@linux.intel.com>
> 
> Daniel, you probably want to give your opinion on the "2 APIs to manage the
> power well" discussion below.
> 
> In case, the logic seems correct so: with or without the two nitpicks below
> (that we can address later if deemed necessary):
> 
> Reviewed-by: Damien Lespiau <damien.lespiau@intel.com>
> 
> --
> Damien
> 
> > ---
> >  drivers/gpu/drm/i915/i915_dma.c  |    6 +++
> >  drivers/gpu/drm/i915/i915_drv.h  |   12 +++++
> >  drivers/gpu/drm/i915/intel_drv.h |    4 ++
> >  drivers/gpu/drm/i915/intel_pm.c  |   92
> +++++++++++++++++++++++++++++++++++---
> >  include/drm/i915_powerwell.h     |   36 +++++++++++++++
> >  5 files changed, 143 insertions(+), 7 deletions(-)  create mode
> > 100644 include/drm/i915_powerwell.h
> >
> > diff --git a/drivers/gpu/drm/i915/i915_dma.c
> > b/drivers/gpu/drm/i915/i915_dma.c index f5addac..b702915 100644
> > --- a/drivers/gpu/drm/i915/i915_dma.c
> > +++ b/drivers/gpu/drm/i915/i915_dma.c
> > @@ -1652,6 +1652,9 @@ int i915_driver_load(struct drm_device *dev,
> unsigned long flags)
> >  	/* Start out suspended */
> >  	dev_priv->mm.suspended = 1;
> >
> > +	if (IS_HASWELL(dev))
> > +		i915_init_power_well(dev);
> > +
> >  	if (drm_core_check_feature(dev, DRIVER_MODESET)) {
> >  		ret = i915_load_modeset_init(dev);
> >  		if (ret < 0) {
> > @@ -1708,6 +1711,9 @@ int i915_driver_unload(struct drm_device *dev)
> >
> >  	intel_gpu_ips_teardown();
> >
> > +	if (IS_HASWELL(dev))
> > +		i915_remove_power_well(dev);
> > +
> >  	i915_teardown_sysfs(dev);
> >
> >  	if (dev_priv->mm.inactive_shrinker.shrink)
> > diff --git a/drivers/gpu/drm/i915/i915_drv.h
> > b/drivers/gpu/drm/i915/i915_drv.h index 14817de..ea94e5e 100644
> > --- a/drivers/gpu/drm/i915/i915_drv.h
> > +++ b/drivers/gpu/drm/i915/i915_drv.h
> > @@ -720,6 +720,15 @@ struct intel_ilk_power_mgmt {
> >  	struct drm_i915_gem_object *renderctx;  };
> >
> > +/* Power well structure for haswell */ struct i915_power_well {
> > +	struct drm_device *device;
> > +	spinlock_t lock;
> > +	/* power well enable/disable usage count */
> > +	int count;
> > +	int i915_request;
> > +};
> > +
> >  struct i915_dri1_state {
> >  	unsigned allow_batchbuffer : 1;
> >  	u32 __iomem *gfx_hws_cpu_addr;
> > @@ -1073,6 +1082,9 @@ typedef struct drm_i915_private {
> >  	 * mchdev_lock in intel_pm.c */
> >  	struct intel_ilk_power_mgmt ips;
> >
> > +	/* Haswell power well */
> > +	struct i915_power_well *hsw_pwr;
> > +
> 
> We usually just put the structure inside struct drm_i915_private and pass it's
> pointer around instead of an allocation for a few bytes.
> 
> We also try quite hard to not be platform specific but feature specific in our
> code (eg. HAS_POWER_WELL() and not IS_HASWELL()). hsw_pwr should
> probably be renamed to power_well.

Good point. I will make changes accordingly in next version.

> 
> >  	enum no_fbc_reason no_fbc_reason;
> >
> >  	struct drm_mm_node *compressed_fb;
> > diff --git a/drivers/gpu/drm/i915/intel_drv.h
> > b/drivers/gpu/drm/i915/intel_drv.h
> > index 0f35545..8b5017d 100644
> > --- a/drivers/gpu/drm/i915/intel_drv.h
> > +++ b/drivers/gpu/drm/i915/intel_drv.h
> > @@ -754,6 +754,10 @@ extern void intel_update_fbc(struct drm_device
> > *dev);  extern void intel_gpu_ips_init(struct drm_i915_private
> > *dev_priv);  extern void intel_gpu_ips_teardown(void);
> >
> > +/* Power well */
> > +extern int i915_init_power_well(struct drm_device *dev); extern void
> > +i915_remove_power_well(struct drm_device *dev);
> > +
> >  extern bool intel_display_power_enabled(struct drm_device *dev,
> >  					enum intel_display_power_domain domain);  extern
> void
> > intel_init_power_well(struct drm_device *dev); diff --git
> > a/drivers/gpu/drm/i915/intel_pm.c b/drivers/gpu/drm/i915/intel_pm.c
> > index 1a76572..f429347 100644
> > --- a/drivers/gpu/drm/i915/intel_pm.c
> > +++ b/drivers/gpu/drm/i915/intel_pm.c
> > @@ -4502,18 +4502,12 @@ bool intel_display_power_enabled(struct
> drm_device *dev,
> >  	}
> >  }
> >
> > -void intel_set_power_well(struct drm_device *dev, bool enable)
> > +static void __intel_set_power_well(struct drm_device *dev, bool
> > +enable)
> >  {
> >  	struct drm_i915_private *dev_priv = dev->dev_private;
> >  	bool is_enabled, enable_requested;
> >  	uint32_t tmp;
> >
> > -	if (!HAS_POWER_WELL(dev))
> > -		return;
> > -
> > -	if (!i915_disable_power_well && !enable)
> > -		return;
> > -
> >  	tmp = I915_READ(HSW_PWR_WELL_DRIVER);
> >  	is_enabled = tmp & HSW_PWR_WELL_STATE;
> >  	enable_requested = tmp & HSW_PWR_WELL_ENABLE; @@ -4536,6
> +4530,90 @@
> > void intel_set_power_well(struct drm_device *dev, bool enable)
> >  	}
> >  }
> >
> > +static struct i915_power_well *hsw_pwr;
> > +
> > +/* Display audio driver power well request */ void
> > +i915_request_power_well(void) {
> > +	if (hsw_pwr == NULL)
> > +		return;
> > +
> > +	spin_lock_irq(&hsw_pwr->lock);
> > +	if (!hsw_pwr->count++ &&
> > +			!hsw_pwr->i915_request)
> > +		__intel_set_power_well(hsw_pwr->device, true);
> > +	spin_unlock_irq(&hsw_pwr->lock);
> > +}
> > +EXPORT_SYMBOL_GPL(i915_request_power_well);
> > +
> > +/* Display audio driver power well release */ void
> > +i915_release_power_well(void) {
> > +	if (hsw_pwr == NULL)
> > +		return;
> > +
> > +	spin_lock_irq(&hsw_pwr->lock);
> > +	WARN_ON(!hsw_pwr->count);
> > +	if (!--hsw_pwr->count &&
> > +		       !hsw_pwr->i915_request)
> > +		__intel_set_power_well(hsw_pwr->device, false);
> > +	spin_unlock_irq(&hsw_pwr->lock);
> > +}
> > +EXPORT_SYMBOL_GPL(i915_release_power_well);
> > +
> > +int i915_init_power_well(struct drm_device *dev) {
> > +	struct drm_i915_private *dev_priv = dev->dev_private;
> > +
> > +	hsw_pwr = kzalloc(sizeof *hsw_pwr, GFP_KERNEL);
> > +	if (hsw_pwr == NULL)
> > +		return -ENOMEM;
> > +
> > +	dev_priv->hsw_pwr = hsw_pwr;
> > +
> > +	hsw_pwr->device = dev;
> > +	spin_lock_init(&hsw_pwr->lock);
> > +	hsw_pwr->count = 0;
> > +
> > +	return 0;
> > +}
> > +
> > +void i915_remove_power_well(struct drm_device *dev) {
> > +	struct drm_i915_private *dev_priv = dev->dev_private;
> > +
> > +	kfree(dev_priv->hsw_pwr);
> > +	dev_priv->hsw_pwr = NULL;
> > +	hsw_pwr = NULL;
> > +}
> > +
> > +void intel_set_power_well(struct drm_device *dev, bool enable) {
> > +	struct drm_i915_private *dev_priv = dev->dev_private;
> > +	struct i915_power_well *power_well = dev_priv->hsw_pwr;
> > +
> > +	if (!HAS_POWER_WELL(dev))
> > +		return;
> > +
> > +	if (!i915_disable_power_well && !enable)
> > +		return;
> > +
> > +	if (!power_well)
> > +		return;
> > +
> > +	spin_lock_irq(&power_well->lock);
> > +	power_well->i915_request = enable;
> > +
> > +	/* only reject "disable" power well request */
> > +	if (power_well->count && !enable) {
> > +		spin_unlock_irq(&power_well->lock);
> > +		return;
> > +	}
> > +
> > +	__intel_set_power_well(dev, enable);
> > +	spin_unlock_irq(&power_well->lock);
> > +}
> > +
> 
> Based on your previous feedback it seems that we don't yet have a balanced
> number of calls to set_power_well() in the i915 driver (we didn't need to), so
> blindy replacing the set_power_well() calls get
> get()/put() doesn't work.

Yes that's true. That's why we introduce "i915_request" for protection. We can make
sure the audio side calling the APIs in balanced way but cannot guanrantee gfx side.
In fact it would shut down power well from gfx side without such protection, and audio driver
become unaccessible after losing power.

> 
> We probably want that to work at some point, but it needs someone to have a
> look at where we want to put the callers on our side.
> 
> I think we can live with the transition period where we have these two APIs,
> until we go back and fix this on the i915 side. But Daniel may be of a different
> opinion.
> 
> On a side note, could you describe your test case so we can check we're not
> regressing while doing some refactoring?

I tested the cases with Haswell eDP enabled(you can test with HDMI/DP monitor or else).
Please note you should test in below three ways to make sure power-well is working well along with audio.

Test 1: Bootup test
The patchset could fix dependency between i915 module and snd_hda_intel module. In case i915 module loaded
after snd_hda_i915, audio driver would try to load i915 module manually and make sure the symbol exported from
gfx side exist.

After bootup, Please check step 4 at below "Test 2", make sure the codec info are there.

Test 2: runtime test
Audio side would enter runtime suspend mode automatically and release power-well to avoid causing too 
Much power usage. And when exit from suspend mode, it would request power-well if it was shutdown.

1). enable power well feature by:
Echo 1 > /sys/module/i915/parameters/disable_power_well

2). enable auto-power save in audio driver side:
Echo 5 > /sys/module/snd_hda_intel/parameters/power_save
(means codec would enter suspend mode after "5" seconds)

3).HSW HD-A controller and codec would enter runtime suspend mode

4) cat /proc/asound/card0/codec#0
Check the full codec info,there should be eight node, like:

cat /proc/asound/card0/codec#0 |grep Node
Node 0x02 [Audio Output] wcaps 0x6611: 8-Channels Digital
Node 0x03 [Audio Output] wcaps 0x6611: 8-Channels Digital
Node 0x04 [Audio Output] wcaps 0x6611: 8-Channels Digital
Node 0x05 [Pin Complex] wcaps 0x40778d: 8-Channels Digital Amp-Out CP
Node 0x06 [Pin Complex] wcaps 0x40778d: 8-Channels Digital Amp-Out CP
Node 0x07 [Pin Complex] wcaps 0x40778d: 8-Channels Digital Amp-Out CP
Node 0x08 [Vendor Defined Widget] wcaps 0xf00000: Mono

Test 3: suspend/resume test 

Echo mem > /sys/power/state

Check codec info when exit from suspend. In the resume routine, if power-well
Was shutdown, audio driver would try to request power-well on.

(Also you can play audio on display port as test case)

> 
> >  /*
> >   * Starting with Haswell, we have a "Power Down Well" that can be turned
> off
> >   * when not needed anymore. We have 4 registers that can request the
> > power well diff --git a/include/drm/i915_powerwell.h
> > b/include/drm/i915_powerwell.h new file mode 100644 index
> > 0000000..cfdc884
> > --- /dev/null
> > +++ b/include/drm/i915_powerwell.h
> > @@ -0,0 +1,36 @@
> >
> +/**************************************************************
> ******
> > +******
> > + *
> > + * Copyright 2013 Intel Inc.  > + * All Rights Reserved.
> > + *
> > + * Permission is hereby granted, free of charge, to any person
> > +obtaining a
> > + * copy of this software and associated documentation files (the
> > + * "Software"), to deal in the Software without restriction,
> > +including
> > + * without limitation the rights to use, copy, modify, merge,
> > +publish,
> > + * distribute, sub license, and/or sell copies of the Software, and
> > +to
> > + * permit persons to whom the Software is furnished to do so, subject
> > +to
> > + * the following conditions:
> > + *
> > + * The above copyright notice and this permission notice (including
> > +the
> > + * next paragraph) shall be included in all copies or substantial
> > +portions
> > + * of the Software.
> > + *
> > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY
> KIND,
> > +EXPRESS OR
> > + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> > +MERCHANTABILITY,
> > + * FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO
> EVENT
> > +SHALL
> > + * THE COPYRIGHT HOLDERS, AUTHORS AND/OR ITS SUPPLIERS BE LIABLE
> FOR
> > +ANY CLAIM,
> > + * DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
> TORT
> > +OR
> > + * OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
> SOFTWARE
> > +OR THE
> > + * USE OR OTHER DEALINGS IN THE SOFTWARE.
> > + *
> > + *
> > +
> >
> +***************************************************************
> ******
> > +*****/
> > +
> > +#ifndef _I915_POWERWELL_H_
> > +#define _I915_POWERWELL_H_
> > +
> > +/* For use by hda_i915 driver */
> > +extern void i915_request_power_well(void); extern void
> > +i915_release_power_well(void);
> 
> Note that, to be fully future proof, this interface is likely to change to add an
> enum intel_display_power_domain parameter (and add another power domain
> enum for Audio). We don't need to do that now, but a patch will follow at some
> point (and probably from me), you've been warned :)
> 

I see. please cc me when you send out the patch. :)
I can help test then and make sure audio works well.
Also if audio side need further improvement, we can cowork then.

Thanks
--xingchao 
