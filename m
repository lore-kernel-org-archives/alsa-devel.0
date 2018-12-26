From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: fixing seq_midi: MIDI output buffer overrun
Date: Wed, 26 Dec 2018 14:13:54 +0900
Message-ID: <20181226051354.GA12745@workstation>
References: <CAHbXqSim_CR09w9Wu5EOO+OEzRXVyG24t1xmOWTxYg_zfpE8eQ@mail.gmail.com>
 <20181225113402.GA30176@workstation>
 <CAHbXqSh6dKpF3msz5j73v_6KerurjmRRZXSVP1Fvk91kL3ZCFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com
 [209.85.210.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E5A28267AE6
 for <alsa-devel@alsa-project.org>; Wed, 26 Dec 2018 06:14:02 +0100 (CET)
Received: by mail-pf1-f193.google.com with SMTP id u6so7408954pfh.11
 for <alsa-devel@alsa-project.org>; Tue, 25 Dec 2018 21:14:02 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAHbXqSh6dKpF3msz5j73v_6KerurjmRRZXSVP1Fvk91kL3ZCFw@mail.gmail.com>
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

On Tue, Dec 25, 2018 at 08:29:00PM -0500, Adam Goode wrote:
> An easy way to reproduce is to have amidicat send a sysex file to any
> USB MIDI device:
> http://krellan.com/amidicat/
> 
> amidicat   --port 28:0 test.syx
> 
> (You can send anything, including /dev/urandom on stdin.)
> 
> amidicat has a purpose similar to Web MIDI in Chromium, it opens in
> blocking mode and uses snd_midi_event_encode_byte to convert MIDI
> bytes into seq events without doing much inspection on the data
> itself.
> If you look at write_event() in amidicat.c you can see it tries to
> send bytes to seq with as low latency or processing as possible. But
> there is a comment in the code:
> 
> /* FUTURE: Even though this loop works, it's still too easy to flood
> the other end and overrun, perhaps a queuing bug internally within
> ALSA? */
> 
> Which is probably this same problem.
 
I note that 'How to reproduce' is the most important when taking any issue.
In your case:

1. Prepare a batch of sysex messages over 4096 bytes or more
2. Open user client to ALSA sequencer
3. Write a batch of sysex messages toward rawmidi kernel client of ALSA
   sequencer.
4. Even if returning from the above operation, the peer don't still receive
   all of the messages. Even if enough later, the peer neither yet. This
   is an issue.

The cause is buffer-overflow detection in rawmidi substream. A rawmidi
kernel client of ALSA sequencer discourages data transmission in
this case without any retry.

> > If so, it's easy to bring buffer-overflow in buffers of rawmidi
> > substream for target sound card (= kernel client of ALSA sequencer).
> > As a default, the size of buffer is the same as memory page frame[1]
> > thus the system-exclusive message is 4,096 bytes or more.
> >
> 
> When using rawmidi directly, there is no overflow since the user gets
> blocked. In ALSA sequencer, dump_midi() first checks rawmidi's
> internal buffer and fails if there is not enough space.
>
> > On the other hand, physical layer of serial bus for MIDI communication
> > has 31,250 bits/sec bandwidth. This means that drivers need over 1 sec
> > to finish transmission of the message.
> >
> > > A few questions:
> > >
> > > 1. Can I change dump_midi to block instead of return ENOMEM if I don't
> > > use SND_SEQ_NONBLOCK in snd_seq_open?
> >
> > This is a callgraph for callers of 'dump_midi()'.
> >
> > (sound/core/seq/seq_midi.c)
> > dump_midi()
> > <-snd_seq_dump_var_event()
> >   <-event_process_midi()
> >     (sound/core/seq/seq_clientmgr.c)
> >     <-snd_seq_deliver_single_event()
> >       <-broadcast_event()
> >       <-bounce_error_event()
> >       <-port_broadcast_event()
> >       <-deliver_to_subscribers()
> >         <-snd_seq_deliver_event()
> >           <-snd_seq_client_enqueue_event()
> >             <-snd_seq_write()
> >               <-write(2)
> >           <-snd_seq_kernel_client_dispatch()
> >             <-(in-kernel)
> >           <-snd_seq_dispatch_event()
> >             (sound/core/seq/seq_queue.c)
> >             <-snd_seq_check_queue()
> >               <-snd_seq_enqueue_event()
> >                 <-snd_seq_dispatch_event()
> >                   <-(loop)
> >                 <-snd_seq_client_enqueue_event()
> >                   <-snd_seq_write()
> >                     <-write(2)
> >                   <-kernel_client_enqueue()
> >                     <-(in-kernel)
> >
> > If changing behaviour of the 'dump_midi()' function, we need to care
> > all of the above. Especially, in ALSA sequencer subsystem, there're
> > two types of client; 'kernel' and 'user'. When introducing the
> > non-blocking behaviour, we need to investigate kernel clients.If any
> > call on the above graph runs in any IRQ context, usage of task
> > scheduler can break Linux system.
> >
> 
> Yes, maybe I will try to introduce proper error returns before trying
> to solve blocking mode.
> 
> > > 2. What should be returned in NONBLOCK mode? Probably EAGAIN?
> >
> > In this subsystem, it's natural behaviour to return EAGAIN to callers
> > with non-blocking mode.
> >
> 
> I think EAGAIN would work for normal events, but sysex uses
> snd_seq_dump_var_event() which calls dump_midi in a loop. It is tricky
> because user-to-user sysex doesn't have the same size limit that
> user-to-rawmidi does. We might be able to return ENOMEM immediately if
> the size of the sysex message size exceeds the rawmidi buffer, but
> only for rawmidi. This is probably ok since no sysex message sent to
> rawmidi through seq can be larger than PAGESIZE already. If we can
> ensure that we never return EAGAIN in the middle of sending a sysex,
> then that should work ok.
> 
> > > 3. The general blocking behavior of seq seems inconsistent. If I am
> > > using snd_seq_ev_set_direct, then I get EAGAIN even with a blocking
> > > open. Should I expect blocking from the pool, or only if using a
> > > queue?

I've got it. Then I note that we should take enough care of kernel client,
queue scheduled by kernel timer, and so on. Blocking behaviour with calls
of task scheduler, or propagation of EAGAIN to expect callers to retry
should break nothing, as much as possible. Any test programs (or test
drivers) is preferrable.

> > > 4. Is there any obvious fix I am overlooking?
> >
> > If this issue should be fixed immediately, it's better to change Chromium
> > implementation not to write a batch of MIDI messages in one time to
> > ALSA seq character device, with enough care of narrow bandwidth of
> > serial bus for MIDI communication.
> >
> 
> No, I don't think it needs to be fixed immediately. I just happened to
> find this myself.
> 
> In general, the main workaround for this (used by amidicat and dosbox)
> are simply to delay some amount between messages. I don't want to do
> that in Chromium because that would complicate the code quite a bit
> and since this introduces artificial delay that is not needed for
> user-to-user MIDI communications.

It's natural to have differences between two cases; the peer is rawmidi
kernel client, and the peer is userspace application because userspace
application never has bandwidth limitation to process received MIDI
messages, in theory.

However, if you want to change behaviour of rawmidi client and the
others in ALSA sequencer, please post your patches. I'm willing to
review them.


Regards

Takashi Sakamoto
