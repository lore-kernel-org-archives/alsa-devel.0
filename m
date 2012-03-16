From: Tabi Timur-B04825 <B04825@freescale.com>
Subject: Re: [PATCH v3 09/11] ASoC: fsl: remove the fatal error
 checking on codec-handle
Date: Fri, 16 Mar 2012 04:17:02 +0000
Message-ID: <4F62BEBC.9040203@freescale.com>
References: <20120314122723.GC3133@opensource.wolfsonmicro.com>
	<4F612319.50302@freescale.com>
	<20120315142702.GL3138@opensource.wolfsonmicro.com>
	<4F621C60.5090700@freescale.com>
	<20120316020111.GE6065@S2101-09.ap.freescale.net>
	<4F62A06C.5000304@freescale.com>
	<20120316022345.GA7632@S2101-09.ap.freescale.net>
	<4F62B729.2090902@freescale.com>
	<20120316035254.GF6065@S2101-09.ap.freescale.net>
	<4F62BCBE.7030806@freescale.com>
	<20120316041428.GA7772@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from db3outboundpool.messaging.microsoft.com
	(db3ehsobe004.messaging.microsoft.com [213.199.154.142])
	by alsa0.perex.cz (Postfix) with ESMTP id 033D91046FF
	for <alsa-devel@alsa-project.org>; Fri, 16 Mar 2012 05:17:12 +0100 (CET)
In-Reply-To: <20120316041428.GA7772@S2101-09.ap.freescale.net>
Content-Language: en-US
Content-ID: <7927C4EE4CB9C749B4125E4741B1D697@mgd.freescale.com>
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
> I need to program the DMA controller for audio.  But that's done through
> generic dmaengine API with audio specific parameters passed in.  That's
> pretty much what all snd_imx_pcm_hw_params (sound/soc/fsl/imx-pcm-dma.c)
> does there.

Interesting.  I'll have to check that out.

-- 
Timur Tabi
Linux kernel developer at Freescale
