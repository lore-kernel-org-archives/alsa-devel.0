From: Lee Revell <rlrevell@joe-job.com>
Subject: emu10k1 multichannel playback design (was Re: [PATCH] emu10k1: add
 interval timer support)
Date: Fri, 24 Sep 2004 17:02:16 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1096059735.11589.45.camel@krustophenia.net>
References: <Pine.LNX.4.58.0409241546570.2289@pnote.perex-int.cz>
	 <200409241453.i8OErtVR029650@localhost.localdomain>
	 <s5hk6uj3dko.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hk6uj3dko.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Paul Davis <paul@linuxaudiosystems.com>, Jaroslav Kysela <perex@suse.cz>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Fri, 2004-09-24 at 11:13, Takashi Iwai wrote:
> At Fri, 24 Sep 2004 10:53:55 -0400,
> Paul Davis wrote:
> > 
> > >On Fri, 24 Sep 2004, Takashi Iwai wrote:
> > >
> > >> > How would I open only channels 10 and 11 with one app and 1-6 with
> > >> > another using a single 16 channel device?  
> > >> 
> > >> It's doable to implement the multi-channel non-interleaved PCM with
> > >> multi open.  But even in this case, we provide eventually 16
> > >> substreams, so perhaps providing 16 mono substreams would be easier to
> > >> implement (at least for the kernel driver).
> > >> 
> > >> Regarding the efficiency (latency), there will be no difference
> > >> between the multi-channel and multi-substream implementations.
> > >> In the latter case, we can use linked substreams, as you already
> > >> mentioned.
> > >
> > >I don't understand much the requirement. If you want to use other ALSA 
> > >(legacy) applications, you can reroute them to appropriate FX bus only.
> > >The controls are already available.
> > >
> > >The multichannel PCM should be best only for multichannel recording /
> > >playback. You're trying to desing a new API which does not make much
> > >sense.
> > 
> > more to the point, perhaps, is that the very first implementation of
> > the RME Hammerfall (digi9652) driver that i did took lee's approach
> > and when we measured it, there was a very definite performance
> > hit. having to call the "elapsed" function for every mono stream added
> > measurable overhead. when we collapsed it back to a single
> > non-interleaved, 26 channel device, it was significantly more
> > efficient.
> 
> It's a good point.  If you use the timer-style irq, the perfomance
> decrease would be smaller, though, because you don't (can't) get irqs
> per PCM stream.  However, the overhead must still exist.
> 

While certainly easier to implement in the driver, the problem with a
single 16 channel device is that it wastes voices.  In the example of a
non-ReWire compliant app (which is the same as working around a non-JACK
aware app), you would have to use 16 voices for each open, even if the
device will only use 2 of the channels.

The current driver does support something like this, via the FX send
routing controls for playback streams.  Really the only difference here
is that instead of using an extra voice for the timer like the current
driver, you would call the elapsed function in the EFX capture interrupt
handler.  I actually looked at the RME drivers and it would work in a
similar way; a single interrupt source for the full-duplex device.  The
timer interrupt will probably not be used at all; Jaroslav has convinced
me the extra voice is the best solution for regular PCM playback (system
sounds and whatnot). 

It is more efficient to use a single 16 channel non-interleaved device
if, as in the case of JACK, only one app will be using the device and it
will use all channels.  Individual mono streams become more efficient as
the channel count gets lower.

>From reading the changelogs of the kX drivers, and reading some posts
that the author made in the forums, it looks like they originally used a
single 16 channel device, then later moved to individual mono streams as
in my proposal.  For example their driver originally did not support
multiple open, because they probably just grabbed 16 voices at startup. 
Also with kX ASIO you can lower the CPU load by only opening as many
playback channels as you will use, because with multiple mono channels
the amount of work you do in the interrupt handler is proportional to
the number of channels.

Anyway I will probably start with whatever is easier to get working. 
This will actually not be a huge patch, and I certainly don't want to
design a new API.  I am just running through some more complex use cases
that I know work on Windows to verify I am on the right track.

Lee




-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
