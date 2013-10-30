From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v3] ALSA: compress: fix drain calls
 blocking other compress functions
Date: Wed, 30 Oct 2013 20:48:40 +0530
Message-ID: <20131030151840.GD18788@intel.com>
References: <1382600141-9866-1-git-send-email-vinod.koul@intel.com>
 <1382612851-18058-1-git-send-email-vinod.koul@intel.com>
 <s5heh72u86m.wl%tiwai@suse.de> <20131030145811.GC18788@intel.com>
 <s5h8uxau4rh.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 850F1265463
 for <alsa-devel@alsa-project.org>; Wed, 30 Oct 2013 17:13:20 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5h8uxau4rh.wl%tiwai@suse.de>
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

On Wed, Oct 30, 2013 at 05:01:38PM +0100, Takashi Iwai wrote:
 
> > > > +static int snd_compress_wait_for_drain(struct snd_compr_stream *stream)
> > > > +{
> > > > +	/*
> > > > +	 * We are called with lock held. So drop the lock while we wait for
> > > > +	 * drain complete notfication from the driver
> > > > +	 *
> > > > +	 * It is expected that driver will notify the drain completion and then
> > > > +	 * stream will be moved to SETUP state, even if draining resulted in an
> > > > +	 * error. We can trigger next track after this.
> > > > +	 */
> > > > +	stream->runtime->state = SNDRV_PCM_STATE_DRAINING;
> > > > +	mutex_unlock(&stream->device->lock);
> > > > +
> > > > +	wait_event(stream->runtime->wait, stream->runtime->drain_wake);
> > > 
> > > Don't you really want the interruption?
> > > Or use wait_event_interruptible() and return error appropriately.
> > any interruption from usermode should trigger the compress_stop/compress_free
> 
> ... but how?
> 
> > which will unblock this. I dont see the need to have interruptible here
> 
> Suppose you're running a single thread program.  Then who triggers the
> stop?
Your signal catcher which should be registered for signals intrested and then
calls stop or free. Assuming this should be considered single threaded. IIRC,
this is how you do in aplay, right?

Btw am okay to make it interruptible, but since can be done in usermode and
closed which unblocks this I would prefer this way. Pls do let me know :)
--
~Vinod
