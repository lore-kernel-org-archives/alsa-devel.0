From: "Wang, Xingchao" <xingchao.wang@intel.com>
Subject: Re: [alsa-devel] [PATCH 5/5] ALSA/i915: Check power
 well API existense before calling
Date: Mon, 13 May 2013 13:50:39 +0000
Message-ID: <46B810F6945F7C4788E11DCE57EC489010E5C291@SHSMSX102.ccr.corp.intel.com>
References: <1368430648-2353-1-git-send-email-xingchao.wang@linux.intel.com>
	<1368430648-2353-6-git-send-email-xingchao.wang@linux.intel.com>
	<5190A43B.8040106@canonical.com>
	<46B810F6945F7C4788E11DCE57EC489010E5C1B8@SHSMSX102.ccr.corp.intel.com>
	<5190D8DC.8090305@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <5190D8DC.8090305@canonical.com>
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
To: David Henningsson <david.henningsson@canonical.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Girdwood,
	Liam R" <liam.r.girdwood@intel.com>, "tiwai@suse.de" <tiwai@suse.de>, "Lin, Mengdong" <mengdong.lin@intel.com>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, Wang Xingchao <xingchao.wang@linux.intel.com>, "Li,
	Jocelyn" <jocelyn.li@intel.com>, "Barnes,
	Jesse" <jesse.barnes@intel.com>, "Zanoni,
	Paulo R" <paulo.r.zanoni@intel.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: David Henningsson [mailto:david.henningsson@canonical.com]
> Sent: Monday, May 13, 2013 8:13 PM
> To: Wang, Xingchao
> Cc: Wang Xingchao; alsa-devel@alsa-project.org; daniel@ffwll.ch;
> tiwai@suse.de; Lin, Mengdong; intel-gfx@lists.freedesktop.org; Li, Jocelyn;
> Barnes, Jesse; Girdwood, Liam R; Zanoni, Paulo R
> Subject: Re: [alsa-devel] [PATCH 5/5] ALSA/i915: Check power well API
> existense before calling
> 
> On 05/13/2013 01:55 PM, Wang, Xingchao wrote:
> > Hi David,
> >
> >
> >> -----Original Message-----
> >> From: alsa-devel-bounces@alsa-project.org
> >> [mailto:alsa-devel-bounces@alsa-project.org] On Behalf Of David
> >> Henningsson
> >> Sent: Monday, May 13, 2013 4:29 PM
> >> To: Wang Xingchao
> >> Cc: alsa-devel@alsa-project.org; daniel@ffwll.ch; tiwai@suse.de; Lin,
> >> Mengdong; intel-gfx@lists.freedesktop.org; Li, Jocelyn; Barnes,
> >> Jesse; Girdwood, Liam R; Zanoni, Paulo R
> >> Subject: Re: [alsa-devel] [PATCH 5/5] ALSA/i915: Check power well API
> >> existense before calling
> >>
> >> On 05/13/2013 09:37 AM, Wang Xingchao wrote:
> >>> I915 module maybe loaded after snd_hda_intel, the power-well API
> >>> doesnot exist in such case. This patch intended to avoid loading
> >>> dependency between snd-hda-intel and i915 module.
> >>
> >> Hi Xingchao and thanks for working on this.
> >>
> >> This patch seems to re-do some of the work done in other patches (a
> >> lot of lines removed), so it's a little hard to follow. But I'll try
> >> to write some overall comments on how I have envisioned things...
> >>
> >> 1. I don't think there's any need to create an additional kernel
> >> module, we can just let hda_i915.c be in the snd-hda-intel.ko module,
> >> and only compile it if
> >> DRM_I915 is defined.
> >>
> >> 2. We don't need an IS_HSW macro on the audio side. Instead declare a
> >> new AZX_DCAPS_NEED_I915_POWER (or similar) driver quirk.
> >>
> >> 3. Somewhere in the beginning of the probing in hda_intel.c, we'll
> >> need something like:
> >>
> >> if (driver_caps & AZX_DCAPS_NEED_I915_POWER)
> >>     hda_i915_init(chip);
> >>
> >> 4. The hda_i915_init does not need to be exported (they're now both
> >> in the same module). hda_i915.h could have something like:
> >>
> >> #ifdef DRM_I915
> >>     void hda_i915_init(chip);
> >> #else
> >>     #define hda_i915_init(chip) do {} while(0) #endif
> 
> Or perhaps even better
> 
> static inline void hda_i915_init(azx *chip) {}
> 
> >
> > Thanks your suggestions. Will change them in next version.
> >>
> >> 5. You're saying this patch is about avoid loading dependency between
> >> snd-hda-intel and i915 module. That does not make sense to me, since
> >> the powerwell API is in the i915 module, snd-hda-intel must load it
> >> when it wants to enable power on haswell, right? Thus there is a
> >> loading dependency. If the i915 module is not loaded at that point,
> >> we must wait for it to load, so we can have proper power, instead of
> continuing probing without the power well?
> >>
> >
> > If i915 module not loaded, snd-had-intel will load it in current code.
> > The question is the tolerant delay of waiting for i915 loading.
> 
> Could you explain in more detail, what you mean with "tolerant delay"
> and what will happen if you exceed that delay?

You said " If the i915 module is not loaded at that point, we must wait for it to load".
I'm not clear about the routine, how long will snd-hda-intel wait? What would happen if loading i915 too long time?
How will snd-hda-intel get to know the i915 loading finished?

> 
> > Continuing probing would immediately fail.
> 
> Isn't that what's happening with your current patch set, if snd-hda-intel is
> loaded first?
> In azx_probe, hda_i915_init won't get the symbols, because request_module is
> nowait. Then hda_display_power(true) won't enable power, because there are
> no symbols.
> Probing audio controller will then continue without power well, which is bad?

Yeah, it's bad here. As power-well is really critical for audio controller initialization, it could not
be postponed. If it's one feature like graphic turbo mode, it's easy to postpone until module loading finished.

Anyway this should be fixed in next version.

Thanks
--xingchao
> 
> --
> David Henningsson, Canonical Ltd.
> https://launchpad.net/~diwic
