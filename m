From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: Timer instability
Date: Fri, 20 Feb 2009 02:26:17 +0100
Message-ID: <20090220012617.GA12137@tango.0pointer.de>
References: <20090219024611.GA7930@tango.0pointer.de>
	<s5hy6w2hqap.wl%tiwai@suse.de>
	<20090220012220.GA11526@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 538571037F8
	for <alsa-devel@alsa-project.org>; Fri, 20 Feb 2009 02:26:19 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090220012220.GA11526@tango.0pointer.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 20.02.09 02:22, Lennart Poettering (mznyfn@0pointer.de) wrote:

> 
> On Thu, 19.02.09 07:52, Takashi Iwai (tiwai@suse.de) wrote:
> 
> > 
> > At Thu, 19 Feb 2009 03:46:11 +0100,
> > Lennart Poettering wrote:
> > > 
> > > Heya!
> > > 
> > > As you might now PulseAudio schedules audio by system timers, not by
> > > sound card interrupts. Unfortunately there are are couple of issues
> > > with the reliability of the timing/buffering information we get from
> > > ALSA. 
> > > 
> > > For example, on an ens1371 I have tracked down the following issue: I
> > > use the full buffer that the sound card provides (64K, i.e. 371ms). I
> > > sleep for about 350 ms, then fill up again, and sleep 350ms, and so
> > > and so on. Everytime I wake up I check snd_pcm_avail() and write
> > > exactly as much as this call tells me to. I also listen to POLLOUT
> > > events on the fd, however I call snd_pcm_sw_params_set_period_event(,
> > > 0) for it to make sure I actually don't get any real events on that.
> > > 
> > > After a couple of minutes of running this loop I can reliably
> > > reproduce that _avail() tells me I should fill the buffer up, I do so,
> > > query it again and it shows the buffer is filled up. I then go to
> > > sleep but immediately get POLLIN (although I shouldnt, given that I
> > > called snd_pcm_sw_params_set_period_event()), wake up again, call
> > > snd_pcm_avail() and according to it the buffer ran completely
> > > empty. The poll() took less than 1 ms time, and the last thing I did
> > > before going to sleep was checking that the buffer was full. So
> > > certainly ALSA is lying to me here... The buffer couldn't have run
> > > empty in less than 1 ms!
> > > 
> > > The same with real numbers as one example:
> > > 
> > >   1. ... we are woken up
> > >   2. _avail() returns 15496 samples (i.e. 350ms to fill up)
> > >   3. we gather and write 15496 samples
> > >   4. _avail() returns 48 samples, which we consider "filled up enough" to go to sleep
> > >   5. we call poll()
> > >   6. after < 1ms we are woken up by a POLLIN (which we actually thought we had explicitly disabled)
> > >   7. _avail() returns 16448 samples (i.e. 372ms to fill up -- larger than the actual buffer of 16384 samples!)  
> > >   
> > > This smells a lot like some kind of overflow to me, given that in every
> > > case where I could reproduce this it was possible to 'fix' the issue
> > > by substracting the buffer size from the _avail() after the
> > > poll(). After that substraction the value started to make sense
> > > again. (i.e. in the example above it then becomes 64 samples, which is
> > > reasonable after sleep less than 1ms I guess).
> > > 
> > > The stop threshold is set to the boundary here btw.
> > > 
> > > If necessary I could extract a test case for this, but my hope that
> > > you guys might have an idea what goes on without a test case, given
> > > that this smells so "overflowy" ;-)
> > > 
> > > And of course, how come ALSA triggers POLLIN if I asked it not to?
> > 
> > Are you using *_period_event() stuff?
> 
> Yes, I am. But ignore that part for now. I have now commented the use
> of that call. Now I certainly get more POLLOUTs as expected, but the
> real problem stays: after a few minutes _avail() will suddenly jump
> from next to zero to more then the hwbuf size in less than 1ms without
> any further inteference and with a buffer size of 350ms! There is
> something really wrong with the behaviour of _avail().
> 
> I can reproduce this only on ens1371 for now.

Oh, and upgrading to 2.6.29-rc5 had no effect either. Problem stays.

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
