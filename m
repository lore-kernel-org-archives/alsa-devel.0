From: Abramo Bagnara <abramo@alsa-project.org>
Subject: Re: Re: should i be able to abort in the middle
 ofsnd_pcm_mmap_{begin,commit} ?
Date: Thu, 21 Feb 2002 10:02:58 +0100
Message-ID: <3C74B7C2.2CA47B86@alsa-project.org>
References: <Pine.LNX.4.31.0202210913180.578-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Kai Vehmanen <kai.vehmanen@wakkanet.fi>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> 
> On Thu, 21 Feb 2002, Kai Vehmanen wrote:
> 
> > On Tue, 19 Feb 2002, Jaroslav Kysela wrote:
> >
> > >> I'm still a bit puzzled why I didn't get xruns in the test case quoted
> > >> below, but until I can reproduce the problem, there's not much to discuss
> > > You posted this sw params on alsa-devel a few days ago:
> > [....]
> > > sw_params:
> > > stop_threshold: 4294967295
> > [...]
> > > As you can see, the stop_threshold is set to UMAX_INT. In case when
> > > stop_threshold is above ring buffer size, then it means for drivers: I
> > > don't care about xruns, don't report them. The stop threshold must be
> > > equal to ring buffer size to get xruns when no more frames are in ring
> > > buffer.
> >
> > Hmm, makes sense. This raises a few new questions:
> >
> > 1) Is 'avail > stop_threshold' the only condition when a stream
> >    can move from RUNNING to XRUN state? The only places I located
> >    in the current source tree, where this state change happens, were
> >    in alsa-kernel/core/pcm_lib.c, functions
> >    snd_pcm_update_hw_ptr_interrupt() and snd_pcm_update_hw_ptr().
> >
> > 2) If (1) is true, why does runnig jack produces xruns every
> >    now and then...? The stop_threshold is UMAX_INT for
> >    both directions and it should never occur that over
> >    buffer_size samples is writable to, or readable from
> >    the pcm device.
> >
> > And to save your time ;), here's one possible explanation to (2):
> >
> > Looking at jackd code, one possibility is that the we are only getting an
> > EPIPE from snd_pcm_avail_update(), but the stream is still in RUNNING
> > state. At least in alsa-lib/src/pcm/pcm_hw.c:snd_pcm_hw_avail_update()
> > we have a test for:
> >
> > --cut--
> > if (avail > pcm->buffer_size)
> >       return -EPIPE;
> > --cut--
> >
> > This would trigger jackd's xrun handling code, but leave state to RUNNING.
> > Am I on the right track here?
> 
> Yes, this condition is faulty. It should be 'avail >= pcm->stop_threshold'.
> Fixed in CVS and thanks for verbose error detection.

Perhaps I'm missing something, but I strongly disagree with your recent
changes on CVS:

- if avail > buffer_size this means either played garbage (playback) or
overwritten samples (capture). The return of an error is perfectly
sensible (also because the value returned would not have any sensible
meaning).

- the insertion of SND_PCM_IOCTL_XRUN is a nonsense, as the application
has explicitly asked to not stop the stream when xrun happens.

As a side note (and as a broken record :-( ), I'd like you don't change
the API without peer review. I hope you fully undertstand why...

-- 
Abramo Bagnara                       mailto:abramo@alsa-project.org

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy

ALSA project               http://www.alsa-project.org
It sounds good!

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
