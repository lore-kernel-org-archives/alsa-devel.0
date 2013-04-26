From: Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: [PATCH] drm/i915: Add private api for power well
 usage -- alignment between graphic team and audio team
Date: Fri, 26 Apr 2013 09:24:49 +0200
Message-ID: <CAKMK7uGZ1eK1MngbihR_+xUZZXsFQGEV3=NH1Ohjf7S0i9s2-g@mail.gmail.com>
References: <1B1032E88FFFDA4898B04D530F28DEDB53CAB7@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <1B1032E88FFFDA4898B04D530F28DEDB53CAB7@SHSMSX101.ccr.corp.intel.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
Errors-To: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
To: "Li, Jocelyn" <jocelyn.li@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Zanoni,
	Paulo R" <paulo.r.zanoni@intel.com>, Takashi Iwai <tiwai@suse.de>, "Lin,
	Mengdong" <mengdong.lin@intel.com>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Wang Xingchao <xingchao.wang@linux.intel.com>, "Hindman,
	Gavin" <gavin.hindman@intel.com>, "Barnes,
	Jesse" <jesse.barnes@intel.com>, "Girdwood,
	Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 26, 2013 at 8:58 AM, Li, Jocelyn <jocelyn.li@intel.com> wrote:
> Hi Guys,
>
> I apologize that I may have misunderstood on the agreement we have made on power well work. I assumed that audio team is expected to create private gfx driver API to control the power well between gfx and audio for internal releases. That's why I asked Xingchao work on that.

Yes, that's my understanding, too.

> So the correct implementation approach between gfx and audio should be,
>
> #1, Daniel will work on the existing private API in gfx driver for power well control that can be used by the audio driver to enable/disable the power well.
>
> #2, Once #1 is done, Audio team will integrate Daniel's patch into audio driver and add/improve on anything that is missing

That sounds backwards to me. Imo first priority should be to get the
audio driver to work with power well functionality enabled. And
Xingchao's patch looks like it should be good enough to start with
that on the audio side.

Once we've figured out what needs to be changed in the audio driver we
can look at the entire patch series and the interface to i915.ko.
That's also why I didn't comment on Xingchao's patch right away, but
only once he specifically asked for feedback, since doing a real
review of the interface doesn't make sense until we have all the
pieces (and a working audio driver).

Yours, Daniel

