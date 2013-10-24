From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] ALSA: compress: fix drain calls blocking
 other compress functions
Date: Thu, 24 Oct 2013 14:57:24 +0530
Message-ID: <20131024092724.GW14013@intel.com>
References: <1382545021-26918-1-git-send-email-vinod.koul@intel.com>
 <1382600141-9866-1-git-send-email-vinod.koul@intel.com>
 <s5hli1jnhps.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 97B2B260863
 for <alsa-devel@alsa-project.org>; Thu, 24 Oct 2013 12:21:32 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hli1jnhps.wl%tiwai@suse.de>
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

On Thu, Oct 24, 2013 at 11:25:35AM +0200, Takashi Iwai wrote:
> At Thu, 24 Oct 2013 13:05:41 +0530,
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
> > v2:
> >  fix the 80 line warn
> >  move the state change to compress_drain()
> > 
> >  include/sound/compress_driver.h |   12 ++++++++++
> >  sound/core/compress_offload.c   |   43 ++++++++++++++++++++++++++++++++++++--
> >  2 files changed, 52 insertions(+), 3 deletions(-)
> > 
> > diff --git a/include/sound/compress_driver.h b/include/sound/compress_driver.h
> > index 9031a26..eff5f84 100644
> > --- a/include/sound/compress_driver.h
> > +++ b/include/sound/compress_driver.h
> > @@ -48,6 +48,8 @@ struct snd_compr_ops;
> >   *	the ring buffer
> >   * @total_bytes_transferred: cumulative bytes transferred by offload DSP
> >   * @sleep: poll sleep
> > + * @wait: drain wait queuq
> > + * @draining: draining wait condition
> 
> What does this mean exactly?  I thought draining = 1 meaning that the
> stream is draining (i.e. waiting for the finish notification), but
> it looks opposite in your code below...
What i meant was the draining wait conditions which would be used for waiting.
Before wait the caller will set to 0 and on completion the callback will set to
1 and wake up.

> >   */
> >  struct snd_compr_runtime {
> >  	snd_pcm_state_t state;
> > @@ -59,6 +61,8 @@ struct snd_compr_runtime {
> >  	u64 total_bytes_available;
> >  	u64 total_bytes_transferred;
> >  	wait_queue_head_t sleep;
> > +	wait_queue_head_t wait;
> > +	unsigned int draining;
> >  	void *private_data;
> >  };
> >  
> > @@ -171,4 +175,12 @@ static inline void snd_compr_fragment_elapsed(struct snd_compr_stream *stream)
> >  	wake_up(&stream->runtime->sleep);
> >  }
> >  
> > +static inline void snd_compr_drain_notify(struct snd_compr_stream *stream)
> > +{
> > +	snd_BUG_ON(!stream);
> > +
> > +	stream->runtime->draining = 1;
> > +	wake_up(&stream->runtime->wait);
> > +}
> > +
> >  #endif
> > diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
> > index bea523a..c030365 100644
> > --- a/sound/core/compress_offload.c
> > +++ b/sound/core/compress_offload.c
> > @@ -123,6 +123,7 @@ static int snd_compr_open(struct inode *inode, struct file *f)
> >  	}
> >  	runtime->state = SNDRV_PCM_STATE_OPEN;
> >  	init_waitqueue_head(&runtime->sleep);
> > +	init_waitqueue_head(&runtime->wait);
> >  	data->stream.runtime = runtime;
> >  	f->private_data = (void *)data;
> >  	mutex_lock(&compr->lock);
> > @@ -682,12 +683,36 @@ static int snd_compr_stop(struct snd_compr_stream *stream)
> >  	if (!retval) {
> >  		stream->runtime->state = SNDRV_PCM_STATE_SETUP;
> >  		wake_up(&stream->runtime->sleep);
> > +		stream->runtime->draining = 1;
> > +		wake_up(&stream->runtime->wait);
> 
> Not using snd_compr_drain_notify()?
Yes that should be added, thanks for pointing!

> >  		stream->runtime->total_bytes_available = 0;
> >  		stream->runtime->total_bytes_transferred = 0;
> >  	}
> >  	return retval;
> >  }
> >  
> > +static int snd_compress_wait_for_drain(struct snd_compr_stream *stream)
> > +{
> > +	int retval = 0;
> > +
> > +	/*
> > +	 * we are called with lock held. So drop the lock while we wait for
> > +	 * drain complete notfication from the driver
> > +	 */
> > +	stream->runtime->state = SNDRV_PCM_STATE_DRAINING;
> > +	mutex_unlock(&stream->device->lock);
> > +
> > +	retval = wait_event_interruptible(stream->runtime->wait,
> > +			stream->runtime->draining);
> > +	if (retval)
> > +		pr_err("Wait for drain failed %d\n", retval);
> 
> If you make it interruptible, it's no actual kernel error when user
> interrupts the operation, so no reason to put the kernel error message
> there.  At least, better to check whether it's a user interruption or
> a system error.
Agreed. I think I dont even need to make it interruptible. If user is
terminating the stop will be invoked and then with above fix it should work. We
can do away with interrutiple part :)

> > +
> > +	wake_up(&stream->runtime->sleep);
> > +	mutex_lock(&stream->device->lock);
> > +
> > +	return retval;
> > +}
> > +
> >  static int snd_compr_drain(struct snd_compr_stream *stream)
> >  {
> >  	int retval;
> > @@ -695,11 +720,17 @@ static int snd_compr_drain(struct snd_compr_stream *stream)
> >  	if (stream->runtime->state == SNDRV_PCM_STATE_PREPARED ||
> >  			stream->runtime->state == SNDRV_PCM_STATE_SETUP)
> >  		return -EPERM;
> > +
> > +	stream->runtime->draining = 0;
> >  	retval = stream->ops->trigger(stream, SND_COMPR_TRIGGER_DRAIN);
> > -	if (!retval) {
> > -		stream->runtime->state = SNDRV_PCM_STATE_DRAINING;
> > +	if (retval) {
> > +		pr_err("SND_COMPR_TRIGGER_DRAIN failed %d\n", retval);
> >  		wake_up(&stream->runtime->sleep);
> > +		return retval;
> >  	}
> > +
> > +	retval = snd_compress_wait_for_drain(stream);
> > +	stream->runtime->state = SNDRV_PCM_STATE_SETUP;
> 
> So, the runtime state goes to SETUP even if wait_for_drain() returns
> an error?  In other words, compress core expects that the driver takes
> care of the proper state change in the error handling?
I guess it would make sense to communicate error. I havent added notion of
status on drain complete. By adding another status flag in the callback we cna
let driver tell us if error occured. Then pass the error in draining value and
do the state change accordingly.

--
~Vinod
