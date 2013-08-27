From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 2/9] ALSA: compress: use mutex in drain
Date: Tue, 27 Aug 2013 19:40:51 +0530
Message-ID: <20130827141051.GF2748@intel.com>
References: <1377585639-29516-1-git-send-email-vinod.koul@intel.com>
 <1377585639-29516-3-git-send-email-vinod.koul@intel.com>
 <s5hioyrjur0.wl%tiwai@suse.de> <20130827094741.GV2748@intel.com>
 <s5hd2ozjtfh.wl%tiwai@suse.de> <20130827101614.GY2748@intel.com>
 <s5h8uznjpag.wl%tiwai@suse.de> <20130827130922.GZ2748@intel.com>
 <s5hy57ni63s.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 025802652B9
 for <alsa-devel@alsa-project.org>; Tue, 27 Aug 2013 16:56:13 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hy57ni63s.wl%tiwai@suse.de>
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

On Tue, Aug 27, 2013 at 04:03:03PM +0200, Takashi Iwai wrote:
> > > An ops callback must be defined either to be locked or unlocked.
> > > Calling in the unlocked context only for some case doesn't sound
> > > right.
> > well all the callbacks except drain is called with lock held from framework...
> 
> You're calling the same ops with and without the lock.
> I'd understand better if you created a new ops for drain, but in the
> current patch, it's still the same ops...
yup but cant different callbacks in the ops have different conditions. Anyway
all except drain ones are supposed to NOT block.
> 
> > > > > > The point of lock is to sync
> > > > > > the stream states here.
> > > > > 
> > > > > Without the lock, it's racy.  What if another thread calls the same
> > > > > function at the same time?
> > > > that part can be checked by seeing if we are already draining.
> > > 
> > > But how?  The place you're calling trigger is unlocked.
> > > Suppose another thread calling trigger_stop just between
> > > mutex_unlock() and stream->ops->trigger(DRAIN) call in the above.
> > > The state check doesn't work there.
> > the framework does this with lock held and then calls the driver
> > something like this will ensure this while making sync right...
> 
> It's still racy.  In your code below:
> 
> > 	mutex_lock(&lock);
> > 	if (state == DRAINING) {
> > 		mutex_unlock(&lock);
> > 		return -EPERM;
> > 	} else
> > 		state = DRAINING;
> > 	mutex_unlock(&lock);
> 
> Suppose that another thread calls stop at this point before
> ops->drain() is called.  It'll change the state to STOP, call
> ops->trigger(STOP).  And ops->drain() (or ops->trigger(DRAIN)) may be
> called at the same time because there is no protection without knowing
> that it's being stopped.
yup...

> 
> > 	ops->drain(substream);
> > 
> > 	mutex_lock(&lock);
> > 	state = DRAINED;
> > 	mutex_unlock(&lock);
> 
> Takashi
> 
> 
> > > > > > We are not modfying anything. During drain and partial
> > > > > > drain we need to allow other trigger ops like pause, stop tog o thru so drop the
> > > > > > lock here for these two ops only!
> > > > > 
> > > > > Well, the biggest problem is that there is no proper design for which
> > > > > ops take a lock and which not.  The trigger callback is basically to
> > > > > trigger the action.  There should be no long-time blocking there.
> > > > > (Otherwise you'll definitely loose a gunfight :)
> > > > The reason for blocked implementation is to treat return of the call as
> > > > notifcation that draining is completed.
> > > > 
> > > > For example user has written all the buffers, lets says worth 3 secs and now has
> > > > triggered drain. User needs to wait till drain is complete before closing the
> > > > device etc. So he waits on drain to compelete..
> > > > 
> > > > Do you have a better way to manage this?
> > > 
> > > Split the drain action in two parts, trigger and synchronization:
> > > 
> > > 	lock();
> > > 	...
> > > 	trigger(pause);
> > > 	while (!pause_finished) {
> > > 		unlock();
> > > 		schedule_or_sleep_or_whatever();
> > > 		lock();
> > > 	}
> > > 	...
> > > 	unlock();
with this am thinking of handling it differently now on the above lines and
split the drain action and drain blocking parts. Trigger and action.

How about making the drain and partial drain triggers calls NOT blocking.
This will take care of sync issues etc.

But we also need to have notification for when drain completes.

IMO this can be handled in two ways
a) like in above we sleep and wake up on notification from driver.
Driver can call the drain_complete() which wakes up and we return to user
b) we call the driver for drain and then call blocking new callback which
returns when action is complete

~Vinod
-- 
