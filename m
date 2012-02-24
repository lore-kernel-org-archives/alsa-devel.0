From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 6/6] ASoC: fsl: check property 'compatible'
 for the machine name
Date: Fri, 24 Feb 2012 10:30:05 -0600
Message-ID: <4F47BB0D.9080905@freescale.com>
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
	<1330092582-21180-1-git-send-email-shawn.guo@linaro.org>
	<1330092582-21180-7-git-send-email-shawn.guo@linaro.org>
	<20120224141207.GI5450@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
	by alsa0.perex.cz (Postfix) with ESMTP id BB192103910
	for <alsa-devel@alsa-project.org>; Fri, 24 Feb 2012 17:30:29 +0100 (CET)
In-Reply-To: <20120224141207.GI5450@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Shawn Guo <shawn.guo@linaro.org>, Hauer <s.hauer@pengutronix.de>, Sascha@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> The ARM machines really shouldn't be using the bindings that PowerPC is
> using for the machine as they conflate the machine driver with the SSI
> binding.  The idiom for new systems is that machine drivers should be
> first class devices in the device tree referencing the SSI and CODEC.

Where is this documented?

I don't remember participating in the discussion for this new binding.

> The current bindings should be preserved for existing systems of course.

There's no reason we can't update the PowerPC device trees.

-- 
Timur Tabi
Linux kernel developer at Freescale
