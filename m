From: Pedro Lopez-Cabanillas <plcl@telefonica.net>
Subject: Re: alsa timer slippage
Date: Mon, 15 Dec 2003 02:30:33 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200312150230.33546.plcl@telefonica.net>
References: <E1AVXB7-00025m-JG@sc8-sf-list2.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <E1AVXB7-00025m-JG@sc8-sf-list2.sourceforge.net>
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
Cc: Chris Cannam <cannam@all-day-breakfast.com>
List-Id: alsa-devel@alsa-project.org

Chris Cannam wrote:
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

Please, send me your test program.

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

The ALSA MIDI sequencer can use several timer sources. By default, it uses the 
Linux system timer functions, see:
http://hegel.ittc.ukans.edu/topics/linux/man-pages/man9/init_timer.9.html

Other timer sources are PCM devices and the RTC timer. The module snd-rtctimer 
provides this functionality. To compile it for a 2.4.x kernel, you need to 
patch your rtc driver (and rebuild), see alsa-driver/utils/patches

You can set a system-wide alternate timer in your /etc/modules.conf, for 
instance: 
	options snd-seq seq_default_timer_device=1
	alias snd-timer-1 snd-rtctimer

Or your program can select an alternate timer source for a single queue. See:
http://www.mail-archive.com/alsa-user@lists.sourceforge.net/msg09048.html

Regards,
Pedro

-- 
ALSA Library Bindings for Pascal
http://alsapas.alturl.com



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
