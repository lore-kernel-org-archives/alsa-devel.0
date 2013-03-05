From: <Joerg-Cyril.Hoehle@t-systems.com>
Subject: How to send non-SysEx system messages via ALSA?
Date: Tue, 5 Mar 2013 11:56:24 +0100
Message-ID: <8E4C156DA5797D418DBFADFD8CE655A422BA54AFBB@HE113481.emea1.cds.t-internal.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tcmail93.telekom.de (tcmail93.telekom.de [80.149.113.205])
 by alsa0.perex.cz (Postfix) with ESMTP id 31E5E26520C
 for <alsa-devel@alsa-project.org>; Tue,  5 Mar 2013 11:56:26 +0100 (CET)
Content-Language: de-DE
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

seqmid.h contains function that declare the major event types like
snd_seq_ev_set_noteon and snd_seq_ev_set_sysex.  However, seq_event.h
knows many more types, e.g. SND_SEQ_EVENT_START and
SND_SEQ_EVENT_CLOCK/TICK.

Now, consider an app playing a MIDI file or a debug tool that allows
to send arbitrary messages.  How should such an app send e.g. the
2-byte MTC Quarter Frame sequence via ALSA?

A. Use a 2 byte buffer F1 xx and snd_seq_ev_set_sysex(&event, 2, buf);

B. Use SND_SEQ_EVENT_TICK and figure out some copy&paste code from seqmidi.=
h, perhaps
   snd_seq_ev_set_queue_control(ev,SND_SEQ_EVENT_TICK,SND_SEQ_QUEUE_DIRECT,=
xx)
   But why does that alter my destination port via
    snd_seq_ev_set_dest(ev, SND_SEQ_CLIENT_SYSTEM, SND_SEQ_PORT_SYSTEM_TIME=
R)?

C. It's SND_SEQ_EVENT_CLOCK actually, TICK being the one byte F8 real-time =
message?

Background: Wine on Linux needs to generate such messages on behalf of
applications and users with real MIDI HW.
So far Wine assumes that it can encapsulate all system messages in a SysEx,
IOW Wine does A.  Is that usage of the set_sysex API correct?
More generally, can Wine transparently stuff system messages into a byte bu=
ffer
and send them off via snd_seq_ev_set_sysex?

Thank you,
 J=F6rg H=F6hle
