From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: OSS midi emulation bug: 1.0.0pre3
Date: Mon, 1 Dec 2003 09:38:58 +1030 (CST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200311302308.hAUN8w423494@turbo.physics.adelaide.edu.au>
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
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
List-Id: alsa-devel@alsa-project.org

Hi all

I had a chance to test Alsa 1.0.0pre3 over the weekend against a suite of
programs I use.  I noticed a small but very annoying quirk with the OSS
midi emulation.  The applications were jazz++ 4.1.3 and playmidi 2.4.  While
the symptoms were slightly different I suspect there might be one underlying
cause.  Output is to the external MPU401 on an ES1370 card.  Test midi files
used were created under jazz++ 4.1.3.

Under Jazz++, any "hold on" controller event which occurs within the first
bar played gets turned off too quickly (assuming playback starts at beat one
of a bar).  In fact, even if there are no subsequent "hold off" events
within the entire midi file the "hold on" is still turned "off".  The
turning off happens very soon after the "hold on" is transmitted - the "hold
on" has some effect but it's very short lived.

"hold on" and "hold off" events work exactly as expected in all other bars
of a piece - it's only in the bar at which playback starts (not necessarily
the first bar of the midi file) that there's a problem.  If you start
playback at bar 4 then the problem's in bar 4.  If you start at bar 2 the
problem's in bar 2 and bar 4 plays perfectly.

The effect is similar even if playback starts in the middle of a bar but
then obviously the effect can sometimes carry over into the next bar.  I
have not done extensive tests to quantify timings in the case of starting
mid-bar.

Under playmidi the problem is a bit different.  It seems that the midi
events in the first beat of the first bar of the midi file played are sent
too quickly - it's as if the timing info sent back to playmidi runs too fast
for the first beat or so.

I didn't get a chance to get exact timings on these things - observations
were by ear.  If it would help I can try to measure things a little more
objectively.

My rather nieve throught is that the timing events sent by the ALSA
emulation are running fast for the first bar or so of playback.  Whereas
this affects all events sent by playmidi, it only affects controller events
from jazz++ (maybe because of the odd way jazz++ does its timing).  Of
course there may be more to it than this - if it was simply timing then an
isolated "hold on" would still remain in effect during jazz++ playback, but
tests show it is turned off "by magic".

Any ideas as to what could be causing these problems?  The existance of this
problem is the one thing stopping me from moving to ALSA permanently. 
Currently I have to use OSS for midi work which is a bit of a pain.

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
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
