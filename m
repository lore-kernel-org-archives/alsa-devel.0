From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH 5/5] ALSA/i915: Check power well API
 existense before calling
Date: Mon, 13 May 2013 11:53:56 +0200
Message-ID: <5190B834.5090201@perex.cz>
References: <1368430648-2353-1-git-send-email-xingchao.wang@linux.intel.com>
 <1368430648-2353-6-git-send-email-xingchao.wang@linux.intel.com>
 <5190A43B.8040106@canonical.com> <5190AA92.8040400@perex.cz>
 <s5h1u9btfvn.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 7A4952616C1
 for <alsa-devel@alsa-project.org>; Mon, 13 May 2013 11:53:56 +0200 (CEST)
In-Reply-To: <s5h1u9btfvn.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, liam.r.girdwood@intel.com, jocelyn.li@intel.com, mengdong.lin@intel.com, intel-gfx@lists.freedesktop.org, Wang Xingchao <xingchao.wang@linux.intel.com>, jesse.barnes@intel.com, daniel@ffwll.ch, David Henningsson <david.henningsson@canonical.com>, paulo.r.zanoni@intel.com
List-Id: alsa-devel@alsa-project.org

Date 13.5.2013 10:59, Takashi Iwai wrote:
> At Mon, 13 May 2013 10:55:46 +0200,
> Jaroslav Kysela wrote:
>>
>> Date 13.5.2013 10:28, David Henningsson wrote:
>>> On 05/13/2013 09:37 AM, Wang Xingchao wrote:
>>>> I915 module maybe loaded after snd_hda_intel, the power-well
>>>> API doesnot exist in such case. This patch intended to avoid
>>>> loading dependency between snd-hda-intel and i915 module.
>>>
>>> Hi Xingchao and thanks for working on this.
>>>
>>> This patch seems to re-do some of the work done in other patches (a lot 
>>> of lines removed), so it's a little hard to follow. But I'll try to 
>>> write some overall comments on how I have envisioned things...
>>>
>>> 1. I don't think there's any need to create an additional kernel module, 
>>> we can just let hda_i915.c be in the snd-hda-intel.ko module, and only 
>>> compile it if DRM_I915 is defined.
>>>
>>> 2. We don't need an IS_HSW macro on the audio side. Instead declare a 
>>> new AZX_DCAPS_NEED_I915_POWER (or similar) driver quirk.
>>>
>>> 3. Somewhere in the beginning of the probing in hda_intel.c, we'll need 
>>> something like:
>>>
>>> if (driver_caps & AZX_DCAPS_NEED_I915_POWER)
>>>    hda_i915_init(chip);
>>>
>>> 4. The hda_i915_init does not need to be exported (they're now both in 
>>> the same module). hda_i915.h could have something like:
>>>
>>> #ifdef DRM_I915
>>>    void hda_i915_init(chip);
>>> #else
>>>    #define hda_i915_init(chip) do {} while(0)
>>> #endif
>>>
>>> 5. You're saying this patch is about avoid loading dependency between 
>>> snd-hda-intel and i915 module. That does not make sense to me, since the 
>>> powerwell API is in the i915 module, snd-hda-intel must load it when it 
>>> wants to enable power on haswell, right? Thus there is a loading 
>>> dependency. If the i915 module is not loaded at that point, we must wait 
>>> for it to load, so we can have proper power, instead of continuing 
>>> probing without the power well?
>>
>> Looking to the code, if the drm code requires a callback to the audio
>> code, I would just register it in the audio driver init phase and
>> unregister it when snd-hda-intel is unloaded. This cross module loading
>> dependency looks really bad. Or it is not allowed to load the audio
>> driver later than DRM one?
> 
> It's not allowed.  The drm/i915 must be initialized before the audio.
> And yet, we don't want this dependency in a hard way in the hda
> driver, because the driver is not only for i915 but for other vendor's
> controllers, too.
> 
> In the previous meeting, I suggested to split snd-hda-intel for
> Haswell as an alternative solution.  But this has obvious
> disadvantages, and since the dynamic symbol lookup is already used in
> a few other kernel codes, we decided to try this first.

Yes, I agree here, but I was talking about the proposed
intel_gpu_audio_init() function which creates a back-dependency to the
audio driver. It should be done using a callback to the DRM code without
adding a new cross module. The other stuff (request_module, symbol_get)
looks good, but it should be integrated to the main snd-hda-intel module
as David proposed.

						Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project; Red Hat, Inc.
