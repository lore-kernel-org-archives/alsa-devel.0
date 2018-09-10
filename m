From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: AMD: Fix simultaneous playback and
	capture on different channel" to the asoc tree
Date: Mon, 10 Sep 2018 18:53:38 +0100 (BST)
Message-ID: <20180910175338.F41E311227B6@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id E63B626788E
 for <alsa-devel@alsa-project.org>; Mon, 10 Sep 2018 19:53:40 +0200 (CEST)
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
To: Akshu Agrawal <akshu.agrawal@amd.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: AMD: Fix simultaneous playback and capture on different channel

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 8dcb0c90c691de5b79608d04ec7941ef9b3fee9c Mon Sep 17 00:00:00 2001
From: Akshu Agrawal <akshu.agrawal@amd.com>
Date: Mon, 10 Sep 2018 22:50:27 +0530
Subject: [PATCH] ASoC: AMD: Fix simultaneous playback and capture on different
 channel

If capture and playback are started on different channel (I2S/BT)
there is a possibilty that channel information passed from machine driver
is overwritten before the configuration is done in dma driver.
Example:
113.597588: cz_max_startup: ---playback sets BT channel
113.597694: cz_dmic1_startup: ---capture sets I2S channel
113.597979: acp_dma_hw_params: ---configures capture for I2S channel
113.598114: acp_dma_hw_params: ---configures playback for I2S channel

This is fixed by having 2 separate instance for playback and capture.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/acp-da7219-max98357a.c | 40 +++++++++++++++++++++++-----
 sound/soc/amd/acp-pcm-dma.c          |  8 ++++--
 sound/soc/amd/acp.h                  |  3 ++-
 3 files changed, 41 insertions(+), 10 deletions(-)

diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
index 3879cccbd2c0..717a017f0db6 100644
--- a/sound/soc/amd/acp-da7219-max98357a.c
+++ b/sound/soc/amd/acp-da7219-max98357a.c
@@ -133,7 +133,7 @@ static const struct snd_pcm_hw_constraint_list constraints_channels = {
 	.mask = 0,
 };
 
-static int cz_da7219_startup(struct snd_pcm_substream *substream)
+static int cz_da7219_play_startup(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
@@ -150,7 +150,28 @@ static int cz_da7219_startup(struct snd_pcm_substream *substream)
 	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
 				   &constraints_rates);
 
-	machine->i2s_instance = I2S_SP_INSTANCE;
+	machine->play_i2s_instance = I2S_SP_INSTANCE;
+	return da7219_clk_enable(substream);
+}
+
+static int cz_da7219_cap_startup(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_card *card = rtd->card;
+	struct acp_platform_info *machine = snd_soc_card_get_drvdata(card);
+
+	/*
+	 * On this platform for PCM device we support stereo
+	 */
+
+	runtime->hw.channels_max = DUAL_CHANNEL;
+	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
+				   &constraints_channels);
+	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
+				   &constraints_rates);
+
+	machine->cap_i2s_instance = I2S_SP_INSTANCE;
 	machine->capture_channel = CAP_CHANNEL1;
 	return da7219_clk_enable(substream);
 }
@@ -177,7 +198,7 @@ static int cz_max_startup(struct snd_pcm_substream *substream)
 	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
 				   &constraints_rates);
 
-	machine->i2s_instance = I2S_BT_INSTANCE;
+	machine->play_i2s_instance = I2S_BT_INSTANCE;
 	return da7219_clk_enable(substream);
 }
 
@@ -203,7 +224,7 @@ static int cz_dmic0_startup(struct snd_pcm_substream *substream)
 	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
 				   &constraints_rates);
 
-	machine->i2s_instance = I2S_BT_INSTANCE;
+	machine->cap_i2s_instance = I2S_BT_INSTANCE;
 	return da7219_clk_enable(substream);
 }
 
@@ -224,7 +245,7 @@ static int cz_dmic1_startup(struct snd_pcm_substream *substream)
 	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
 				   &constraints_rates);
 
-	machine->i2s_instance = I2S_SP_INSTANCE;
+	machine->cap_i2s_instance = I2S_SP_INSTANCE;
 	machine->capture_channel = CAP_CHANNEL0;
 	return da7219_clk_enable(substream);
 }
@@ -234,8 +255,13 @@ static void cz_dmic_shutdown(struct snd_pcm_substream *substream)
 	da7219_clk_disable();
 }
 
+static const struct snd_soc_ops cz_da7219_play_ops = {
+	.startup = cz_da7219_play_startup,
+	.shutdown = cz_da7219_shutdown,
+};
+
 static const struct snd_soc_ops cz_da7219_cap_ops = {
-	.startup = cz_da7219_startup,
+	.startup = cz_da7219_cap_startup,
 	.shutdown = cz_da7219_shutdown,
 };
 
@@ -266,7 +292,7 @@ static struct snd_soc_dai_link cz_dai_7219_98357[] = {
 				| SND_SOC_DAIFMT_CBM_CFM,
 		.init = cz_da7219_init,
 		.dpcm_playback = 1,
-		.ops = &cz_da7219_cap_ops,
+		.ops = &cz_da7219_play_ops,
 	},
 	{
 		.name = "amd-da7219-cap",
diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index e359938e3d7e..8f3bc6e37f26 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -846,8 +846,12 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 
 	if (pinfo) {
-		rtd->i2s_instance = pinfo->i2s_instance;
-		rtd->capture_channel = pinfo->capture_channel;
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+			rtd->i2s_instance = pinfo->play_i2s_instance;
+		} else {
+			rtd->i2s_instance = pinfo->cap_i2s_instance;
+			rtd->capture_channel = pinfo->capture_channel;
+		}
 	}
 	if (adata->asic_type == CHIP_STONEY) {
 		val = acp_reg_read(adata->acp_mmio,
diff --git a/sound/soc/amd/acp.h b/sound/soc/amd/acp.h
index be3963e8f4fa..dbbb1a85638d 100644
--- a/sound/soc/amd/acp.h
+++ b/sound/soc/amd/acp.h
@@ -158,7 +158,8 @@ struct audio_drv_data {
  * and dma driver
  */
 struct acp_platform_info {
-	u16 i2s_instance;
+	u16 play_i2s_instance;
+	u16 cap_i2s_instance;
 	u16 capture_channel;
 };
 
-- 
2.19.0.rc1
