From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: ALSA OSS MIDI emulation: input problems
Date: Wed, 26 Mar 2003 17:30:09 +1030 (CST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200303260700.h2Q709p03090@sprite.physics.adelaide.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi all

I've been messing with the following problem on and off for the last few
weeks.  It occurs when the OSS sequencer emulation is used with Jazz++
4.1.3.  In essence, incoming MIDI events from an external MIDI interface
have their time quantised to multiples of 48 ticks, which is not very
satisfactory.

After a lot of messing around, I think I'm starting to work out why this is.
Jazz++ updates its play position every 48 ticks and the trigger for this is
a SEQ_ECHO event.  When one of these arrives, jazz increments its time
counters, sets another SEQ_ECHO event to happen in 48 ticks time and then
finishes.  This means that in the absence of MIDI input, jazz++ time goes up
in increments of 48 ticks.

Now, when input occurs, Jazz++ needs to know the current time, which is very
unlikely to be a multiple of 48 ticks.  Under nateive OSS it seems that
before the NOTEON event (for example) OSS sends a TMR_WAIT_ABS event to
update the application on the current time - the NOTEON event then follows
and is assumed to have occurred at the "current time" which of course will
be the time set by the TMR_WAIT_ABS event.

The problem as I see it is that the ALSA OSS emulation does not send this
TMR_WAIT_ABS event - it only sends the NOTEON event.  Jazz gets this and
without any TMR_WAIT_ABS to tell it otherwise, assumes that it occured at
the "current" time - which is always a multiple of 48 ticks.

Now, in order to correct this, seq_oss_event.c:send_synth_event() must have
access to the current time.  Investigation shows that the OSS timer's time
is not at all accurate which means it can't be used for this.  We really
need to get access to the underlying ALSA timer.  I will look into this more
tonight.  If anyone has any ideas I'd welcome them!

A side issue is of course why the OSS timer isn't tracking time.  It seems
that it's tick value is only ever set when echo event requests come in for
times greater than its current setting.  Jazz++ sometimes batches echo
requests in lots of 10 or more, so consequently the OSS timer's "cur_tick"
field is often miles in the future.  It doesn't seem to be updated in real
time.  Maybe it's not meant to, but to me this appears to be a problem.

In any case, if the OSS timer could be relied on to accurately track the
ALSA timer then it could be used to source the time for the TMR_WAIT_ABS
event preceeding the NOTEON event.  If not, some other method of getting
access to the timer may be needed.

Anyway, any help or insight people have to this would be appreciated.

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