>
> Please correct me if my understanding is not correct.
>
> Thanks,
> Jocelyn
>
> -----Original Message-----
> From: Daniel Vetter [mailto:daniel.vetter@ffwll.ch]
> Sent: Thursday, April 25, 2013 3:52 PM
> To: Wang, Xingchao
> Cc: Zanoni, Paulo R; ville.syrjala@linux.intel.com; Lin, Mengdong; Girdwood, Liam R; Li, Jocelyn; intel-gfx@lists.freedesktop.org; alsa-devel@alsa-project.org; Wang Xingchao; Takashi Iwai; Barnes, Jesse; Wysocki, Rafael J
> Subject: Re: [PATCH] drm/i915: Add private api for power well usage
>
> On Thu, Apr 25, 2013 at 4:36 AM, Wang, Xingchao <xingchao.wang@intel.com> wrote:
>> Hi Daniel/Paulo,
>>
>> Any comments on this?
>> Add Jesse and Rafael in loop.
>
> Well I've figured we want to get the power well integration working before we waste time reviewing an interface which might or might not quite work. But if you want, I can drop two quick comments:
> - I think the functions needs some prefix like i915_
> - Imo the power well should just be reference counted (the current interface name suggests it's generally useable, but actually can only cope with one request from the audio driver).
> - Is the spin_lock (irq-disabling even) really required for the audio driver to work? power well enabling can take up to 20ms, so this won't work as-is. Can't we just use a mutex?
> - I'd need to see the audio driver side of this to check how this works for coping with arbitrary module load ordering.
>
> Cheers, Daniel
>
>>
>> thanks
>> --xingchao
>>
>>
>>> -----Original Message-----
>>> From: Wang, Xingchao
>>> Sent: Wednesday, April 24, 2013 3:29 PM
>>> To: daniel.vetter@ffwll.ch; Zanoni, Paulo R; 'Takashi Iwai'
>>> Cc: ville.syrjala@linux.intel.com; Lin, Mengdong; Girdwood, Liam R;
>>> Li, Jocelyn; intel-gfx@lists.freedesktop.org; alsa-devel@alsa-project.org; 'Wang Xingchao'
>>> Subject: RE: [PATCH] drm/i915: Add private api for power well usage
>>>
>>> Hi Guys,
>>>
>>> Sorry I should Add Takashi and alsa maillist in loop.
>>>
>>> I tested this patch against Daniel's "drm-intel-next-queued" Branch,
>>> on Haswell Mobile C3 stepping machines.
>>>
>>> Test steps:
>>> 1. only connect one monitor through HDMI cable 2. echo 1 >
>>> /sys/module/i915/parameters/disable_power_well ==> I think this could
>>> be set as 1 by default if applied my patch.
>>> 3. plug out HDMI cable
>>> 4. cat /proc/asound/card0/codec#0
>>>
>>> At step 3,  i915 will try to disable power well but rejected as
>>> display audio is using power well.
>>> Without the patch, display audio would crash at step 4.
>>>
>>> I did not list suspend/resume test here, as during suspend sequence,
>>> i915 will _ENABLE_ power well, that's a BUG?
>>>
>>> For me above test case is the only one to reproduce the issue, if you
>>> have more ideas and need more test, please let me know.
>>>
>>> I'm afraid there's some risk because the dependency between alsa
>>> driver and drm driver. For example, if i915 module was not loaded,
>>> display audio Will call
>>> request_power_well() and meet symbol error. Even if i915 module
>>> loaded after snd-hda-intel module, there's such risk too. Any comment on this?
>>>
>>> Another risk is the pointer "power_well_device", it should be set
>>> NULL when
>>> i915 module unloaded, I added the caller but have no idea where to
>>> call it, if anyone has suggestion, that would be fine.
>>>
>>> thanks
>>> --xingchao
>>>
>>>
>>> > -----Original Message-----
>>> > From: Wang Xingchao [mailto:xingchao.wang@linux.intel.com]
>>> > Sent: Thursday, April 24, 2014 10:20 PM
>>> > To: daniel.vetter@ffwll.ch; Zanoni, Paulo R
>>> > Cc: ville.syrjala@linux.intel.com; Lin, Mengdong; Girdwood, Liam R;
>>> > Li, Jocelyn; intel-gfx@lists.freedesktop.org; Wang, Xingchao; Wang
>>> > Xingchao
>>> > Subject: [PATCH] drm/i915: Add private api for power well usage
>>> >
>>> > Display audio depends on power well in graphic side, it should
>>> > request power well before use it and release power well after use.
>>> > I915 will not shutdown power well if it detects audio is using.
>>> > This patch protects display audio crash for Intel Haswell mobile
>>> > C3 stepping board.
>>> >
>>> > Signed-off-by: Wang Xingchao <xingchao.wang@linux.intel.com>
>>> > ---
>>> >  drivers/gpu/drm/i915/intel_pm.c |   73
>>> > +++++++++++++++++++++++++++++++++++----
>>> >  include/drm/audio_drm.h         |   39 +++++++++++++++++++++
>>> >  sound/pci/hda/hda_intel.c       |    8 +++++
>>> >  3 files changed, 113 insertions(+), 7 deletions(-)  create mode
>>> > 100644 include/drm/audio_drm.h
>>> >
>>> > diff --git a/drivers/gpu/drm/i915/intel_pm.c
>>> > b/drivers/gpu/drm/i915/intel_pm.c index 2557926..9983f56 100644
>>> > --- a/drivers/gpu/drm/i915/intel_pm.c
>>> > +++ b/drivers/gpu/drm/i915/intel_pm.c
>>> > @@ -4298,18 +4298,12 @@ bool intel_using_power_well(struct
>>> > drm_device
>>> > *dev)
>>> >             return true;
>>> >  }
>>> >
>>> > -void intel_set_power_well(struct drm_device *dev, bool enable)
>>> > +void set_power_well(struct drm_device *dev, bool enable)
>>> >  {
>>> >     struct drm_i915_private *dev_priv = dev->dev_private;
>>> >     bool is_enabled, enable_requested;
>>> >     uint32_t tmp;
>>> >
>>> > -   if (!HAS_POWER_WELL(dev))
>>> > -           return;
>>> > -
>>> > -   if (!i915_disable_power_well && !enable)
>>> > -           return;
>>> > -
>>> >     tmp = I915_READ(HSW_PWR_WELL_DRIVER);
>>> >     is_enabled = tmp & HSW_PWR_WELL_STATE;
>>> >     enable_requested = tmp & HSW_PWR_WELL_ENABLE; @@ -4332,6
>>> > +4326,71 @@ void intel_set_power_well(struct drm_device *dev, bool
>>> > +enable)
>>> >     }
>>> >  }
>>> >
>>> > +/* Global drm_device for display audio drvier usage */ static
>>> > +struct drm_device *power_well_device; static bool
>>> > +audio_power_well_using, i915_power_well_using;
>>> > +/* Lock protecting power well setting */
>>> > +DEFINE_SPINLOCK(powerwell_lock);
>>> > +
>>> > +void request_power_well(void)
>>> > +{
>>> > +   DRM_DEBUG_KMS("Display audio requesting power well\n");
>>> > +   spin_lock_irq(&powerwell_lock);
>>> > +   if (!power_well_device)
>>> > +           goto out;
>>> > +   if (i915_power_well_using == false)
>>> > +           set_power_well(power_well_device, true);
>>> > +   audio_power_well_using = true;
>>> > +out:
>>> > +   spin_unlock_irq(&powerwell_lock);
>>> > +   return;
>>> > +}
>>> > +EXPORT_SYMBOL_GPL(request_power_well);
>>> > +
>>> > +void release_power_well(void)
>>> > +{
>>> > +   DRM_DEBUG_KMS("Display audio releasing power well\n");
>>> > +   spin_lock_irq(&powerwell_lock);
>>> > +   if (!power_well_device)
>>> > +           goto out;
>>> > +   if (i915_power_well_using == false)
>>> > +           set_power_well(power_well_device, false);
>>> > +   audio_power_well_using = false;
>>> > +out:
>>> > +   spin_unlock_irq(&powerwell_lock);
>>> > +   return;
>>> > +}
>>> > +EXPORT_SYMBOL_GPL(release_power_well);
>>> > +
>>> > +/* TODO: Call this when i915 module unload */ void
>>> > +remove_power_well(void) {
>>> > +   spin_lock_irq(&powerwell_lock);
>>> > +   audio_power_well_using = false;
>>> > +   i915_power_well_using = false;
>>> > +   power_well_device = NULL;
>>> > +   spin_unlock_irq(&powerwell_lock); }
>>> > +
>>> > +void intel_set_power_well(struct drm_device *dev, bool enable) {
>>> > +   if (!HAS_POWER_WELL(dev))
>>> > +           return;
>>> > +
>>> > +   spin_lock_irq(&powerwell_lock);
>>> > +   power_well_device = dev;
>>> > +   i915_power_well_using = enable;
>>> > +   if (!enable && audio_power_well_using)
>>> > +           goto out;
>>> > +
>>> > +   if (!i915_disable_power_well && !enable)
>>> > +           goto out;
>>> > +   set_power_well(dev, enable);
>>> > +out:
>>> > +   spin_unlock_irq(&powerwell_lock);
>>> > +   return;
>>> > +}
>>> > +
>>> >  /*
>>> >   * Starting with Haswell, we have a "Power Down Well" that can be
>>> > turned
>>> off
>>> >   * when not needed anymore. We have 4 registers that can request
>>> > the power well diff --git a/include/drm/audio_drm.h
>>> > b/include/drm/audio_drm.h new file mode 100644 index
>>> > 0000000..4412b36
>>> > --- /dev/null
>>> > +++ b/include/drm/audio_drm.h
>>> > @@ -0,0 +1,39 @@
>>> >
>>> +/**************************************************************
>>> > ********
>>> > +****
>>> > + *
>>> > + * Copyright 2013 Intel Inc.
>>> > + * All Rights Reserved.
>>> > + *
>>> > + * Permission is hereby granted, free of charge, to any person
>>> > +obtaining a
>>> > + * copy of this software and associated documentation files (the
>>> > + * "Software"), to deal in the Software without restriction,
>>> > +including
>>> > + * without limitation the rights to use, copy, modify, merge,
>>> > +publish,
>>> > + * distribute, sub license, and/or sell copies of the Software,
>>> > +and to
>>> > + * permit persons to whom the Software is furnished to do so,
>>> > +subject to
>>> > + * the following conditions:
>>> > + *
>>> > + * The above copyright notice and this permission notice
>>> > +(including the
>>> > + * next paragraph) shall be included in all copies or substantial
>>> > +portions
>>> > + * of the Software.
>>> > + *
>>> > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY
>>> KIND,
>>> > +EXPRESS OR
>>> > + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
>>> > +MERCHANTABILITY,
>>> > + * FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO
>>> > EVENT
>>> > +SHALL
>>> > + * THE COPYRIGHT HOLDERS, AUTHORS AND/OR ITS SUPPLIERS BE LIABLE
>>> > FOR
>>> > +ANY CLAIM,
>>> > + * DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
>>> > TORT
>>> > +OR
>>> > + * OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
>>> > SOFTWARE
>>> > +OR THE
>>> > + * USE OR OTHER DEALINGS IN THE SOFTWARE.
>>> > + *
>>> > + *
>>> > +
>>> >
>>> +***************************************************************
>>> > ********
>>> > +***/
>>> > +/*
>>> > + * Authors:
>>> > + * Wang Xingchao <xingchao.wang@intel.com>  */
>>> > +
>>> > +#ifndef _AUDIO_DRM_H_
>>> > +#define _AUDIO_DRM_H_
>>> > +
>>> > +extern void request_power_well(void); extern void
>>> > +release_power_well(void);
>>> > +
>>> > +#endif                             /* _AUDIO_DRM_H_ */
>>> > diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
>>> > index 418bfc0..59a85de 100644
>>> > --- a/sound/pci/hda/hda_intel.c
>>> > +++ b/sound/pci/hda/hda_intel.c
>>> > @@ -50,6 +50,7 @@
>>> >  #include <linux/clocksource.h>
>>> >  #include <linux/time.h>
>>> >  #include <linux/completion.h>
>>> > +#include <drm/audio_drm.h>
>>> >
>>> >  #ifdef CONFIG_X86
>>> >  /* for snoop control */
>>> > @@ -2869,6 +2870,7 @@ static int azx_suspend(struct device *dev)
>>> >     pci_disable_device(pci);
>>> >     pci_save_state(pci);
>>> >     pci_set_power_state(pci, PCI_D3hot);
>>> > +   release_power_well();
>>> >     return 0;
>>> >  }
>>> >
>>> > @@ -2881,6 +2883,7 @@ static int azx_resume(struct device *dev)
>>> >     if (chip->disabled)
>>> >             return 0;
>>> >
>>> > +   request_power_well();
>>> >     pci_set_power_state(pci, PCI_D0);
>>> >     pci_restore_state(pci);
>>> >     if (pci_enable_device(pci) < 0) { @@ -2913,6 +2916,7 @@ static
>>> > int azx_runtime_suspend(struct device
>>> > *dev)
>>> >
>>> >     azx_stop_chip(chip);
>>> >     azx_clear_irq_pending(chip);
>>> > +   release_power_well();
>>> >     return 0;
>>> >  }
>>> >
>>> > @@ -2921,6 +2925,7 @@ static int azx_runtime_resume(struct device *dev)
>>> >     struct snd_card *card = dev_get_drvdata(dev);
>>> >     struct azx *chip = card->private_data;
>>> >
>>> > +   request_power_well();
>>> >     azx_init_pci(chip);
>>> >     azx_init_chip(chip, 1);
>>> >     return 0;
>>> > @@ -3671,6 +3676,8 @@ static int azx_probe(struct pci_dev *pci,
>>> >             return -ENOENT;
>>> >     }
>>> >
>>> > +   request_power_well();
>>> > +
>>> >     err = snd_card_create(index[dev], id[dev], THIS_MODULE, 0, &card);
>>> >     if (err < 0) {
>>> >             snd_printk(KERN_ERR "hda-intel: Error creating
>>> > card!\n"); @@
>>> > -3806,6 +3813,7 @@ static void azx_remove(struct pci_dev *pci)
>>> >     if (card)
>>> >             snd_card_free(card);
>>> >     pci_set_drvdata(pci, NULL);
>>> > +   release_power_well();
>>> >  }
>>> >
>>> >  /* PCI IDs */
>>> > --
>>> > 1.7.9.5
>>
>
>
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> +41 (0) 79 365 57 48 - http://blog.ffwll.ch



--
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
