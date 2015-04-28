From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH v2 3/3] ALSA: hda - implement a refcount
 for i915 power well switch
Date: Tue, 28 Apr 2015 15:09:23 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F82B8441CD@SHSMSX101.ccr.corp.intel.com>
References: <4530387c0b63ccfafb5dbb3399a39b4093651c48.1429880424.git.mengdong.lin@intel.com>
 <1430224999-22271-1-git-send-email-mengdong.lin@intel.com>
 <s5hr3r4v23t.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 61F6B260603
 for <alsa-devel@alsa-project.org>; Tue, 28 Apr 2015 17:09:47 +0200 (CEST)
In-Reply-To: <s5hr3r4v23t.wl-tiwai@suse.de>
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

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Tuesday, April 28, 2015 9:01 PM

> > This is to check the refcount of audio driver and reduce calling to i915.
> 
> This has to be implemented before patch 1 & 2, I suppose.

You're right. I'll change the patch order.

> But, you don't mention about the new mutex at all.  Why do you need it?

I'll remove the mutex. 
Actually we need not this mutex for legacy HD-A at all. I'm not sure about the new SKL driver and so add a mutex. 
But since the HW power dependency is same no matter which driver is used on SKL, we could assume the new driver will also request/release power in probe and codec runtime PM ops.

Thanks
Mengdong
 
> 
> Takashi
> 
> >
> > Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>
> >
> > diff --git a/sound/pci/hda/hda_i915.c b/sound/pci/hda/hda_i915.c index
> > 52a85d8..e831691 100644
> > --- a/sound/pci/hda/hda_i915.c
> > +++ b/sound/pci/hda/hda_i915.c
> > @@ -42,11 +42,16 @@ int hda_display_power(struct hda_intel *hda, bool
> > enable)
> >
> >  	dev_dbg(&hda->chip.pci->dev, "display power %s\n",
> >  		enable ? "enable" : "disable");
> > -	if (enable)
> > -		acomp->ops->get_power(acomp->dev);
> > -	else
> > -		acomp->ops->put_power(acomp->dev);
> > -
> > +	mutex_lock(&hda->display_power.lock);
> > +	if (enable) {
> > +		if (!hda->display_power.use_count++)
> > +			acomp->ops->get_power(acomp->dev);
> > +	} else {
> > +		WARN_ON(!hda->display_power.use_count);
> > +		if (!--hda->display_power.use_count)
> > +			acomp->ops->put_power(acomp->dev);
> > +	}
> > +	mutex_unlock(&hda->display_power.lock);
> >  	return 0;
> >  }
> >
> > @@ -171,6 +176,8 @@ int hda_i915_init(struct hda_intel *hda)
> >
> >  	dev_dbg(dev, "bound to i915 component master\n");
> >
> > +	mutex_init(&hda->display_power.lock);
> > +
> >  	return 0;
> >  out_master_del:
> >  	component_master_del(dev, &hda_component_master_ops); diff --git
> > a/sound/pci/hda/hda_intel.h b/sound/pci/hda/hda_intel.h index
> > 2069898..3ca000a 100644
> > --- a/sound/pci/hda/hda_intel.h
> > +++ b/sound/pci/hda/hda_intel.h
> > @@ -19,6 +19,11 @@
> >  #include <drm/i915_component.h>
> >  #include "hda_controller.h"
> >
> > +struct i915_display_power {
> > +	struct mutex lock;
> > +	int use_count;
> > +};
> > +
> >  struct hda_intel {
> >  	struct azx chip;
> >
> > @@ -46,6 +51,7 @@ struct hda_intel {
> >
> >  	/* i915 component interface */
> >  	struct i915_audio_component audio_component;
> > +	struct i915_display_power display_power;
> >  };
> >
> >  #ifdef CONFIG_SND_HDA_I915
> > --
> > 1.9.1
> >
