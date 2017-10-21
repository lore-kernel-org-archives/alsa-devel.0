From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: stm32: sai: Move static settings to DAI
	init" to the asoc tree
Date: Sat, 21 Oct 2017 11:31:50 +0100 (BST)
Message-ID: <20171021103150.C26EB440057@finisterre.ee.mobilebroadband>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 556A9267786
 for <alsa-devel@alsa-project.org>; Sat, 21 Oct 2017 12:31:52 +0200 (CEST)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, olivier moysan <olivier.moysan@st.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: stm32: sai: Move static settings to DAI init

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 61fb4ff70377cd2c49a3487bdb0156eba6930072 Mon Sep 17 00:00:00 2001
From: Olivier Moysan <olivier.moysan@st.com>
Date: Thu, 19 Oct 2017 15:03:18 +0200
Subject: [PATCH] ASoC: stm32: sai: Move static settings to DAI init

Audio interface direction and protocol settings does not change
at runtime. So, these settings are moved from hw_params
function to dai_probe and set_fmt.

Signed-off-by: olivier moysan <olivier.moysan@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/stm/stm32_sai_sub.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index dde8ddf9e777..815ef1036199 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -308,12 +308,15 @@ static int stm32_sai_set_dai_tdm_slot(struct snd_soc_dai *cpu_dai, u32 tx_mask,
 static int stm32_sai_set_dai_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
 {
 	struct stm32_sai_sub_data *sai = snd_soc_dai_get_drvdata(cpu_dai);
-	int cr1 = 0, frcr = 0;
-	int cr1_mask = 0, frcr_mask = 0;
+	int cr1, frcr = 0;
+	int cr1_mask, frcr_mask = 0;
 	int ret;
 
 	dev_dbg(cpu_dai->dev, "fmt %x\n", fmt);
 
+	cr1_mask = SAI_XCR1_PRTCFG_MASK;
+	cr1 = SAI_XCR1_PRTCFG_SET(SAI_FREE_PROTOCOL);
+
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	/* SCK active high for all protocols */
 	case SND_SOC_DAIFMT_I2S:
@@ -340,7 +343,7 @@ static int stm32_sai_set_dai_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
 		return -EINVAL;
 	}
 
-	cr1_mask |= SAI_XCR1_PRTCFG_MASK | SAI_XCR1_CKSTR;
+	cr1_mask |= SAI_XCR1_CKSTR;
 	frcr_mask |= SAI_XFRCR_FSPOL | SAI_XFRCR_FSOFF |
 		     SAI_XFRCR_FSDEF;
 
@@ -458,7 +461,7 @@ static int stm32_sai_set_config(struct snd_soc_dai *cpu_dai,
 			   SAI_XCR2_FTH_SET(STM_SAI_FIFO_TH_HALF));
 
 	/* Mode, data format and channel config */
-	cr1 = SAI_XCR1_PRTCFG_SET(SAI_FREE_PROTOCOL);
+	cr1_mask = SAI_XCR1_DS_MASK;
 	switch (params_format(params)) {
 	case SNDRV_PCM_FORMAT_S8:
 		cr1 |= SAI_XCR1_DS_SET(SAI_DATASIZE_8);
@@ -473,11 +476,6 @@ static int stm32_sai_set_config(struct snd_soc_dai *cpu_dai,
 		dev_err(cpu_dai->dev, "Data format not supported");
 		return -EINVAL;
 	}
-	cr1_mask = SAI_XCR1_DS_MASK | SAI_XCR1_PRTCFG_MASK;
-
-	cr1_mask |= SAI_XCR1_RX_TX;
-	if (STM_SAI_IS_CAPTURE(sai))
-		cr1 |= SAI_XCR1_RX_TX;
 
 	cr1_mask |= SAI_XCR1_MONO;
 	if ((sai->slots == 2) && (params_channels(params) == 1))
@@ -729,6 +727,7 @@ static void stm32_sai_shutdown(struct snd_pcm_substream *substream,
 static int stm32_sai_dai_probe(struct snd_soc_dai *cpu_dai)
 {
 	struct stm32_sai_sub_data *sai = dev_get_drvdata(cpu_dai->dev);
+	int cr1 = 0, cr1_mask;
 
 	sai->dma_params.addr = (dma_addr_t)(sai->phys_addr + STM_SAI_DR_REGX);
 	/*
@@ -745,7 +744,11 @@ static int stm32_sai_dai_probe(struct snd_soc_dai *cpu_dai)
 	else
 		snd_soc_dai_init_dma_data(cpu_dai, NULL, &sai->dma_params);
 
-	return 0;
+	cr1_mask = SAI_XCR1_RX_TX;
+	if (STM_SAI_IS_CAPTURE(sai))
+		cr1 |= SAI_XCR1_RX_TX;
+
+	return regmap_update_bits(sai->regmap, STM_SAI_CR1_REGX, cr1_mask, cr1);
 }
 
 static const struct snd_soc_dai_ops stm32_sai_pcm_dai_ops = {
-- 
2.14.1
