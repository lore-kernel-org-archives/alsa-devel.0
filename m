From: Peter Rosin <peda@lysator.liu.se>
Subject: prealloc_buffer_size and buffer_bytes_max
Date: Thu, 21 May 2015 14:28:25 +0200
Message-ID: <555DCF69.9090008@lysator.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.lysator.liu.se (mail.lysator.liu.se [130.236.254.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 19C202612D1
 for <alsa-devel@alsa-project.org>; Thu, 21 May 2015 14:28:36 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>
List-Id: alsa-devel@alsa-project.org

Hi!

I got my hopes up when I read the commit message for c14e2591bf54
ASoC: atmel-pcm-dma: increase buffer_bytes_max. Quoting it:

	atmel-pcm-dma is not limited to a buffer size of 64kB like
	atmel-pcm-pdc. Increase buffer_bytes_max to 512kB to allow
	for higher bit rates (i.e. 32bps at 192kHz) to work correctly.
	By default, keep the prealloc at 64kB.

However, as I (think I) request a bigger buffer it still caps out at 64kB.
I'm using the latency argument of snd_pcm_set_params to control the buffer:

	snd_pcm_set_params(pcm,
		SND_PCM_FORMAT_S32_LE,
		SND_PCM_ACCESS_RW_INTERLEAVED,
		2,      /* channels */
		250000, /* rate */
		0,      /* do not resample */
		90000); /* latency in us */

But snd_pcm_hw_params_get_buffer_size "only" returns 8192 frames (64kB)
even if I request 9us * 250kHz * 2 * 4 = 180kB. If I change the prealloc
from 64kB to 256kB I get a bigger buffer (and it works better too!).

Admittedly I backported this patch on top of the linux-3.18-at91
branch from the Atmel git repo, so there might be some support
missing that has gone in after 3.18?

Or have I completely misunderstood, and these are unrelated buffers?

Any insight in how I can get a big enough buffer without hacking the
prealloc is appreciated!

Cheers,
Peter
