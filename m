From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: emu10k1 multichannel playback design (was Re:
	[PATCH] emu10k1: add interval timer support)
Date: Sun, 26 Sep 2004 02:50:43 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1096181442.7203.50.camel@krustophenia.net>
References: <200409260315.i8Q3FUMg005327@localhost.localdomain>
	 <1096170629.1357.19.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1096170629.1357.19.camel@krustophenia.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@suse.cz>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sat, 2004-09-25 at 23:50, Lee Revell wrote: 
> On Sat, 2004-09-25 at 23:15, Paul Davis wrote:
> > >OK, I fixed the voice allocator to handle multichannel PCM.  Now it
> > >looks like the prepare callback is being called over and over in a loop.
> > 
> >    [ ... ]
> > 
> > >I am still missing parts of the driver, like the interrupt handler.  But
> > >it seems like the prepare callback should not loop this way.  Am I doing
> > >something wrong?
> > 
> 
> The interrupt handler fortunately was a one liner.  All I have left is
> the pointer callback and it should work.

OK, I have the basic driver working, but I think I am doing something
wrong somewhere.  Jack can open the device but the watchdog thread times
it out, and it looks like the prepare callback is being called over and
over.  However the hardware pointer looks correct:

ptr = 0x84c, ccca_start_addr = 0x803c
ptr = 0x10, buffer_size = 0x800, period_size = 0x400
in capture efx irq handler, updating playback stream
ptr = 0xc2f, ccca_start_addr = 0x803c
ptr = 0x3f3, buffer_size = 0x800, period_size = 0x400
in capture efx irq handler, updating playback stream
in snd_emu10k1_efx_playback_prepare - start_addr 0x1000 end_addr 0x11000
init voice - master 1 extra 0 start_addr 0x800 end_addr 0x1000
init voice - master 1 extra 0 start_addr 0x1000 end_addr 0x1800
init voice - master 1 extra 0 start_addr 0x1800 end_addr 0x2000
init voice - master 1 extra 0 start_addr 0x2000 end_addr 0x2800
init voice - master 1 extra 0 start_addr 0x2800 end_addr 0x3000
init voice - master 1 extra 0 start_addr 0x3000 end_addr 0x3800
init voice - master 1 extra 0 start_addr 0x3800 end_addr 0x4000
init voice - master 1 extra 0 start_addr 0x4000 end_addr 0x4800
init voice - master 1 extra 0 start_addr 0x4800 end_addr 0x5000
init voice - master 1 extra 0 start_addr 0x5000 end_addr 0x5800
init voice - master 1 extra 0 start_addr 0x5800 end_addr 0x6000
init voice - master 1 extra 0 start_addr 0x6000 end_addr 0x6800
init voice - master 1 extra 0 start_addr 0x6800 end_addr 0x7000
init voice - master 1 extra 0 start_addr 0x7000 end_addr 0x7800
init voice - master 1 extra 0 start_addr 0x7800 end_addr 0x8000
init voice - master 1 extra 0 start_addr 0x8000 end_addr 0x8800
ptr = 0x84d, ccca_start_addr = 0x803c
ptr = 0x11, buffer_size = 0x800, period_size = 0x400
in capture efx irq handler, updating playback stream
ptr = 0xc2f, ccca_start_addr = 0x803c
ptr = 0x3f3, buffer_size = 0x800, period_size = 0x400
in capture efx irq handler, updating playback stream
in snd_emu10k1_efx_playback_prepare - start_addr 0x1000 end_addr 0x11000
init voice - master 1 extra 0 start_addr 0x800 end_addr 0x1000

...

init voice - master 1 extra 0 start_addr 0x8000 end_addr 0x8800
ptr = 0x84d, ccca_start_addr = 0x803c
ptr = 0x11, buffer_size = 0x800, period_size = 0x400
in capture efx irq handler, updating playback stream
ptr = 0xc2f, ccca_start_addr = 0x803c
ptr = 0x3f3, buffer_size = 0x800, period_size = 0x400
in capture efx irq handler, updating playback stream
in snd_emu10k1_efx_playback_prepare - start_addr 0x1000 end_addr 0x11000
init voice - master 1 extra 0 start_addr 0x800 end_addr 0x1000

...

init voice - master 1 extra 0 start_addr 0x8000 end_addr 0x8800
ptr = 0x84c, ccca_start_addr = 0x803c
ptr = 0x10, buffer_size = 0x800, period_size = 0x400
in capture efx irq handler, updating playback stream
ptr = 0xc2f, ccca_start_addr = 0x803c
ptr = 0x3f3, buffer_size = 0x800, period_size = 0x400
in capture efx irq handler, updating playback stream
in snd_emu10k1_efx_playback_prepare - start_addr 0x1000 end_addr 0x11000
init voice - master 1 extra 0 start_addr 0x800 end_addr 0x1000

...

init voice - master 1 extra 0 start_addr 0x8000 end_addr 0x8800
ptr = 0x84e, ccca_start_addr = 0x803c
ptr = 0x12, buffer_size = 0x800, period_size = 0x400
in capture efx irq handler, updating playback stream
ptr = 0xc2c, ccca_start_addr = 0x803c
ptr = 0x3f0, buffer_size = 0x800, period_size = 0x400
in capture efx irq handler, updating playback stream

The jitter is about the same as with the extra voice method, 0-3
samples.  However it looks like with every other interrupt it resets the
stream.

Do I need to post the code to debug this further?

Lee




-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
