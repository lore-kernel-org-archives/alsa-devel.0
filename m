From: "Wang, Xingchao" <xingchao.wang@intel.com>
Subject: Re: [PATCH 1/2] drm/915: Add private api for power
 well	usage
Date: Thu, 16 May 2013 03:32:59 +0000
Message-ID: <46B810F6945F7C4788E11DCE57EC489010E69D0C@SHSMSX102.ccr.corp.intel.com>
References: <1368531859-1943-1-git-send-email-xingchao.wang@linux.intel.com>
 <1368531859-1943-2-git-send-email-xingchao.wang@linux.intel.com>
 <s5h4ne5pwss.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id C2EDA261701
 for <alsa-devel@alsa-project.org>; Thu, 16 May 2013 05:33:12 +0200 (CEST)
In-Reply-To: <s5h4ne5pwss.wl%tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>, Wang Xingchao <xingchao.wang@linux.intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "daniel@ffwll.ch" <daniel@ffwll.ch>, "Li, Jocelyn" <jocelyn.li@intel.com>, "Lin, Mengdong" <mengdong.lin@intel.com>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "Barnes,
 Jesse" <jesse.barnes@intel.com>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>, "david.henningsson@canonical.com" <david.henningsson@canonical.com>, "Zanoni,
 Paulo R" <paulo.r.zanoni@intel.com>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,


> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Tuesday, May 14, 2013 8:32 PM
> To: Wang Xingchao
> Cc: daniel@ffwll.ch; Girdwood, Liam R; alsa-devel@alsa-project.org; Zanoni,
> Paulo R; Li, Jocelyn; Lin, Mengdong; intel-gfx@lists.freedesktop.org; Wang,
> Xingchao; Barnes, Jesse; david.henningsson@canonical.com
> Subject: Re: [alsa-devel] [PATCH 1/2] drm/915: Add private api for power well
> usage
> 
> At Tue, 14 May 2013 19:44:18 +0800,
> Wang Xingchao wrote:
> >
> > Haswell Display audio depends on power well in graphic side, it should
> > request power well before use it and release power well after use.
> > I915 will not shutdown power well if it detects audio is using.
> > This patch protects display audio crash for Intel Haswell mobile
> > C3 stepping board.
> >
> > Signed-off-by: Wang Xingchao <xingchao.wang@linux.intel.com>
> > ---
> >  drivers/gpu/drm/i915/intel_pm.c |   76
> +++++++++++++++++++++++++++++++++++----
> >  include/drm/i915_powerwell.h    |   36 +++++++++++++++++++
> >  2 files changed, 105 insertions(+), 7 deletions(-)  create mode
> > 100644 include/drm/i915_powerwell.h
> >
> > diff --git a/drivers/gpu/drm/i915/intel_pm.c
> > b/drivers/gpu/drm/i915/intel_pm.c index 0f4b46e..cf7e352 100644
> > --- a/drivers/gpu/drm/i915/intel_pm.c
> > +++ b/drivers/gpu/drm/i915/intel_pm.c
> > @@ -4344,18 +4344,12 @@ bool intel_using_power_well(struct drm_device
> *dev)
> >  		return true;
> >  }
> >
> > -void intel_set_power_well(struct drm_device *dev, bool enable)
> > +static void enable_power_well(struct drm_device *dev, bool enable)
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
> >  	enable_requested = tmp & HSW_PWR_WELL_ENABLE; @@ -4378,6
> +4372,74 @@
> > void intel_set_power_well(struct drm_device *dev, bool enable)
> >  	}
> >  }
> >
> > +/* Global drm_device for display audio drvier usage */ static struct
> > +drm_device *power_well_device;
> > +/* Lock protecting power well setting */ static
> > +DEFINE_SPINLOCK(powerwell_lock); static bool i915_power_well_using;
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
> > +	if (!hsw_power_count++) {
> > +		enable_power_well(power_well_device, true);
> > +	}
> 
> Should be
> 	if (!hsw_power_count++ && !i915_power_well_using)
> 		enable_power_well(power_well_device, true);

Fixed.

Thanks
--xingchao
