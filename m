From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: S3C platform: Fix
 s3c2410_dma_started() called at improper time
Date: Tue, 25 Aug 2009 13:12:30 +0100
Message-ID: <20090825121229.GA7167@rakim.wolfsonmicro.main>
References: <20090820121851.GB11699@sirena.org.uk>
	<1250775480.1404.19.camel@sl>
	<20090820145207.GA25143@rakim.wolfsonmicro.main>
	<1250783107.1404.70.camel@sl> <20090820184714.GD5032@sirena.org.uk>
	<1250848839.3928.6.camel@shinel>
	<20090823102841.GA737@opensource.wolfsonmicro.com>
	<1251169466.4272.22.camel@shinel>
	<20090825103328.GA31012@rakim.wolfsonmicro.main>
	<1251201950.6004.8.camel@shinel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1A36910382A
	for <alsa-devel@alsa-project.org>;
	Tue, 25 Aug 2009 14:12:31 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1251201950.6004.8.camel@shinel>
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

On Tue, Aug 25, 2009 at 08:05:50PM +0800, Shine Liu wrote:

> Yes, I agree with you. I have cut down the unnecessary comments in the
> patch. Thank you for your appropriate suggestion.

I've applied this, taking the commit message from your original e-mail
with a slight update to reflect the final solution.  Thanks for all your
patient work on this.
