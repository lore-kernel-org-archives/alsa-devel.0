From: Adish Kuvelker <adkuvi@gmail.com>
Subject: DMA Physical Address through "snd_pcm_lib_malloc_pages"
Date: Thu, 24 Jun 2010 03:50:17 +0530
Message-ID: <AANLkTik4I2g_DCdJFgNpKrp4vp08UbpKQUtz9YLAVM8K@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id 2B6A224422
	for <alsa-devel@alsa-project.org>;
	Thu, 24 Jun 2010 00:20:19 +0200 (CEST)
Received: by vws20 with SMTP id 20so1485896vws.38
	for <alsa-devel@alsa-project.org>; Wed, 23 Jun 2010 15:20:18 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello,

I am trying to allocate memory for DMA buffer through
"snd_pcm_lib_malloc_pages" in hw_params callout function, with prior
use of "snd_pcm_lib_preallocate_pages_for_all". The chapter on PCM
Interface in "writing an ALSA driver" states that if the standard
function "snd_pcm_lib_malloc_pages" is use for allocating the DMA
buffers then the DMA fields of dma_addr, dma_area, dma_bytes are set
by the ALSA middle layer.

However my code walk through didn't point me to the area where this
physical memory setting is done. My DMA channel is not serving a PCI
device. I would be very grateful if any of you guys can point me to
the code where this settings get done by calling
"snd_pcm_lib_malloc_pages". Going through the code for a few devices
registered under "pci" I found that the call to
"snd_pcm_lib_malloc_pages" is followed by call to
"snd_pcm_sgbuf_get_addr" to get the physical address. Also a call to
"__pa" is done in the "parisc/harmony.c".

Do I have to set the dma parameters in the runtime structure even
after allocating memory using "snd_pcm_lib_malloc_pages"?

Regards;
Aadish
