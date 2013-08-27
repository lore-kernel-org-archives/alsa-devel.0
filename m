From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 2/9] ALSA: compress: use mutex in drain
Date: Tue, 27 Aug 2013 15:17:41 +0530
Message-ID: <20130827094741.GV2748@intel.com>
References: <1377585639-29516-1-git-send-email-vinod.koul@intel.com>
 <1377585639-29516-3-git-send-email-vinod.koul@intel.com>
 <s5hioyrjur0.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5hioyrjur0.wl%tiwai@suse.de>
Sender: stable-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 27, 2013 at 12:25:23PM +0200, Takashi Iwai wrote:
> At Tue, 27 Aug 2013 12:10:32 +0530,
> Vinod Koul wrote:
> > 
> > Since we dont have lock over the function, we need to aquire mutex when checking
> > and modfying states in drain and partial_drain handlers
> > 
> > Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> > Cc: <stable@vger.kernel.org>
> > ---
> >  sound/core/compress_offload.c |   22 +++++++++++++++++++---
> >  1 files changed, 19 insertions(+), 3 deletions(-)
> > 
> > diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
> > index 868aefd..e640f8c 100644
> > --- a/sound/core/compress_offload.c
> > +++ b/sound/core/compress_offload.c
> > @@ -676,18 +676,29 @@ static int snd_compr_stop(struct snd_compr_stream *stream)
> >  	return retval;
> >  }
> >  
> > +/* this fn is called without lock being held and we change stream states here
> > + * so while using the stream state auquire the lock but relase before invoking
> > + * DSP as the call will possibly take a while
> > + */
> >  static int snd_compr_drain(struct snd_compr_stream *stream)
> >  {
> >  	int retval;
> >  
> > +	mutex_lock(&stream->device->lock);
> >  	if (stream->runtime->state == SNDRV_PCM_STATE_PREPARED ||
> > -			stream->runtime->state == SNDRV_PCM_STATE_SETUP)
> > -		return -EPERM;
> > +			stream->runtime->state == SNDRV_PCM_STATE_SETUP) {
> > +		retval = -EPERM;
> > +		goto ret;
> > +	}
> > +	mutex_unlock(&stream->device->lock);
> >  	retval = stream->ops->trigger(stream, SND_COMPR_TRIGGER_DRAIN);
> 
> Why release the lock here?  The trigger callback is called within this
> mutex lock in other places.
This is the main part :)

Since the drain states will take a while (order of few seconds) to execute so we
will be blocked. Thats why we cant have lock here. The point of lock is to sync
the stream states here. We are not modfying anything. During drain and partial
drain we need to allow other trigger ops like pause, stop tog o thru so drop the
lock here for these two ops only!

~Vinod
