From: Jon Smirl <jonsmirl@gmail.com>
Subject: Proposal for more reliable audio DMA.
Date: Sat, 20 Jun 2009 22:06:07 -0400
Message-ID: <9e4733910906201906y78f76545sc3cdfe9b45a8db5f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f171.google.com (mail-qy0-f171.google.com
	[209.85.221.171])
	by alsa0.perex.cz (Postfix) with ESMTP id A398824410
	for <alsa-devel@alsa-project.org>;
	Sun, 21 Jun 2009 04:06:08 +0200 (CEST)
Received: by qyk1 with SMTP id 1so3082754qyk.16
	for <alsa-devel@alsa-project.org>; Sat, 20 Jun 2009 19:06:07 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This algorithm is fairly similar to what currently exists in ALSA with
a few modifications. I'm trying to come up with guaranteed way to play
glitch free audio. Does this algorithm work or could it be modified to
work?

The main change is to track a high resolution timer as the means of
estimating where in the buffer to insert new, low latency data. This
tracking is done in a timer tick interrupt. Jiffies are too coarse and
not all hardware allows you to ask the current DMA position.

The other change is to keep all of the buffers filled with silence if
there isn't any pending data. (not doing this caused problem in my
mpc5200 AC97 driver)

Three buffers are used as a way to deterministically bound the DMA
pointer without needing interrupts.

---

Use three chained buffers.
Buffer size is samples/tick (or maybe 1.5 samples/tick)
Initialize buffers to silence.
Set end of buffer three to automatically terminate DMA

Set FIFO to minimum bus allows
Fill buffer one with samples available, start playing.

On timer tick call into driver..
If buffer one has finished playing move it to third position.
New last buffer is set to automatically stop DMA.
Return swap status to ALSA
If swapped, fill buffer three with silence or pending data
It is important to fill this buffer with silence if there is no pending data

The size of the buffers needs to be large enough to cover worst case
timer tick latency. Buffer two has to be large enough to ensure that
the tick routine will notice buffer one has been played before buffer
three starts.

If two buffers have been completed when the tick runs, let the third
buffer finish without swapping. Since you don't know where you are in
the third buffer, it is unsafe to swap at this point.

Playing the last buffer causes the end of buffer interrupt to happen.
Callback into ALSA to alert it of the underrun and need to restart DMA.
If this callback happens, make the buffers larger.

Long term observation of buffer completion status in tick handler will allow
accurate computation of samples/HPET unit. Record high accuracy timer
(HPET) on tick.

New low latency data that arrives can be inserted into the buffers dynamically.
Use the high resolution timer source to estimate where to place it.
Minimum FIFO ensures low latency play.

Design a minimum power mode.
Allows a huge FIFO to be loaded (like 128KB).
Call into driver to reset to minimum latency, small FIFO mode.

Advantages:

1) If ALSA goes away, hardware will stop on it's own with no noise.
2) No need to know the current position of DMA hardware.
3) Both low and high latency modes.
4) Audio interrupts only generated as error condition
5) Behavior is deterministic. Nothing is left to guess work.


-- 
Jon Smirl
jonsmirl@gmail.com
