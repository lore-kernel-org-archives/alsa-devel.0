From: Shine Liu <shinel@foxmail.com>
Subject: Re: [PATCH] ASoC: s3c24xx platform: Fix
 s3c2410_dma_started called at wrong time
Date: Thu, 20 Aug 2009 23:45:07 +0800
Message-ID: <1250783107.1404.70.camel@sl>
References: <1250761331.4412.70.camel@shinel>
	<20090820101549.GA23141@rakim.wolfsonmicro.main>
	<1250769588.3684.28.camel@sl> <20090820121851.GB11699@sirena.org.uk>
	<1250775480.1404.19.camel@sl>
	<20090820145207.GA25143@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpbg75.qq.com (smtpbg75.qq.com [119.147.10.234])
	by alsa0.perex.cz (Postfix) with SMTP id 831FD10384D
	for <alsa-devel@alsa-project.org>;
	Thu, 20 Aug 2009 17:45:33 +0200 (CEST)
In-Reply-To: <20090820145207.GA25143@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: ben@simtec.co.uk, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


> The callback doesn't need to be set up within the trigger function - if
> it's done before the trigger functions are called then the DMA trigger
> can call it.  Off the top of my head I'd expect it's possible to set it
> up when the device is opened.

Who call the DMA trigger? When? In any of the platform/cpu_dai trigger
functions?
