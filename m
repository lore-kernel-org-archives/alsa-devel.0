From: Daniel Mack <daniel@caiaq.de>
Subject: [PATCH 4/4] pxa-ssp: switch from network mode to psp
Date: Wed,  4 Mar 2009 21:17:00 +0100
Message-ID: <1236197820-21022-4-git-send-email-daniel@caiaq.de>
References: <20090304201505.GE12183@buzzloop.caiaq.de>
	<1236197820-21022-1-git-send-email-daniel@caiaq.de>
	<1236197820-21022-2-git-send-email-daniel@caiaq.de>
	<1236197820-21022-3-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 29160103929
	for <alsa-devel@alsa-project.org>; Wed,  4 Mar 2009 21:17:14 +0100 (CET)
In-Reply-To: <1236197820-21022-3-git-send-email-daniel@caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tim Ruetz <tim@caiaq.de>, Liam Girdwood <lrg@kernel.org>
List-Id: alsa-devel@alsa-project.org

This patch uses the SSP's PSP functionality to provide I2S timings. The
particular problem is that even though the datasheets state it should be
possbible, there is no mode which uses the network feature with its
associated time slots in a sane way to do what we need.

Hence, in order to have full 64 bit I2S on the wire, we need to fiddle
around with the SSP and the timing paramters a lot. There are some
constants left in the code which can't be replaced by names because the
true meaning of their registers remains nebulous.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
Signed-off-by: Tim Ruetz <tim@caiaq.de>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <lrg@kernel.org>
Cc: Philipp Zabel <philipp.zabel@gmail.com>
---
 sound/soc/pxa/pxa-ssp.c |   39 +++++++++++++++++++++------------------
 1 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index 45fb600..97f11d6 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -319,6 +319,7 @@ static int pxa_ssp_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
 		break;
 	case PXA_SSP_CLK_EXT:
 		priv->sysclk = freq;
+		ssp_set_scr(&priv->dev, 4);
 		sscr0 |= SSCR0_ECS;
 		break;
 	case PXA_SSP_CLK_NET:
@@ -551,17 +552,13 @@ static int pxa_ssp_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 
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
-			break;
-		case SND_SOC_DAIFMT_IB_IF:
 			sspsp |= SSPSP_SFRMP;
 			break;
 		default:
@@ -652,33 +649,39 @@ static int pxa_ssp_hw_params(struct snd_pcm_substream *substream,
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
+		switch (priv->dai_fmt & SND_SOC_DAIFMT_FRAME_FORMAT_MASK) {
+		case SND_SOC_DAIFMT_FF_I2S_32:
+			/* These values are all found out by trying and
+			 * failing a lot. PXA's SSP is all black magic and
+			 * does not work like described in any datasheet.
+			 */
+			sspsp |= SSPSP_SFRMWDTH(32);
+			sspsp |= SSPSP_SFRMDLY(32 * 2);
+			sspsp |= SSPSP_EDMYSTOP(3);
+			sspsp |= SSPSP_DMYSTOP(3);
+			sspsp |= SSPSP_DMYSTRT(1);
+			break;
+		default:
+			/* Cleared when the DAI format is set */
+			sspsp |= SSPSP_SFRMWDTH(width);
+			break;
+		}
 		ssp_write_reg(ssp, SSPSP, sspsp);
-		break;
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
1.6.1.3
