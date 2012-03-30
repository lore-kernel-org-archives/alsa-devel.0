From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] ASoC: fsl: enable ssi clock in probe
	function
Date: Fri, 30 Mar 2012 08:03:28 -0500
Message-ID: <4F75AF20.6080009@freescale.com>
References: <1332989621-5211-1-git-send-email-shawn.guo@linaro.org>
	<20120329112949.GM3668@opensource.wolfsonmicro.com>
	<4F748751.3020300@freescale.com>
	<20120329160916.GG19506@S2101-09.ap.freescale.net>
	<4F748C8E.1010702@freescale.com>
	<20120330055543.GH19506@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
	by alsa0.perex.cz (Postfix) with ESMTP id F391C10443F
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Mar 2012 15:03:46 +0200 (CEST)
In-Reply-To: <20120330055543.GH19506@S2101-09.ap.freescale.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Shawn Guo wrote:
> I guess you only meant mpc85xx_defconfig (and mpc85xx_smp_defconfig).
> I sent the patch after compile-testing for mpc85xx_defconfig, and
> took it for granted that mpc8610_hpcd_defconfig will also compile.
> But I just discovered that PPC_CLOCK is not enabled for
> mpc8610_hpcd_defconfig, so it fails on the final link.

Argh.  I was thinking about testing mpc8610 as well, but I thought, "Hey,
p1022ds works, why bother testing the 8610?  Why would it fail?"

> I just sent a patch proposing to fix it by always building in PPC_CLOCK
> for FSL_SOC.

You'll need to get Kumar Gala's ACK on that one, but if only the 8610 is
broken, then I don't think he'll like it.

-- 
Timur Tabi
Linux kernel developer at Freescale
