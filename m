From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: Re: pxa2xx-pcm and dma_request
Date: Wed, 13 May 2009 08:43:05 +0400
Message-ID: <bc64b4640905122143o76b5ebccm7b9f40e8b2577f7c@mail.gmail.com>
References: <87vdo6c9pt.fsf@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f215.google.com (mail-bw0-f215.google.com
	[209.85.218.215])
	by alsa0.perex.cz (Postfix) with ESMTP id CDC5110387D
	for <alsa-devel@alsa-project.org>;
	Wed, 13 May 2009 06:43:05 +0200 (CEST)
Received: by bwz11 with SMTP id 11so427436bwz.32
	for <alsa-devel@alsa-project.org>; Tue, 12 May 2009 21:43:05 -0700 (PDT)
In-Reply-To: <87vdo6c9pt.fsf@free.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

2009/5/13 Robert Jarzmik <robert.jarzmik@free.fr>:
> Hi Mark and Dimitry,
>
> I've been playing for some time with DMA on the PXA series. I was wondering if
> the behaviour of pxa2xx-pcm is correct.
>
> As far as I understand, in an asoc context, the __pxa2xx_pcm_open() is called,
> while in "arm context", pxa2xx_pcm_open() is called, which calls
> __pxa2xx_pcm_open().
>
> This was introduced by commit a6d77317678148c973bb0131cc5a3a772f756d23 I think.
>
> One main difference is that in "arm context", pxa_dma_request() is called, while
> in "asoc context", it is not.

This was done by intent as before code merge plain ARM driver used DMA while
ASoC didn't. That was done mainly because I didn't have all the hw
variants (only
pxa255 at hand) and didn't want to introduce any points of possible failure.
Now merging DMA code into generic code path would be a nice feature though.

> I'd like one of you to cross-check, as I must admit I'm not following all the
> impacts of the pcm code split-up.

The initial impact of the merge should be void, as it was an
_unification_ of code
presented in ASoC and non-ASoC drivers.

-- 
With best wishes
Dmitry
