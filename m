From: "Wang, Xingchao" <xingchao.wang@intel.com>
Subject: Re: module dependency between i915 and snd-hda-intel
Date: Fri, 17 May 2013 10:14:19 +0000
Message-ID: <46B810F6945F7C4788E11DCE57EC489010E6C6DE@SHSMSX102.ccr.corp.intel.com>
References: <46B810F6945F7C4788E11DCE57EC489010E6C69F@SHSMSX102.ccr.corp.intel.com>
 <s5h61yh7wjy.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id BE42A260307
 for <alsa-devel@alsa-project.org>; Fri, 17 May 2013 12:14:24 +0200 (CEST)
In-Reply-To: <s5h61yh7wjy.wl%tiwai@suse.de>
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
Cc: "Li,
 Jocelyn" <jocelyn.li@intel.com>, "Lin, Mengdong" <mengdong.lin@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>, "david.henningsson@canonical.com" <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org


> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Friday, May 17, 2013 6:03 PM
> To: Wang, Xingchao
> Cc: Lin, Mengdong; david.henningsson@canonical.com; Li, Jocelyn; Girdwood,
> Liam R; alsa-devel@alsa-project.org
> Subject: Re: module dependency between i915 and snd-hda-intel
> 
> At Fri, 17 May 2013 09:55:13 +0000,
> Wang, Xingchao wrote:
> >
> > Hi Takashi,
> >
> > Seems kernel building will determine the module loading sequence, this would
> fix the dependency for i915 and snd-hda-intel.
> > If we call the i915 module API directly in snd-hda-intel side, kernel building will
> change the module.dep accordingly like:
> > "
> > kernel/sound/pci/hda/snd-hda-intel.ko: kernel/drivers/gpu/drm/i915/i915.ko
> kernel/drivers/gpu/dr     m/drm_kms_helper.ko
> kernel/drivers/gpu/drm/drm.ko kernel/drivers/i2c/algos/i2c-algo-bit.ko kerne
> l/drivers/acpi/video.ko kernel/sound/pci/hda/snd-hda-codec.ko
> kernel/sound/core/snd-hwdep.ko ker     nel/sound/core/snd-pcm.ko
> kernel/sound/core/snd-timer.ko kernel/sound/core/snd.ko kernel/sound/s
> oundcore.ko kernel/sound/core/snd-page-alloc.ko
> > "
> > So snd-hda-intel will wait for i915 loading. Even I added i915 into blacklist.conf,
> it will force load i915.ko.
> >
> > So I think the only bad case is no i915 module built-in, that would cause
> haswell hda initialize fail, and the patch would output error message.
> 
> Is it the result with your patch?  If so, something must be wrong.
> 

No. i'm testing the case to call the API directly.
The issue is with current patch to load i915.ko by request_module(), It would take ~50s
and symbol_get() would fail, but I can see i915 module already there by "lsmod".

So is there any difference between request_module() and auto-loading i915 module?

> We don't want to call i915 functions directly from snd-hda-intel.
> That's the exact reason symbol_get() is used.  Otherwise i915 module is
> always referred, thus always load when HD-audio is used, no matter which
> hardware is.

Okay, I see.

Thanks
--xingchao
> 
> 
> Takashi
