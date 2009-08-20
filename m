From: Shine Liu <shinel@foxmail.com>
Subject: Re: [PATCH] ASoC: s3c24xx platform: Fix
 s3c2410_dma_started called at wrong time
Date: Thu, 20 Aug 2009 21:38:00 +0800
Message-ID: <1250775480.1404.19.camel@sl>
References: <1250761331.4412.70.camel@shinel>
	<20090820101549.GA23141@rakim.wolfsonmicro.main>
	<1250769588.3684.28.camel@sl>  <20090820121851.GB11699@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpbg92.qq.com (smtpbg92.qq.com [119.147.10.251])
	by alsa0.perex.cz (Postfix) with SMTP id 01EE91038BC
	for <alsa-devel@alsa-project.org>;
	Thu, 20 Aug 2009 15:38:23 +0200 (CEST)
In-Reply-To: <20090820121851.GB11699@sirena.org.uk>
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

On Thu, 2009-08-20 at 13:18 +0100, Mark Brown wrote:
> 
> Yes, I understand the problem.  The callback I suggest above ought to
> allow the appropriate sequencing - the DMA driver can call the callback
> to start the DAI in between starting the DMA and kicking the DMA API to
> queue the next block.  That would avoid the abstraction problems.
> 

Callback is a elegant way to solve the problem. But I have a question
that when should the DMA driver call the callback funtion? There is no
event to tell it to call. Periodly checking? It will not only cause
latency but also increase the system load. 

Thanks.
