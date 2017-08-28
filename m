From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Can ALSA MIDI use timestamps for precise timing?
Date: Mon, 28 Aug 2017 11:11:56 +0200
Message-ID: <bde97703-2954-78ce-4128-4a8596c8042c@ladisch.de>
References: <fdc3abae-84b8-d94c-991d-cdd30c4d9f64@cs.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webclient5.webclient5.de (webclient5.webclient5.de
 [136.243.32.179])
 by alsa0.perex.cz (Postfix) with ESMTP id DA5C0266AE1
 for <alsa-devel@alsa-project.org>; Mon, 28 Aug 2017 11:11:59 +0200 (CEST)
Received: from [10.1.2.4] (unknown [94.101.37.79])
 by webclient5.webclient5.de (Postfix) with ESMTPSA id 50A3F55829C1
 for <alsa-devel@alsa-project.org>; Mon, 28 Aug 2017 11:11:57 +0200 (CEST)
In-Reply-To: <fdc3abae-84b8-d94c-991d-cdd30c4d9f64@cs.cmu.edu>
Content-Language: en-US
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

Roger Dannenberg wrote:
>     PortMIDI wants to send MIDI messages at precise times according to
> arbitrary clocks. In Audacity, the important clock to synchronize to is
> the audio sample clock.

What is the API that PortMIDI wants to offer?  And does any OS actually
offer this?

The ALSA sequencer relies on interrupts for the clock.  It would be
possible to use a PCM device as interrupt source, but there is only one
interrupt after each period, so this would have horrible jitter.

> There's absolute timing, but the docs say that's relative to when you
> start the queue, but when exactly is that?

When you start the queue, i.e., when you send the SND_SEQ_EVENT_START
message or call snd_seq_start_queue().

> if you send with relative time and you get unscheduled just as you are
> executing the write call, you'll be late.

That could also happen with any other call.

> The problem becomes precise timing of queue creation doesn't it?

You could measure the offset between the queue's clock and the actual
clock.

> And there's no timestamp provided for when to start.

You could schedule the start event, but that would require another
queue ...  ;-)


Regards,
Clemens
