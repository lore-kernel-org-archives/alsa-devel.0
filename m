From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [RFC PATCH 1/3] drm/915: Add private api for power
	well usage
Date: Thu, 9 May 2013 11:23:21 +0200
Message-ID: <CAKMK7uEftD9H65oxDhs1RxmjTQR+k0on1t86Ok6ZXmUJ40eYAQ@mail.gmail.com>
References: <1368082842-2537-1-git-send-email-xingchao.wang@linux.intel.com>
	<46B810F6945F7C4788E11DCE57EC489010E584A7@SHSMSX102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <46B810F6945F7C4788E11DCE57EC489010E584A7@SHSMSX102.ccr.corp.intel.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
Errors-To: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
To: "Wang, Xingchao" <xingchao.wang@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Zanoni,
	Paulo R" <paulo.r.zanoni@intel.com>, "tiwai@suse.de" <tiwai@suse.de>, "Lin,
	Mengdong" <mengdong.lin@intel.com>, intel-gfx <intel-gfx@lists.freedesktop.org>, Wang Xingchao <xingchao.wang@linux.intel.com>, "Li,
	Jocelyn" <jocelyn.li@intel.com>, "Barnes,
	Jesse" <jesse.barnes@intel.com>, "Girdwood,
	Liam R" <liam.r.girdwood@intel.com>, "david.henningsson@canonical.com" <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Hi all,

Three things:
1. Any reason public mailing lists (intel-gfx, alsa-devel) aren't
cc'ed? Afaics no secret stuff is being discussed here ... Please
resend the patches with mailings lists cc'ed.

2. On a quick read of the hda driver stuff I don't think the power
well enable/disable places are at the right spot: We force the power
well on whenever the hda codec is used, but we must only do that when
we want to output audio to external screens. And since that state
transition can only really happen due to a modeset change on the gfx
side I don't think we need any autosuspend delays either.

The use-case I'm thinking of is media playback with just the panel
enabled: In that case we can switch off the power well on the display
side, and I don't think the power well is required for audio play back
on the integrated speakerrs/headphone-jack either.

3. The moduel depencies seem to still not work out dynamically, at
least I think we still have a hard chain between hda-intel and i915.ko
(just with one thing in between now).

Cheers, Daniel



