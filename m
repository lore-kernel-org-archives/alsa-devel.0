From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: fixing seq_midi: MIDI output buffer overrun
Date: Tue, 25 Dec 2018 20:34:02 +0900
Message-ID: <20181225113402.GA30176@workstation>
References: <CAHbXqSim_CR09w9Wu5EOO+OEzRXVyG24t1xmOWTxYg_zfpE8eQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com
 [209.85.215.194])
 by alsa0.perex.cz (Postfix) with ESMTP id E2D862678F6
 for <alsa-devel@alsa-project.org>; Tue, 25 Dec 2018 12:34:10 +0100 (CET)
Received: by mail-pg1-f194.google.com with SMTP id z10so6491049pgp.7
 for <alsa-devel@alsa-project.org>; Tue, 25 Dec 2018 03:34:10 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAHbXqSim_CR09w9Wu5EOO+OEzRXVyG24t1xmOWTxYg_zfpE8eQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Adam Goode <agoode@chromium.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Mon, Dec 24, 2018 at 03:43:58PM -0500, Adam Goode wrote:
> I am investigating why Chromium can't reliably send sysex messages on
> Linux. (See https://bugs.chromium.org/p/chromium/issues/detail?id=917708.)
> 
> I've seen the message at
> https://alsa-devel.alsa-project.narkive.com/6w35hffF/sysex-overflow-when-using-the-midi-sequencer-event-interface
> 
> Chromium does use seq and we do need sysex to be reliable since
> vendors such as Novation and Yamaha use Web MIDI to interface with
> hardware.
> 
> The code in question predates git history (2005). It's
> event_process_midi() and dump_midi() in seq_midi.c.
> 
> I see that dump_midi() returns either ENOMEM or EINVAL under certain
> conditions, but the only caller (event_process_midi()) throws these
> errors away and always returns 0 if everything but dump_midi()
> succeeds.

It's difficult to regenerate your issue just according to the above
information. But I guess that chromium process tries to send a batch
of system-exclusive MIDI messages in one operation.

If so, it's easy to bring buffer-overflow in buffers of rawmidi
substream for target sound card (= kernel client of ALSA sequencer).
As a default, the size of buffer is the same as memory page frame[1]
thus the system-exclusive message is 4,096 bytes or more.

On the other hand, physical layer of serial bus for MIDI communication
has 31,250 bits/sec bandwidth. This means that drivers need over 1 sec
to finish transmission of the message.

> A few questions:
> 
> 1. Can I change dump_midi to block instead of return ENOMEM if I don't
> use SND_SEQ_NONBLOCK in snd_seq_open?

This is a callgraph for callers of 'dump_midi()'.

(sound/core/seq/seq_midi.c)
dump_midi()
<-snd_seq_dump_var_event()
  <-event_process_midi()
    (sound/core/seq/seq_clientmgr.c)
    <-snd_seq_deliver_single_event()
      <-broadcast_event()
      <-bounce_error_event()
      <-port_broadcast_event()
      <-deliver_to_subscribers()
        <-snd_seq_deliver_event()
          <-snd_seq_client_enqueue_event()
            <-snd_seq_write()
              <-write(2)
          <-snd_seq_kernel_client_dispatch()
            <-(in-kernel)
          <-snd_seq_dispatch_event()
            (sound/core/seq/seq_queue.c)
            <-snd_seq_check_queue()
              <-snd_seq_enqueue_event()
                <-snd_seq_dispatch_event()
		  <-(loop)
                <-snd_seq_client_enqueue_event()
                  <-snd_seq_write()
		    <-write(2)
                  <-kernel_client_enqueue()
  		    <-(in-kernel)

If changing behaviour of the 'dump_midi()' function, we need to care
all of the above. Especially, in ALSA sequencer subsystem, there're
two types of client; 'kernel' and 'user'. When introducing the
non-blocking behaviour, we need to investigate kernel clients.If any
call on the above graph runs in any IRQ context, usage of task
scheduler can break Linux system.

> 2. What should be returned in NONBLOCK mode? Probably EAGAIN?

In this subsystem, it's natural behaviour to return EAGAIN to callers
with non-blocking mode.

> 3. The general blocking behavior of seq seems inconsistent. If I am
> using snd_seq_ev_set_direct, then I get EAGAIN even with a blocking
> open. Should I expect blocking from the pool, or only if using a
> queue?
>
> 4. Is there any obvious fix I am overlooking?

If this issue should be fixed immediately, it's better to change Chromium
implementation not to write a batch of MIDI messages in one time to
ALSA seq character device, with enough care of narrow bandwidth of
serial bus for MIDI communication.

In this point, usage of queue of ALSA sequencer is one option.

I note that

[1] https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git/tree/sound/core/rawmidi.c#n114


Regards

Takashi Sakamoto
