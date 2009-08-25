From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: S3C platform: Fix
 s3c2410_dma_started() called at improper time
Date: Tue, 25 Aug 2009 11:33:29 +0100
Message-ID: <20090825103328.GA31012@rakim.wolfsonmicro.main>
References: <20090820101549.GA23141@rakim.wolfsonmicro.main>
	<1250769588.3684.28.camel@sl>
	<20090820121851.GB11699@sirena.org.uk>
	<1250775480.1404.19.camel@sl>
	<20090820145207.GA25143@rakim.wolfsonmicro.main>
	<1250783107.1404.70.camel@sl> <20090820184714.GD5032@sirena.org.uk>
	<1250848839.3928.6.camel@shinel>
	<20090823102841.GA737@opensource.wolfsonmicro.com>
	<1251169466.4272.22.camel@shinel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6D88E2446C
	for <alsa-devel@alsa-project.org>;
	Tue, 25 Aug 2009 12:33:30 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1251169466.4272.22.camel@shinel>
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
Cc: alsa-devel@alsa-project.org, ben-linux@fluff.org
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 25, 2009 at 11:04:26AM +0800, Shine Liu wrote:

>      I think before we fix the bug in the callback way, we can use this
> patch provisionally for a while though it seems a little ugly. 

I can't prevail on you to do this with a callback within the ASoC code
only?  This really does seem like something that's created by the way
ASoC is structured rather than a general S3C DMA issue so I'm not sure
that the arch/arm code needs to be changed at all.

Otherwise the patch looks OK, in fact I'd tone down the comments about
it being a hack to do this - ASoC DAI and PCM drivers are supposed to be
fairly closely tied to each other.
