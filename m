From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v2 10/17] ASoC: imx: merge sound/soc/imx
 into sound/soc/fsl
Date: Mon, 5 Mar 2012 18:39:10 +0100
Message-ID: <20120305173910.GZ3852@pengutronix.de>
References: <1330957865-19085-1-git-send-email-shawn.guo@linaro.org>
	<1330957865-19085-11-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 1BD6D104020
	for <alsa-devel@alsa-project.org>; Mon,  5 Mar 2012 18:39:13 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1330957865-19085-11-git-send-email-shawn.guo@linaro.org>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Timur Tabi <timur@freescale.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 05, 2012 at 10:30:58PM +0800, Shawn Guo wrote:
> Freescale PowerPC and ARM/IMX families share the same SSI IP block.
> The patch merges sound/soc/imx into sound/soc/fsl, so that the possible
> code sharing and consolidation can happen.
> 
> This is a plain merge, except that menuconfig SND_POWERPC_SOC is added
> in Kconfig for PowerPC platform as a correspondence to SND_IMX_SOC for
> IMX platform.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  sound/soc/Kconfig                        |    1 -
>  sound/soc/Makefile                       |    1 -
>  sound/soc/fsl/Kconfig                    |   92 ++++++++++++++++++++++++++++++
>  sound/soc/fsl/Makefile                   |   22 +++++++
>  sound/soc/{imx => fsl}/eukrea-tlv320.c   |    2 +-
>  sound/soc/{imx => fsl}/imx-audmux.c      |    0
>  sound/soc/{imx => fsl}/imx-audmux.h      |    0
>  sound/soc/{imx => fsl}/imx-pcm-dma-mx2.c |    0

Maybe this is the right time to rename this file to something like
imx-pcm-dma.c since it has nothing to do with mx2 anymore.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
