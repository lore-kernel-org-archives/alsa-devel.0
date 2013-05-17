From: "Wang, Xingchao" <xingchao.wang@intel.com>
Subject: Re: module dependency between i915 and snd-hda-intel
Date: Fri, 17 May 2013 13:45:15 +0000
Message-ID: <46B810F6945F7C4788E11DCE57EC489010E6C7EC@SHSMSX102.ccr.corp.intel.com>
References: <46B810F6945F7C4788E11DCE57EC489010E6C69F@SHSMSX102.ccr.corp.intel.com>
 <s5h61yh7wjy.wl%tiwai@suse.de>
 <46B810F6945F7C4788E11DCE57EC489010E6C6DE@SHSMSX102.ccr.corp.intel.com>
 <s5h38tl7uma.wl%tiwai@suse.de>
 <46B810F6945F7C4788E11DCE57EC489010E6C7C1@SHSMSX102.ccr.corp.intel.com>
 <s5hmwrt69fm.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 273012608E8
 for <alsa-devel@alsa-project.org>; Fri, 17 May 2013 15:45:24 +0200 (CEST)
In-Reply-To: <s5hmwrt69fm.wl%tiwai@suse.de>
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
Cc: "Li, Jocelyn" <jocelyn.li@intel.com>, "Lin,
 Mengdong" <mengdong.lin@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "david.henningsson@canonical.com" <david.henningsson@canonical.com>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Friday, May 17, 2013 9:08 PM
> To: Wang, Xingchao
> Cc: Li, Jocelyn; Lin, Mengdong; alsa-devel@alsa-project.org; Girdwood, Liam R;
> david.henningsson@canonical.com
> Subject: Re: [alsa-devel] module dependency between i915 and snd-hda-intel
> 
> At Fri, 17 May 2013 13:00:02 +0000,
> Wang, Xingchao wrote:
> >
> >
> >
> > > -----Original Message-----
> > > From: alsa-devel-bounces@alsa-project.org
> > > [mailto:alsa-devel-bounces@alsa-project.org] On Behalf Of Takashi
> > > Iwai
> > > Sent: Friday, May 17, 2013 6:45 PM
> > > To: Wang, Xingchao
> > > Cc: Li, Jocelyn; Lin, Mengdong; alsa-devel@alsa-project.org;
> > > Girdwood, Liam R; david.henningsson@canonical.com
> > > Subject: Re: [alsa-devel] module dependency between i915 and
> > > snd-hda-intel
> > >
> > > At Fri, 17 May 2013 10:14:19 +0000,
> > > Wang, Xingchao wrote:
> > > >
> > > >
> > > > > -----Original Message-----
> > > > > From: Takashi Iwai [mailto:tiwai@suse.de]
> > > > > Sent: Friday, May 17, 2013 6:03 PM
> > > > > To: Wang, Xingchao
> > > > > Cc: Lin, Mengdong; david.henningsson@canonical.com; Li, Jocelyn;
> > > > > Girdwood, Liam R; alsa-devel@alsa-project.org
> > > > > Subject: Re: module dependency between i915 and snd-hda-intel
> > > > >
> > > > > At Fri, 17 May 2013 09:55:13 +0000, Wang, Xingchao wrote:
> > > > > >
> > > > > > Hi Takashi,
> > > > > >
> > > > > > Seems kernel building will determine the module loading
> > > > > > sequence, this would
> > > > > fix the dependency for i915 and snd-hda-intel.
> > > > > > If we call the i915 module API directly in snd-hda-intel side,
> > > > > > kernel building will
> > > > > change the module.dep accordingly like:
> > > > > > "
> > > > > > kernel/sound/pci/hda/snd-hda-intel.ko:
> > > > > > kernel/drivers/gpu/drm/i915/i915.ko
> > > > > kernel/drivers/gpu/dr     m/drm_kms_helper.ko
> > > > > kernel/drivers/gpu/drm/drm.ko
> > > > > kernel/drivers/i2c/algos/i2c-algo-bit.ko kerne
> > > > > l/drivers/acpi/video.ko
> > > kernel/sound/pci/hda/snd-hda-codec.ko
> > > > > kernel/sound/core/snd-hwdep.ko ker     nel/sound/core/snd-pcm.ko
> > > > > kernel/sound/core/snd-timer.ko kernel/sound/core/snd.ko
> > > > > kernel/sound/s oundcore.ko kernel/sound/core/snd-page-alloc.ko
> > > > > > "
> > > > > > So snd-hda-intel will wait for i915 loading. Even I added i915
> > > > > > into blacklist.conf,
> > > > > it will force load i915.ko.
> > > > > >
> > > > > > So I think the only bad case is no i915 module built-in, that
> > > > > > would cause
> > > > > haswell hda initialize fail, and the patch would output error message.
> > > > >
> > > > > Is it the result with your patch?  If so, something must be wrong.
> > > > >
> > > >
> > > > No. i'm testing the case to call the API directly.
> > > > The issue is with current patch to load i915.ko by
> > > > request_module(), It would take ~50s and symbol_get() would fail,
> > > > but I can see i915 module
> > > already there by "lsmod".
> > >
> > > Which distro are you using?
> >
> > I'm using ubuntu 12.10, kernel image was built based on daniel's
> drm-intel-next branch, with latest commits.
> 
> Note that the long stall is not about kernel but an issue in user-space, either
> udev or kmod.

Yes it should be fixed when I get the correct patch.

> 
> But, if the latest distro shows the problem, maybe we need a workaround in
> anyway.  For example, kicking a work to call azx_probe_contine(), and call the
> dynamic binding including the
> request_module() call there; the similar hack is found for the firmware loading
> stuff via request_firmware_nowait().

Okay I would try ubuntu 13.04 next Monday when I'm at office. I will let you know the result then.

> 
> If such a complication isn't preferred, the best option is to split Haswell-specific
> snd-hda-intel driver.

Agree. :)

Thanks
--xingchao
> 
> 
> Takashi
> 
> >
> > Thanks
> > --xingchao
> >
> >  I guess you are bitten by a known problem, and
> > > maybe it's the reason request_module_notime() is used in drm driver.
> > > This should have been fixed some time ago in udev, I thought.
> > >
> > > > So is there any difference between request_module() and
> > > > auto-loading i915
> > > module?
> > >
> > > Yes.
> > >
> > >
> > > Takashi
> > >
> > > > > We don't want to call i915 functions directly from snd-hda-intel.
> > > > > That's the exact reason symbol_get() is used.  Otherwise i915
> > > > > module is always referred, thus always load when HD-audio is
> > > > > used, no matter which hardware is.
> > > >
> > > > Okay, I see.
> > > >
> > > > Thanks
> > > > --xingchao
> > > > >
> > > > >
> > > > > Takashi
> > > >
> > > _______________________________________________
> > > Alsa-devel mailing list
> > > Alsa-devel@alsa-project.org
> > > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> >