On Thu, May 9, 2013 at 9:23 AM, Wang, Xingchao <xingchao.wang@intel.com> wrote:
> Hi All,
>
> This is a newer version patchset for power well feature implementation.
>
> I will send out a document later to describe the design, especially for David and Takashi as they could not see Bspec
> so it maybe a bit confuse. Meanwhile Liam will send out a meeting request for discussion, welcome Daniel, Paulo, Jesse to join us.
>
> Basically, here's the latest working status on my side:
>
> I tested the power well feature on Haswell ULT board, there's only one eDP port used.
> Without this patch and we enabled power well feature, gfx driver will shutdown power well, audio driver will crash.
> Applied this patch, display audio driver will request power well on before initialize the card. In gfx side, it will enable power well.
>
> Also power_save feature in audio side should be enabled, I set "5" second to let codec enter suspend when free for 5s long.
> Audio controller driver detects all codecs are suspended it will release power well and suspend too. Gfx driver will receive the request and shut down power well.
>
> If user trigger some audio operations(cat codec# info), audio controller driver will request power well again...
>
> If gfx side decided to disable power well now, while audio is in use, power well would be kept on.
>
> Generally audio drvier will request power well on need and release it immediately after suspend. Gfx should make decision at his side.
>
> The new introduced module "hda-i915" has dependency on i915, only built in when i915 enabled. So it's safe for call.
> This module was based on David's original patch, which added pm_suspend/resume callback for hdmi codec. As the codecs and controller are both depending on powerwell,
> and codec *must* already on power so I moved the power well request/release to controller side and changed the module name to "hda-i915".
> David, would you like me to add you as author for the second patch? :)
>
> For non-Haswell platform, power well is no need atm. If the module is built in and gfx will reject power well request at its side, so it's safe too.
>
> thanks
> --xingchao
>
>
>> -----Original Message-----
>> From: Wang Xingchao [mailto:xingchao.wang@linux.intel.com]
>> Sent: Thursday, May 09, 2013 3:01 PM
>> To: david.henningsson@canonical.com; Girdwood, Liam R; tiwai@suse.de;
>> daniel@ffwll.ch
>> Cc: Barnes, Jesse; Li, Jocelyn; Lin, Mengdong; Wang, Xingchao; Zanoni, Paulo R;
>> Wang Xingchao
>> Subject: [RFC PATCH 1/3] drm/915: Add private api for power well usage
>>
>> Haswell Display audio depends on power well in graphic side, it should request
>> power well before use it and release power well after use.
>> I915 will not shutdown power well if it detects audio is using.
>> This patch protects display audio crash for Intel Haswell mobile
>> C3 stepping board.
>>
>> Signed-off-by: Wang Xingchao <xingchao.wang@linux.intel.com>
>> ---
>>  drivers/gpu/drm/i915/intel_pm.c |  127
>> ++++++++++++++++++++++++++++++++++++---
>>  include/drm/audio_drm.h         |   39 ++++++++++++
>>  2 files changed, 159 insertions(+), 7 deletions(-)  create mode 100644
>> include/drm/audio_drm.h
>>
>> diff --git a/drivers/gpu/drm/i915/intel_pm.c b/drivers/gpu/drm/i915/intel_pm.c
>> index 2557926..cba753e 100644
>> --- a/drivers/gpu/drm/i915/intel_pm.c
>> +++ b/drivers/gpu/drm/i915/intel_pm.c
>> @@ -4298,18 +4298,12 @@ bool intel_using_power_well(struct drm_device
>> *dev)
>>               return true;
>>  }
>>
>> -void intel_set_power_well(struct drm_device *dev, bool enable)
>> +void set_power_well(struct drm_device *dev, bool enable)
>>  {
>>       struct drm_i915_private *dev_priv = dev->dev_private;
>>       bool is_enabled, enable_requested;
>>       uint32_t tmp;
>>
>> -     if (!HAS_POWER_WELL(dev))
>> -             return;
>> -
>> -     if (!i915_disable_power_well && !enable)
>> -             return;
>> -
>>       tmp = I915_READ(HSW_PWR_WELL_DRIVER);
>>       is_enabled = tmp & HSW_PWR_WELL_STATE;
>>       enable_requested = tmp & HSW_PWR_WELL_ENABLE; @@ -4332,6
>> +4326,125 @@ void intel_set_power_well(struct drm_device *dev, bool
>> enable)
>>       }
>>  }
>>
>> +/* Global drm_device for display audio drvier usage */ static struct
>> +drm_device *power_well_device;
>> +/* Lock protecting power well setting */
>> +DEFINE_SPINLOCK(powerwell_lock); static bool i915_power_well_using;
>> +
>> +struct power_well {
>> +     int user_cnt;
>> +     struct list_head power_well_list;
>> +};
>> +
>> +static struct power_well hsw_power = {
>> +     .user_cnt = 0,
>> +     .power_well_list = LIST_HEAD_INIT(hsw_power.power_well_list),
>> +};
>> +
>> +struct power_well_user {
>> +     char name[16];
>> +     struct list_head list;
>> +};
>> +
>> +void i915_request_power_well(const char *name) {
>> +     struct power_well_user *user;
>> +
>> +     DRM_DEBUG_KMS("request power well for %s\n", name);
>> +     spin_lock_irq(&powerwell_lock);
>> +     if (!power_well_device)
>> +             goto out;
>> +
>> +     if (!IS_HASWELL(power_well_device))
>> +             goto out;
>> +
>> +     list_for_each_entry(user, &hsw_power.power_well_list, list) {
>> +             if (!strcmp(user->name, name)) {
>> +                     goto out;
>> +             }
>> +     }
>> +
>> +     user = kzalloc(sizeof(*user), GFP_KERNEL);
>> +     if (user == NULL) {
>> +             goto out;
>> +     }
>> +     strcpy(user->name, name);
>> +
>> +     list_add(&user->list, &hsw_power.power_well_list);
>> +     hsw_power.user_cnt++;
>> +
>> +     if (hsw_power.user_cnt == 1) {
>> +             set_power_well(power_well_device, true);
>> +             DRM_DEBUG_KMS("%s set power well on\n", user->name);
>> +     }
>> +out:
>> +     spin_unlock_irq(&powerwell_lock);
>> +     return;
>> +}
>> +EXPORT_SYMBOL_GPL(i915_request_power_well);
>> +
>> +void i915_release_power_well(const char *name) {
>> +     struct power_well_user *user;
>> +
>> +     DRM_DEBUG_KMS("release power well from %s\n", name);
>> +     spin_lock_irq(&powerwell_lock);
>> +     if (!power_well_device)
>> +             goto out;
>> +
>> +     if (!IS_HASWELL(power_well_device))
>> +             goto out;
>> +
>> +     list_for_each_entry(user, &hsw_power.power_well_list, list) {
>> +             if (!strcmp(user->name, name)) {
>> +                     list_del(&user->list);
>> +                     hsw_power.user_cnt--;
>> +                     DRM_DEBUG_KMS("Releaseing power well:%s, user_cnt:%d,
>> i915 using:%d\n",
>> +                                     user->name, hsw_power.user_cnt,
>> i915_power_well_using);
>> +                     if (!hsw_power.user_cnt && !i915_power_well_using)
>> +                             set_power_well(power_well_device, false);
>> +                     goto out;
>> +             }
>> +     }
>> +
>> +     DRM_DEBUG_KMS("power well %s doesnot exist\n", name);
>> +out:
>> +     spin_unlock_irq(&powerwell_lock);
>> +     return;
>> +}
>> +EXPORT_SYMBOL_GPL(i915_release_power_well);
>> +
>> +/* TODO: Call this when i915 module unload */ void
>> +remove_power_well(void) {
>> +     spin_lock_irq(&powerwell_lock);
>> +     i915_power_well_using = false;
>> +     power_well_device = NULL;
>> +     spin_unlock_irq(&powerwell_lock);
>> +}
>> +
>> +void intel_set_power_well(struct drm_device *dev, bool enable) {
>> +     if (!HAS_POWER_WELL(dev))
>> +             return;
>> +
>> +     spin_lock_irq(&powerwell_lock);
>> +     power_well_device = dev;
>> +     i915_power_well_using = enable;
>> +     if (!enable && hsw_power.user_cnt) {
>> +             DRM_DEBUG_KMS("Display audio power well busy using now\n");
>> +             goto out;
>> +     }
>> +
>> +     if (!i915_disable_power_well && !enable)
>> +             goto out;
>> +     set_power_well(dev, enable);
>> +out:
>> +     spin_unlock_irq(&powerwell_lock);
>> +     return;
>> +}
>> +
>>  /*
>>   * Starting with Haswell, we have a "Power Down Well" that can be turned off
>>   * when not needed anymore. We have 4 registers that can request the
>> power well diff --git a/include/drm/audio_drm.h b/include/drm/audio_drm.h
>> new file mode 100644 index 0000000..215295f
>> --- /dev/null
>> +++ b/include/drm/audio_drm.h
>> @@ -0,0 +1,39 @@
>> +/**************************************************************
>> ********
>> +****
>> + *
>> + * Copyright 2013 Intel Inc.
>> + * All Rights Reserved.
>> + *
>> + * Permission is hereby granted, free of charge, to any person
>> +obtaining a
>> + * copy of this software and associated documentation files (the
>> + * "Software"), to deal in the Software without restriction, including
>> + * without limitation the rights to use, copy, modify, merge, publish,
>> + * distribute, sub license, and/or sell copies of the Software, and to
>> + * permit persons to whom the Software is furnished to do so, subject
>> +to
>> + * the following conditions:
>> + *
>> + * The above copyright notice and this permission notice (including the
>> + * next paragraph) shall be included in all copies or substantial
>> +portions
>> + * of the Software.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>> +EXPRESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
>> +MERCHANTABILITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO
>> EVENT
>> +SHALL
>> + * THE COPYRIGHT HOLDERS, AUTHORS AND/OR ITS SUPPLIERS BE LIABLE
>> FOR
>> +ANY CLAIM,
>> + * DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
>> TORT
>> +OR
>> + * OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
>> SOFTWARE
>> +OR THE
>> + * USE OR OTHER DEALINGS IN THE SOFTWARE.
>> + *
>> + *
>> +
>> +***************************************************************
>> ********
>> +***/
>> +/*
>> + * Authors:
>> + * Wang Xingchao <xingchao.wang@intel.com>  */
>> +
>> +#ifndef _AUDIO_DRM_H_
>> +#define _AUDIO_DRM_H_
>> +
>> +extern void i915_request_power_well(const char *name); extern void
>> +i915_release_power_well(const char *name);
>> +
>> +#endif                               /* _AUDIO_DRM_H_ */
>> --
>> 1.7.9.5
>



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
