From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v5] ALSA: compress: fix drain calls
 blocking other compress functions
Date: Thu, 7 Nov 2013 12:56:47 +0530
Message-ID: <20131107072647.GA2990@intel.com>
References: <1383803409-2269-1-git-send-email-vinod.koul@intel.com>
 <s5hd2mcelu1.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id C4485260376
 for <alsa-devel@alsa-project.org>; Thu,  7 Nov 2013 09:21:54 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hd2mcelu1.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 07, 2013 at 08:02:14AM +0100, Takashi Iwai wrote:
> At Thu,  7 Nov 2013 11:20:09 +0530,
> Vinod Koul wrote:
> > 
> > The drain and drain_notify callback were blocked by low level driver untill the
> > draining was complete. Due to this being invoked with big fat mutex held, others
> > ops like reading timestamp, calling pause, drop were blocked.
> > 
> > So to fix this we add a new snd_compr_drain_notify() API. This would be required
> > to be invoked by low level driver when drain or partial drain has been completed
> > by the DSP. Thus we make the drain and partial_drain callback as non blocking
> > and driver returns immediately after notifying DSP.
> > The waiting is done while relasing the lock so that other ops can go ahead.
> > 
> > Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> > CC: stable@vger.kernel.org
> > ---
> > v5:
> >  remove the drain_wake and wait queue and use the existing wait queue
> >  make wait in draining state as interruptible
> > 
> > v4:
> >  move pr_err -> pr_debug to avoid spamming kernel log
> >  make wait in drain interruptible
> > v3:
> >  call snd_compr_drain_notify from compress_stop()
> >  rename draining -> drain_wake
> >  add some comments on state transistion after drain
> > v2:
> >  fix the 80 line warn
> >  move the state change to compress_drain()
> > 
> > include/sound/compress_driver.h |    9 ++++++
> >  sound/core/compress_offload.c   |   52 ++++++++++++++++++++++++++++++++++++---
> >  2 files changed, 57 insertions(+), 4 deletions(-)
> > 
> > diff --git a/include/sound/compress_driver.h b/include/sound/compress_driver.h
> > index 9031a26..ae6c3b8 100644
> > --- a/include/sound/compress_driver.h
> > +++ b/include/sound/compress_driver.h
> > @@ -171,4 +171,13 @@ static inline void snd_compr_fragment_elapsed(struct snd_compr_stream *stream)
> >  	wake_up(&stream->runtime->sleep);
> >  }
> >  
> > +static inline void snd_compr_drain_notify(struct snd_compr_stream *stream)
> > +{
> > +	if (snd_BUG_ON(!stream))
> > +		return;
> > +
> > +	stream->runtime->state = SNDRV_PCM_STATE_SETUP;
> > +	wake_up(&stream->runtime->sleep);
> > +}
> > +
> >  #endif
> > diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
> > index bea523a..e60e0c9 100644
> > --- a/sound/core/compress_offload.c
> > +++ b/sound/core/compress_offload.c
> > @@ -682,12 +682,48 @@ static int snd_compr_stop(struct snd_compr_stream *stream)
> >  	if (!retval) {
> >  		stream->runtime->state = SNDRV_PCM_STATE_SETUP;
> >  		wake_up(&stream->runtime->sleep);
> > +		snd_compr_drain_notify(stream);
> 
> The two lines above this do the exactly same as
> snd_compr_drain_notify(), thus it can be dropped here.
ah yes will send updated one..

--
~Vinod
