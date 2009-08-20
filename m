From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: s3c24xx platform: Fix
 s3c2410_dma_started called at wrong time
Date: Thu, 20 Aug 2009 11:15:50 +0100
Message-ID: <20090820101549.GA23141@rakim.wolfsonmicro.main>
References: <1250761331.4412.70.camel@shinel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8D81310385E
	for <alsa-devel@alsa-project.org>;
	Thu, 20 Aug 2009 12:15:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1250761331.4412.70.camel@shinel>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Shine Liu <shinel@foxmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 20, 2009 at 05:42:11PM +0800, Shine Liu wrote:

> In the current framework, s3c24xx_pcm_trigger() is always called before
> s3c24xx_pcm_trigger(). So the s3c2410_dma_started() should be called in
> s3c24xx_pcm_trigger() after s3c24xx_snd_txctrl(1) or
> s3c24xx_snd_rxctrl(1) is called in this function.

I suspect some of the function names in your description here are
incorrect :) Another option is to provide a callback in the private data
passed to the DMA driver which the DMA driver can call at the
appropriate point during setup.

Someone will presumably also need to take care of the same things in the
other S3C DAI drivers too, though it should be possible to arrange
things so that can be done seperately.
