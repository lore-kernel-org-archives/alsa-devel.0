From: Chris Cannam <cannam@all-day-breakfast.com>
Subject: sequencer queue PCM timing drift
Date: Thu, 1 Jul 2004 13:52:01 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200407011352.01194.cannam@all-day-breakfast.com>
References: <200405131416.54774.cannam@all-day-breakfast.com> <Pine.LNX.4.58.0405132009120.1834@pnote.perex-int.cz> <200405131934.26656.cannam@all-day-breakfast.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200405131934.26656.cannam@all-day-breakfast.com>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


This is further to a problem I asked about a while ago but never 
really got anywhere with.  At the time, I had seen it reported on the 
Rosegarden devel list but thought it didn't happen on my own 
hardware; now I realise it does.

I have a small test program that creates an ALSA sequencer queue timed 
from the PCM-0-0-0 timer as well as a JACK client, and that lets them 
both run and reports any drift between sequencer timing and JACK 
frame count.  This is the program:

http://cvs.sf.net/viewcvs.py/rosegarden/base/test/seq/
queue-timer-jack.c?rev=1.1

If I run jackd at 48kHz and then let this program run for a few 
minutes, I see no appreciable drift.

However, if I run jackd at 44.1kHz (something I hardly ever do) and 
then start this program and let it run for a few minutes, I do get a 
predictable drift -- the ALSA queue timer is faster (i.e. claims to 
have seen more frames go by) by about 0.25%, or 0.15 seconds per 
minute of run time, with no xruns.

In both cases jackd is running on the hw:0 ALSA PCM device with 1024 
frames per period, 2 periods/buffer; the soundcard is an M-Audio 
Audiophile 2496; /proc/asound/timers says

G0: system timer : 1000.000us (10000000 ticks)
P0-0-0: PCM playback 0-0-0 : SLAVE
  Client sequencer queue 0 : running : lost interrupts 0
P0-0-1: PCM capture 0-0-1 : SLAVE

and /proc/asound/seq/timer says (in the 44.1 case)

Timer for queue 0 : PCM playback 0-0-0
  Period time : 0.046545454
  Skew : 65536 / 65536

What could cause this drift?  Where should I look next?


Chris



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
