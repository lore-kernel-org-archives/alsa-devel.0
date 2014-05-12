From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH] ALSA: hda - using POS_FIX_LPIB on
 Broadwell HDMI Audio
Date: Mon, 12 May 2014 08:22:13 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F82B4142B7@SHSMSX101.ccr.corp.intel.com>
References: <1399485804-75028-1-git-send-email-libin.yang@intel.com>
 <s5hzjisq2kj.wl%tiwai@suse.de>
 <96A12704CE18D347B625EE2D4A099D195232A6@SHSMSX103.ccr.corp.intel.com>
 <s5htx90q0mi.wl%tiwai@suse.de>
 <96A12704CE18D347B625EE2D4A099D19523313@SHSMSX103.ccr.corp.intel.com>
 <s5hr444pzap.wl%tiwai@suse.de>
 <96A12704CE18D347B625EE2D4A099D1952333A@SHSMSX103.ccr.corp.intel.com>
 <s5hoaz8pydg.wl%tiwai@suse.de>
 <96A12704CE18D347B625EE2D4A099D195233B1@SHSMSX103.ccr.corp.intel.com>
 <536BAB70.3010905@canonical.com>
 <F46914AEC2663F4A9BB62374E5EEF8F82B40F3CB@SHSMSX101.ccr.corp.intel.com>
 <s5h1tw3qmmt.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 961C4264F09
 for <alsa-devel@alsa-project.org>; Mon, 12 May 2014 10:28:56 +0200 (CEST)
In-Reply-To: <s5h1tw3qmmt.wl%tiwai@suse.de>
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
Cc: "Yang, Libin" <libin.yang@intel.com>, "anssi.hannula@iki.fi" <anssi.hannula@iki.fi>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Friday, May 09, 2014 6:20 PM
> To: Lin, Mengdong
> Cc: David Henningsson; Yang, Libin; anssi.hannula@iki.fi;
> alsa-devel@alsa-project.org; Pierre-Louis Bossart
> Subject: Re: [alsa-devel] [PATCH] ALSA: hda - using POS_FIX_LPIB on Broadwell
> HDMI Audio
> 
> At Fri, 9 May 2014 10:08:19 +0000,
> Lin, Mengdong wrote:
> >
> > Hi,
> >
> > We found the Broadwell HDMI audio regression is introduced by this patch:
> >
> > commit dcb32ecd9a533f47ab652c5c5680bc50a7a822cd
> > Author: Anssi Hannula <anssi.hannula@iki.fi>
> > Date: Tue Apr 8 12:36:42 2014 +0300
> > ALSA: hda - Do not assign streams in reverse order
> >
> > We'll further check the root cause.
> > Since this patch seems only affect the stream ID. Actually Intel GPU tool only
> find the stream ID is changed by this patch.
> >
> > In addition, Haswell HDMI audio is not affected and works well. It seems
> there is HW behavior difference between HSW and BDW.
> 
> Thanks for spotting out!
> 
> This sounds like a weird hardware bug of BDW.  If any, we'd need to introduce
> a flag indicating flipping this  lookup behavior depending on the chip.

In the display HD-A controller of HSW/BDW, there are 3 sets of stream descriptors registers which controls the DMA engines to transfer audio data over HD-A link:
set #0: 0x80 ~ 0x9c SD0CTL ~ SD0BDPU
set #1: 0xa0 ~ 0xbc SD1CTL ~ SD1BDPU
set #2: 0xc0 ~ 0xdc SD2CTL ~ SD2BDPU

Test shows that
On HSW, DMA update on all 3 sets of registers are okay.
On BDW, DMA update on set #1 and #2 are okay, but is buggy on set #0. Since the three sets of registers have the same definition according to spec and driver behavior is also same, it seems to be a HW issue.

Maybe we'll have to use the original reverse lookup order for BDW HDMI/DP audio.

Thanks
Mengdong
