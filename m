From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: ALSA OSS MIDI emulation: input problems
Date: Mon, 31 Mar 2003 09:44:31 +0930 (CST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200303310014.h2V0EVW24644@sprite.physics.adelaide.edu.au>
References: <s5h7kajolsy.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h7kajolsy.wl@alsa2.suse.de> from "Takashi Iwai" at Mar 28, 2003 10:57:49 AM
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

> > > The problem as I see it is that the ALSA OSS emulation does not send this
> > > TMR_WAIT_ABS event - it only sends the NOTEON event.  Jazz gets this and
> > > without any TMR_WAIT_ABS to tell it otherwise, assumes that it occured at
> > > the "current" time - which is always a multiple of 48 ticks.
> > 
> > does the attached patch cure?
> > :
> > diff -u -r1.8 seq_oss_midi.c
> > --- alsa-kernel/core/seq/oss/seq_oss_midi.c   12 Mar 2003 11:26:20 -0000 1.8
> > +++ alsa-kernel/core/seq/oss/seq_oss_midi.c   26 Mar 2003 17:51:31 -0000
> > @@ -593,6 +593,7 @@
> >               break;
> >       }
> >       
> > +     snd_seq_oss_readq_put_timestamp(dp->readq, ev->time.tick, dp->seq_mode);
> >       snd_seq_oss_readq_put_event(dp->readq, &ossev);
> >  
> >       return 0;
> > 
> Ok.  Last night I investigated ev->time.tick.  Admittedly this was under
> 0.90rc8b.  It transpires that ev->time.tick is *always* zero when the event
> is a NOTEON/NOTEOF, and therefore gives no timing information what-so-ever. 
> Thus the above patch does *not* fix the problem, at least under 0.90rc8b.

Over the weekend I tested this patch against ALSA 0.9.2 release.  The patch
DOES fix the problem under this version of ALSA - so obviously the sequencer
changes since 0.9.0rc8b have rectified the problems with ev->time.tick. 
This is a good development - it means I can run a single sound driver now
rather than having to switch between ALSA and OSS depending on what I need
to do at the time.

So to confirm: the above patch fixes the input event timing when using ALSA 
OSS sequencer (/dev/sequencer2) emulation.

Best regards
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
