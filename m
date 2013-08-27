From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 2/9] ALSA: compress: use mutex in drain
Date: Tue, 27 Aug 2013 18:39:22 +0530
Message-ID: <20130827130922.GZ2748@intel.com>
References: <1377585639-29516-1-git-send-email-vinod.koul@intel.com>
 <1377585639-29516-3-git-send-email-vinod.koul@intel.com>
 <s5hioyrjur0.wl%tiwai@suse.de> <20130827094741.GV2748@intel.com>
 <s5hd2ozjtfh.wl%tiwai@suse.de> <20130827101614.GY2748@intel.com>
 <s5h8uznjpag.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id E1CA92651C2
 for <alsa-devel@alsa-project.org>; Tue, 27 Aug 2013 15:54:20 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5h8uznjpag.wl%tiwai@suse.de>
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

On Tue, Aug 27, 2013 at 02:23:19PM +0200, Takashi Iwai wrote:
> > > > > > +/* this fn is called without lock being held and we change stream states here
> > > > > > + * so while using the stream state auquire the lock but relase before invoking
> > > > > > + * DSP as the call will possibly take a while
> > > > > > + */
> > > > > >  static int snd_compr_drain(struct snd_compr_stream *stream)
> > > > > >  {
> > > > > >  	int retval;
> > > > > >  
> > > > > > +	mutex_lock(&stream->device->lock);
> > > > > >  	if (stream->runtime->state == SNDRV_PCM_STATE_PREPARED ||
> > > > > > -			stream->runtime->state == SNDRV_PCM_STATE_SETUP)
> > > > > > -		return -EPERM;
> > > > > > +			stream->runtime->state == SNDRV_PCM_STATE_SETUP) {
> > > > > > +		retval = -EPERM;
> > > > > > +		goto ret;
> > > > > > +	}
> > > > > > +	mutex_unlock(&stream->device->lock);
> > > > > >  	retval = stream->ops->trigger(stream, SND_COMPR_TRIGGER_DRAIN);
> > > > > 
> > > > > Why release the lock here?  The trigger callback is called within this
> > > > > mutex lock in other places.
> > > > This is the main part :)
> > > > 
> > > > Since the drain states will take a while (order of few seconds) to execute so we
> > > > will be blocked. Thats why we cant have lock here.
> > > 
> > > What's about other places calling the trigger ops within lock?
> > > You can't mix things.
> > Well i was going to treat drain only as exception to this. The issue here is
> > during the long drain other triggers are perfectly valid cases
> 
> An ops callback must be defined either to be locked or unlocked.
> Calling in the unlocked context only for some case doesn't sound
> right.
well all the callbacks except drain is called with lock held from framework...

> > > > The point of lock is to sync
> > > > the stream states here.
> > > 
> > > Without the lock, it's racy.  What if another thread calls the same
> > > function at the same time?
> > that part can be checked by seeing if we are already draining.
> 
> But how?  The place you're calling trigger is unlocked.
> Suppose another thread calling trigger_stop just between
> mutex_unlock() and stream->ops->trigger(DRAIN) call in the above.
> The state check doesn't work there.
the framework does this with lock held and then calls the driver
something like this will ensure this while making sync right...
	mutex_lock(&lock);
	if (state == DRAINING) {
		mutex_unlock(&lock);
		return -EPERM;
	} else
		state = DRAINING;
	mutex_unlock(&lock);

	ops->drain(substream);

	mutex_lock(&lock);
	state = DRAINED;
	mutex_unlock(&lock);
	
> 
> > > > We are not modfying anything. During drain and partial
> > > > drain we need to allow other trigger ops like pause, stop tog o thru so drop the
> > > > lock here for these two ops only!
> > > 
> > > Well, the biggest problem is that there is no proper design for which
> > > ops take a lock and which not.  The trigger callback is basically to
> > > trigger the action.  There should be no long-time blocking there.
> > > (Otherwise you'll definitely loose a gunfight :)
> > The reason for blocked implementation is to treat return of the call as
> > notifcation that draining is completed.
> > 
> > For example user has written all the buffers, lets says worth 3 secs and now has
> > triggered drain. User needs to wait till drain is complete before closing the
> > device etc. So he waits on drain to compelete..
> > 
> > Do you have a better way to manage this?
> 
> Split the drain action in two parts, trigger and synchronization:
> 
> 	lock();
> 	...
> 	trigger(pause);
> 	while (!pause_finished) {
> 		unlock();
> 		schedule_or_sleep_or_whatever();
> 		lock();
> 	}
> 	...
> 	unlock();
okay, i guess above is on same lines...

~Vinod
-- 
