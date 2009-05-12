From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: pxa2xx-pcm and dma_request
Date: Tue, 12 May 2009 23:06:22 +0200
Message-ID: <87vdo6c9pt.fsf@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 907D610386E
	for <alsa-devel@alsa-project.org>;
	Tue, 12 May 2009 23:06:30 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, dbaryshkov@gmail.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Mark and Dimitry,

I've been playing for some time with DMA on the PXA series. I was wondering if
the behaviour of pxa2xx-pcm is correct.

As far as I understand, in an asoc context, the __pxa2xx_pcm_open() is called,
while in "arm context", pxa2xx_pcm_open() is called, which calls
__pxa2xx_pcm_open().

This was introduced by commit a6d77317678148c973bb0131cc5a3a772f756d23 I think.

One main difference is that in "arm context", pxa_dma_request() is called, while
in "asoc context", it is not.

I'd like one of you to cross-check, as I must admit I'm not following all the
impacts of the pcm code split-up.

Cheers.

--
Robert
