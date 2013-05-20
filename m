From: "Wang, Xingchao" <xingchao.wang@intel.com>
Subject: Re: [PATCH 1/2 V3] drm/915: Add private api for power
	well usage
Date: Mon, 20 May 2013 11:35:29 +0000
Message-ID: <46B810F6945F7C4788E11DCE57EC48901181448A@SHSMSX104.ccr.corp.intel.com>
References: <1368690757-2856-1-git-send-email-xingchao.wang@linux.intel.com>
	<1368690757-2856-2-git-send-email-xingchao.wang@linux.intel.com>
	<20130517084333.2e868d7f@jbarnes-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <20130517084333.2e868d7f@jbarnes-desktop>
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
To: "Barnes, Jesse" <jesse.barnes@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "tiwai@suse.de" <tiwai@suse.de>, "Lin, Mengdong" <mengdong.lin@intel.com>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, Wang Xingchao <xingchao.wang@linux.intel.com>, "Li,
	Jocelyn" <jocelyn.li@intel.com>, "Girdwood,
	Liam R" <liam.r.girdwood@intel.com>, "david.henningsson@canonical.com" <david.henningsson@canonical.com>, "Zanoni, Paulo R" <paulo.r.zanoni@intel.com>
List-Id: alsa-devel@alsa-project.org

Hi Jesse,

> -----Original Message-----
> From: Barnes, Jesse
> Sent: Friday, May 17, 2013 11:44 PM
> To: Wang Xingchao
> Cc: tiwai@suse.de; daniel@ffwll.ch; Girdwood, Liam R;
> david.henningsson@canonical.com; Lin, Mengdong; Li, Jocelyn;
> alsa-devel@alsa-project.org; intel-gfx@lists.freedesktop.org; Zanoni, Paulo R;
> Wang, Xingchao
> Subject: Re: [PATCH 1/2 V3] drm/915: Add private api for power well usage
> 
> A few comments and questions below.
> 
> On Thu, 16 May 2013 15:52:36 +0800
> Wang Xingchao <xingchao.wang@linux.intel.com> wrote:
> 
> > Haswell Display audio depends on power well in graphic side, it should
> > request power well before use it and release power well after use.
> > I915 will not shutdown power well if it detects audio is using.
> > This patch protects display audio crash for Intel Haswell C3 stepping board.
> >
> > Signed-off-by: Wang Xingchao <xingchao.wang@linux.intel.com>
> > ---
> >  drivers/gpu/drm/i915/intel_pm.c |   75
> +++++++++++++++++++++++++++++++++++----
> >  include/drm/i915_powerwell.h    |   36 +++++++++++++++++++
> >  2 files changed, 104 insertions(+), 7 deletions(-)  create mode
> > 100644 include/drm/i915_powerwell.h
> >
> > diff --git a/drivers/gpu/drm/i915/intel_pm.c
> > b/drivers/gpu/drm/i915/intel_pm.c index 0f4b46e..88820e1 100644
> > --- a/drivers/gpu/drm/i915/intel_pm.c
> > +++ b/drivers/gpu/drm/i915/intel_pm.c
> > @@ -4344,18 +4344,12 @@ bool intel_using_power_well(struct drm_device
> *dev)
> >  		return true;
> >  }
> >
> > -void intel_set_power_well(struct drm_device *dev, bool enable)
> > +static void enable_power_well(struct drm_device *dev, bool enable)
> 
> We can leave the name of this function alone; even for static stuff we tend to
> use the intel_ prefix.  Plus it's a set function, not an enable function...  so
> maybe just put a __ in front of it to indicate it's for internal use only.
> 
> >  {
> >  	struct drm_i915_private *dev_priv = dev->dev_private;
> >  	bool is_enabled, enable_requested;
> >  	uint32_t tmp;
> >
> 
> 
> > +/* Global drm_device for display audio drvier usage */ static struct
> > +drm_device *power_well_device;
> > +/* Lock protecting power well setting */ static
> > +DEFINE_SPINLOCK(powerwell_lock); static bool i915_power_well_using;
> 
> What does this mean?  If it's just for making sure we don't use bogus
> power_well_device, it seems like we can just use a NULL check against
> power_well_device for that instead.
> 
> > +static int hsw_power_count;
> > +
> > +void i915_request_power_well(void)
> > +{
> > +	if (!power_well_device)
> > +		return;
> > +
> > +	if (!IS_HASWELL(power_well_device))
> > +		return;
> > +
> > +	spin_lock_irq(&powerwell_lock);
> > +	if (!hsw_power_count++ && !i915_power_well_using)
> > +		enable_power_well(power_well_device, true);
> > +	spin_unlock_irq(&powerwell_lock);
> > +}
> > +EXPORT_SYMBOL_GPL(i915_request_power_well);
> > +
> > +void i915_release_power_well(void)
> > +{
> > +	if (!power_well_device)
> > +		return;
> > +
> > +	if (!IS_HASWELL(power_well_device))
> > +		return;
> > +
> > +	spin_lock_irq(&powerwell_lock);
> > +	WARN_ON(!hsw_power_count);
> > +	if (!--hsw_power_count
> > +			&& !i915_power_well_using)
> > +		enable_power_well(power_well_device, false);
> > +	spin_unlock_irq(&powerwell_lock);
> > +}
> > +EXPORT_SYMBOL_GPL(i915_release_power_well);
> > +
> > +/* TODO: Call this when i915 module unload */ void
> > +i915_remove_power_well(void) {
> > +	i915_power_well_using = false;
> > +	power_well_device = NULL;
> > +}
> > +
> > +void intel_set_power_well(struct drm_device *dev, bool enable) {
> > +	if (!HAS_POWER_WELL(dev))
> > +		return;
> > +
> > +	power_well_device = dev;
> > +	spin_lock_irq(&powerwell_lock);
> > +	i915_power_well_using = enable;
> > +	if (!enable && hsw_power_count) {
> > +		DRM_DEBUG_KMS("Display audio power well busy using now\n");
> > +		goto out;
> > +	}
> > +
> > +	if (!i915_disable_power_well && !enable)
> > +		goto out;
> > +
> > +	enable_power_well(dev, enable);
> > +out:
> > +	spin_unlock_irq(&powerwell_lock);
> > +}
> 
> I think we should just set the power_well_device at module init time, then ou
> wouldn't need to check/set it here.
> 
> Also, the existing i915 code could just use the request/release functions too
> (internal versions taking a drm_device *), then you wouldn't need this special
> case.

It's not a good idea to use the same reference count to track power-well calling for both audio and i915 driver.
For audio driver the calling request/release are symmetrical, but for i915 driver it's not. 
In my test, i915 request power-well 3 times, but release power-well 5 times. That obviously caused conflicts.

> 
> > +/* For use by hda_i915 driver */
> > +extern void i915_request_power_well(void); extern void
> > +i915_release_power_well(void);
> 
> For future proofing, it might be good if these took an enum for the power well
> being requested.  Then we could track an array of refcounts later when we
> need the additional controls.
> 
> But I suppose that could be added later when we have a better idea of what
> future chips will look like.
> 
> Jesse

thanks
--xingchao
