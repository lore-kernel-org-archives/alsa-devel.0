From: Ville Oikarinen <ville@oikarinen.org>
Subject: Slow/piecewise send of sysex?
Date: Wed, 12 Jul 2017 09:49:24 +0300
Message-ID: <CACCw25PGWUoVPv3hnKNjgh0dB9mNxggPyKSXAox4k9hSuQUisw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qt0-f171.google.com (mail-qt0-f171.google.com
 [209.85.216.171])
 by alsa0.perex.cz (Postfix) with ESMTP id 27CB9266B7E
 for <alsa-devel@alsa-project.org>; Wed, 12 Jul 2017 08:49:25 +0200 (CEST)
Received: by mail-qt0-f171.google.com with SMTP id b40so11294582qtb.2
 for <alsa-devel@alsa-project.org>; Tue, 11 Jul 2017 23:49:25 -0700 (PDT)
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

Hello.

I just created this question as a ticket
https://github.com/opensrc/alsa/issues/24 but was instructed to ask
here.

So:

I'm using amidi --send-hex to send data to a Commodore 64 via a CLab
MIDI interface. The problem is that even with 100 bytes the
probability of a buffer overrun is about 30%. I didn't find a way to
throttle the send speed. I also tried sending the data in smaller
chunks, but I cannot get amidi to send anything after the first chunk.
I suspect it refuses to send anything if the data doesn't start with
F0 i.e. sysex dump start.

If I am right about that assumption, as a workaround I could
encapsulate each chunk as a full sysex dump, but that requires extra
logic on the receiving side and it also wastes bandwidth, so I don't
really wish to do that.

Primarily I would prefer a way to throttle the speed, but if I cannot
have that, I would like to be able to send the data a few bytes at a
time in a simple shell loop.

- Ville Oikarinen
