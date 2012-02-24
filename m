From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 4/4] ASoC: fsl: make fsl_ssi driver
	compilable on	ARM/IMX
Date: Fri, 24 Feb 2012 23:15:02 +0000
Message-ID: <20120224231501.GD15120@n2100.arm.linux.org.uk>
References: <4F465A33.3020208@ru.mvista.com> <4F465EE5.4010908@freescale.com>
	<20120223165242.GB22562@n2100.arm.linux.org.uk>
	<4F4671BB.7060409@freescale.com>
	<20120223171407.GC22562@n2100.arm.linux.org.uk>
	<4F480120.6080409@freescale.com>
	<20120224215448.GA15120@n2100.arm.linux.org.uk>
	<4F480871.9020206@freescale.com>
	<20120224223512.GB15120@n2100.arm.linux.org.uk>
	<4F4817AC.7050406@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
	[78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id 73C08104343
	for <alsa-devel@alsa-project.org>; Sat, 25 Feb 2012 00:15:16 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4F4817AC.7050406@freescale.com>
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

On Fri, Feb 24, 2012 at 05:05:16PM -0600, Timur Tabi wrote:
> Russell King - ARM Linux wrote:
> 
> > Ho hum.  So, what that's saying to me is that even implementing in_32be()
> > on ARM results in rubbish because it wouldn't be big endian there.
> 
> Well, the "be" in in_be32() means to assume that 32-bit integer is stored
> in big-endian format, and to convert it to native format during the read.
>  An ARM implementation of in_be32() would include byte-swapping.

So, let's go around this loop again.

What would be wrong with converting in_be32() in these drivers to
instead ioread32be()?
