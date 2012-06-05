From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2 REBASE] ASoC: fsl_ssi: convert to use
	devm_clk_get
Date: Tue, 5 Jun 2012 11:08:51 +0100
Message-ID: <20120605100851.GI8262@n2100.arm.linux.org.uk>
References: <1338774174-3960-1-git-send-email-richard.zhao@freescale.com>
	<20120605064714.GL30400@pengutronix.de>
	<20120605100316.GG23408@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
	[78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id D3921245C9
	for <alsa-devel@alsa-project.org>;
	Tue,  5 Jun 2012 12:09:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20120605100316.GG23408@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, shawn.guo@linaro.org, Sascha Hauer <s.hauer@pengutronix.de>, Richard Zhao <richard.zhao@freescale.com>, kernel@pengutronix.de, dong.aisheng@linaro.org, timur@freescale.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 05, 2012 at 11:03:16AM +0100, Mark Brown wrote:
> On Tue, Jun 05, 2012 at 08:47:14AM +0200, Sascha Hauer wrote:
> 
> > Have you tried compiling this on PowerPC? devm_clk_get is only available
> > with CONFIG_CLKDEV_LOOKUP, I think on PowerPC this is not the case.
> 
> I've not, but I guess there will be an issue.  I'd say the fix here is
> on the PowerPC side - it's not good to have to have Kconfig bodges for
> things like this in individual drivers.  Ideally we'd add clkdev
> support...

Or get rid of devm_clk_get()'s dependency on CLKDEV (which is in itself
silly.)
