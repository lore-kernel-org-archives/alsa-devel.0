From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: 2.6.26.[6|7]-rt11, alsa rawmidi, seq hang
Date: Fri, 07 Nov 2008 16:48:06 -0800
Message-ID: <1226105286.7647.21.camel@localhost.localdomain>
References: <1226019485.3135.31.camel@localhost.localdomain>
	<49140683.9040008@ladisch.de>
	<1226081557.20569.5.camel@localhost.localdomain>
	<1226099549.7647.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp5.stanford.edu (smtp5.Stanford.EDU [171.67.219.85])
	by alsa0.perex.cz (Postfix) with ESMTP id A3D77103826
	for <alsa-devel@alsa-project.org>; Sat,  8 Nov 2008 01:49:33 +0100 (CET)
In-Reply-To: <1226099549.7647.3.camel@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Takashi Iwai <tiwai@suse.de>, Ingo Molnar <mingo@elte.hu>, alsa-devel@alsa-project.org, Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, 2008-11-07 at 15:12 -0800, Fernando Lopez-Lezcano wrote:
> On Fri, 2008-11-07 at 10:12 -0800, Fernando Lopez-Lezcano wrote:
> > On Fri, 2008-11-07 at 10:12 +0100, Clemens Ladisch wrote:
> > > Fernando Lopez-Lezcano wrote:
> > > > I'm seeing a realtime patch related hard hang in the kernel alsa
> > > > subsystem (MIDI input/output). In a nutshell:
> > > >
> > > > - alsa rawmidi works (ie: "rawmidi -v -i hw:0" outputs a stream of
> > > > messages when pointed to a midi capable card that has an external
> > > > keyboard connected).
> > > >
> > > > - the alsa sequencer interface works (ie: aplaymidi connected to
> > > > aseqdump transfers data just fine).
> > > >
> > > > - BOTH combined do NOT work (ie: use aconnect to connect the port that
> > > > corresponds to the external midi interface to aseqdump: aseqdump hangs
> > > > forever after transferring the first message and the only way out is a
> > > > reboot).
> > > 
> > > Please try the snd-virmidi driver, then we'd have a test case that does
> > > not require MIDI hardware.
> > > 
> > > > ... including the output of a "echo t >/proc/sysrq-trigger" that
> > > > should show where aseqdump currently hangs (or so I think).
> > > 
> > > It hangs in tasklet_kill(), which gets called while it tries to close
> > > the rawmidi port.
> > > 
> > > The rawmidi framework uses this tasklet to notify the sequencer that new
> > > MIDI data is available.  The handler function is
> > > snd_rawmidi_input_event_tasklet() in sound/core/rawmidi.c; the sequencer
> > > callback that gets called from there is snd_midi_input_event() in
> > > core/seq/seq_midi.c.
> > > 
> > > You say that the first event gets delivered, so it might be possible
> > > that the tasklet never finishes executing.  Please check whether the
> > > call to snd_seq_kernel_client_dispatch() in snd_midi_input_event()
> > > ever returns.
> > 
> > I added a printk before and after the call, it looks like it gets called
> > and it returns (but only _once_... aseqdump hangs in an unkillable state
> > as before).
> 
> Just in case, the tasklet keeps getting called as long as midi bytes are
> received. So the tasklet runs once, snd_midi_input_event gets called
> once and the tasklet keeps running again and again, but nobody runs
> snd_midi_input_event. Who should?

I normally use rtirq to tune realtime priorities for realtime kernel
processes, as I looked around and noticed tasklets seem to be related to
(or are) software interrupts and those have priorities, so I disabled
rtirq and rebooted (which leaves the default priority of 50 for all
realtime kernel processes). 

Now I get __two__ midi bytes instead of one (active sensing messages
from the keyboard) and the whole thing stalls as before. 
??
So is this a priority inversion problem?
-- Fernando
