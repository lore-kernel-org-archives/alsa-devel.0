From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: ALSA OSS MIDI emulation: input problems
Date: Thu, 27 Mar 2003 09:54:16 +1030 (CST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200303262324.h2QNOG601721@sprite.physics.adelaide.edu.au>
References: <s5hvfy6nheu.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hvfy6nheu.wl@alsa2.suse.de> from "Takashi Iwai" at Mar 26, 2003 06:53:29 PM
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> > Now, when input occurs, Jazz++ needs to know the current time, which is very
> > unlikely to be a multiple of 48 ticks.  Under nateive OSS it seems that
> > before the NOTEON event (for example) OSS sends a TMR_WAIT_ABS event to
> > update the application on the current time - the NOTEON event then follows
> > and is assumed to have occurred at the "current time" which of course will
> > be the time set by the TMR_WAIT_ABS event.
> > 
> > The problem as I see it is that the ALSA OSS emulation does not send this
> > TMR_WAIT_ABS event - it only sends the NOTEON event.  Jazz gets this and
> > without any TMR_WAIT_ABS to tell it otherwise, assumes that it occured at
> > the "current" time - which is always a multiple of 48 ticks.
> 
> does the attached patch cure?
> :
> diff -u -r1.8 seq_oss_midi.c
> --- alsa-kernel/core/seq/oss/seq_oss_midi.c	12 Mar 2003 11:26:20 -0000	1.8
> +++ alsa-kernel/core/seq/oss/seq_oss_midi.c	26 Mar 2003 17:51:31 -0000
> @@ -593,6 +593,7 @@
>  		break;
>  	}
>  	
> +	snd_seq_oss_readq_put_timestamp(dp->readq, ev->time.tick, dp->seq_mode);
>  	snd_seq_oss_readq_put_event(dp->readq, &ossev);
>  
>  	return 0;

I'll check this out tonight and report accordingly.

What I can confirm is that the mechanism I outlined is in fact the reason
why jazz++ (and probably most other OSS sequencers) have bad timing when
recording midi input.

A a hack to test this I did the following:
 * in seq_oss_midi.c:send_synth_event() I inserted the following just before
   the call to snd_seq_oss_readq_put_event():
     { queue_t *q = queueptr(dp->queue);
       snd_seq_oss_readq_put_timestamp(dp->readq,
         q->timer->tick.cur_tick,dp->seq_mode);
       queuefree(q);
     }
 * added include files so queueptr() prototype was available to
   seq_oss_midi.c
 * arranged for queueptr() to be exported from seq_queue.c

When used, this revised code produced correct results inside jazz++.  At the
time this was the only way I knew to get at a known good timer (I'd
previously verified that the queue's timer was incrementing as expected).
I had somehow missed that ev had a valid `time' field in this context.

Takashi's patch *should* work so long as ev->time.tick is correct (ie: it's
not derived from the oss timer).  My rudamentary knowledge of ALSA internals 
suggests that it should be fine though.  Again, I'll confirm tonight.

I also suspect that seq_oss_midi.c:send_midi_event() might also need to
reference ev->time.tick rather than the oss timer because as far as I can
tell the oss timer time is somewhat bogus (or at least that's what it
appears to me).  Is it correct that the oss timer doesn't actually track
real time?  If so, what exactly is the purpose of the oss timer in the
seq_oss_devinfo_t structure (other than to keep track time of the last
queued echo event)?  The other possibility is that the oss timer is only
valid for /dev/sequencer accesses - jazz++ uses /dev/sequencer2 and this is
the only interface I can conveniently test.

Regards
  jonathan
-- 
* Jonathan Woithe    jwoithe@physics.adelaide.edu.au                        *
*                    http://www.physics.adelaide.edu.au/~jwoithe            *
***-----------------------------------------------------------------------***
** "Time is an illusion; lunchtime doubly so"                              **
*  "...you wouldn't recognize a subtle plan if it painted itself purple and *
*   danced naked on a harpsichord singing 'subtle plans are here again'"    *


-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
