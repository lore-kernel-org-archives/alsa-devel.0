From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: How to send non-SysEx system messages via ALSA?
Date: Tue, 05 Mar 2013 12:51:24 +0100
Message-ID: <5135DC3C.20706@ladisch.de>
References: <8E4C156DA5797D418DBFADFD8CE655A422BA54AFBB@HE113481.emea1.cds.t-internal.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id C1BF0265224
 for <alsa-devel@alsa-project.org>; Tue,  5 Mar 2013 12:51:27 +0100 (CET)
In-Reply-To: <8E4C156DA5797D418DBFADFD8CE655A422BA54AFBB@HE113481.emea1.cds.t-internal.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Joerg-Cyril.Hoehle@t-systems.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Joerg-Cyril.Hoehle@t-systems.com wrote:
> seqmid.h contains function that declare the major event types like
> snd_seq_ev_set_noteon and snd_seq_ev_set_sysex.  However, seq_event.h
> knows many more types, e.g. SND_SEQ_EVENT_START and
> SND_SEQ_EVENT_CLOCK/TICK.

The functions in seqmid.h are just helpers for the most common messages;
you can fill the snd_seq_event_t structure manually.

> Now, consider an app playing a MIDI file or a debug tool that allows
> to send arbitrary messages.  How should such an app send e.g. the
> 2-byte MTC Quarter Frame sequence via ALSA?
> ...
> B. Use SND_SEQ_EVENT_TICK

This is not a MIDI message.  (In fact, this message is not used at all.
Er, and don't believe what its comment says.)

>    snd_seq_ev_set_queue_control(ev,...)
>    But why does that alter my destination port via
>     snd_seq_ev_set_dest(ev, SND_SEQ_CLIENT_SYSTEM, SND_SEQ_PORT_SYSTEM_TIMER)?

Certain messages are use for sequencer-specific notification and control
purposes.  Messages that affect (queue) timers are sent to the special
system timer client.

> C. It's SND_SEQ_EVENT_CLOCK actually,

SND_SEQ_EVENT_CLOCK is MIDI Clock (F8).

MTC Quarter Frame (F1) is SND_SEQ_EVENT_QFRAME.

> Background: Wine on Linux needs to generate such messages on behalf of
> applications and users with real MIDI HW.
> So far Wine assumes that it can encapsulate all system messages in a SysEx,
> IOW Wine does A.  Is that usage of the set_sysex API correct?

It works, but it's not what this event type was designed for.  In any
case, all MIDI messages have a corresponding sequencer event type, so
you should use that.

You could save much work by using ALSA's built-in MIDI encoder:
http://www.alsa-project.org/alsa-doc/alsa-lib/group___m_i_d_i___event.html


Regards,
Clemens
