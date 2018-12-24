From: Adam Goode <agoode@chromium.org>
Subject: fixing seq_midi: MIDI output buffer overrun
Date: Mon, 24 Dec 2018 15:43:58 -0500
Message-ID: <CAHbXqSim_CR09w9Wu5EOO+OEzRXVyG24t1xmOWTxYg_zfpE8eQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com
 [209.85.208.178])
 by alsa0.perex.cz (Postfix) with ESMTP id 97ABD267A6C
 for <alsa-devel@alsa-project.org>; Mon, 24 Dec 2018 21:44:35 +0100 (CET)
Received: by mail-lj1-f178.google.com with SMTP id n18-v6so11036988lji.7
 for <alsa-devel@alsa-project.org>; Mon, 24 Dec 2018 12:44:35 -0800 (PST)
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

I am investigating why Chromium can't reliably send sysex messages on
Linux. (See https://bugs.chromium.org/p/chromium/issues/detail?id=917708.)

I've seen the message at
https://alsa-devel.alsa-project.narkive.com/6w35hffF/sysex-overflow-when-using-the-midi-sequencer-event-interface

Chromium does use seq and we do need sysex to be reliable since
vendors such as Novation and Yamaha use Web MIDI to interface with
hardware.

The code in question predates git history (2005). It's
event_process_midi() and dump_midi() in seq_midi.c.

I see that dump_midi() returns either ENOMEM or EINVAL under certain
conditions, but the only caller (event_process_midi()) throws these
errors away and always returns 0 if everything but dump_midi()
succeeds.

A few questions:

1. Can I change dump_midi to block instead of return ENOMEM if I don't
use SND_SEQ_NONBLOCK in snd_seq_open?

2. What should be returned in NONBLOCK mode? Probably EAGAIN?

3. The general blocking behavior of seq seems inconsistent. If I am
using snd_seq_ev_set_direct, then I get EAGAIN even with a blocking
open. Should I expect blocking from the pool, or only if using a
queue?

4. Is there any obvious fix I am overlooking?


Thanks,

Adam
