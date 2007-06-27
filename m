From: "Pharaoh ." <pharaoh137@gmail.com>
Subject: Re: Getting physical address of the DMA buffer
Date: Wed, 27 Jun 2007 14:18:13 +0530
Message-ID: <61445c750706270148m486dcceai27959d18feedd63c@mail.gmail.com>
References: <61445c750706261104i24d912edp6eee24944e3bd16f@mail.gmail.com>
	<1182926306.31503.1197270305@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.182])
	by alsa0.perex.cz (Postfix) with ESMTP id 240F81037FF
	for <alsa-devel@alsa-project.org>;
	Wed, 27 Jun 2007 10:48:14 +0200 (CEST)
Received: by wa-out-1112.google.com with SMTP id m33so129569wag
	for <alsa-devel@alsa-project.org>; Wed, 27 Jun 2007 01:48:13 -0700 (PDT)
In-Reply-To: <1182926306.31503.1197270305@webmail.messagingengine.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <cladisch@fastmail.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 6/27/07, Clemens Ladisch <cladisch@fastmail.net> wrote:
> Pharaoh . wrote:
> > I have allocated the DMA buffer using snd_pcm_lib_malloc_pages() and
> > it was preallocated as:
> >
> > snd_pcm_lib_preallocate_pages_for_all(pcm,
> >                                       SNDRV_DMA_TYPE_CONTINUOUS,
> >                                       snd_dma_continuous_data
> >                                       (GFP_KERNEL),
>
> SNDRV_DMA_TYPE_CONTINUOUS is for a buffer that cannot be accessed
> over DMA.
>
> What kind of bus does your hardware use, and how would you
> allocate memory for it?
>
>
> Regards,
> Clemens
>

Continuous buffers unrelated to the bus type can be allocated using
SNDRV_DMA_TYPE_CONTINUOUS right? I am referring a standard driver from
omap source tree, and the buffer allocation functions I have copied
from there and they should be same for the range of OMAPs since the
dma handling is same for them.

> SNDRV_DMA_TYPE_CONTINUOUS is for a buffer that cannot be accessed
> over DMA.

Thats why I get runtime->dma_addr as 0.
