From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Re: should i be able to abort in the middle of
 snd_pcm_mmap_{begin,commit} ?
Date: Thu, 21 Feb 2002 09:14:18 +0100 (CET)
Message-ID: <Pine.LNX.4.31.0202210913180.578-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <Pine.LNX.4.44.0202210745340.3739-100000@ecabase.localdomain>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Kai Vehmanen <kai.vehmanen@wakkanet.fi>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 21 Feb 2002, Kai Vehmanen wrote:

> On Tue, 19 Feb 2002, Jaroslav Kysela wrote:
>
> >> I'm still a bit puzzled why I didn't get xruns in the test case quoted
> >> below, but until I can reproduce the problem, there's not much to discuss
> > You posted this sw params on alsa-devel a few days ago:
> [....]
> > sw_params:
> > stop_threshold: 4294967295
> [...]
> > As you can see, the stop_threshold is set to UMAX_INT. In case when
> > stop_threshold is above ring buffer size, then it means for drivers: I
> > don't care about xruns, don't report them. The stop threshold must be
> > equal to ring buffer size to get xruns when no more frames are in ring
> > buffer.
>
> Hmm, makes sense. This raises a few new questions:
>
> 1) Is 'avail > stop_threshold' the only condition when a stream
>    can move from RUNNING to XRUN state? The only places I located
>    in the current source tree, where this state change happens, were
>    in alsa-kernel/core/pcm_lib.c, functions
>    snd_pcm_update_hw_ptr_interrupt() and snd_pcm_update_hw_ptr().
>
> 2) If (1) is true, why does runnig jack produces xruns every
>    now and then...? The stop_threshold is UMAX_INT for
>    both directions and it should never occur that over
>    buffer_size samples is writable to, or readable from
>    the pcm device.
>
> And to save your time ;), here's one possible explanation to (2):
>
> Looking at jackd code, one possibility is that the we are only getting an
> EPIPE from snd_pcm_avail_update(), but the stream is still in RUNNING
> state. At least in alsa-lib/src/pcm/pcm_hw.c:snd_pcm_hw_avail_update()
> we have a test for:
>
> --cut--
> if (avail > pcm->buffer_size)
> 	return -EPIPE;
> --cut--
>
> This would trigger jackd's xrun handling code, but leave state to RUNNING.
> Am I on the right track here?

Yes, this condition is faulty. It should be 'avail >= pcm->stop_threshold'.
Fixed in CVS and thanks for verbose error detection.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
