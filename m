From: Hynek Hanke <hanke@brailcom.org>
Subject: Re: The different STATES of ALSA
Date: Sun, 31 Jul 2005 17:17:55 +0200
Message-ID: <20050731151755.GB13386@brailcom.cz>
References: <20050731133552.GA13386@brailcom.cz> <42ECDD88.5010805@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtp-out4.iol.cz (smtp-out4.iol.cz [194.228.2.92])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 83CE61B0
	for <alsa-devel@alsa-project.org>; Sun, 31 Jul 2005 17:21:05 +0200 (MEST)
Content-Disposition: inline
In-Reply-To: <42ECDD88.5010805@superbug.co.uk>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: Hynek Hanke <hanke@brailcom.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> >(After I was told alsa-lib is not thread-safe and there is some bug in the 
> >kernel
> >implementation of the underlaying calls of snd_pcm_writei(), I'm now 
> >running the
> >non-blocking/polling approach).
> alsa-lib is perfectly thread-safe.

I was told otherwise by several ALSA developers in the thread ``How to
interrupt snd_pcm_writei'' started on June the 21st. A kernel patch was
sent to the conference and I tried it, but the problem persisted. So, as
you suggest too, I started using the non-blocking/polling approach.

> >1) In which states am I allowed to call
> >	a) snd_pcm_hw_params_any
> Only after snd_pcm_open() and snd_pcm_hw_params_alloca(&params);

In my app, I typically open one ALSA connection at the start and then play
soundfiles when needed, often interrupting them in the middle to play another
ones. Do I need to allocate a new params structure each time I want to play a
new sample or is it possible to reuse the old one?

I don't know what are the allowed states (SND_PCM_STATE_...) for this. For
example SND_PCM_STATE_XRUN is ok or is it not? (since I'll later fix it for
playing with snd_pcm_prepare() ).

> >	c) snd_pcm_prepare
> After an xrun(for xrun recovery) or after hw and sw params have been set up.

So the same states as snd_pcm_hw_params_any + SND_PCM_STATE_XRUN?
 
> >	d) snd_pcm_drop and _drain
> At any time while the stream is in RUNNING state.

Calling the function in every other state is considered an error?

> >3) How is it possible that snd_pcm_drain returns with a success value *and*
> >   the snd_pcm_state() still reports SND_PCM_STATE_DRAINING ? Is this a 
> >   bug?
> This depends on block/non-block status.
> snd_pcm_nonblock()

I didn't find anything specific about this in the documentation.

You say that snd_pcm_drain() behaves differently in the blocking and
non-blocking mode? snd_pcm_drain() returns immediatelly in non-blocking mode? I
thought it's purpose is to wait? So, do I need to wait with poll() instead?
 
> from the programmer. You might want to look into it. It is called jackd.

Yes, we know about this option.

Thanks for your help,
Hynek


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
