From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [RFC] compress: add support for gapless playback
Date: Wed, 6 Feb 2013 06:31:18 -0800
Message-ID: <20130206143118.GL3143@intel.com>
References: <1360074085-562-1-git-send-email-vinod.koul@intel.com>
 <s5hk3ql8rd5.wl%tiwai@suse.de> <20130206140932.GJ3143@intel.com>
 <s5ha9rh8pmt.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 9B422261985
 for <alsa-devel@alsa-project.org>; Wed,  6 Feb 2013 15:56:03 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5ha9rh8pmt.wl%tiwai@suse.de>
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
Cc: Jeeja KP <jeeja.kp@intel.com>, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 06, 2013 at 03:48:26PM +0100, Takashi Iwai wrote:
> > > How is the operation flow?  Does it drain until which point?
> > Right, we want to move from one track to another. And while at this DSP needs to
> > exhaust the buffers from first track and then we should start writing second
> > track. When userspace has finsihed wirting first track it sends partial_drain
> > and DSP decods finsihed off and returns when it is ready to accept second track
> > data. The userland sends the metadata for this followed by data write.
> 
> Hm, could you depict the flow?  Will be like below?
> 
> - Open
> - Get caps / codec caps
> - Set params
> - Set metadata of the first track
> - Fill data of the first track
> - Trigger START
> - User-space finished sending all, then trigger PARTIAL_DRAIN
PARTAIL_DRAIN is returned when DSP has finished most of data from first track
and is ready to accept second track data
> - Set metadata of the next track
> - Fill data of the next track
DSP switches to second track
Keep writing till we finish track, then trigger PARTIAL_DRAIN
Continue till you reach end of album
Then trigger DRAIN
Close

I will add this to documentation patch as well...

> OK, then PARTIAL_DRAIN doesn't sound intuitive.
> Something like CONTINUE_TO_NEXT?
Sure, anyone else with a better name :-)
> 
> (I'm not particularly good at naming, so someone must have a better
>  idea...)
Welcome to club, I wont mind naming after you :D

--
~Vinod
