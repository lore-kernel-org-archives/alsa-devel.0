From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH v5] ASoC: add imx-sgtl5000 machine driver
 working with fsl_ssi
Date: Fri, 16 Mar 2012 16:25:09 -0500
Message-ID: <4F63AFB5.8000408@freescale.com>
References: <1331888204-27058-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from va3outboundpool.messaging.microsoft.com
	(va3ehsobe010.messaging.microsoft.com [216.32.180.30])
	by alsa0.perex.cz (Postfix) with ESMTP id 267D9243DF
	for <alsa-devel@alsa-project.org>; Fri, 16 Mar 2012 22:25:17 +0100 (CET)
In-Reply-To: <1331888204-27058-1-git-send-email-shawn.guo@linaro.org>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Shawn Guo wrote:
> Changes since v4:
>  * Add new_binding flag for fsl_ssi driver to support both
>    "old binding" and "new binding"
> 
> ---
> Shawn Guo (8):
>       ASoC: fsl: separate SSI and DMA Kconfig options
>       ASoC: imx: merge sound/soc/imx into sound/soc/fsl
>       ASoC: fsl: rename imx-pcm Kconfig options and filename
>       ASoC: fsl: create fsl_utils to accommodate the common functions
>       ASoC: fsl: remove helper fsl_asoc_get_codec_dev_name
>       ASoC: fsl: make fsl_ssi driver compilable on ARM/IMX
>       ASoC: fsl: let fsl_ssi work with imx pcm and machine drivers
>       ASoC: fsl: add imx-sgtl5000 machine driver

Entire patchset:

Acked-by: Timur Tabi <timur@freescale.com>

-- 
Timur Tabi
Linux kernel developer at Freescale
