From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] [v2] ASoC: support all possible sample
 rates in the WM8776 driver
Date: Fri, 16 Sep 2011 13:25:08 -0500
Message-ID: <4E739484.4000604@freescale.com>
References: <1316182614-9666-1-git-send-email-timur@freescale.com>
	<20110916164412.GD23727@opensource.wolfsonmicro.com>
	<4E737D89.9060900@freescale.com>
	<20110916164838.GF23727@opensource.wolfsonmicro.com>
	<4E737FA8.5090109@freescale.com>
	<20110916171259.GG23727@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
	by alsa0.perex.cz (Postfix) with ESMTP id B57DE103D5C
	for <alsa-devel@alsa-project.org>;
	Fri, 16 Sep 2011 20:25:57 +0200 (CEST)
In-Reply-To: <20110916171259.GG23727@opensource.wolfsonmicro.com>
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

>> "Although the WM8776 driver includes a .set_sysclk function, it was also
>> hard-coding the list of supported sample rates."
> 
> Right, but the two things aren't connected.  As I've *repeatedly* said
> the list of supported sample rates in the DAI should be the full set
> that the device can support, unrelated to any clock setup.

But I could hook up any frequency to audmclk and dacmclk.  What if I want
40000Hz as a sample rate?  I could then then set mclk to 15.36MHz.

I don't see how the codec driver can know what sample rates it supports until
*after* set_sysclk() is called (i.e. when the driver is told the value of mclk).

-- 
Timur Tabi
Linux kernel developer at Freescale
