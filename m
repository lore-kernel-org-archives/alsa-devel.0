From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: alsa timer slippage
Date: Sun, 14 Dec 2003 15:27:05 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <yw1x4qw3a30m.fsf@kth.se>
References: <200312141335.00239.cannam@all-day-breakfast.com> <1071410558.10990.3.camel@eviltwin>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

Jan Depner <eviltwin69@cableone.net> writes:

> On Sun, 2003-12-14 at 08:07, Chris Cannam wrote:
>> 
>> While trying to track down the source of some poor timing in 
>> sequencing, I've noticed that my ALSA sequencer queue timer has a 
>> tendency to fall suddenly behind.
>> 
>> I have a little test program (available on request) that just starts a 
>> queue and every second or so compares the queue timer against real 
>> time as returned by gettimeofday().  It doesn't mind if the two don't 
>> quite match, but it does complain if the difference between the two 
>> timers changes dramatically between two sample points.  When I run 
>> it, it never lasts for more than about a minute before the ALSA queue 
>> timer suddenly slips by anything from 10 to 60 milliseconds.
>
> If I'm not mistaken the timing for your audio is coming from your sound
> card not your system clock.  The gettimeofday is from the system clock. 
> They probably won't match.

That's true.  However, you typically see a gradual drift, not a sudden
jump.

-- 
Måns Rullgård
mru@kth.se



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
