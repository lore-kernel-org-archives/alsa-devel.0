From: Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: ALSA patch Nvidia 8 channel hdmi audio
Date: Fri, 5 Jun 2009 14:14:07 +0800
Message-ID: <20090605061407.GA16909@localhost>
References: <410e92830906021530l767478c4tae72c4b161583b6@mail.gmail.com>
	<200906030200.54455.marek.vasut@gmail.com>
	<15F501D1A78BD343BE8F4D8DB854566B058A63F1@hkemmail01.nvidia.com>
	<410e92830906030100m5a3d045dsa856382fa2396e60@mail.gmail.com>
	<15F501D1A78BD343BE8F4D8DB854566B058A63F2@hkemmail01.nvidia.com>
	<s5h4ouxshq3.wl%tiwai@suse.de>
	<15F501D1A78BD343BE8F4D8DB854566B058A63F3@hkemmail01.nvidia.com>
	<s5hzlco4im2.wl%tiwai@suse.de> <20090605042829.GA14167@localhost>
	<s5hbpp31bmd.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id 62FF7245A1
	for <alsa-devel@alsa-project.org>;
	Fri,  5 Jun 2009 08:14:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hbpp31bmd.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Peer Chen <pchen@nvidia.com>, Marek Vasut <marek.vasut@gmail.com>, Wei Ni <wni@nvidia.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Alan Alan <alanwww1@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 05, 2009 at 01:40:58PM +0800, Takashi Iwai wrote:
> At Fri, 5 Jun 2009 12:28:29 +0800,
> Wu Fengguang wrote:
> > 
> > On Thu, Jun 04, 2009 at 08:29:25AM +0200, Takashi Iwai wrote:
> > > At Thu, 4 Jun 2009 14:05:52 +0800,
> > > Wei Ni wrote:
> > > > 
> > > > Yes, my test wav file is from Windows.
> > > > 
> > > > I had used different player to test with my test wav file.
> > > > The mplayer has no mapping problem, but other players map channels
> > > > wrong.
> > > > As you said, it seems that is caused by the difference of the ALSA and
> > > > Windows.
> > > 
> > > I guess mplayer corrects the channel mapping automatically.
> > > 
> > > > Unfortunately, our nvidia codec doesn't support channel-slot assignment
> > > > yet.
> > > 
> > > OK.
> > > 
> > > > How could we fix this problems, do you have any suggestions?
> > > 
> > > It's a bit difficult issue right now.  Usually we could "fix" the
> > > channel mapping in alsa-lib configuration.  But, HD-audio has currently
> > > a single alsa-lib configuration, and others may use the right channel
> > > mapping.
> > > 
> > > I don't remember how is the case of Intel HDMI...  Can anyone check?
> > 
> > The codecs I tested - G35/G45/GM45 - does not support the channel-slot
> > assignment. I guess future hardwares may support that.
> 
> OK, and the channel assignment is also FL/FR/C/LFE/RL/RR, right?

It's FL/FR/LFE/FC/RL/RR for 5.1, but it can be more complicated. HDMI supports
a number of speaker configurations - which will be reported via ELD by HDMI
sinks.  And we have a big mapping table name channel_allocations in
patch_intelhdmi.c.

The 6 channel configurations listed in the table are:

                                 /* 5.1 */
{ .ca_index = 0x0b,  .speakers = {   0,    0,  RR,  RL,  FC,  LFE,  FR,  FL } },
{ .ca_index = 0x0c,  .speakers = {   0,   RC,  RR,  RL,   0,    0,  FR,  FL } },
{ .ca_index = 0x0d,  .speakers = {   0,   RC,  RR,  RL,   0,  LFE,  FR,  FL } },
{ .ca_index = 0x0e,  .speakers = {   0,   RC,  RR,  RL,  FC,    0,  FR,  FL } },


Thanks,
Fengguang
