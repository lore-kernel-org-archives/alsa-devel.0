From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: timer/sequencer driver issues: pulling my grey hair
 out
Date: Wed, 19 Oct 2005 09:56:07 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0510190935050.13768-100000@studcom.urz.uni-halle.de>
References: <20051018210040.GB27858@rhlx01.fht-esslingen.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20051018210040.GB27858@rhlx01.fht-esslingen.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Andreas Mohr <andi@lisas.de>
Cc: Lee Revell <rlrevell@joe-job.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Andreas Mohr wrote:
> This timer has:
> - a frequency of 1024000/s
> [...]
> pmidi -p 128:0 /home/andi/jazz.mid
> , then all I get is a completely locked-up PC.
>
> Why?
> Simple! It's because the program sets an sticks value of 1, since my
> timer announces a very high-speed resolution.
> This of course results in an IRQ DoS which completely locks up my PC,
> due to triggering a timer IRQ every 0.976us.

This is a bug in the sequencer timer code -- it uses the maximum
available frequency when no default has been set (that would be done
with the seq_default_timer_resolution parameter of the snd-seq
module).

> Now I've seen that snd_emu10k1_timer_start() has the following very nice code:
>
>         delay = timer->sticks - 1;
>         if (delay < 5 ) /* minimum time is 5 ticks */
>                 delay = 5;
>
> IOW, if the sticks value is too low, it will *bend* it to a minimum value
> of 5, i.e. 100us in this card timer's case.
> Since this 5 value translates to about a 110 value in my case to reach about
> 100us, too, I did that modification, which resulted in a working MIDI output
> which *finally* didn't stop after the first note (I had timer value issues
> before due to completely wrong _snd_timer_hardware configuration, so
> the music execution was *very* slow).
>
> Again, with the new 110 limit value the music now started playing several
> notes, however *very* slow (one note every 10 seconds or so),
> most likely **since the program didn't know at all about my evil
> backyard tweak** and instead did its timing calculations with the assumption
> of my timer using the sticks value of 1 it asked me to set.
>
> IOW, the 5 value limitation in snd_emu10k1_timer_start will *break*
> correct timing execution - its only purpose seems to be to protect the
> PC from timer IRQ overload conditions.

That code is based on my code for the ymfpci timer which has a similar
lower limit which is due to a hardware limitation (the ymfpci timer
has 96 kHz resolution, but the maximum frequency is 48 kHz).

I guess I should just declare the timer to have 48 kHz resolution as
long as the timer core doesn't know about minimum tick lengths that
are greater that the resolution.

> In my case, the situation is *terribly* aggravated, since I'm not simply
> using a 48kHz timer, but a >1MHz timer even which can much more easily
> cause timer IRQ overload!
>
> Questions:
> - why is the program configuring a dangerously low sticks value of 1?

Because I haven't yet applied the patch I'm writing just now that
limits the sequencer timer frequency to some sane value.

> - it's a very good idea to get rid of the "stupid" *hidden* sticks bending
>   in snd_emu10k1_timer_start(), right?

Yes.  I'll do this for the ymfpci driver.

Lee, I don't know if the 5 ticks limit is a hardware limitation of the
Emu10k1.  The comment you quoted seems to indicate it's not.  I guess
we should just allow a frequency of 48 kHz; the sequencer won't
actually use it.


Regards,
Clemens



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
