From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: 2.6.26.[6|7]-rt11, alsa rawmidi, seq hang
Date: Fri, 07 Nov 2008 10:12:35 +0100
Message-ID: <49140683.9040008@ladisch.de>
References: <1226019485.3135.31.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5.smtp.messagingengine.com (out5.smtp.messagingengine.com
	[66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id AF5DF1038BC
	for <alsa-devel@alsa-project.org>; Fri,  7 Nov 2008 10:12:38 +0100 (CET)
In-Reply-To: <1226019485.3135.31.camel@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: Takashi Iwai <tiwai@suse.de>, Ingo Molnar <mingo@elte.hu>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Fernando Lopez-Lezcano wrote:
> I'm seeing a realtime patch related hard hang in the kernel alsa
> subsystem (MIDI input/output). In a nutshell:
>
> - alsa rawmidi works (ie: "rawmidi -v -i hw:0" outputs a stream of
> messages when pointed to a midi capable card that has an external
> keyboard connected).
>
> - the alsa sequencer interface works (ie: aplaymidi connected to
> aseqdump transfers data just fine).
>
> - BOTH combined do NOT work (ie: use aconnect to connect the port that
> corresponds to the external midi interface to aseqdump: aseqdump hangs
> forever after transferring the first message and the only way out is a
> reboot).

Please try the snd-virmidi driver, then we'd have a test case that does
not require MIDI hardware.

> ... including the output of a "echo t >/proc/sysrq-trigger" that
> should show where aseqdump currently hangs (or so I think).

It hangs in tasklet_kill(), which gets called while it tries to close
the rawmidi port.

The rawmidi framework uses this tasklet to notify the sequencer that new
MIDI data is available.  The handler function is
snd_rawmidi_input_event_tasklet() in sound/core/rawmidi.c; the sequencer
callback that gets called from there is snd_midi_input_event() in
core/seq/seq_midi.c.

You say that the first event gets delivered, so it might be possible
that the tasklet never finishes executing.  Please check whether the
call to snd_seq_kernel_client_dispatch() in snd_midi_input_event()
ever returns.


I vaguely remember that we had exactly the same problem (hangs when
using sequencer on RT kernel) some time ago, and that it was somehow
related to tasklets.


Regards,
Clemens
