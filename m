From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH] ASoC: fsl: Fix module build
Date: Tue, 30 Jul 2013 15:55:27 +0800
Message-ID: <20130730075526.GE12382@S2101-09.ap.freescale.net>
References: <1375133852-15248-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0184.outbound.messaging.microsoft.com [213.199.154.184])
 by alsa0.perex.cz (Postfix) with ESMTP id 0C43326517F
 for <alsa-devel@alsa-project.org>; Tue, 30 Jul 2013 09:55:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1375133852-15248-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, broonie@kernel.org, g.liakhovetski@gmx.de, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 29, 2013 at 06:37:32PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Building imx_v6_v7_defconfig with all audio drivers as modules results in
> the folowing build error:
> 
> ERROR: "imx_pcm_fiq_init" [sound/soc/fsl/snd-soc-imx-ssi.ko] undefined!
> ERROR: "imx_pcm_dma_init" [sound/soc/fsl/snd-soc-imx-ssi.ko] undefined!
> ERROR: "imx_pcm_fiq_exit" [sound/soc/fsl/snd-soc-imx-ssi.ko] undefined!
> ERROR: "imx_pcm_dma_exit" [sound/soc/fsl/snd-soc-imx-ssi.ko] undefined!
> ERROR: "imx_pcm_dma_init" [sound/soc/fsl/snd-soc-fsl-ssi.ko] undefined!
> ERROR: "imx_pcm_dma_exit" [sound/soc/fsl/snd-soc-fsl-ssi.ko] undefined!

What tree?  I tested linux-next 20130730 and did not see the error.

  LD [M]  sound/soc/codecs/snd-soc-sgtl5000.ko
  LD [M]  sound/soc/codecs/snd-soc-tlv320aic23.ko
  LD [M]  sound/soc/codecs/snd-soc-wm8962.ko
  LD [M]  sound/soc/codecs/snd-soc-wm9712.ko
  LD [M]  sound/soc/fsl/snd-soc-eukrea-tlv320.ko
  LD [M]  sound/soc/fsl/snd-soc-fsl-ssi.ko
  LD [M]  sound/soc/fsl/snd-soc-fsl-utils.ko
  LD [M]  sound/soc/fsl/snd-soc-imx-audmux.ko
  LD [M]  sound/soc/fsl/snd-soc-imx-sgtl5000.ko
  LD [M]  sound/soc/fsl/snd-soc-imx-wm8962.ko
  LD [M]  sound/soc/fsl/snd-soc-imx-ssi.ko
  LD [M]  sound/soc/fsl/snd-soc-phycore-ac97.ko

Shawn
