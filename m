From: Tabi Timur-B04825 <B04825@freescale.com>
Subject: Re: [PATCH 0/6] ASoC: a few cleanups on sound/soc/fsl
Date: Sat, 25 Feb 2012 01:39:05 +0000
Message-ID: <4F483BB8.7030706@freescale.com>
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
	<1330092582-21180-1-git-send-email-shawn.guo@linaro.org>
	<20120224140200.GH5450@opensource.wolfsonmicro.com>
	<20120224142342.GA16659@S2101-09.ap.freescale.net>
	<20120224141705.GJ5450@opensource.wolfsonmicro.com>
	<20120224232148.GA24268@S2101-09.ap.freescale.net>
	<4F4819C4.5040709@freescale.com>
	<20120225000319.GC24268@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from AM1EHSOBE004.bigfish.com (am1ehsobe005.messaging.microsoft.com
	[213.199.154.208])
	by alsa0.perex.cz (Postfix) with ESMTP id 658B024404
	for <alsa-devel@alsa-project.org>; Sat, 25 Feb 2012 02:39:15 +0100 (CET)
In-Reply-To: <20120225000319.GC24268@S2101-09.ap.freescale.net>
Content-Language: en-US
Content-ID: <DE6623AB94C67745B3FB672E79A1E062@mgd.freescale.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Sascha Hauer <s.hauer@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

Shawn Guo wrote:
> Yes, I did something wrong.  But my point is the following patches
> should belong to one big series.  They can not be applied separately.
>
> [PATCH 1/4] ASoC: imx: let SND_MXC_SOC_FIQ select FIQ
> [PATCH 2/4] ASoC: imx: move SND_SOC_AC97_BUS selection down to machine driver
> [PATCH 3/4] ASoC: imx: initialize dma_params burstsize just in imx-ssi
> [PATCH 4/4] ASoC: imx: separate imx-pcm bits from imx-ssi driver
> [PATCH 0/4] ASoC: merge imx into fsl
> [PATCH 0/6] ASoC: a few cleanups on sound/soc/fsl

That's not what Mark is talking about.  You somehow posted patch 0/6 as a 
reply to the *previous* patchset, so the two patchsets were merged into 
one email thread.

-- 
Timur Tabi
Linux kernel developer at Freescale
