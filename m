From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 4/4] ASoC: fsl: make fsl_ssi driver
	compilable on ARM/IMX
Date: Fri, 24 Feb 2012 16:00:17 -0600
Message-ID: <4F480871.9020206@freescale.com>
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
	<1330008519-3584-1-git-send-email-shawn.guo@linaro.org>
	<1330008519-3584-5-git-send-email-shawn.guo@linaro.org>
	<4F465A33.3020208@ru.mvista.com> <4F465EE5.4010908@freescale.com>
	<20120223165242.GB22562@n2100.arm.linux.org.uk>
	<4F4671BB.7060409@freescale.com>
	<20120223171407.GC22562@n2100.arm.linux.org.uk>
	<4F480120.6080409@freescale.com>
	<20120224215448.GA15120@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from VA3EHSOBE009.bigfish.com (va3ehsobe001.messaging.microsoft.com
	[216.32.180.11])
	by alsa0.perex.cz (Postfix) with ESMTP id E4EE0103C53
	for <alsa-devel@alsa-project.org>; Fri, 24 Feb 2012 23:00:33 +0100 (CET)
In-Reply-To: <20120224215448.GA15120@n2100.arm.linux.org.uk>
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
> BenH tells me that he'll accept patches which converts in_32be() to
> ioread32be(), as in_32be() is ancient PPC cruft that needs to die.

Where did he say this?  in_be32() (and its variants) are used EVERYWHERE
in PowerPC code.

Also, keep in mind that on ARM, ioread32be() is probably wrong, because we
want to read the register as little-endian.  The SSI audio controller is
little-endian on i.MX chips and big-endian on PowerPC chip.  So we really
need a native-endian variant of ioread32be().  ioread32() is little-endian
on PowerPC, so we can't use that.

-- 
Timur Tabi
Linux kernel developer at Freescale
