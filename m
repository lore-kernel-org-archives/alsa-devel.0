From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: s3c24xx platform: Fix
 s3c2410_dma_started called at wrong time
Date: Thu, 20 Aug 2009 19:47:14 +0100
Message-ID: <20090820184714.GD5032@sirena.org.uk>
References: <1250761331.4412.70.camel@shinel>
	<20090820101549.GA23141@rakim.wolfsonmicro.main>
	<1250769588.3684.28.camel@sl>
	<20090820121851.GB11699@sirena.org.uk>
	<1250775480.1404.19.camel@sl>
	<20090820145207.GA25143@rakim.wolfsonmicro.main>
	<1250783107.1404.70.camel@sl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 28282103886
	for <alsa-devel@alsa-project.org>;
	Thu, 20 Aug 2009 21:06:35 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1250783107.1404.70.camel@sl>
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

On Thu, Aug 20, 2009 at 11:45:07PM +0800, Shine Liu wrote:

> > The callback doesn't need to be set up within the trigger function - if
> > it's done before the trigger functions are called then the DMA trigger
> > can call it.  Off the top of my head I'd expect it's possible to set it
> > up when the device is opened.

> Who call the DMA trigger? When? In any of the platform/cpu_dai trigger
> functions?

It's called ultimately by user space; within ASoC it's always called by
the core trigger function in the fixed order that it has.  The open()
callback would be a safe place to do the setup - that's called before
anything else.
