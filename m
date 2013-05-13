From: "Wang, Xingchao" <xingchao.wang@intel.com>
Subject: Re: [PATCH 5/5] ALSA/i915: Check power well API
 existense before calling
Date: Mon, 13 May 2013 13:43:04 +0000
Message-ID: <46B810F6945F7C4788E11DCE57EC489010E5C26B@SHSMSX102.ccr.corp.intel.com>
References: <1368430648-2353-1-git-send-email-xingchao.wang@linux.intel.com>
 <1368430648-2353-6-git-send-email-xingchao.wang@linux.intel.com>
 <5190A43B.8040106@canonical.com>
 <46B810F6945F7C4788E11DCE57EC489010E5C1B8@SHSMSX102.ccr.corp.intel.com>
 <s5hbo8frs59.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id E642B2617B6
 for <alsa-devel@alsa-project.org>; Mon, 13 May 2013 15:43:09 +0200 (CEST)
In-Reply-To: <s5hbo8frs59.wl%tiwai@suse.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>, "Li, Jocelyn" <jocelyn.li@intel.com>, "Lin, Mengdong" <mengdong.lin@intel.com>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, Wang Xingchao <xingchao.wang@linux.intel.com>, "Barnes,
 Jesse" <jesse.barnes@intel.com>, "daniel@ffwll.ch" <daniel@ffwll.ch>, David Henningsson <david.henningsson@canonical.com>, "Zanoni,
 Paulo R" <paulo.r.zanoni@intel.com>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,


> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Monday, May 13, 2013 8:17 PM
> To: Wang, Xingchao
> Cc: David Henningsson; Wang Xingchao; alsa-devel@alsa-project.org;
> daniel@ffwll.ch; Lin, Mengdong; intel-gfx@lists.freedesktop.org; Li, Jocelyn;
> Barnes, Jesse; Girdwood, Liam R; Zanoni, Paulo R
> Subject: Re: [alsa-devel] [PATCH 5/5] ALSA/i915: Check power well API
> existense before calling
> 
> At Mon, 13 May 2013 11:55:14 +0000,
> Wang, Xingchao wrote:
> >
> > Hi David,
> >
> >
> > > -----Original Message-----
> > > From: alsa-devel-bounces@alsa-project.org
> > > [mailto:alsa-devel-bounces@alsa-project.org] On Behalf Of David
> > > Henningsson
> > > Sent: Monday, May 13, 2013 4:29 PM
> > > To: Wang Xingchao
> > > Cc: alsa-devel@alsa-project.org; daniel@ffwll.ch; tiwai@suse.de;
> > > Lin, Mengdong; intel-gfx@lists.freedesktop.org; Li, Jocelyn; Barnes,
> > > Jesse; Girdwood, Liam R; Zanoni, Paulo R
> > > Subject: Re: [alsa-devel] [PATCH 5/5] ALSA/i915: Check power well
> > > API existense before calling
> > >
> > > On 05/13/2013 09:37 AM, Wang Xingchao wrote:
> > > > I915 module maybe loaded after snd_hda_intel, the power-well API
> > > > doesnot exist in such case. This patch intended to avoid loading
> > > > dependency between snd-hda-intel and i915 module.
> > >
> > > Hi Xingchao and thanks for working on this.
> > >
> > > This patch seems to re-do some of the work done in other patches (a
> > > lot of lines removed), so it's a little hard to follow. But I'll try
> > > to write some overall comments on how I have envisioned things...
> > >
> > > 1. I don't think there's any need to create an additional kernel
> > > module, we can just let hda_i915.c be in the snd-hda-intel.ko
> > > module, and only compile it if
> > > DRM_I915 is defined.
> > >
> > > 2. We don't need an IS_HSW macro on the audio side. Instead declare
> > > a new AZX_DCAPS_NEED_I915_POWER (or similar) driver quirk.
> > >
> > > 3. Somewhere in the beginning of the probing in hda_intel.c, we'll
> > > need something like:
> > >
> > > if (driver_caps & AZX_DCAPS_NEED_I915_POWER)
> > >    hda_i915_init(chip);
> > >
> > > 4. The hda_i915_init does not need to be exported (they're now both
> > > in the same module). hda_i915.h could have something like:
> > >
> > > #ifdef DRM_I915
> > >    void hda_i915_init(chip);
> > > #else
> > >    #define hda_i915_init(chip) do {} while(0) #endif
> >
> > Thanks your suggestions. Will change them in next version.
> 
> A question is what to do if a Haswell controller is loaded without
> i915 driver.  Shouldn't we warn?

I think the dependency between snd-hda-intel and i915 module is that
I915 module *must* be loaded, otherwise Haswell HD-A controller and codec
would both fail. There's an alternative solution is that power-well enabled through BIOS setting by default.
In latter case the Audio controller and codecs registers maybe accessible but the functionality would not, it donot make sense.

The default loading sequence is i915 first in my test. 
So for your question, I think there should be a warning about the loading sequence at first; then if trying load i915 fail, probe failed here.

Thanks
--xingchao

> 
> 
> Takashi
