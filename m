From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 4/4] ASoC: fsl: make fsl_ssi driver
	compilable on ARM/IMX
Date: Thu, 23 Feb 2012 11:04:59 -0600
Message-ID: <4F4671BB.7060409@freescale.com>
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
	<1330008519-3584-1-git-send-email-shawn.guo@linaro.org>
	<1330008519-3584-5-git-send-email-shawn.guo@linaro.org>
	<4F465A33.3020208@ru.mvista.com> <4F465EE5.4010908@freescale.com>
	<20120223165242.GB22562@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from TX2EHSOBE007.bigfish.com (tx2ehsobe005.messaging.microsoft.com
	[65.55.88.15]) by alsa0.perex.cz (Postfix) with ESMTP id 04F7124411
	for <alsa-devel@alsa-project.org>; Thu, 23 Feb 2012 18:05:16 +0100 (CET)
In-Reply-To: <20120223165242.GB22562@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: alsa-devel@alsa-project.org, Sergei Shtylyov <sshtylyov@ru.mvista.com>, Sascha Hauer <s.hauer@pengutronix.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Russell King - ARM Linux wrote:
> Is your readl() or readl_be() unordered then?  

Yes.  At least, it sure looks like it is.

> Wouldn't that be buggy
> between coherent DMA accesses and accessing, eg, a PCI peripheral to
> enable or read DMA status?

I think so.

We almost never use readl.  I see that it is used in some places, but
honestly I can't see how it can be valid.  For instance, the mpic driver
uses it in mpic_startup_ht_interrupt().  I don't understand how that's
valid, since there's nothing preventing the readl() from happening
*before* the writeb.

I'll have to ask around, because I'm sure I'm missing something.

-- 
Timur Tabi
Linux kernel developer at Freescale
