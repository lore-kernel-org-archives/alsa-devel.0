From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 4/4] ASoC: fsl: make fsl_ssi driver
	compilable on	ARM/IMX
Date: Thu, 23 Feb 2012 16:52:42 +0000
Message-ID: <20120223165242.GB22562@n2100.arm.linux.org.uk>
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
	<1330008519-3584-1-git-send-email-shawn.guo@linaro.org>
	<1330008519-3584-5-git-send-email-shawn.guo@linaro.org>
	<4F465A33.3020208@ru.mvista.com> <4F465EE5.4010908@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
	[78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id E6D911041F8
	for <alsa-devel@alsa-project.org>; Thu, 23 Feb 2012 17:53:03 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4F465EE5.4010908@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org, Sergei Shtylyov <sshtylyov@ru.mvista.com>, Sascha Hauer <s.hauer@pengutronix.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Thu, Feb 23, 2012 at 09:44:37AM -0600, Timur Tabi wrote:
> Sergei Shtylyov wrote:
> >     These functions are not equivalent concerning endianness. You should 
> > probably have used readl_be() instead, else it won't work on PPC anymore.
> 
> readl_be() is not good enough, either.  The in/out_be functions have
> specific syncronization instructions in them, so that the operations
> conform to the PowerPC instruction ordering architecture.

Is your readl() or readl_be() unordered then?  Wouldn't that be buggy
between coherent DMA accesses and accessing, eg, a PCI peripheral to
enable or read DMA status?
