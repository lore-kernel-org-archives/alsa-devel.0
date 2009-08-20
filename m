From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: s3c24xx platform: Fix
 s3c2410_dma_started called at wrong time
Date: Thu, 20 Aug 2009 15:52:07 +0100
Message-ID: <20090820145207.GA25143@rakim.wolfsonmicro.main>
References: <1250761331.4412.70.camel@shinel>
	<20090820101549.GA23141@rakim.wolfsonmicro.main>
	<1250769588.3684.28.camel@sl>
	<20090820121851.GB11699@sirena.org.uk>
	<1250775480.1404.19.camel@sl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DB68A1037F8
	for <alsa-devel@alsa-project.org>;
	Thu, 20 Aug 2009 16:52:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1250775480.1404.19.camel@sl>
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

On Thu, Aug 20, 2009 at 09:38:00PM +0800, Shine Liu wrote:

> Callback is a elegant way to solve the problem. But I have a question
> that when should the DMA driver call the callback funtion? There is no
> event to tell it to call. Periodly checking? It will not only cause
> latency but also increase the system load. 

The callback doesn't need to be set up within the trigger function - if
it's done before the trigger functions are called then the DMA trigger
can call it.  Off the top of my head I'd expect it's possible to set it
up when the device is opened.
