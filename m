From: Jon Smirl <jonsmirl@gmail.com>
Subject: DMA over run on playback
Date: Wed, 13 May 2009 09:08:17 -0400
Message-ID: <9e4733910905130608u63a924cam25dca6af929ec82b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.145])
	by alsa0.perex.cz (Postfix) with ESMTP id 44FC11038AB
	for <alsa-devel@alsa-project.org>;
	Wed, 13 May 2009 15:08:19 +0200 (CEST)
Received: by qw-out-1920.google.com with SMTP id 4so430188qwk.56
	for <alsa-devel@alsa-project.org>; Wed, 13 May 2009 06:08:18 -0700 (PDT)
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

There's a long thread over on the pulse list about glitch free
playback. The glitches they are encountering are caused by CPU
scheduling latency.  They are trying to fix this by setting HZ up to
1000 and constantly polling the audio DMA queue to keep it 99% full.

This doesn't seem like the right solution to me. It is fixing the
symptom not the cause. The cause is 200-300ms scheduling latency. The
source of that needs to be tracked down and fixed in the kernel.  But
we have to live with the latencies until they are fixed.

The strategy of checking the queue at 1000Hz works but it is very
inefficient. The underlying problem is that the buffer ALSA is using
is too small on systems with 300ms latency.  The buffer is just big
enough to cover 300ms so they rapidly check and fill it at 1000Hz to
ensure that it is full if the 300ms latency strikes.

On my hardware with period interrupts ALSA is only checking the buffer
at 8Hz. Since I'm checking appl_ptr I know when DMA over runs the
buffers. This allows me to insert silence and I could indicated this
condition to ALSA if there was a mechanism for doing so. ALSA could
use this over run knowledge to measure scheduling latency and adjust
the buffering.

But the DMA interface between ALSA and the driver has been fixed at
stream creation time. There's no way to dynamically alter it (like
window size changes in TCP/IP).  With networking you get a list of
buffers to send. As you send these buffers you mark them sent. The
core is free to hand you buffers straight from user space or do copies
and use internal ring buffers. The network driver just gets a list of
physical addresses to send. This buffer bookkeeping could occur in
snd_pcm_period_elapsed().

A dynamic chaining mechanism allows you to alter the buffering
mid-stream. If the driver indication a DMA over run error this tells
ALSA that it needs to insert another buffer. After a while these
errors will stop and ALSA will have measured worst case CPU scheduling
latency. From then on it will know the exact size of buffering needed
for the kernel it it running on and it can use this knowledge at
stream creation time. Now filling the buffer at 8Hz or lower will work
and you don't have to spend the power associated with 1000Hz timer
interrupts.

-- 
Jon Smirl
jonsmirl@gmail.com
