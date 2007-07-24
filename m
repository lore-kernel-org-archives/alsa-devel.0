From: Florian Schmidt <mista.tapas-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: [LAD] How to get correct midi timings from ALSA using the library
	only
Date: Tue, 24 Jul 2007 12:06:09 +0200
Message-ID: <200707241206.09991.mista.tapas@gmx.net>
References: <46A5BFDF.4040906@gmail.com>
Reply-To: The Linux Audio Developers' Mailing List <linux-audio-dev-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-audio-dev-bounces-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org>
In-Reply-To: <46A5BFDF.4040906-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.linuxaudio.org/mailman/listinfo.cgi/linux-audio-dev>,
	<mailto:linux-audio-dev-request-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linuxaudio.org/pipermail/linux-audio-dev>
List-Post: <mailto:linux-audio-dev-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org>
List-Help: <mailto:linux-audio-dev-request-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linuxaudio.org/mailman/listinfo.cgi/linux-audio-dev>,
	<mailto:linux-audio-dev-request-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: linux-audio-dev-bounces-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org
Errors-To: linux-audio-dev-bounces-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org
To: linux-audio-dev-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Tuesday 24 July 2007, Carlo Florendo wrote:
> Hi,
>
> (1) I've written a command line MIDI sequencer for lightweight systems and
> am successful in making it work using the ALSA queue API.  However, one
> drawback of the API is its lack of callback functions.  I wish to be able
> to track events as they are drained by the queue.
>
> (2) I know and have successfully worked on a work around whereby the
> application itself subscribes to the output port so as to see events as
> they are played.
>
> However, I wish to be able to make the sequencer or player work without the
> use of the ALSA queue nor the workaround in (2).
>
> Here's the pseudo-code of the relevant MIDI player routine:
>
> for (i = 0; i < number_of_events; i++)
> {
>      usleep(event[i].delta_time_in_microseconds);
>      output_and_drain_event(event[i]);
> }
>
> This routine gives a non-bearable latency on 2.4 kernels but not so much on
> 2.6 kernels.
>
> How could I get the app to <u|nano>sleep() in the most accurate way in
> userspace without using the ALSA queue nor the extra subscription to an
> output port?   Or, is there a drain or output routine that supports
> callbacks?  If so, I will be grateful if you could point them out.  I seem
> not to find any output callback routine under the docs.

One way to improve timing is to make sure your process has the highest prio in 
the system, so that even in the case that other tasks want to run, too, at 
the moment of wakeup, your process gets the CPU.

Try running your process with SCHED_FIFO scheduling and a high prio of e.g. 
99.

Also using a kernel patched with ingo molnar's -rt patches might help quite a 
bit (additional to running your process SCHED_FIFO).

Also you want to check on every wakeup (after your sleep expired) how long you 
really slept, so you can adjust the next sleep time. clock_gettime 
(CLOCK_MONOTONIC) might be useful for this..

Another approach, that works very well in my experience, is to not sleep the 
total required time until the next event, but rather regularly sleep for very 
short amounts of time (< 1ms), wakeup, measure the current time and if any 
event time now lies in the past, simply play it back immediately. This way 
the sleep time doesn't need to be accurate at all. All that's needed is that 
it's small enough to get some decent timing.

Regards,
Flo

-- 
Palimm Palimm!
http://tapas.affenbande.org
