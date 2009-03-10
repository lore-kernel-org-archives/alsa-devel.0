From: Daniel Mack <daniel@caiaq.de>
Subject: Re: snd-soc-pxa-ssp I2C/FIFO issues
Date: Tue, 10 Mar 2009 16:47:41 +0100
Message-ID: <20090310154741.GC10574@buzzloop.caiaq.de>
References: <74d0deb30903090747p3fbb8dd5l27cd7313d4be7de2@mail.gmail.com>
	<20090309153629.GB24787@buzzloop.caiaq.de>
	<20090309174443.GG13593@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id F18721037FC
	for <alsa-devel@alsa-project.org>; Tue, 10 Mar 2009 16:47:44 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090309174443.GG13593@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: alsa-devel@alsa-project.org, pHilipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 09, 2009 at 05:44:46PM +0000, Mark Brown wrote:
> On Mon, Mar 09, 2009 at 04:36:29PM +0100, Daniel Mack wrote:
> 
> > Mark says he'd rather like me to use/abuse the set_clk_div() interface
> > for that but IMO that's an evil hack. The next CPU would need a similar
> > thing to be used with this codec, so there should be a clean way to
> > achive that.
> 
> The point here is that this is already fairly widely supported with some
> combination of that approach and network mode and adding a third method
> only makes things more complex, especially with more flexibile devices
> which are capable of supporting combinations of these options

Ok, there might be an even more straight-forward solution for this
problem: As we know already from the DIV_SCR divider what our
BCLK/LRCLK ratio is, we can add a special case for the mode I need, as
implemented in the patch below.

