From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: ALSA OSS MIDI emulation: input problems
Date: Fri, 28 Mar 2003 08:58:47 +1030 (CST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200303272228.h2RMSlJ13989@sprite.physics.adelaide.edu.au>
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

Ok.  Last night I investigated ev->time.tick.  Admittedly this was under
0.90rc8b.  It transpires that ev->time.tick is *always* zero when the event
is a NOTEON/NOTEOF, and therefore gives no timing information what-so-ever. 
Thus the above patch does *not* fix the problem, at least under 0.90rc8b.

I will grab the latest release today (0.9.2) and give that a go over the
weekend in case this has been rectified since the later rc releases.  If
not, we'll have to find some other way of getting at the timer info (either
fixing ev->timer or perhaps formalising the rough hack I outlined in a
previous email).

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
