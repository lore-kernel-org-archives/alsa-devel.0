From: Shine Liu <shinel@foxmail.com>
Subject: Re: [PATCH] ASoC: s3c24xx platform: Fix
 s3c2410_dma_started called at wrong time
Date: Mon, 24 Aug 2009 21:31:28 +0800
Message-ID: <1251120688.3676.65.camel@shinel>
References: <20090820121851.GB11699@sirena.org.uk>
	<1250775480.1404.19.camel@sl>
	<20090820145207.GA25143@rakim.wolfsonmicro.main>
	<1250783107.1404.70.camel@sl> <20090820184714.GD5032@sirena.org.uk>
	<1250848839.3928.6.camel@shinel>
	<20090823102841.GA737@opensource.wolfsonmicro.com>
	<1251027433.732.42.camel@sl>
	<20090824101733.GA3591@rakim.wolfsonmicro.main>
	<1251114880.3676.41.camel@shinel> <20090824120530.GA9090@sirena.org.uk>
Reply-To: shinel@foxmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpbg68.qq.com (smtpbg68.qq.com [119.147.10.227])
	by alsa0.perex.cz (Postfix) with SMTP id 4310B243E5
	for <alsa-devel@alsa-project.org>;
	Mon, 24 Aug 2009 15:31:51 +0200 (CEST)
In-Reply-To: <20090824120530.GA9090@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, ben-linux@fluff.org
List-Id: alsa-devel@alsa-project.org


> But why are you changing the core DMA code in the first place?  The ASoC
> drivers have split front end and DMA code but this is not the normal
> case for a DMA client.

I think your idea of the callback is very elegant and I appreciate this
way to solve the problem so I try to add new API for the core DMA to
achive this goal.

Well, if there are two arguments for the callback function passed though
struct struct s3c2410_dma_client, it's also reasonable. If there are
more arguments to pass, maybe this is not the best solution. Use a
internal struct to wrapper more arguments into one object and pass the
pointer is just a candidate. 
