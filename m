From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 4/4] ASoC: fsl: make fsl_ssi driver
	compilable on	ARM/IMX
Date: Fri, 24 Feb 2012 21:54:48 +0000
Message-ID: <20120224215448.GA15120@n2100.arm.linux.org.uk>
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
	<1330008519-3584-1-git-send-email-shawn.guo@linaro.org>
	<1330008519-3584-5-git-send-email-shawn.guo@linaro.org>
	<4F465A33.3020208@ru.mvista.com> <4F465EE5.4010908@freescale.com>
	<20120223165242.GB22562@n2100.arm.linux.org.uk>
	<4F4671BB.7060409@freescale.com>
	<20120223171407.GC22562@n2100.arm.linux.org.uk>
	<4F480120.6080409@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
	[78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id D039E103C55
	for <alsa-devel@alsa-project.org>; Fri, 24 Feb 2012 22:55:02 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4F480120.6080409@freescale.com>
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

On Fri, Feb 24, 2012 at 03:29:04PM -0600, Timur Tabi wrote:
> Russell King - ARM Linux wrote:
> >> > I'll have to ask around, because I'm sure I'm missing something.
> > If what you say is true, it means we have different semantics for the
> > same accessors on different architectures.  No wonder it's needing
> > drivers to gain ifdefs to select appropriate accessors.
> > 
> > This needs sorting out properly.  It needs the semantics of readl() etc
> > to be fully defined, and all architectures to implement those semantics
> > rather than what they think would be appropriate for them.
> 
> So I asked around, and sure enough, my macro-fu was weak.  On PowerPC,
> readl() maps to in_le32().  Even though PowerPC is big-endian, some
> devices are little endian (e.g. PCI and some PICs).
> 
> in_le32() is the byte-swapping version of in_be32().  Both functions have
> instruction order synchronization instructions in them.
> 
> So replacing in_be32() with readl() will break on PowerPC.

But not a BE variant.  Like ioread32be().

BenH tells me that he'll accept patches which converts in_32be() to
ioread32be(), as in_32be() is ancient PPC cruft that needs to die.
