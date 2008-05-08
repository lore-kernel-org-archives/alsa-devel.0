From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: SoC sound support for imx27
Date: Thu, 8 May 2008 10:33:39 +0100
Message-ID: <20080508093339.GA17836@rakim.wolfsonmicro.main>
References: <200804231654.44526.jbe@pengutronix.de>
	<200805051256.38153.jbe@pengutronix.de>
	<20080505124233.GE3426@sirena.org.uk>
	<200805080954.28299.jbe@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 73512246FB
	for <alsa-devel@alsa-project.org>;
	Thu,  8 May 2008 11:33:41 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200805080954.28299.jbe@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Juergen Beisert <jbe@pengutronix.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, May 08, 2008 at 09:54:28AM +0200, Juergen Beisert wrote:

> It seems the documentation in the "asoc-v2-dev" 
> (Documentation/sound/alsa/soc/) is still v1, isn't it?

Yes.

> I'm confused how to link the pcm-layer and the transmission layer together. 
> pxa2xx-i2s.c registers a codec-dai (line 346), while the imx-ssi.c registers 
> (line 864) a platform-dai (internally called a cpu_dai. BTW: why a different 
> name?). I _believe_ the CPU DAI tries to connect the CPU-pcm to the 
> transmission interface like ssi or i2s on the same chip. But both 
> implementations are using the same layering (pcm-dma and ssi/i2s), but 
> registering different DAIs. 

The i.MX code is correct here.  

The PXA I2S code isn't a good example to use - it doesn't compile at the
minute due to changes in the underlying PXA platform code - and has only
been translated mechanically for ASoC v2.  If you're looking for
examples then the most heavily tested in-tree configurations for ASoC v2
are:

 - i.MX31 I2S with WM8350
 - PXA3xx AC97 with WM9713

> Now I have an ssi driver for my CPU (to be more precise: Two instances of it, 
> when I registering two ssi devices in my BSP file). But how to tell the CPU 
> pcm-layer which one it should use (and for what purpose, play, capture)? And 
> only the ssi driver itself knows how to interact with the DMA controller. But 
> this information is needed in the CPU pcm-layer as it setup the DMA.

The CPU DAI has a dma_data member intended for this purpose - it can set
up information the DMA driver will need in there for the DMA driver to
pick up when it needs it.  The PXA code sets this up in hw_params since
the DMA configuration depends on if the stream is mono or stereo but
there's no need to set it up that late if you don't have a similar
requirement.

> Does a list exists, where I can store driver's private data in each layer 
> (mapped iomem addresses for example)? And how to access it, when I only get 
> a "struct snd_pcm_substream" as a parameter?

Yes.  ASoC sets the private_data of snd_pcm_substream to point to the
struct snd_soc_pcm_runtime for the substream.  That in turn contains
pointers to the platform, codec and CPU DAIs.  Each of those has a
private_data member which you can use.
