From: Daniel Mack <daniel@caiaq.de>
Subject: Re: snd-soc-pxa-ssp I2C/FIFO issues
Date: Wed, 11 Mar 2009 19:42:14 +0100
Message-ID: <20090311184214.GE29871@buzzloop.caiaq.de>
References: <74d0deb30903090747p3fbb8dd5l27cd7313d4be7de2@mail.gmail.com>
	<20090309153629.GB24787@buzzloop.caiaq.de>
	<20090309174443.GG13593@sirena.org.uk>
	<20090310154741.GC10574@buzzloop.caiaq.de>
	<74d0deb30903111110h4e441959yec421225a4b90cc9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 6E41A103898
	for <alsa-devel@alsa-project.org>; Wed, 11 Mar 2009 19:42:17 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <74d0deb30903111110h4e441959yec421225a4b90cc9@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: pHilipp Zabel <philipp.zabel@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 11, 2009 at 07:10:28PM +0100, pHilipp Zabel wrote:
> Tested-by me. Of course this still doesn't help me to enable 16-bit
> DMA transfers for stereo, but it doesn't hurt either.

Ok, new version below.

Daniel


>From ad8734e93eed130a55482b0e937729578e6d93c8 Mon Sep 17 00:00:00 2001
From: Daniel Mack <daniel@caiaq.de>
Date: Wed, 11 Mar 2009 19:38:15 +0100
Subject: [PATCH] pxa-ssp: switch from network mode to PSP

This switches the pxa ssp port usage from network mode to PSP mode.
Removed some comments and checks for configured TDM channels.
A special case is added to support configuration where BCLK = 64fs. We
need to do some black magic in this case which doesn't look nice but
there is unfortunately no other option than that.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
---
 sound/soc/pxa/pxa-ssp.c |   44 +++++++++++++++++++++++++++++++++-----------
 1 files changed, 33 insertions(+), 11 deletions(-)

diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index 52d97c4..3cde686 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -558,18 +558,17 @@ static int pxa_ssp_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 
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
@@ -655,33 +654,56 @@ static int pxa_ssp_hw_params(struct snd_pcm_substream *substream,
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
+	       sspsp = ssp_read_reg(ssp, SSPSP);
+
+		if (((sscr0 & SSCR0_SCR) == SSCR0_SerClkDiv(4)) &&
+		     (width == 16)) {
+			/* This is a special case where the bitclk is 64fs
+			* and we're not dealing with 2*32 bits of audio
+			* samples.
+			*
+			* The SSP values used for that are all found out by
+			* trying and failing a lot; some of the registers
+			* needed for that mode are only available on PXA3xx.
+			*/
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
+	/* When we use a network mode, we always require TDM slots
 	 * - complain loudly and fail if they've not been set up yet.
 	 */
-	if (!(ssp_read_reg(ssp, SSTSA) & 0xf)) {
+	if ((sscr0 & SSCR0_MOD) && !(ssp_read_reg(ssp, SSTSA) & 0xf)) {
 		dev_err(&ssp->pdev->dev, "No TDM timeslot configured\n");
 		return -EINVAL;
 	}
-- 
1.6.2
