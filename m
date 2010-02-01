From: pl bossart <bossart.nospam@gmail.com>
Subject: Re: safe support for rewind in ALSA
Date: Mon, 1 Feb 2010 16:40:04 -0600
Message-ID: <6160a5131002011440p52fb1b2dv9d077681544adb8c@mail.gmail.com>
References: <6160a5131002010920j4417a34ai9f410fb500f7f305@mail.gmail.com>
	<alpine.LNX.2.00.1002011840020.25340@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f173.google.com (mail-px0-f173.google.com
	[209.85.216.173])
	by alsa0.perex.cz (Postfix) with ESMTP id 1DDE824385
	for <alsa-devel@alsa-project.org>; Mon,  1 Feb 2010 23:40:05 +0100 (CET)
Received: by pxi3 with SMTP id 3so16853pxi.16
	for <alsa-devel@alsa-project.org>; Mon, 01 Feb 2010 14:40:04 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.1002011840020.25340@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: ALSA development <alsa-devel@alsa-project.org>, Kai Vehmanen <kvehmanen@eca.cx>
List-Id: alsa-devel@alsa-project.org

> I don't think that there have been no progress. The queued samples can be
> stored to runtime->delay now, so snd_pcm_delay() returns a correct value.
>
> The snd_pcm_rewind() and snd_pcm_forward() functions should operate in the
> ring buffer and it's ok. See the USB driver for an example. Just add support
> for runtime->delay to the lowlevel drivers and use snd_pcm_delay() correctly
> in the user space and everything will work as expected.
>
> In other words - for hardware with large FIFOs, the runtime->delay should be
> used for queued samples and the hw_ptr in the ring buffer should be
> increased as soon as the FIFO is filled with samples from the ring buffer.

Thanks Jaroslav.
I was under the impression that the runtime->delay indicated the time
needed for transmission and D/A. If this is intended to be the queued
samples, then it plays the same role as my 'fifo' proposal. There are
several consequences though:
- This means rewind() can only happen within the ring buffer, and all
samples previously queued will be played as is.
- the 'only' change is to make sure the hw_ptr reported in .pointer is
NOT the number of samples pushed out to the interface. hw_ptr should
really represent the next read position in the ring buffer, this isn't
uniform across drivers. This means for example that the HDAudio
implementation needs to modified so that the LPIB value is increased
with runtime->delay.
- How do you specify the time for transmission and D/A, so that
applications can know when a sample will actually be played. With your
explanation the applications can only know when a sample will be
pushed out, there is an additional latency not accounted for.
Thanks for your feedback.
- Pierre
