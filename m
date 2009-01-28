From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: Misusing snd_pcm_avail_update()
Date: Wed, 28 Jan 2009 19:26:08 +0100
Message-ID: <20090128182608.GF11770@tango.0pointer.de>
References: <20090120025727.GA30499@tango.0pointer.de>
	<49758B71.8090605@ladisch.de>
	<20090120142614.GA27494@tango.0pointer.de>
	<49761C79.8060605@ladisch.de>
	<20090120202933.GA17626@tango.0pointer.de>
	<s5hwscpqypo.wl%tiwai@suse.de>
	<20090122222015.GB9379@tango.0pointer.de>
	<s5htz7q54k3.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id AFC101037E3
	for <alsa-devel@alsa-project.org>; Wed, 28 Jan 2009 19:26:08 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5htz7q54k3.wl%tiwai@suse.de>
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

On Fri, 23.01.09 18:13, Takashi Iwai (tiwai@suse.de) wrote:

> > snd_pcm_update_avail() -- returns how many samples can be written
> >                           right now without blocking.
> > 
> > snd_pcm_delay() -- returns how many samples will be played before the
> >                    samples that are written now can be heard.
> > 
> > snd_pcm_busy_for() -- returns how many samples will be played before
> >                       ALSA would enter an underrun situation if no
> >                       further samples are written.
> 
> Well, in a ring-buffer model,
> 
>     snd_pcm_busy_for = buffer_size - snd_pcm_update_avail

That is what I currently use in PA and which turns out not to work so
well. Due to granularity and due to "fast starts" such as done by the
USB driver.

> If a granularity matters (e.g. no accurate sample position update can
> be done), it would be
> 
>     snd_pcm_busy_for = max{0, buffer_size - s_p_u_a - granularity}
> 
> The granularity is between 0 and period_size.  The batch-mode is
> granularity = period_size.

It would be good to have something to query the current
granularity. (as Clemens suggested)

> > snd_pcm_update_avail() and snd_pcm_busy_for() return metrics that are
> > solely dependant on the size and metrics of the hardware buffer and
> > its current indexes. snd_pcm_delay() also includes information about
> > any extra latency that comes after the playback buffer.
> > 
> > Onle snd_pcm_update_avail()/snd_pcm_busy_for() are influenced by "fast
> > starts" as done by the USB driver's double buffering and by
> > block-based transfer.
> > 
> > Hmm, I am trying my best to explain why I want this function and what
> > exactly it should do. Any chance I can convince you guys that this
> > function really matters for timer-based audio scheduling?
> 
> I don't care much about the user-space API at this moment.  My main
> concern is what kernel <-> user API is needed in addition or needed
> to be changed.
> 
> If it's a question how to pass the granularity to user-space, usually
> it's a constant value, and thus it can be put somewhere in the
> existing struct, or add a single ioctl. 
> 
> OTOH, if it has to be implemented as a form of snd_pcm_busy_for(),
> the kernel needs the compuation like the above.  That's my concern.

Hmm, maybe there could be a default implementation that works as you
suggested above? And only drivers that have a different buffer model
(such as 'fast starts') or a granularity that is >1 sample would need
to overwrite that default implementation.

The reason why I'd prefer having snd_pcm_busy_for() instead of
seperate APIs to query the granularity and 'fast starts' is that this
forces the underlying drivers into a specific buffer model. However
especially with userspace drivers the buffering used might be very
complex and very different from how current hardware drivers do
it. Hence I'd prefer a high-level API that leaves room to different
buffering models including those which might come in the future than
breaking down buffering into primitive parameters that userspace has to
make sense of in a very specific scheme.

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
