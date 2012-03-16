From: Tabi Timur-B04825 <B04825@freescale.com>
Subject: Re: [PATCH v3 09/11] ASoC: fsl: remove the fatal error
 checking on codec-handle
Date: Fri, 16 Mar 2012 03:53:39 +0000
Message-ID: <4F62B941.5010306@freescale.com>
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
	<20120316025219.GB7632@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from va3outboundpool.messaging.microsoft.com
	(va3ehsobe003.messaging.microsoft.com [216.32.180.13])
	by alsa0.perex.cz (Postfix) with ESMTP id DCF69104699
	for <alsa-devel@alsa-project.org>; Fri, 16 Mar 2012 04:53:48 +0100 (CET)
In-Reply-To: <20120316025219.GB7632@S2101-09.ap.freescale.net>
Content-Language: en-US
Content-ID: <5B98655962DEA74995303774CCD076C2@mgd.freescale.com>
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
> So something like this?
>
>          /*
>           * If codec-handle property is missing from SSI node, we assume
>           * that the machine driver uses new binding which does not require
>           * SSI driver to trigger machine driver's probe.
>           */
>          if (!of_get_property(np, "codec-handle", NULL)) {
>                  if (ssi_private->ssi_on_imx) {
>                          ssi_private->imx_pcm_pdev =
>                                  platform_device_register_simple("imx-pcm-audio",
>                                                                  -1, NULL, 0);
>                          if (IS_ERR(ssi_private->imx_pcm_pdev)) {
>                                  ret = PTR_ERR(ssi_private->imx_pcm_pdev);
>                                  goto error_dev;
>                          }
>                  }
>                  /* success for new binding case */
>                  return 0;
>          }
>
> It does not reduce any reference to "imx" actually.  If you think it's
> worth another iteration of the series, I will post v5 for it.

I had something more like this in mind:

         /*
          * If codec-handle property is missing from SSI node, we assume
          * that the machine driver uses new binding which does not require
          * SSI driver to trigger machine driver's probe.
          */
         if (!of_get_property(np, "codec-handle", NULL))
		ssi_private->new_binding = true;


	if (ssi_private->ssi_on_imx) {
                 ssi_private->imx_pcm_pdev =
                 	platform_device_register_simple("imx-pcm-audio",
                                                                 -1, NULL, 0);
                         if (IS_ERR(ssi_private->imx_pcm_pdev)) {
                                 ret = PTR_ERR(ssi_private->imx_pcm_pdev);
                                 goto error_dev;
                         }
                 }
                 /* success for new binding case */
                 return 0;
         }

Well, it's not perfect, but the idea is that we keep track of new vs. old 
binding separately from imx vs. powerpc.  Although I'm thinking there 
might be a way to general the call to platform_device_register_simple. 
Maybe we could put "imx-pcm-audio" in the device tree?

-- 
Timur Tabi
Linux kernel developer at Freescale
