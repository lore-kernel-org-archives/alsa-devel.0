From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] [v2] ASoC: support all possible sample
 rates in the WM8776 driver
Date: Fri, 16 Sep 2011 11:56:08 -0500
Message-ID: <4E737FA8.5090109@freescale.com>
References: <1316182614-9666-1-git-send-email-timur@freescale.com>
	<20110916164412.GD23727@opensource.wolfsonmicro.com>
	<4E737D89.9060900@freescale.com>
	<20110916164838.GF23727@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
	by alsa0.perex.cz (Postfix) with ESMTP id 3BE0E243E2
	for <alsa-devel@alsa-project.org>;
	Fri, 16 Sep 2011 18:56:13 +0200 (CEST)
In-Reply-To: <20110916164838.GF23727@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
>> > Is this not a list of sample rates that the driver says it supports?

> It is.  It's not referenced at all in set_sysclk().

But it is reference in ASoC.  That's the point I was trying to make:

"Although the WM8776 driver includes a .set_sysclk function, it was also
hard-coding the list of supported sample rates."

Here, I say that the WM8776 driver was hard-coding a list of supported sample
rates.  I don't understand how this is not true.

Unless you're saying that the "it" refers to the set_sysclk function, rather
than "the WM8776 driver".

-- 
Timur Tabi
Linux kernel developer at Freescale
