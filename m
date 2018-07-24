From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: core: add support to
	snd_soc_dai_get_channel_map()" to the asoc tree
Date: Tue, 24 Jul 2018 12:50:37 +0100 (BST)
Message-ID: <20180724115037.3DF0E440078@finisterre.ee.mobilebroadband>
References: <20180723155410.9494-6-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id A488726733D
 for <alsa-devel@alsa-project.org>; Tue, 24 Jul 2018 13:50:40 +0200 (CEST)
In-Reply-To: <20180723155410.9494-6-srinivas.kandagatla@linaro.org>
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, linux-kernel@vger.kernel.org, tiwai@suse.com, robh+dt@kernel.org, lgirdwood@gmail.com, vkoul@kernel.org, broonie@kernel.org, lee.jones@linaro.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: core: add support to snd_soc_dai_get_channel_map()

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

>From 467b061f1ac80f323bedb56d20a24f7bc0d2cec5 Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Mon, 23 Jul 2018 16:54:03 +0100
Subject: [PATCH] ASoC: core: add support to snd_soc_dai_get_channel_map()

On Qualcomm platforms, specifically with SLIMbus interfaced codecs,
the codec slim channel numbers are passed to DSP while configuring
the slim audio path. Having get_channel_map() would allow dais to
share such information across multiple dais.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc-dai.h |  8 ++++++++
 sound/soc/soc-core.c    | 22 ++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index a14bc0608ae9..f5d70041108f 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -138,6 +138,11 @@ int snd_soc_dai_set_tristate(struct snd_soc_dai *dai, int tristate);
 int snd_soc_dai_digital_mute(struct snd_soc_dai *dai, int mute,
 			     int direction);
 
+
+int snd_soc_dai_get_channel_map(struct snd_soc_dai *dai,
+		unsigned int *tx_num, unsigned int *tx_slot,
+		unsigned int *rx_num, unsigned int *rx_slot);
+
 int snd_soc_dai_is_dummy(struct snd_soc_dai *dai);
 
 struct snd_soc_dai_ops {
@@ -165,6 +170,9 @@ struct snd_soc_dai_ops {
 	int (*set_channel_map)(struct snd_soc_dai *dai,
 		unsigned int tx_num, unsigned int *tx_slot,
 		unsigned int rx_num, unsigned int *rx_slot);
+	int (*get_channel_map)(struct snd_soc_dai *dai,
+			unsigned int *tx_num, unsigned int *tx_slot,
+			unsigned int *rx_num, unsigned int *rx_slot);
 	int (*set_tristate)(struct snd_soc_dai *dai, int tristate);
 
 	int (*set_sdw_stream)(struct snd_soc_dai *dai,
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index ad5b0ef16d82..81b27923303d 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2679,6 +2679,28 @@ int snd_soc_dai_set_channel_map(struct snd_soc_dai *dai,
 }
 EXPORT_SYMBOL_GPL(snd_soc_dai_set_channel_map);
 
+/**
+ * snd_soc_dai_get_channel_map - Get DAI audio channel map
+ * @dai: DAI
+ * @tx_num: how many TX channels
+ * @tx_slot: pointer to an array which imply the TX slot number channel
+ *           0~num-1 uses
+ * @rx_num: how many RX channels
+ * @rx_slot: pointer to an array which imply the RX slot number channel
+ *           0~num-1 uses
+ */
+int snd_soc_dai_get_channel_map(struct snd_soc_dai *dai,
+	unsigned int *tx_num, unsigned int *tx_slot,
+	unsigned int *rx_num, unsigned int *rx_slot)
+{
+	if (dai->driver->ops->get_channel_map)
+		return dai->driver->ops->get_channel_map(dai, tx_num, tx_slot,
+			rx_num, rx_slot);
+	else
+		return -ENOTSUPP;
+}
+EXPORT_SYMBOL_GPL(snd_soc_dai_get_channel_map);
+
 /**
  * snd_soc_dai_set_tristate - configure DAI system or master clock.
  * @dai: DAI
-- 
2.18.0
