From: Jan Depner <eviltwin69@cableone.net>
Subject: Re: alsa timer slippage
Date: 14 Dec 2003 08:02:38 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1071410558.10990.3.camel@eviltwin>
References: <200312141335.00239.cannam@all-day-breakfast.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200312141335.00239.cannam@all-day-breakfast.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Chris Cannam <cannam@all-day-breakfast.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

If I'm not mistaken the timing for your audio is coming from your sound
card not your system clock.  The gettimeofday is from the system clock. 
They probably won't match.  Of course, I could be totally in the dark
;-)

Jan


On Sun, 2003-12-14 at 08:07, Chris Cannam wrote:
> 
> While trying to track down the source of some poor timing in 
> sequencing, I've noticed that my ALSA sequencer queue timer has a 
> tendency to fall suddenly behind.
> 
> I have a little test program (available on request) that just starts a 
> queue and every second or so compares the queue timer against real 
> time as returned by gettimeofday().  It doesn't mind if the two don't 
> quite match, but it does complain if the difference between the two 
> timers changes dramatically between two sample points.  When I run 
> it, it never lasts for more than about a minute before the ALSA queue 
> timer suddenly slips by anything from 10 to 60 milliseconds.
> 
> This is a non-low-latency kernel so I'm not surprised that there may 
> be some occasional timing issues, but 60ms is a lot on an unloaded 
> machine, and I am vaguely surprised that the timer doesn't notice 
> it's fallen behind and recover -- instead all events on the queue 
> continue to be delivered late forever.  This obviously makes for some 
> disconcerting audible effects.
> 
> The system is SuSE 9.0 on a dual 2GHz Athlon using SuSE's stock SMP 
> kernel.  I have tried both ALSA 0.9.6 (from SuSE) and 1.0.0rc2 
> drivers and libraries.  I haven't managed to reproduce it using a 
> PlanetCCRMA SMP kernel on the same machine, nor on my uniprocessor 
> laptop.  I've surveyed a few other people on rosegarden-devel and 
> nobody's corroborated my findings, so I guess it might be related to 
> using a dual-processor machine.
> 
> Any thoughts on this, anyone?  I'm finding it a little depressing that 
> I can't play even a minute of 4/4 beats from an ALSA test program 
> without the timing slipping audibly at least once.  I'm ready to 
> delve cluelessly into the timer code to take a look, but (glancing at 
> alsa-kernel/core/timer.c) I'm not at all sure how far I'd get...
> 
> 
> Chris
> 
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: SF.net Giveback Program.
> Does SourceForge.net help you be more productive?  Does it
> help you create better code?  SHARE THE LOVE, and help us help
> YOU!  Click Here: http://sourceforge.net/donate/
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
