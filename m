From: Trent Piepho <xyzzy@speakeasy.org>
Subject: Re: hw_params function and OSS emulation
Date: Tue, 21 Aug 2007 16:42:09 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0708211623010.30669@shell2.speakeasy.net>
References: <46CB2BB4.9060808@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail2.sea5.speakeasy.net (mail2.sea5.speakeasy.net
	[69.17.117.4]) by alsa0.perex.cz (Postfix) with ESMTP id A084424376
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Aug 2007 01:42:12 +0200 (CEST)
In-Reply-To: <46CB2BB4.9060808@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 21 Aug 2007, Timur Tabi wrote:
> I'm working on an ASoC driver, and I noticed that with OSS emulation enabled,
> my snd_pcm_ops.hw_params and and snd_pcm_ops.hw_free are called multiple times
> when an OSS driver uses the OSS emulation.  In my case, .hw_params is called
> *four* times, each time with a different DMA buffer size and number of periods.
>
> The problem is that my driver allocates a DMA buffer in my .hw_params
> function.  For now, I have it deallocate the buffers at the top of the
> function and then allocate new ones based on the new hw_params values.
>
> This is really annoying.  So I have a few questions:
>
> 1) Is there any way this can be fixed?  Can't the OSS emulation code figure
> out what it needs and wait until it's done before it calls .hw_params?
>
> As a solution to the DMA buffer deallocate/reallocate hack I'm using, would it
> be okay to move the actual allocations to snd_pcm_ops.prepare()?  My
> .hw_params function will collect the relevant data and keep them in some
> private structure.  Then when .prepare() is called, I do the actual buffer
> allocation.
>
> 2) Can I assume that .prepare() is called only once?
>

The drivers docs say:
	The difference from hw_params is that the prepare callback will be
	called at each time snd_pcm_prepare() is called, i.e. when
	recovered after underruns, etc.

	Be careful that this callback will be called many times at each set
	up, too.

> 3) Can I assume that .hw_params() is never called after .prepare() is called?

Good question!  When prepare is called multiple times, will the hw_params
values be the same each time?  i.e., could one allocate memory and setup IOMMU
resources for the dma buffer the first time it is called, then avoid doing
so on subsequent calls?
