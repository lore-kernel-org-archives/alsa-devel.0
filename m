From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [RFC] compress: add support for gapless playback
Date: Thu, 7 Feb 2013 08:34:18 -0800
Message-ID: <20130207163418.GS3143@intel.com>
References: <1360074085-562-1-git-send-email-vinod.koul@intel.com>
 <37A133201056E44A80888420ECA881BF1093DC5F68@EXCMB2.wolfsonmicro.main>
 <20130207011518.GA30348@opensource.wolfsonmicro.com>
 <20130207021807.GM3143@intel.com> <s5ha9rg5x0e.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
 by alsa0.perex.cz (Postfix) with ESMTP id 9415626501D
 for <alsa-devel@alsa-project.org>; Thu,  7 Feb 2013 17:59:02 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5ha9rg5x0e.wl%tiwai@suse.de>
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
Cc: jeeja.kp@intel.com, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, Richard Fitzgerald <rf@opensource.wolfsonmicro.com>, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

On Thu, Feb 07, 2013 at 09:49:37AM +0100, Takashi Iwai wrote:
> At Wed, 6 Feb 2013 18:18:07 -0800,
> Vinod Koul wrote:
> > 
> > On Thu, Feb 07, 2013 at 01:15:54AM +0000, Richard Fitzgerald wrote:
> > > > +- partial drain
> > > > +This is called when end of file is reached. The userspace can inform DSP that
> > > > +EOF is reached and now DSP can start skipping padding delay. Also next write
> > > > +data would belong to next track
> > > 
> > > We're really doing two different tasks inside the "partial drain". The name,
> > > and the reason we are doing two tasks in one, comes from a particular higher-
> > > layer scenario, but there's no reason the driver API need use the same
> > > terminology as one particular application of the functionality.
> > > The two tasks are:
> > > 
> > > 1) Tell the DSP that we have sent all data for the current track and following
> > > data will be for the next track. This lets the DSP lay down a marker for where
> > > it should strip padding at the end of a track, and know it should be expecting
> > > more data for another track to follow gaplessly where it must strip the
> > > encoder delay from the start.
> > > 
> > > 2) Ask for notification when DSP has reached the changeover point between the
> > > playback of the two tracks
> > > 
> > > I think it would be more logical and less confusing not to combine the two into
> > > a single ioctl. Instead, add only one new ioctl specifically to provide the
> > > track changeover hint, something like SNDRV_COMPRESS_NEXT_TRACK (meaning DSP
> > > should expect data for next track to follow). Don't add a new drain, just use
> > > the existing SNDRV_COMPRESS_DRAIN - the driver/DSP can make a decision whether
> > > it needs to do something special with the drain if we have told it that we
> > > will be sending it some more data for a following track.
> > > 
> > > So the SNDRV_COMPRESS_PARTIAL_DRAIN in this patch would become
> > > 
> > > 1) Send SNDRV_COMPRESS_NEXT_TRACK
> > > 2) Send SNDRV_COMPRESS_DRAIN
> > The problem would be in that case the defination of SNDRV_COMPRESS_DRAIN which
> > expects the decoder to completely drain its buffers and come to complete halt.
> > This would also mean the framework will treat a drained stream as stopped and
> > needs a new start. Certainly we dont want that in this case. So we can't use
> > SNDRV_COMPRESS_DRAIN to indicate. Yes we can put conditional check but IMO that
> > would overtly complicate this. If we are not doing proper drian lets not
> > call it that.
> > 
> > But I think I like the idea of splitting the two up to do a cleaner interface.
> > Let me check this...
> 
> In the way above, NEXT_TRACK is no longer a trigger op, but it's
> rather an operational option.  This would set a flag something like
> 	compr->drain_mode = SND_COMPR_DRAIN_RESTART;
> while its default is SND_COMPR_DRAIN_STOP.
> (Or, set compr->next_track_after_drain = true, or whatever.)
So the basic difference would be that stream is never stopped in gapless case.
The stream should retain running state maybe trasition to intermediate one for
book keeping but then needs to go back to running.

But, should framework really care about that as DSP is doing handling!

--
~Vinod
