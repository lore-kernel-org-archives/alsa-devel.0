From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 20/20] ASoC: fsl: add imx-sgtl5000 machine
	driver
Date: Mon, 5 Mar 2012 10:58:54 -0600
Message-ID: <4F54F0CE.60706@freescale.com>
References: <1330788001-10158-1-git-send-email-shawn.guo@linaro.org>
	<1330788001-10158-21-git-send-email-shawn.guo@linaro.org>
	<20120304133818.GE3083@opensource.wolfsonmicro.com>
	<20120305080623.GD16232@S2101-09.ap.freescale.net>
	<20120305115612.GB3224@opensource.wolfsonmicro.com>
	<20120305130707.GF16232@S2101-09.ap.freescale.net>
	<20120305131332.GM3224@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from db3outboundpool.messaging.microsoft.com
	(db3ehsobe006.messaging.microsoft.com [213.199.154.144])
	by alsa0.perex.cz (Postfix) with ESMTP id 0CCDB10400D
	for <alsa-devel@alsa-project.org>; Mon,  5 Mar 2012 17:59:09 +0100 (CET)
In-Reply-To: <20120305131332.GM3224@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> The DMA and SSI drivers should have some relationship with each other if
> they're the same piece of hardware.  

The DMA and SSI are completely separate blocks in the SOC.  On PowerPC,
the P1022 SOC has an SSI and the standard FSL PPC DMA controller (we call
it the Elo controller).  On i.MX, there is a completely different DMA
controller (I'm not familiar with it), but the same exact SSI.

-- 
Timur Tabi
Linux kernel developer at Freescale
