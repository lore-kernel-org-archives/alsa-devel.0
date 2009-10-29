From: jassi brar <jassisinghbrar@gmail.com>
Subject: Re: What am i doing wrong?
Date: Thu, 29 Oct 2009 21:45:46 +0900
Message-ID: <1b68c6790910290545i2cd3e9a6u9f2be4b5614008db@mail.gmail.com>
References: <0D107966AF6D79418315B7C5549F4B5101150D3A@lemail1.le.imgtec.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f203.google.com (mail-px0-f203.google.com
	[209.85.216.203])
	by alsa0.perex.cz (Postfix) with ESMTP id B55F41037FC
	for <alsa-devel@alsa-project.org>; Thu, 29 Oct 2009 13:45:47 +0100 (CET)
Received: by pxi41 with SMTP id 41so1201925pxi.24
	for <alsa-devel@alsa-project.org>; Thu, 29 Oct 2009 05:45:46 -0700 (PDT)
In-Reply-To: <0D107966AF6D79418315B7C5549F4B5101150D3A@lemail1.le.imgtec.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Neil Jones <neil.jones@imgtec.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 29, 2009 at 2:33 AM, Neil Jones <neil.jones@imgtec.com> wrote:
> PCM DMA IRQ: status 100000, timestamp 4483380 ms,
> ALSA sound/core/pcm_lib.c:250: period_update: pcmC0D0p:0:
> pos=0x1000/0x1000/0xbb80, hwptr=0x0, hw_base=0x0, hw_intr=0x0
> PCM DMA IRQ: status 120000, timestamp 4483430 ms,
> ALSA sound/core/pcm_lib.c:250: period_update: pcmC0D0p:0:
> pos=0x2000/0x1000/0xbb80, hwptr=0x1000, hw_base=0x0, hw_intr=0x1000
> PCM DMA IRQ: status 120000, timestamp 4483480 ms,
> ALSA sound/core/pcm_lib.c:250: period_update: pcmC0D0p:0:
> pos=0x3000/0x1000/0xbb80, hwptr=0x2000, hw_base=0x0, hw_intr=0x2000
> PCM DMA IRQ: status 120000, timestamp 4483530 ms,
> ALSA sound/core/pcm_lib.c:250: period_update: pcmC0D0p:0:
> pos=0x4000/0x1000/0xbb80, hwptr=0x3000, hw_base=0x0, hw_intr=0x3000
> PCM DMA IRQ: status 120000, timestamp 4483580 ms,
> ALSA sound/core/pcm_lib.c:250: period_update: pcmC0D0p:0:
> pos=0x5000/0x1000/0xbb80, hwptr=0x4000, hw_base=0x0, hw_intr=0x4000
> PCM DMA IRQ: status 120000, timestamp 4483630 ms,
> ALSA sound/core/pcm_lib.c:250: period_update: pcmC0D0p:0:
> pos=0x6000/0x1000/0xbb80, hwptr=0x5000, hw_base=0x0, hw_intr=0x5000
> PCM DMA IRQ: status 120000, timestamp 4483680 ms,
> ALSA sound/core/pcm_lib.c:250: period_update: pcmC0D0p:0:
> pos=0x7000/0x1000/0xbb80, hwptr=0x6000, hw_base=0x0, hw_intr=0x6000
> PCM DMA IRQ: status 120000, timestamp 4483730 ms,
> ALSA sound/core/pcm_lib.c:250: period_update: pcmC0D0p:0:
> pos=0x8000/0x1000/0xbb80, hwptr=0x7000, hw_base=0x0, hw_intr=0x7000
> PCM DMA IRQ: status 120000, timestamp 4483790 ms,
> ALSA sound/core/pcm_lib.c:250: period_update: pcmC0D0p:0:
> pos=0x9000/0x1000/0xbb80, hwptr=0x8000, hw_base=0x0, hw_intr=0x8000

> PCM DMA IRQ: status 120000, timestamp 4483840 ms,
> ALSA sound/core/pcm_lib.c:250: period_update: pcmC0D0p:0:
> pos=0xa000/0x1000/0xbb80, hwptr=0x9000, hw_base=0x0, hw_intr=0x9000
> PCM DMA IRQ: status 120000, timestamp 4483890 ms,
> ALSA sound/core/pcm_lib.c:250: period_update: pcmC0D0p:0:
> pos=0x0/0x1000/0xbb80, hwptr=0xa000, hw_base=0x0, hw_intr=0xa000

Missing IRQ@0xb000 after 0xa000?
Timestamp corresponds to 4800 period size but IRQs to 4096
Check that your DMA driver and snd_pcm_ops.pointer function returns
correct position.

Also, try setting constraint on buffer size to be an integral multiple
of period size, i.e, if
you don't take care of last shorter period elapsed than expected by ALSA
