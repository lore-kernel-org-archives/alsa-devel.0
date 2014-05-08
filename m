From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH] ALSA: hda - using POS_FIX_LPIB on
	Broadwell HDMI Audio
Date: Thu, 8 May 2014 09:37:13 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F82B40DA9C@SHSMSX101.ccr.corp.intel.com>
References: <1399485804-75028-1-git-send-email-libin.yang@intel.com>
 <s5hzjisq2kj.wl%tiwai@suse.de>
 <96A12704CE18D347B625EE2D4A099D195232A6@SHSMSX103.ccr.corp.intel.com>
 <s5htx90q0mi.wl%tiwai@suse.de>
 <96A12704CE18D347B625EE2D4A099D19523313@SHSMSX103.ccr.corp.intel.com>
 <s5hr444pzap.wl%tiwai@suse.de>
 <96A12704CE18D347B625EE2D4A099D1952333A@SHSMSX103.ccr.corp.intel.com>
 <s5hoaz8pydg.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id 4EDE526109C
 for <alsa-devel@alsa-project.org>; Thu,  8 May 2014 11:37:18 +0200 (CEST)
In-Reply-To: <s5hoaz8pydg.wl%tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>, "Yang, Libin" <libin.yang@intel.com>
Cc: "Li, Jocelyn" <jocelyn.li@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

Is it possible to accept this patch as a quick fix?

It seems that a driver regression triggers this issue, since we don't have this problem two weeks ago.
We're still trying to locate the regression and checking the root cause. 

This patch could avoid audio degradation atm before we have a better solution.

Thanks
Mengdong

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Thursday, May 08, 2014 2:40 PM
> To: Yang, Libin
> Cc: alsa-devel@alsa-project.org; Lin, Mengdong; Pierre-Louis Bossart
> Subject: Re: [PATCH] ALSA: hda - using POS_FIX_LPIB on Broadwell HDMI Audio
> 
> At Thu, 8 May 2014 06:28:17 +0000,
> Yang, Libin wrote:
> >
> > Hi Takashi,
> >
> > > -----Original Message-----
> > > From: Takashi Iwai [mailto:tiwai@suse.de]
> > > Sent: Thursday, May 8, 2014 2:20 PM
> > > To: Yang, Libin
> > > Cc: alsa-devel@alsa-project.org; Lin, Mengdong; Pierre-Louis Bossart
> > > Subject: Re: [PATCH] ALSA: hda - using POS_FIX_LPIB on Broadwell
> > > HDMI Audio
> > >
> > > At Thu, 8 May 2014 06:13:31 +0000,
> > > Yang, Libin wrote:
> > > >
> > > > Hi Takashi,
> > > >
> > > > > -----Original Message-----
> > > > > From: Takashi Iwai [mailto:tiwai@suse.de]
> > > > > Sent: Thursday, May 8, 2014 1:51 PM
> > > > > To: Yang, Libin
> > > > > Cc: alsa-devel@alsa-project.org; Lin, Mengdong; Pierre-Louis
> > > > > Bossart
> > > > > Subject: Re: [PATCH] ALSA: hda - using POS_FIX_LPIB on Broadwell
> > > > > HDMI Audio
> > > > >
> > > > > At Thu, 8 May 2014 05:48:04 +0000, Yang, Libin wrote:
> > > > > >
> > > > > > Hi Takashi,
> > > > > >
> > > > > > I checked the wallclock counter. The counter is OK. But it
> > > > > > failed to correct
> > > > > the position.
> > > > >
> > > > > So, how wrong the position buffer is?  Is the problem intermittent?
> > > > > Please elaborate more.
> > > >
> > > > The issue is the position is almost always inaccurate. You will
> > > > hear there is
> > > intermittent noise in the sound. And the sound is played faster than
> > > it should be.
> > > >
> > > > The following message is what I got from dmesg:
> > > >
> > > > [ 73.278117] snd_hda_intel 0000:00:03.0: IRQ timing workaround is
> > > activated for card #0. Suggest a bigger bdl_pos_adj.
> > > > [ 73.528575] snd_hda_intel 0000:00:03.0: Unstable LPIB (26240 >=
> > > > 24064); disabling LPIB delay counting
> > > >
> > > > Do you think the print of wallclk and position information in the
> > > > function
> > > azx_position_ok() is useful to you? If yes, I will add debug code to
> > > print the info.
> > >
> > > It'd better to have the raw values of posbuf, lpib and wallclock for
> > > further analysis, yes.
> > >
> > > BTW, did you try non-snoop mode via snoop=0 option?
> >
> > I haven't tried non-snoop. Do I use `modprobe snd-hda-intel snoop=0` to use
> non-snoop mode?
> 
> Yes.
> 
> Takashi
