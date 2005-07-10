From: Ryan Underwood <nemesis-lists@icequake.net>
Subject: Re: CS4232 SBpro
Date: Sun, 10 Jul 2005 18:02:24 -0500
Message-ID: <20050710230224.GB11888@dbz.icequake.net>
References: <20050705023313.GB30398@dbz.icequake.net> <s5hmzp0b3h2.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hmzp0b3h2.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Ryan Underwood <nemesis-lists@icequake.net>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


On Wed, Jul 06, 2005 at 01:04:09PM +0200, Takashi Iwai wrote:
 
> You can create a skeleton irq handler in the top-level driver which
> calls either snd_cs4231_interrupt() or snd_sb8dsp_interrupt()
> according to the current mode.
> 
> To avoid to use snd_cs4231_interrupt(), pass CS4231_HWSHARE_IRQ to
> snd_cs4231_create(), and do request_irq() by yourself in the
> top-level.

I didn't see your message, but this is exactly what I did after several
other futile efforts.  I'm glad that I'm on the right track.

Unfortunately, I'm having other hardware problems that hopefully someone
with a CS4232 can replicate.

1) Load snd-cs4232.  Play some wav file with aplay.  Success.
2) rmmod snd-cs4232, load snd-sb8.  Play some wav file with aplay.
Success.
3) rmmod snd-sb8, load snd-cs4232.  Play some wav file with aplay.

Unfortunately, the last one doesn't work; no playback IRQ is generated,
and eventually pcm layer quits with EIO.  If you play around with the
CS4231 registers at that point, you will find that no changes can be
made to the registers - they are "stuck" - but this condition *only*
occurs after doing some DMA operation with the CS4232 in SB emulation
mode.  However, you can then load back up snd-sb8 and the SB emulation
continues to work.

How *not* to run into the problem:

If the snd-cs4232 driver has just played something, and I poke the SB
registers to reset the SB emulation, then no problem occurs.

Also, I can *load* snd-sb8, and then immediately unload it, and then
load snd-cs4232 and play a sound, and it works fine.  So nothing in the
SB reset/detection seems to create the problem.

After anything is *played* with snd-sb8 (and AFAIK, sb8 doesn't have a
PIO playback mode so there's no way to check if it's only the fault of
DMA), the WSS/CS4231 component is stuck until reset.

One might theorize that maybe CS4232 wasn't meant to be used in this
way even though the databook claims it can be, but it seems to be the
same issue if it was in DOS/Windows, and a SB program was used in DOS
before Windows is started where the WSS is used.

Maybe there's a reset procedure for the WSS that I'm missing?  I see
nothing in the CS4231/2 databook (or in AD1848K databook) about it,
except for an external reset pin.  I guess this pin is held by the BIOS
through some proprietary port when the system reboots, to explain why
the chip is "alive" again after a warm-reboot.

Anyway, can someone test this above test-case on a CS4232 and tell me
what happens, so I know it's not just my broken hardware?  Also if
possible, test it on CS4235+ and check X30 register, which will give the
current context.  I hope that any register write to SB puts CWSS to 0,
and any register write to WSS puts CWSS to 1.  Otherwise, there is
probably some reset procedure necessary which I'm missing.

-- 
Ryan Underwood, <nemesis@icequake.net>


-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
