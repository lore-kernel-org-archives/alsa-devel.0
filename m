From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH v2] ALSA: hda - restore BCLK M/N values
 when resuming HSW/BDW display controller
Date: Wed, 2 Jul 2014 14:50:02 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F82B588B28@SHSMSX101.ccr.corp.intel.com>
References: <cf161a8248cc08c0a3e1d9a59be572d1941fe2b6.1403779411.git.mengdong.lin@intel.com>
 <s5h7g44vt2d.wl%tiwai@suse.de>
 <F46914AEC2663F4A9BB62374E5EEF8F82B5803B1@SHSMSX101.ccr.corp.intel.com>
 <s5h4mz7x4l5.wl%tiwai@suse.de>	<s5hwqc3vl43.wl%tiwai@suse.de>
 <F46914AEC2663F4A9BB62374E5EEF8F82B5815DC@SHSMSX101.ccr.corp.intel.com>
 <s5ha98yve8g.wl%tiwai@suse.de>
 <F46914AEC2663F4A9BB62374E5EEF8F82B588630@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id CA33726529F
 for <alsa-devel@alsa-project.org>; Wed,  2 Jul 2014 16:50:24 +0200 (CEST)
In-Reply-To: <F46914AEC2663F4A9BB62374E5EEF8F82B588630@SHSMSX101.ccr.corp.intel.com>
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
To: "Lin, Mengdong" <mengdong.lin@intel.com>, Takashi Iwai <tiwai@suse.de>
Cc: "Nikula, Jani" <jani.nikula@intel.com>, "Yang,
 Libin" <libin.yang@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Li,
 Jocelyn" <jocelyn.li@intel.com>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

I submitted patches, using the private API to query CDCLK from i915 and restore BCLK. Could you have a review?
http://mailman.alsa-project.org/pipermail/alsa-devel/2014-July/078489.html

The 1st patch by Jani is actually for i915 to provide the interface for audio driver to query CDCLK. 

Thanks
Mengdong

> -----Original Message-----
> From: alsa-devel-bounces@alsa-project.org
> [mailto:alsa-devel-bounces@alsa-project.org] On Behalf Of Lin, Mengdong
> Sent: Wednesday, July 02, 2014 6:58 PM
> To: Takashi Iwai
> Cc: Nikula, Jani; Yang, Libin; alsa-devel@alsa-project.org; Li, Jocelyn
> Subject: Re: [alsa-devel] [PATCH v2] ALSA: hda - restore BCLK M/N values
> when resuming HSW/BDW display controller
> 
> Add Jani from Gfx driver team and audio team.
> 
> Hi Takashi,
> 
> > -----Original Message-----
> > From: Takashi Iwai [mailto:tiwai@suse.de]
> > Sent: Friday, June 27, 2014 6:28 PM
> >
> > At Fri, 27 Jun 2014 06:38:47 +0000,
> > Lin, Mengdong wrote:
> > >
> > > Hi Takashi,
> > >
> > > Sorry. This patch cannot handle the following case:
> > > If only embedded DP is connected on boot, the gfx driver will turn
> > > off
> > the display power well on boot case before the audio driver probes and
> > request this power.
> > > So the M/V values programmed by BIOS in EM4/5 registers will be lost
> > > at
> > the very beginning. And so the audio driver will save invalid M/N
> > values on suspend and restore these invalid values on resume.
> > > One phenomenon is: if HDMI or DP monitor is connected after boot,
> > audio playback rate is ~20% faster than normal.
> > > And I guess it's the patch cannot fix the Haswell issue
> > > https://bugzilla.kernel.org/show_bug.cgi?id=74861
> > >
> > > There are two possible solutions:
> > > (1) Follows Windows model: Windows, gfx driver notifies BIOS on LPSP
> > (when only eDP is connected) exit and BIOS reprograms those EM4/5
> > registers.
> > >    There is no such implementation in Linux gfx driver now. We need
> > time to check the effort.
> > >
> > > (2) Gfx driver notify audio driver on exiting LPSP and CDCLK value
> > > (by
> > reading GPU registers), so audio driver can reprograms EM4/5 registers.
> > >   The open source interface between audio/gfx driver is still not
> ready.
> > Would an private API to get CDCLK from gfx driver will be a possible
> > workaround atm?
> > >
> > > Could you share your opinion on this issue?
> >
> > To me, the former sounds like an easier solution.  In the latter case,
> > it can be still an issue of module loading order.
> 
> Can we introduce a private i915 interface for the audio driver to get the
> CDCLK as a quick fix?  Then the audio driver can reprogram the EM4/5
> M/N values as per the CDCLK.
> 
> The interface can be like 'int i915_get_cdclk_freq(void)' and the audio
> driver will use symbol_request() to get this private API and avoid the issue
> of module loading order.
> We can put the relevant code in sound/pci/hda/ hda_i915.c
> 
> For Broadwell Jani has implemented a notification to BIOS, so BIOS can
> reprogram the EM4/5 value after restoring the power.
> http://patchwork.freedesktop.org/patch/28866/
> http://patchwork.freedesktop.org/patch/28868/
> 
> But for Haswell, BIOS does not support the above notification and provide
> another heavy-weight notification which will enable/disable the HD-A
> controller at runtime and so need OS to re-enumerate the device stack.
> That causes system hang. And test on Haswell shows that reprogramming
> the EM4/5 as per the CDCLK is also enough to give good BCLK and audio
> rate. So we hope to avoid further dependency on the black-box BIOS.
> 
> Libin is working on the generic interface between audio and gfx now and
> we can clean up code in the future.
> But before the interface is ready, a private API to query CDCLK seems to be
> a quick and reliable fix for Haswell and Broadwell.
> 
> Thanks
> Mengdong
> 
> 
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
