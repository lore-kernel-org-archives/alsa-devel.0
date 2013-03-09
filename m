From: "Gabriel M. Beddingfield" <gabrbedd@gmail.com>
Subject: Re: How to send non-SysEx system messages via ALSA?
Date: Sat, 09 Mar 2013 11:42:33 -0800
Message-ID: <513B90A9.7070309@gmail.com>
References: <8E4C156DA5797D418DBFADFD8CE655A422BA54AFBB@HE113481.emea1.cds.t-internal.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-da0-f48.google.com (mail-da0-f48.google.com
 [209.85.210.48])
 by alsa0.perex.cz (Postfix) with ESMTP id 58BA6265005
 for <alsa-devel@alsa-project.org>; Sat,  9 Mar 2013 20:42:46 +0100 (CET)
Received: by mail-da0-f48.google.com with SMTP id w4so391293dam.7
 for <alsa-devel@alsa-project.org>; Sat, 09 Mar 2013 11:42:45 -0800 (PST)
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

On 03/05/2013 02:56 AM, Joerg-Cyril.Hoehle@t-systems.com wrote:
> Now, consider an app playing a MIDI file or a debug tool that allows
> to send arbitrary messages.  How should such an app send e.g. the
> 2-byte MTC Quarter Frame sequence via ALSA?

If you want to send arbitrary MIDI messages, you'll find the rawmidi 
interface more flexible.  The seq interface is very restrictive in this 
case.

For example, I think you can send arbitrary (even random/invalid) stuff 
using the CLI `amidi`.  It was intended for Sysex dumps, but I think 
it's more flexable.  It uses the rawmidi api.

http://www.alsa-project.org/alsa-doc/alsa-lib/group___raw_midi.html

The down-side of using rawmidi is that you're now on your own for 
sequencing (timing).

> A. Use a 2 byte buffer F1 xx and snd_seq_ev_set_sysex(&event, 2, buf);

Set up a snd_seq_event_t with type SND_SEQ_EVENT_QFRAME and fill out the 
snd_seq_event_t::control structure with the appropriate data.  Your 
1-byte payload message should go into the 'value' field... and ignore 
the 'channel' and 'param' fields.

> B. Use SND_SEQ_EVENT_TICK and figure out some copy&paste code from seqmidi.h, perhaps
>     snd_seq_ev_set_queue_control(ev,SND_SEQ_EVENT_TICK,SND_SEQ_QUEUE_DIRECT,xx)
>     But why does that alter my destination port via
>      snd_seq_ev_set_dest(ev, SND_SEQ_CLIENT_SYSTEM, SND_SEQ_PORT_SYSTEM_TIMER)?

Inspecting the source, it looks like the kernel seq driver drops the 
non-standard 'Tick' message (0xF9).  The only way I know to send it is 
to use the rawmidi API.  [Anybody: please correct me if I'm wrong here.]

> Background: Wine on Linux needs to generate such messages on behalf of
> applications and users with real MIDI HW.
> So far Wine assumes that it can encapsulate all system messages in a SysEx,
> IOW Wine does A.  Is that usage of the set_sysex API correct?
> More generally, can Wine transparently stuff system messages into a byte buffer
> and send them off via snd_seq_ev_set_sysex?

Since Wine is sending/receiving midi data (without timing) that is to be 
sent/received _immediately_ -- you might find life easier by using the 
rawmidi api.  Using this, it might even be as simple as passing raw data 
back and forth without having to decode anything yourself.

-gabriel
