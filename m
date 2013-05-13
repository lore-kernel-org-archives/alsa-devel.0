From: "Wang, Xingchao" <xingchao.wang@intel.com>
Subject: Re: [PATCH 5/5] ALSA/i915: Check power well API
 existense before calling
Date: Mon, 13 May 2013 12:00:16 +0000
Message-ID: <46B810F6945F7C4788E11DCE57EC489010E5C1D0@SHSMSX102.ccr.corp.intel.com>
References: <1368430648-2353-1-git-send-email-xingchao.wang@linux.intel.com>
 <1368430648-2353-6-git-send-email-xingchao.wang@linux.intel.com>
 <5190A43B.8040106@canonical.com> <5190AA92.8040400@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 2C2EE26166B
 for <alsa-devel@alsa-project.org>; Mon, 13 May 2013 14:00:27 +0200 (CEST)
In-Reply-To: <5190AA92.8040400@perex.cz>
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
To: Jaroslav Kysela <perex@perex.cz>, David Henningsson <david.henningsson@canonical.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "daniel@ffwll.ch" <daniel@ffwll.ch>, "tiwai@suse.de" <tiwai@suse.de>, "Lin,
 Mengdong" <mengdong.lin@intel.com>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, Wang Xingchao <xingchao.wang@linux.intel.com>, "Li,
 Jocelyn" <jocelyn.li@intel.com>, "Barnes, Jesse" <jesse.barnes@intel.com>, "Girdwood, Liam R" <liam.r.girdwood@intel.com>, "Zanoni,
 Paulo R" <paulo.r.zanoni@intel.com>
List-Id: alsa-devel@alsa-project.org

Hi Jaroslav,

> -----Original Message-----
> From: alsa-devel-bounces@alsa-project.org
> [mailto:alsa-devel-bounces@alsa-project.org] On Behalf Of Jaroslav Kysela
> Sent: Monday, May 13, 2013 4:56 PM
> To: David Henningsson
> Cc: alsa-devel@alsa-project.org; Girdwood, Liam R; tiwai@suse.de; Lin,
> Mengdong; intel-gfx@lists.freedesktop.org; Wang Xingchao; Li, Jocelyn;
> Barnes, Jesse; daniel@ffwll.ch; Zanoni, Paulo R
> Subject: Re: [alsa-devel] [PATCH 5/5] ALSA/i915: Check power well API
> existense before calling
> 
> Date 13.5.2013 10:28, David Henningsson wrote:
> > On 05/13/2013 09:37 AM, Wang Xingchao wrote:
> >> I915 module maybe loaded after snd_hda_intel, the power-well API
> >> doesnot exist in such case. This patch intended to avoid loading
> >> dependency between snd-hda-intel and i915 module.
> >
> > Hi Xingchao and thanks for working on this.
> >
> > This patch seems to re-do some of the work done in other patches (a
> > lot of lines removed), so it's a little hard to follow. But I'll try
> > to write some overall comments on how I have envisioned things...
> >
> > 1. I don't think there's any need to create an additional kernel
> > module, we can just let hda_i915.c be in the snd-hda-intel.ko module,
> > and only compile it if DRM_I915 is defined.
> >
> > 2. We don't need an IS_HSW macro on the audio side. Instead declare a
> > new AZX_DCAPS_NEED_I915_POWER (or similar) driver quirk.
> >
> > 3. Somewhere in the beginning of the probing in hda_intel.c, we'll
> > need something like:
> >
> > if (driver_caps & AZX_DCAPS_NEED_I915_POWER)
> >    hda_i915_init(chip);
> >
> > 4. The hda_i915_init does not need to be exported (they're now both in
> > the same module). hda_i915.h could have something like:
> >
> > #ifdef DRM_I915
> >    void hda_i915_init(chip);
> > #else
> >    #define hda_i915_init(chip) do {} while(0) #endif
> >
> > 5. You're saying this patch is about avoid loading dependency between
> > snd-hda-intel and i915 module. That does not make sense to me, since
> > the powerwell API is in the i915 module, snd-hda-intel must load it
> > when it wants to enable power on haswell, right? Thus there is a
> > loading dependency. If the i915 module is not loaded at that point, we
> > must wait for it to load, so we can have proper power, instead of
> > continuing probing without the power well?
> 
> Looking to the code, if the drm code requires a callback to the audio code, I
> would just register it in the audio driver init phase and unregister it when
> snd-hda-intel is unloaded. This cross module loading dependency looks really
> bad. Or it is not allowed to load the audio driver later than DRM one?

I think the dependency here is not real. In case the i915 loaded first, the callback
doesnot exist and do nothing, it's safe. In case snd-hda-intel loaded first, and need
pause there to wait i915 module loading, this callback is helpful to notify snd-hda-intel
the proper time to check symbol again.

Thanks
--xingchao
