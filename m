From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v3 09/11] ASoC: fsl: remove the fatal error
 checking on codec-handle
Date: Fri, 16 Mar 2012 10:23:47 +0800
Message-ID: <20120316022345.GA7632@S2101-09.ap.freescale.net>
References: <20120309013216.GH2499@S2101-09.ap.freescale.net>
	<4F5FD706.8040209@freescale.com>
	<20120313234638.GY3177@opensource.wolfsonmicro.com>
	<4F6008FA.3040805@freescale.com>
	<20120314122723.GC3133@opensource.wolfsonmicro.com>
	<4F612319.50302@freescale.com>
	<20120315142702.GL3138@opensource.wolfsonmicro.com>
	<4F621C60.5090700@freescale.com>
	<20120316020111.GE6065@S2101-09.ap.freescale.net>
	<4F62A06C.5000304@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id D2758244BB
	for <alsa-devel@alsa-project.org>; Fri, 16 Mar 2012 03:23:24 +0100 (CET)
Received: by iakh37 with SMTP id h37so5340731iak.38
	for <alsa-devel@alsa-project.org>; Thu, 15 Mar 2012 19:23:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4F62A06C.5000304@freescale.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Sascha Hauer <s.hauer@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 16, 2012 at 02:07:42AM +0000, Tabi Timur-B04825 wrote:
...
> >> +		ssi_private->imx_pcm_pdev =
> >> +			platform_device_register_simple("imx-pcm-audio",
> >>
> > This is still IMX vs. PowerPC thing rather than "old binding" vs. "new
> > binding" one.
> 
> What is "imx-pcm-audio"?
> 
Something like "fsl-pcm-audio", but different from "fsl-pcm-audio"
will be instantiated as a hardware block by device tree,
"imx-pcm-audio" is pretty much like a ASoC wrapper for calling
dmaengine driver.  So there is no hardware block presenting this
"device" in device tree, and we need to instantiate it from cpu DAI
driver as Mark suggested.

-- 
Regards,
Shawn
