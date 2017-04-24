From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: PM issue with Intel SST Atom driver
Date: Mon, 24 Apr 2017 10:31:44 +0530
Message-ID: <20170424050144.GG6263@localhost>
References: <s5hpog5dgh8.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id 7DC65266C6A
 for <alsa-devel@alsa-project.org>; Mon, 24 Apr 2017 06:59:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hpog5dgh8.wl-tiwai@suse.de>
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
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 21, 2017 at 03:42:43PM +0200, Takashi Iwai wrote:
> Hi,
> 
> I noticed that the unstable PM behavior on my Cherrytrail laptop
> actually comes from the sound driver.  First off, the atom/sst/sst.c
> has the following suspend code:
> 
> static int intel_sst_suspend(struct device *dev)
> {
> ....
> 	/*
> 	 * check if any stream is active and running
> 	 * they should already by suspend by soc_suspend
> 	 */
> 	for (i = 1; i <= ctx->info.max_streams; i++) {
> 		struct stream_info *stream = &ctx->streams[i];
> 
> 		if (stream->status == STREAM_RUNNING) {
> 			dev_err(dev, "stream %d is running, can't suspend, abort\n", i);
> 			return -EBUSY;
> 		}
> 	}
> 
> This doesn't look good, and I actually hit this when I tried to
> suspend while playing something.  In general, the driver shouldn't
> reject at this point, because this is the PM suspend callback,
> i.e. the user wants to suspend the device inevitably.  The driver
> should return an error only when it faces to a fatal error.

Mea culpa

And you are now second person to complain about this so I wonder if we
should rework this

So from hardware POV, we need to first suspend all running streams and then
save the context from DSP (in order to restore them later) and then we can
shutdown the DSP.

The problem is driver being split into platform (which knows streams) and
sst dsp driver. So we devised a careful sequence where platform suspend is
invoked first (calls using asoc pm ops) and then DSP

This results is ASoC doing stream suspend for us and when we hit
intel_sst_suspend() we are supposed to have stream suspended, so save and
shut off DSP.

Now for you issue you see can you check why platform suspend is not getting
called?

> 
> But I wondered why this happened at all, and noticed that the machine
> driver (in my case bytcr_rt5640) has no its own PM ops.  But hooking
> the snd_soc_pm_ops there seems causing a hang up at suspend by some
> reason.

O yes, thats due to double suspend

See 3639ac1cd5177685a5c8abb7230096b680e1d497

> 
> Maybe this wasn't a big problem until now since the BYT/CHT didn't
> support the suspend/resume properly in the past.  But now PM suspend
> is supported on these devices, so the problem surfaced more often.

The Chromebooks shipped on BSW use this method so..

> Could you guys check the status of these drivers?

-- 
~Vinod
