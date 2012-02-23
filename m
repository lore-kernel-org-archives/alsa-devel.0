From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 4/4] ASoC: fsl: make fsl_ssi driver
	compilable on	ARM/IMX
Date: Thu, 23 Feb 2012 17:14:07 +0000
Message-ID: <20120223171407.GC22562@n2100.arm.linux.org.uk>
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
	<1330008519-3584-1-git-send-email-shawn.guo@linaro.org>
	<1330008519-3584-5-git-send-email-shawn.guo@linaro.org>
	<4F465A33.3020208@ru.mvista.com> <4F465EE5.4010908@freescale.com>
	<20120223165242.GB22562@n2100.arm.linux.org.uk>
	<4F4671BB.7060409@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
	[78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id 2635F244B5
	for <alsa-devel@alsa-project.org>; Thu, 23 Feb 2012 18:14:18 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4F4671BB.7060409@freescale.com>
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

On Thu, Feb 23, 2012 at 11:04:59AM -0600, Timur Tabi wrote:
> Russell King - ARM Linux wrote:
> > Is your readl() or readl_be() unordered then?  
> 
> Yes.  At least, it sure looks like it is.
> 
> > Wouldn't that be buggy
> > between coherent DMA accesses and accessing, eg, a PCI peripheral to
> > enable or read DMA status?
> 
> I think so.
> 
> We almost never use readl.  I see that it is used in some places, but
> honestly I can't see how it can be valid.  For instance, the mpic driver
> uses it in mpic_startup_ht_interrupt().  I don't understand how that's
> valid, since there's nothing preventing the readl() from happening
> *before* the writeb.

That just sounds broken.  If readl() can happen before a writeb() issued
in program order, how do most of the PCI drivers work?

> I'll have to ask around, because I'm sure I'm missing something.

If what you say is true, it means we have different semantics for the
same accessors on different architectures.  No wonder it's needing
drivers to gain ifdefs to select appropriate accessors.

This needs sorting out properly.  It needs the semantics of readl() etc
to be fully defined, and all architectures to implement those semantics
rather than what they think would be appropriate for them.
