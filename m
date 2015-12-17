From: "Zhang, Xiong Y" <xiong.y.zhang@intel.com>
Subject: Re: [PATCH] ALSA: hda - Set intel hda controller power
 at	freeze() and thaw()
Date: Thu, 17 Dec 2015 09:05:08 +0000
Message-ID: <8082FF9BCB2B054996454E47167FF4EC0B10DD9A@SHSMSX104.ccr.corp.intel.com>
References: <1450335524-22848-1-git-send-email-xiong.y.zhang@intel.com>
 <s5h4mfhfrk9.wl-tiwai@suse.de>
 <96A12704CE18D347B625EE2D4A099D197B28F2@SHSMSX103.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id D675E2654FB
 for <alsa-devel@alsa-project.org>; Thu, 17 Dec 2015 10:05:13 +0100 (CET)
In-Reply-To: <96A12704CE18D347B625EE2D4A099D197B28F2@SHSMSX103.ccr.corp.intel.com>
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
To: "Yang, Libin" <libin.yang@intel.com>, Takashi Iwai <tiwai@suse.de>
Cc: "Zhang, Xiong Y" <xiong.y.zhang@intel.com>, "Lu, Han" <han.lu@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> > -----Original Message-----
> > From: Takashi Iwai [mailto:tiwai@suse.de]
> > Sent: Thursday, December 17, 2015 3:44 PM
> > To: Zhang, Xiong Y
> > Cc: alsa-devel@alsa-project.org; Yang, Libin; Lu, Han
> > Subject: Re: [alsa-devel] [PATCH] ALSA: hda - Set intel hda controller
> > power at freeze() and thaw()
> >
> > On Thu, 17 Dec 2015 07:58:44 +0100,
> > Xiong Zhang wrote:
> > >
> > > It takes three minutes to enter into hibernation on some OEM SKL
> > > machines and we see many codec spurious response after thaw()
> > opertion.
> > > This is because HDA is still in D0 state after freeze() call and
> > > pci_pm_freeze/pci_pm_freeze_noirq() don't set D3 hot in pci_bus
> > driver.
> > > It seems bios still access HDA when system enter into freeze state,
> > > HDA will receive codec response interrupt immediately after thaw() call.
> > > Because of this unexpected interrupt, HDA enter into a abnormal
> > > state and slow down the system enter into hibernation.
> > >
> > > In this patch, we put HDA into D3 hot state in azx_freeze_noirq() and
> > > put HDA into D0 state in azx_thaw_noirq().
> >
> > A slight concern is whether this would cause any impact on older
> > chipsets.  I don't believe it would, but BIOSen are often crazy
> > sensitive about such a detail.
> >
> > Maybe safer to limit this to SKL+?  I guess Broxton should be covered
> > as well?
> 
> As the issue fixed by the patch is only found on SKL, I agree to
> limit it to SKL+. And apply it to other old platforms later if necessary.
> 
> BTW: We have tested it on BDW and SKL. It works on both platforms.
> 
[Zhang, Xiong Y] Ok, I will apply the fix to SKL+. But how could I identify the HDA is SKL+
1) HDA device ID or define macro IS_SKL_PLUS with DID,  this means hard code
2) use AZX_DCAPS_I915_POWERWELL, this means applying it to HSW+
3) add a new AZX_DCAPS_xxxx bit, but the bit for pci->driver_date is valuable and hda_intel driver has used most of the bit. Only bit 11, 22 and 31 are left. 

thanks
