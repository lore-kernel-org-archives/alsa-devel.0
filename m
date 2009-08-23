From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: s3c24xx platform:
	Fix	s3c2410_dma_started called at wrong time
Date: Sun, 23 Aug 2009 11:28:41 +0100
Message-ID: <20090823102841.GA737@opensource.wolfsonmicro.com>
References: <1250761331.4412.70.camel@shinel>
	<20090820101549.GA23141@rakim.wolfsonmicro.main>
	<1250769588.3684.28.camel@sl>
	<20090820121851.GB11699@sirena.org.uk>
	<1250775480.1404.19.camel@sl>
	<20090820145207.GA25143@rakim.wolfsonmicro.main>
	<1250783107.1404.70.camel@sl> <20090820184714.GD5032@sirena.org.uk>
	<1250848839.3928.6.camel@shinel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2DEDD2433E
	for <alsa-devel@alsa-project.org>;
	Sun, 23 Aug 2009 12:28:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1250848839.3928.6.camel@shinel>
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
Cc: ben@simtec.co.uk, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 21, 2009 at 06:00:39PM +0800, Shine Liu wrote:

> I've finished a draft patch in the callback manner. Waiting for any
> suggestion. Thanks.

This isn't quite what I was expecting - what I was expecting was more
that the I2S driver would set up a function on startup which would be
called by the ASoC DMA driver from its trigger function.  It does look
like a reasonable approach, though.

The way you've got things at the minute at least all the other S3C ASoC
drivers will need to be updated to match the change in the DMA driver.
