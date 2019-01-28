From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: apq8096: add slim support" to the asoc
	tree
Date: Mon, 28 Jan 2019 18:24:52 +0000 (GMT)
Message-ID: <20190128182452.D0F741127D29@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 4450B267456
 for <alsa-devel@alsa-project.org>; Mon, 28 Jan 2019 19:24:54 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: apq8096: add slim support

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

>From 9f11d233d98aa7570210fbfd6cc6e11f5df8906d Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Mon, 28 Jan 2019 14:27:53 +0000
Subject: [PATCH] ASoC: apq8096: add slim support

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/apq8096.c | 71 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 70 insertions(+), 1 deletion(-)

diff --git a/sound/soc/qcom/apq8096.c b/sound/soc/qcom/apq8096.c
index fb45f396ab4a..94363fd6846a 100644
--- a/sound/soc/qcom/apq8096.c
+++ b/sound/soc/qcom/apq8096.c
@@ -9,6 +9,10 @@
 #include <sound/pcm.h>
 #include "common.h"
 
+#define SLIM_MAX_TX_PORTS 16
+#define SLIM_MAX_RX_PORTS 16
+#define WCD9335_DEFAULT_MCLK_RATE	9600000
+
 static int apq8096_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
 				      struct snd_pcm_hw_params *params)
 {
@@ -23,14 +27,79 @@ static int apq8096_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
 	return 0;
 }
 
+static int msm_snd_hw_params(struct snd_pcm_substream *substream,
+			     struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	u32 rx_ch[SLIM_MAX_RX_PORTS], tx_ch[SLIM_MAX_TX_PORTS];
+	u32 rx_ch_cnt = 0, tx_ch_cnt = 0;
+	int ret = 0;
+
+	ret = snd_soc_dai_get_channel_map(codec_dai,
+				&tx_ch_cnt, tx_ch, &rx_ch_cnt, rx_ch);
+	if (ret != 0 && ret != -ENOTSUPP) {
+		pr_err("failed to get codec chan map, err:%d\n", ret);
+		goto end;
+	} else if (ret == -ENOTSUPP) {
+		return 0;
+	}
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		ret = snd_soc_dai_set_channel_map(cpu_dai, 0, NULL,
+						  rx_ch_cnt, rx_ch);
+	else
+		ret = snd_soc_dai_set_channel_map(cpu_dai, tx_ch_cnt, tx_ch,
+						  0, NULL);
+	if (ret != 0 && ret != -ENOTSUPP)
+		pr_err("Failed to set cpu chan map, err:%d\n", ret);
+	else if (ret == -ENOTSUPP)
+		ret = 0;
+end:
+	return ret;
+}
+
+static struct snd_soc_ops apq8096_ops = {
+	.hw_params = msm_snd_hw_params,
+};
+
+static int apq8096_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+
+	/*
+	 * Codec SLIMBUS configuration
+	 * RX1, RX2, RX3, RX4, RX5, RX6, RX7, RX8, RX9, RX10, RX11, RX12, RX13
+	 * TX1, TX2, TX3, TX4, TX5, TX6, TX7, TX8, TX9, TX10, TX11, TX12, TX13
+	 * TX14, TX15, TX16
+	 */
+	unsigned int rx_ch[SLIM_MAX_RX_PORTS] = {144, 145, 146, 147, 148, 149,
+					150, 151, 152, 153, 154, 155, 156};
+	unsigned int tx_ch[SLIM_MAX_TX_PORTS] = {128, 129, 130, 131, 132, 133,
+					    134, 135, 136, 137, 138, 139,
+					    140, 141, 142, 143};
+
+	snd_soc_dai_set_channel_map(codec_dai, ARRAY_SIZE(tx_ch),
+					tx_ch, ARRAY_SIZE(rx_ch), rx_ch);
+
+	snd_soc_dai_set_sysclk(codec_dai, 0, WCD9335_DEFAULT_MCLK_RATE,
+				SNDRV_PCM_STREAM_PLAYBACK);
+
+	return 0;
+}
+
 static void apq8096_add_be_ops(struct snd_soc_card *card)
 {
 	struct snd_soc_dai_link *link;
 	int i;
 
 	for_each_card_prelinks(card, i, link) {
-		if (link->no_pcm == 1)
+		if (link->no_pcm == 1) {
 			link->be_hw_params_fixup = apq8096_be_hw_params_fixup;
+			link->init = apq8096_init;
+			link->ops = &apq8096_ops;
+		}
 	}
 }
 
-- 
2.20.1