Philipp, could you test that again on your board, please?
Applies on top of the other one ("pxa-ssp: don't touch ssp registers
...") I just posted.

Thanks,
Daniel


>From cbd130dfeca4d65acd34cd6a3ca6d1a45885985f Mon Sep 17 00:00:00 2001
From: Daniel Mack <daniel@caiaq.de>
Date: Tue, 10 Mar 2009 16:33:35 +0100
Subject: [PATCH 1/2] pxa-ssp: switch from network mode to PSP

This switches the pxa ssp port usage from network mode to PSP mode.
Removed some comments and checks for configured TDM channels.
A special case is added to support configuration where BCLK = 64fs. We
need to do some black magic in this case which doesn't look nice but
there is unfortunately no other option than that.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
---
 sound/soc/pxa/pxa-ssp.c |   56 ++++++++++++++++++++++++++++++----------------
 1 files changed, 36 insertions(+), 20 deletions(-)

diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index 7fc13f0..1b3a81c 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -45,6 +45,7 @@
 struct ssp_priv {
 	struct ssp_dev dev;
 	unsigned int sysclk;
+	unsigned int scr_div;
 	int dai_fmt;
 #ifdef CONFIG_PM
 	struct ssp_state state;
@@ -281,11 +282,13 @@ static int pxa_ssp_resume(struct snd_soc_dai *cpu_dai)
  * ssp_set_clkdiv - set SSP clock divider
  * @div: serial clock rate divider
  */
-static void ssp_set_scr(struct ssp_dev *dev, u32 div)
+static void ssp_set_scr(struct ssp_priv *priv, u32 div)
 {
+	struct ssp_dev *dev = &priv->dev;
 	struct ssp_device *ssp = dev->ssp;
 	u32 sscr0 = ssp_read_reg(dev->ssp, SSCR0) & ~SSCR0_SCR;
 
+	priv->scr_div = div;
 	ssp_write_reg(ssp, SSCR0, (sscr0 | SSCR0_SerClkDiv(div)));
 }
 
@@ -327,7 +330,7 @@ static int pxa_ssp_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
 		break;
 	case PXA_SSP_CLK_AUDIO:
 		priv->sysclk = 0;
-		ssp_set_scr(&priv->dev, 1);
+		ssp_set_scr(priv, 1);
 		sscr0 |= SSCR0_ACS;
 		break;
 	default:
@@ -388,7 +391,7 @@ static int pxa_ssp_set_dai_clkdiv(struct snd_soc_dai *cpu_dai,
 		ssp_write_reg(ssp, SSACD, val);
 		break;
 	case PXA_SSP_DIV_SCR:
-		ssp_set_scr(&priv->dev, div);
+		ssp_set_scr(priv, div);
 		break;
 	default:
 		return -ENODEV;
@@ -547,18 +550,17 @@ static int pxa_ssp_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
-		sscr0 |= SSCR0_MOD | SSCR0_PSP;
+		sscr0 |= SSCR0_PSP;
 		sscr1 |= SSCR1_RWOT | SSCR1_TRAIL;
 
 		switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
 		case SND_SOC_DAIFMT_NB_NF:
-			sspsp |= SSPSP_FSRT;
 			break;
 		case SND_SOC_DAIFMT_NB_IF:
-			sspsp |= SSPSP_SFRMP | SSPSP_FSRT;
+			sspsp |= SSPSP_SFRMP;
 			break;
 		case SND_SOC_DAIFMT_IB_IF:
-			sspsp |= SSPSP_SFRMP;
+			sspsp |= SSPSP_SFRMP | SSPSP_SCMODE(3);
 			break;
 		default:
 			return -EINVAL;
@@ -644,37 +646,51 @@ static int pxa_ssp_hw_params(struct snd_pcm_substream *substream,
 			sscr0 |= SSCR0_FPCKE;
 #endif
 		sscr0 |= SSCR0_DataSize(16);
-		/* use network mode (2 slots) for 16 bit stereo */
 		break;
 	case SNDRV_PCM_FORMAT_S24_LE:
 		sscr0 |= (SSCR0_EDSS | SSCR0_DataSize(8));
-		/* we must be in network mode (2 slots) for 24 bit stereo */
 		break;
 	case SNDRV_PCM_FORMAT_S32_LE:
 		sscr0 |= (SSCR0_EDSS | SSCR0_DataSize(16));
-		/* we must be in network mode (2 slots) for 32 bit stereo */
 		break;
 	}
 	ssp_write_reg(ssp, SSCR0, sscr0);
 
 	switch (priv->dai_fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
-		/* Cleared when the DAI format is set */
-		sspsp = ssp_read_reg(ssp, SSPSP) | SSPSP_SFRMWDTH(width);
+		sspsp = ssp_read_reg(ssp, SSPSP);
+
+		if ((priv->scr_div == 4) && (width == 16)) {
+			/* This is a special case where the bitclk is 64fs
+			 * and we're not dealing with 2*32 bits of audio
+			 * samples.
+			 *
+			 * The SSP values used for that are all found out by
+			 * trying and failing a lot; some of the registers
+			 * needed for that mode are only available on PXA3xx.
+			 */
+
+#ifdef CONFIG_PXA3xx
+			if (!cpu_is_pxa3xx())
+				return -EINVAL;
+
+			sspsp |= SSPSP_SFRMWDTH(width * 2);
+			sspsp |= SSPSP_SFRMDLY(width * 4);
+			sspsp |= SSPSP_EDMYSTOP(3);
+			sspsp |= SSPSP_DMYSTOP(3);
+			sspsp |= SSPSP_DMYSTRT(1);
+#else
+			return -EINVAL;
+#endif
+		} else
+			sspsp |= SSPSP_SFRMWDTH(width);
+
 		ssp_write_reg(ssp, SSPSP, sspsp);
 		break;
 	default:
 		break;
 	}
 
-	/* We always use a network mode so we always require TDM slots
-	 * - complain loudly and fail if they've not been set up yet.
-	 */
-	if (!(ssp_read_reg(ssp, SSTSA) & 0xf)) {
-		dev_err(&ssp->pdev->dev, "No TDM timeslot configured\n");
-		return -EINVAL;
-	}
-
 	dump_registers(ssp);
 
 	return 0;
-- 
1.6.2
