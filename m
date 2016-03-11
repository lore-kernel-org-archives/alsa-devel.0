From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 1/4] ASoC: compress: Pass error out of
	soc_compr_pointer
Date: Fri, 11 Mar 2016 16:11:01 +0530
Message-ID: <20160311104101.GA11154@localhost>
References: <1457606694-10985-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <20160311074843.GV11154@localhost>
 <20160311100425.GH1490@localhost.localdomain>
 <s5hfuvx5n1p.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id E180B2610A6
 for <alsa-devel@alsa-project.org>; Fri, 11 Mar 2016 11:36:59 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hfuvx5n1p.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, broonie@kernel.org, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 11, 2016 at 11:25:22AM +0100, Takashi Iwai wrote:
> > I guess my return question would be I can imagine many reasons
> > why a pointer query might fail, especially for off chip DSPs.
> > What is the reasoning for wanting to hide those errors from the
> > rest of the system? It seems to me it would be best to handle an
> > error as soon as it is noticed, and if a particular system has a
> > pointer request that never fails then it can just not return an
> > error.
> 
> IMO, propagating the error immediately is a good thing.  I guess it
> wasn't checked in the pointer callback just because the pointer
> callback was supposed to be a simple state copy without involving the
> state change.
> 
> OTOH, another question is whether it's enough just to tell the error
> there as is.  When such an error is detected, it essentially means
> that the whole DSP got wrong.  What we can do at best is to prepare
> for recovery.  And this requires the state change.

Yes, for recovery on our DSP we do inoke snd_pcm_stop() for all the open
streams and then get these restarted. I think we need to do same for
compress too..

> Actually, PCM pointer callback may return a special value indicating
> an XRUN error.  The PCM core reacts for it, stops the stream and
> changes the stream state, so that further accesses get the error
> consistently.  Similar mechanism would be needed for compress API, I
> suppose.

I didnt know that :)

-- 
~Vinod
