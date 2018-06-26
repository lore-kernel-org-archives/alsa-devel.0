From: Shreyas NC <shreyas.nc@intel.com>
Subject: Re: [PATCH v4 3/7] soundwire: Add support to lock
 across	bus instances
Date: Tue, 26 Jun 2018 15:52:01 +0530
Message-ID: <20180626102201.GF15119@snc-desk>
References: <1529924340-30065-1-git-send-email-shreyas.nc@intel.com>
 <1529924340-30065-4-git-send-email-shreyas.nc@intel.com>
 <s5hy3f3yrbd.wl-tiwai@suse.de> <20180626082200.GC15119@snc-desk>
 <s5hy3f2aquu.wl-tiwai@suse.de> <20180626092359.GD15119@snc-desk>
 <s5hlgb1c22s.wl-tiwai@suse.de> <20180626095932.GE15119@snc-desk>
 <s5hfu19yhrp.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id BED092675C8
 for <alsa-devel@alsa-project.org>; Tue, 26 Jun 2018 12:23:31 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hfu19yhrp.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, patches.audio@intel.com, gregkh@linuxfoundation.org, pierre-louis.bossart@linux.intel.com, vkoul@kernel.org, sanyog.r.kale@intel.com
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 26, 2018 at 12:16:42PM +0200, Takashi Iwai wrote:
> On Tue, 26 Jun 2018 11:59:32 +0200,
> Shreyas NC wrote:
> > 
> > On Tue, Jun 26, 2018 at 11:46:35AM +0200, Takashi Iwai wrote:
> > > On Tue, 26 Jun 2018 11:23:59 +0200,
> > > Shreyas NC wrote:
> > > > 
> > > > On Tue, Jun 26, 2018 at 10:34:17AM +0200, Takashi Iwai wrote:
> > > > > On Tue, 26 Jun 2018 10:22:01 +0200,
> > > > > Shreyas NC wrote:
> > > > > > 
> > > > > > > > +/**
> > > > > > > > + * sdw_acquire_bus_lock: Acquire bus lock for all Master runtime(s)
> > > > > > > > + *
> > > > > > > > + * @stream: SoundWire stream
> > > > > > > > + *
> > > > > > > > + * Acquire bus_lock for each of the master runtime(m_rt) part of this
> > > > > > > > + * stream to reconfigure the bus.
> > > > > > > > + */
> > > > > > > > +static void sdw_acquire_bus_lock(struct sdw_stream_runtime *stream)
> > > > > > > > +{
> > > > > > > > +	struct sdw_master_runtime *m_rt = NULL;
> > > > > > > > +	struct sdw_bus *bus = NULL;
> > > > > > > > +
> > > > > > > > +	/* Iterate for all Master(s) in Master list */
> > > > > > > > +	list_for_each_entry(m_rt, &stream->master_list, stream_node) {
> > > > > > > > +		bus = m_rt->bus;
> > > > > > > > +
> > > > > > > > +		mutex_lock(&bus->bus_lock);
> > > > > > > > +	}
> > > > > > > > +}
> > > > > > > 
> > > > > > > So it's nested locks?  Then you'd need some more trick to deal with
> > > > > > > the lockdep.  I guess you'll get the false-positive deadlock detection
> > > > > > > by this code when the mutex lock debug is enabled.
> > > > > > > 
> > > > > > > Also, is the linked order assured not to lead to a real deadlock?
> > > > > > >
> > > > > > 
> > > > > > Hi Takashi,
> > > > > > 
> > > > > > Thanks for the review :)
> > > > > > 
> > > > > > A multi link SoundWire stream consists of a list of Master runtimes and
> > > > > > more importantly only one master runtime per SoundWire bus instance.
> > > > > > 
> > > > > > So, these mutexes are actually different mutex locks(one per bus instance)
> > > > > > and are not nested.
> > > > > 
> > > > > You take a mutex lock inside a mutex lock, so they are nested.
> > > > > If they take the very same lock, it's called a "deadlock" instead.
> > > > > 
> > > > 
> > > > Ok, myy bad, I misunderstood the comment :(
> > > > 
> > > > I forgot to add that I did check with mutex debug enabled and lockdep did
> > > > not complain though :)
> > > 
> > > You didn't test the actual concurrent calls because of FE's mutex
> > > below, right?
> > > 
> > 
> > Yes
> > 
> > > 
> > > > > > In SDW we have a bus instance per Master (link). In multi-link case, a
> > > > > > stream may have multiple Masters, thus we need to lock all bus instances
> > > > > > before we operate on them.
> > > > > > 
> > > > > > Now since these are invoked from a stream (pcm ops) they will be always
> > > > > > serialized and DPCM ensures we are never racing.
> > > > > > 
> > > > > > We did add this note here and in Documentation to make it explicit.
> > > > > 
> > > > > Well, my question is whether the order to take the multiple locks is
> > > > > always assured.  You're calling like:
> > > > > 
> > > > > 	list_for_each_entry(m_rt, &stream->master_list, stream_node)
> > > > > 		mutex_lock();
> > > > > 
> > > > > And it's a linked-list.  If a stream has a link of masters like
> > > > > M1->M2->M3 while another stream has a link like M2->M1->M3, it'll lead
> > > > > to a deadlock with the concurrent calls above.
> > > > > 
> > > > 
> > > > These are called from PCM stream ops context and the DPCM holds
> > > > lock(fe->card->mutex) which serializes these operations.
> > > > So, in the scenario you have mentioned, we would not have
> > > > concurrent calls to this function.
> > > 
> > > The implementation of soundwire bus is basically independent from ASoC
> > > or whatever else.  That is, any other drivers may use this API, and
> > > it'll be busted.
> > > 
> > 
> > Hmmh, yes. The only way we could think of to protect this is to use a global
> > lock which we wanted to avoid.
> > We did give this a thought and since today no other subsytem
> > can use this, we went ahead with the way it is today.
> > Any suggestions on how to go about this ?
> 
> If so, you have to give an explicit big fat warning for the usage in
> the function description.
> 

Ok, I had added it in the commit log and documentation.
It does make sense to add it in the function description.

Thanks!

--Shreyas
-- 
