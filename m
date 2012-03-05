From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 15/20] ASoC: fsl: make fsl_ssi driver
	compilable on	ARM/IMX
Date: Mon, 5 Mar 2012 00:04:11 +0000
Message-ID: <20120305000411.GL7363@n2100.arm.linux.org.uk>
References: <1330788001-10158-1-git-send-email-shawn.guo@linaro.org>
	<1330788001-10158-16-git-send-email-shawn.guo@linaro.org>
	<4F53F704.8080703@freescale.com>
	<20120304232817.GA13516@n2100.arm.linux.org.uk>
	<4F53FBA1.8090200@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
	[78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id B41F824416
	for <alsa-devel@alsa-project.org>; Mon,  5 Mar 2012 01:04:24 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4F53FBA1.8090200@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tabi Timur-B04825 <B04825@freescale.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <s.hauer@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Sun, Mar 04, 2012 at 11:32:50PM +0000, Tabi Timur-B04825 wrote:
> Russell King - ARM Linux wrote:
> > Is the SCR shared between capture and playback?  In that case, what
> > makes this read-modify-write thread safe?
> 
> What's "SCR"?

I assumed you knew the code you were commenting on.

                clrbits32(&ssi->scr, CCSR_SSI_SCR_SSIEN);

The register these functions seem to be used on appears to be called
'SCR'.

> It's not thread-safe on PPC, but then neither is the entire function.  You 
> can't have two threads attempt to initialize the hardware at the same 
> time.

Why do you say "can't" - what prevents it?  If nothing, then this stuff
is buggy when preempt is enabled, or you're running on SMP.
