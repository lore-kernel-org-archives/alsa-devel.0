From: Akshu Agrawal <akshu.agrawal@amd.com>
Subject: [PATCH 1/2] ASoC: AMD: Fix simultaneous playback and
	capture on different channel
Date: Mon, 10 Sep 2018 13:36:29 +0530
Message-ID: <1536566815-3271-1-git-send-email-akshu.agrawal@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM01-BY2-obe.outbound.protection.outlook.com
 (mail-by2nam01on0084.outbound.protection.outlook.com [104.47.34.84])
 by alsa0.perex.cz (Postfix) with ESMTP id D8A9C266E0E
 for <alsa-devel@alsa-project.org>; Mon, 10 Sep 2018 10:07:31 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, open list <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, djkurtz@chromium.org, Mark Brown <broonie@kernel.org>, Wei Yongjun <weiyongjun1@huawei.com>, "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>, Alexander.Deucher@amd.com, akshu.agrawal@amd.com
List-Id: alsa-devel@alsa-project.org

If capture and playback are started on different channel (I2S/BT)
there is a possibilty that channel information passed from machine driver
is overwritten before the configuration is done in dma driver.
Example:
113.597588: cz_max_startup: ---playback sets BT channel
113.597694: cz_dmic1_startup: ---capture sets I2S channel
113.597979: acp_dma_hw_params: ---configures capture for I2S channel
113.598114: acp_dma_hw_params: ---configures playback for I2S channel

This is fixed by having lock between startup and prepare. This ensures
no other codec startup gets called between a codec's startup(where channel
info is set) and hw_params(where channel info is read).

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
---
 sound/soc/amd/acp-da7219-max98357a.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
index 3879ccc..b98ffbc 100644
--- a/sound/soc/amd/acp-da7219-max98357a.c
+++ b/sound/soc/amd/acp-da7219-max98357a.c
@@ -47,6 +47,7 @@
 
 static struct snd_soc_jack cz_jack;
 static struct clk *da7219_dai_clk;
+static struct mutex instance_lock;
 extern int bt_uart_enable;
 
 static int cz_da7219_init(struct snd_soc_pcm_runtime *rtd)
@@ -150,6 +151,7 @@ static int cz_da7219_startup(struct snd_pcm_substream *substream)
 	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
 				   &constraints_rates);
 
+	mutex_lock(&instance_lock);
 	machine->i2s_instance = I2S_SP_INSTANCE;
 	machine->capture_channel = CAP_CHANNEL1;
 	return da7219_clk_enable(substream);
@@ -160,6 +162,12 @@ static void cz_da7219_shutdown(struct snd_pcm_substream *substream)
 	da7219_clk_disable();
 }
 
+static int cz_da7219_prepare(struct snd_pcm_substream *substream)
+{
+	mutex_unlock(&instance_lock);
+	return 0;
+}
+
 static int cz_max_startup(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
@@ -177,6 +185,7 @@ static int cz_max_startup(struct snd_pcm_substream *substream)
 	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
 				   &constraints_rates);
 
+	mutex_lock(&instance_lock);
 	machine->i2s_instance = I2S_BT_INSTANCE;
 	return da7219_clk_enable(substream);
 }
@@ -186,6 +195,12 @@ static void cz_max_shutdown(struct snd_pcm_substream *substream)
 	da7219_clk_disable();
 }
 
+static int cz_max_prepare(struct snd_pcm_substream *substream)
+{
+	mutex_unlock(&instance_lock);
+	return 0;
+}
+
 static int cz_dmic0_startup(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
@@ -203,6 +218,7 @@ static int cz_dmic0_startup(struct snd_pcm_substream *substream)
 	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
 				   &constraints_rates);
 
+	mutex_lock(&instance_lock);
 	machine->i2s_instance = I2S_BT_INSTANCE;
 	return da7219_clk_enable(substream);
 }
@@ -224,6 +240,7 @@ static int cz_dmic1_startup(struct snd_pcm_substream *substream)
 	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
 				   &constraints_rates);
 
+	mutex_lock(&instance_lock);
 	machine->i2s_instance = I2S_SP_INSTANCE;
 	machine->capture_channel = CAP_CHANNEL0;
 	return da7219_clk_enable(substream);
@@ -234,24 +251,34 @@ static void cz_dmic_shutdown(struct snd_pcm_substream *substream)
 	da7219_clk_disable();
 }
 
+static int cz_dmic_prepare(struct snd_pcm_substream *substream)
+{
+	mutex_unlock(&instance_lock);
+	return 0;
+}
+
 static const struct snd_soc_ops cz_da7219_cap_ops = {
 	.startup = cz_da7219_startup,
 	.shutdown = cz_da7219_shutdown,
+	.prepare = cz_da7219_prepare,
 };
 
 static const struct snd_soc_ops cz_max_play_ops = {
 	.startup = cz_max_startup,
 	.shutdown = cz_max_shutdown,
+	.prepare = cz_max_prepare,
 };
 
 static const struct snd_soc_ops cz_dmic0_cap_ops = {
 	.startup = cz_dmic0_startup,
 	.shutdown = cz_dmic_shutdown,
+	.prepare = cz_dmic_prepare,
 };
 
 static const struct snd_soc_ops cz_dmic1_cap_ops = {
 	.startup = cz_dmic1_startup,
 	.shutdown = cz_dmic_shutdown,
+	.prepare = cz_dmic_prepare,
 };
 
 static struct snd_soc_dai_link cz_dai_7219_98357[] = {
@@ -409,6 +436,7 @@ static int cz_probe(struct platform_device *pdev)
 	card = &cz_card;
 	cz_card.dev = &pdev->dev;
 	platform_set_drvdata(pdev, card);
+	mutex_init(&instance_lock);
 	snd_soc_card_set_drvdata(card, machine);
 	ret = devm_snd_soc_register_card(&pdev->dev, &cz_card);
 	if (ret) {
-- 
1.9.1
