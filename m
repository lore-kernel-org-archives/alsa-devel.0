From: Andreas Mohr <andim2@users.sourceforge.net>
Subject: timer/sequencer driver issues: pulling my grey hair out
Date: Tue, 18 Oct 2005 23:00:40 +0200
Message-ID: <20051018210040.GB27858@rhlx01.fht-esslingen.de>
Reply-To: andi@lisas.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
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

Hi all,

ok, it's not THAT bad yet, but I've certainly spent some consecutive 3
evenings or so trying to get the azt3328 DirectX timer accepted as
a *well-working* ALSA sequencer timer.

This timer has:
- a maximum tick value of 1048575 in its value register
- a frequency of 1024000/s, it seems (a 1000 value got me exactly 1024 IRQs
  per second in syslog)

Thus its main characteristics are:

static int snd_azf3328_timer_precise_resolution(snd_timer_t *timer,
                                               unsigned long *num, unsigned long *den)
{
        snd_azf3328_dbgcallenter();
        *num = 1;
        *den = 1024000;
        snd_azf3328_dbgcallleave();
        return 0;
}

static struct _snd_timer_hardware snd_azf3328_timer_hw = {
        .flags = SNDRV_TIMER_HW_AUTO,
        .resolution = 977, /* 1000000/1024000 = 0.9765625us */
        .ticks = 1048576, /* max tick count, defined by the value register */
        .start = snd_azf3328_timer_start,
        .stop = snd_azf3328_timer_stop,
        .precise_resolution = snd_azf3328_timer_precise_resolution,
};


Now if I'm optimistic and let these values harrass a
schedtool -I -p 0 -e timidity -iAv -B2,8 -Os -EFreverb=0
pmidi -p 128:0 /home/andi/jazz.mid
, then all I get is a completely locked-up PC.

Why?
Simple! It's because the program sets an sticks value of 1, since my
timer announces a very high-speed resolution.
This of course results in an IRQ DoS which completely locks up my PC,
due to triggering a timer IRQ every 0.976us.

Now I've seen that snd_emu10k1_timer_start() has the following very nice code:

static int snd_emu10k1_timer_start(snd_timer_t *timer)
{
        emu10k1_t *emu;
        unsigned long flags;
        unsigned int delay;

        emu = snd_timer_chip(timer);
        delay = timer->sticks - 1;
        if (delay < 5 ) /* minimum time is 5 ticks */
                delay = 5;
        spin_lock_irqsave(&emu->reg_lock, flags);
        snd_emu10k1_intr_enable(emu, INTE_INTERVALTIMERENB);
        outw(delay & TIMER_RATE_MASK, emu->port + TIMER);
        spin_unlock_irqrestore(&emu->reg_lock, flags);
        return 0;
}

IOW, if the sticks value is too low, it will *bend* it to a minimum value
of 5, i.e. 100us in this card timer's case.
Since this 5 value translates to about a 110 value in my case to reach about
100us, too, I did that modification, which resulted in a working MIDI output
which *finally* didn't stop after the first note (I had timer value issues
before due to completely wrong _snd_timer_hardware configuration, so
the music execution was *very* slow).

Again, with the new 110 limit value the music now started playing several
notes, however *very* slow (one note every 10 seconds or so),
most likely **since the program didn't know at all about my evil
backyard tweak** and instead did its timing calculations with the assumption
of my timer using the sticks value of 1 it asked me to set.

IOW, the 5 value limitation in snd_emu10k1_timer_start will *break*
correct timing execution - its only purpose seems to be to protect the
PC from timer IRQ overload conditions.

In my case, the situation is *terribly* aggravated, since I'm not simply
using a 48kHz timer, but a >1MHz timer even which can much more easily
cause timer IRQ overload!

Questions:
- why is the program configuring a dangerously low sticks value of 1?
  Is it due to a remaining misdeclaration of my timer attributes somewhere,
  or is it because of this program being stupid in its timer parameter choice?
- it's a very good idea to get rid of the "stupid" *hidden* sticks bending
  in snd_emu10k1_timer_start(), right? Preferrably use an intelligent
  communication instead that makes sure that the program uses an sticks value
  that won't cause IRQ overload?

One currently doable way of handling this overload problem would be to
*algorithmically* down-scale the resolution of my timer and then announce
a lower-res timer in _snd_timer_hardware, thus making sure that only
timer countdown values of say > 256 will be configured by my driver
and the program is *properly* informed about what *exactly* my (now virtual)
timer resolution is.
But this seems to be somewhat stupid IMHO.

For now I'll go with this software down-scaling approach, but if you have
any better idea or can tell me where I'm terribly wrong, then just go ahead
and tell me!

Thanks!

Andreas Mohr


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
