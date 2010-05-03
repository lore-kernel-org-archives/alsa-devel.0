From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: asoc: fsl_dma_hw_free being called twice at end of
	playback
Date: Mon, 3 May 2010 22:02:11 +0100
Message-ID: <8F61234B-3CA5-4553-A956-1722DD53B55F@opensource.wolfsonmicro.com>
References: <4BDF3738.3070900@freescale.com>
	(sfid-20100503_215124_987373_C978C9AB)
Mime-Version: 1.0 (iPhone Mail 7E18)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A33C0246E1
	for <alsa-devel@alsa-project.org>;
	Mon,  3 May 2010 23:01:06 +0200 (CEST)
In-Reply-To: <4BDF3738.3070900@freescale.com>
	(sfid-20100503_215124_987373_C978C9AB)
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
Cc: ALSA development <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On 3 May 2010, at 21:51, Timur Tabi <timur@freescale.com> wrote:

> In my 8610 ASoC driver, I'm seeing the DMA driver's .hw_free  
> function being
> called twice whenever playback ends.  I've added some printk's to  
> demonstrate:

Is this with or without Liam's multiple CODEC work?

> snd_pcm_common_ioctl1:2543
> snd_pcm_hw_free:543
> soc_pcm_hw_free:761 c023983c
> fsl_dma_hw_free:720 substream=df029d00 dma_private=df440000 stream=0
> snd_pcm_release_substream:2022
> soc_pcm_hw_free:761 c023983c
> fsl_dma_hw_free:720 substream=df029d00 dma_private=df440000 stream=0
> fsl_dma_close:759 substream=df029d00 dma_private=df440000
>
> So the ioctl is being called only once, but the both snd_pcm_hw_free 
> () and
> snd_pcm_release_substream() are calling the .hw_free function.
>
> Is this normal?  I don't know how to handle this, other than to add  
> some
> boolean to my private data structure that indicates whether the  
> resources
> have been freed or not.
>
> -- 
> Timur Tabi
> Linux kernel developer at Freescale
