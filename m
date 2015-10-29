From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: fsl_ssi.c: Getting channel slips with fsl_ssi.c in
 TDM (network) mode.
Date: Thu, 29 Oct 2015 11:11:35 -0700
Message-ID: <20151029181135.GB3492@Asurada-CZ80>
References: <CAG5mAdw1Sj25hPWsFKqwQzgKft1_YWkN=7WNkW=kXGiF9P=kUA@mail.gmail.com>
 <56273F75.2040702@invoxia.com>
 <CAG5mAdxDmh3XDZSSHb8Oa7s-rosdVvTZPqu2zyDC42rMcqxxHA@mail.gmail.com>
 <CAG5mAdwC00qbu9zMHKjx5JZX_2CobBo81+jtpsWGPHPQ0jKX0A@mail.gmail.com>
 <20151027071344.GC25728@pengutronix.de>
 <20151027201101.GA9527@Asurada-CZ80>
 <CAG5mAdz=TKSmXBOqKfSj0FYfk3c6syBa87OazyGRRF0NU4snXA@mail.gmail.com>
 <20151029045350.GA3374@Asurada-CZ80>
 <CAG5mAdwQd3ep7ZSNHDEni6caKeFPyvXhM0g=BjqPFA_gDSU1DQ@mail.gmail.com>
 <CAG5mAdw220n3K8vfRAgixxeYa=rBp5YbOrn_8ecwH+KN0JOnnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f42.google.com (mail-pa0-f42.google.com
 [209.85.220.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 0E87B26170F
 for <alsa-devel@alsa-project.org>; Thu, 29 Oct 2015 19:11:40 +0100 (CET)
Received: by padhk11 with SMTP id hk11so47516710pad.1
 for <alsa-devel@alsa-project.org>; Thu, 29 Oct 2015 11:11:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAG5mAdw220n3K8vfRAgixxeYa=rBp5YbOrn_8ecwH+KN0JOnnA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Caleb Crome <caleb@crome.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Markus Pargmann <mpa@pengutronix.de>, "arnaud.mouiche@invoxia.com" <arnaud.mouiche@invoxia.com>, Roberto Fichera <kernel@tekno-soft.it>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 29, 2015 at 07:55:59AM -0700, Caleb Crome wrote:

> >> Therefore, if setting watermark to 8, each FIFO has 7 (15 - 8) space
> >> left, the largest safe burst size could be 14 (7 * 2) actually.

> > Oh, does this depend on the data size?  I'm using 16-bit data, so I
> > guess the bursts are measured in 2 byte units?  Does this mean that
> > the burst size should be dynamically adjusted depending on word size
> > (I guess done in hw_params)?

You don't need to do that. It's already been taken care in the DMA
code.

> Okay, so wm=8 and maxburst=14 definitely does not work at all,.  wm=8,
> maxburst=8 works okay, but still not perfect.

Make sure you are using Dual FIFO configurations for both SDMA and
SSI. You can refer to my change below (I've tested it with a two-
channel test case being played in 44.1KHz 16-bit):

diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index b8a5056..f4c7308 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -307,7 +307,7 @@
 					clocks = <&clks IMX6SX_CLK_SSI1_IPG>,
 						 <&clks IMX6SX_CLK_SSI1>;
 					clock-names = "ipg", "baud";
-					dmas = <&sdma 37 1 0>, <&sdma 38 1 0>;
+					dmas = <&sdma 37 22 0>, <&sdma 38 22 0>;
 					dma-names = "rx", "tx";
 					fsl,fifo-depth = <15>;
 					status = "disabled";
@@ -321,7 +321,7 @@
 					clocks = <&clks IMX6SX_CLK_SSI2_IPG>,
 						 <&clks IMX6SX_CLK_SSI2>;
 					clock-names = "ipg", "baud";
-					dmas = <&sdma 41 1 0>, <&sdma 42 1 0>;
+					dmas = <&sdma 41 22 0>, <&sdma 42 22 0>;
 					dma-names = "rx", "tx";
 					fsl,fifo-depth = <15>;
 					status = "disabled";
@@ -335,7 +335,7 @@
 					clocks = <&clks IMX6SX_CLK_SSI3_IPG>,
 						 <&clks IMX6SX_CLK_SSI3>;
 					clock-names = "ipg", "baud";
-					dmas = <&sdma 45 1 0>, <&sdma 46 1 0>;
+					dmas = <&sdma 45 22 0>, <&sdma 46 22 0>;
 					dma-names = "rx", "tx";
 					fsl,fifo-depth = <15>;
 					status = "disabled";
diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 674abf7..7cfe661 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -1002,8 +1002,8 @@ static int _fsl_ssi_set_dai_fmt(struct device *dev,
 		wm = ssi_private->fifo_depth;
 
 	regmap_write(regs, CCSR_SSI_SFCSR,
-			CCSR_SSI_SFCSR_TFWM0(wm) | CCSR_SSI_SFCSR_RFWM0(wm) |
-			CCSR_SSI_SFCSR_TFWM1(wm) | CCSR_SSI_SFCSR_RFWM1(wm));
+			CCSR_SSI_SFCSR_TFWM0(8) | CCSR_SSI_SFCSR_RFWM0(8) |
+			CCSR_SSI_SFCSR_TFWM1(8) | CCSR_SSI_SFCSR_RFWM1(8));
 
 	if (ssi_private->use_dual_fifo) {
 		regmap_update_bits(regs, CCSR_SSI_SRCR, CCSR_SSI_SRCR_RFEN1,
@@ -1322,8 +1322,9 @@ static int fsl_ssi_imx_probe(struct platform_device *pdev,
 		/* When using dual fifo mode, we need to keep watermark
 		 * as even numbers due to dma script limitation.
 		 */
-		ssi_private->dma_params_tx.maxburst &= ~0x1;
-		ssi_private->dma_params_rx.maxburst &= ~0x1;
+		dev_info(&pdev->dev, "tunning burst size for Dual FIFO mode\n");
+		ssi_private->dma_params_tx.maxburst = 16;
+		ssi_private->dma_params_rx.maxburst = 16;
 	}
 
 	if (!ssi_private->use_dma) {

And make sure you have the dev_info() printed out in your console.
/* 22 in the DT is to call the Dual FIFO SDMA script */

> It started with:
> 
> frame 0:  00, 00, 10, 20, 30, 40, 50, 60, 70, 80, 90, a0, b0, c0, d0, e0
> frame 1:  f0, 01, 11, 21, 31, 41, 51, 61, 71, 81, 91, a1, b1, c1, d1, e1

If this happens, just try to let SDMA work before SSI starts to
read FIFOs -- enabling TDMAE or RDMAE before enabling TE or RE:

@@ -1093,6 +1093,15 @@ static int fsl_ssi_trigger(struct snd_pcm_substream *substream, int cmd,
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+			regmap_update_bits(regs, CCSR_SSI_SIER,
+					   CCSR_SSI_SIER_TDMAE,
+					   CCSR_SSI_SIER_TDMAE);
+		else
+			regmap_update_bits(regs, CCSR_SSI_SIER,
+					   CCSR_SSI_SIER_RDMAE,
+					   CCSR_SSI_SIER_RDMAE);
+
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 			fsl_ssi_tx_config(ssi_private, true);
 		else
 			fsl_ssi_rx_config(ssi_private, true);

Nicolin
