From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH 2/6] ASoC: meson: axg-fifo: add g12a support
Date: Thu,  4 Apr 2019 13:17:29 +0200
Message-ID: <20190404111733.28705-3-jbrunet@baylibre.com>
References: <20190404111733.28705-1-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190404111733.28705-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, Maxime Jourdan <mjourdan@baylibre.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

The g12a fifos gained the ability to set the initial address of the
pointer within the buffer, instead of defaulting to the buffer start
address.

It is not very useful to us (yet) but we need to put a copy the buffer
start address in the related register for the fifo to work properly on the
g12a SoC family

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/meson/axg-fifo.c | 34 +++++++++++++++++++++++++++++++---
 sound/soc/meson/axg-fifo.h |  2 ++
 2 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/sound/soc/meson/axg-fifo.c b/sound/soc/meson/axg-fifo.c
index 75e5e480fda2..01c1c7db2510 100644
--- a/sound/soc/meson/axg-fifo.c
+++ b/sound/soc/meson/axg-fifo.c
@@ -19,7 +19,7 @@
  * This file implements the platform operations common to the playback and
  * capture frontend DAI. The logic behind this two types of fifo is very
  * similar but some difference exist.
- * These differences the respective DAI drivers
+ * These differences are handled in the respective DAI drivers
  */
 
 static struct snd_pcm_hardware axg_fifo_hw = {
@@ -133,6 +133,23 @@ static int axg_fifo_pcm_hw_params(struct snd_pcm_substream *ss,
 	return 0;
 }
 
+static int g12a_fifo_pcm_hw_params(struct snd_pcm_substream *ss,
+				   struct snd_pcm_hw_params *params)
+{
+	struct axg_fifo *fifo = axg_fifo_data(ss);
+	struct snd_pcm_runtime *runtime = ss->runtime;
+	int ret;
+
+	ret = axg_fifo_pcm_hw_params(ss, params);
+	if (ret)
+		return ret;
+
+	/* Set the initial memory address of the DMA */
+	regmap_write(fifo->map, FIFO_INIT_ADDR, runtime->dma_addr);
+
+	return 0;
+}
+
 static int axg_fifo_pcm_hw_free(struct snd_pcm_substream *ss)
 {
 	struct axg_fifo *fifo = axg_fifo_data(ss);
@@ -262,6 +279,17 @@ const struct snd_pcm_ops axg_fifo_pcm_ops = {
 };
 EXPORT_SYMBOL_GPL(axg_fifo_pcm_ops);
 
+const struct snd_pcm_ops g12a_fifo_pcm_ops = {
+	.open =		axg_fifo_pcm_open,
+	.close =        axg_fifo_pcm_close,
+	.ioctl =	snd_pcm_lib_ioctl,
+	.hw_params =	g12a_fifo_pcm_hw_params,
+	.hw_free =      axg_fifo_pcm_hw_free,
+	.pointer =	axg_fifo_pcm_pointer,
+	.trigger =	axg_fifo_pcm_trigger,
+};
+EXPORT_SYMBOL_GPL(g12a_fifo_pcm_ops);
+
 int axg_fifo_pcm_new(struct snd_soc_pcm_runtime *rtd, unsigned int type)
 {
 	struct snd_card *card = rtd->card->snd_card;
@@ -278,7 +306,7 @@ static const struct regmap_config axg_fifo_regmap_cfg = {
 	.reg_bits	= 32,
 	.val_bits	= 32,
 	.reg_stride	= 4,
-	.max_register	= FIFO_STATUS2,
+	.max_register	= FIFO_INIT_ADDR,
 };
 
 int axg_fifo_probe(struct platform_device *pdev)
@@ -339,6 +367,6 @@ int axg_fifo_probe(struct platform_device *pdev)
 }
 EXPORT_SYMBOL_GPL(axg_fifo_probe);
 
-MODULE_DESCRIPTION("Amlogic AXG fifo driver");
+MODULE_DESCRIPTION("Amlogic AXG/G12A fifo driver");
 MODULE_AUTHOR("Jerome Brunet <jbrunet@baylibre.com>");
 MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/meson/axg-fifo.h b/sound/soc/meson/axg-fifo.h
index d9f516cfbeda..5caf81241dfe 100644
--- a/sound/soc/meson/axg-fifo.h
+++ b/sound/soc/meson/axg-fifo.h
@@ -60,6 +60,7 @@ struct snd_soc_pcm_runtime;
 #define FIFO_STATUS1			0x14
 #define  STATUS1_INT_STS(x)		((x) << 0)
 #define FIFO_STATUS2			0x18
+#define FIFO_INIT_ADDR			0x24
 
 struct axg_fifo {
 	struct regmap *map;
@@ -74,6 +75,7 @@ struct axg_fifo_match_data {
 };
 
 extern const struct snd_pcm_ops axg_fifo_pcm_ops;
+extern const struct snd_pcm_ops g12a_fifo_pcm_ops;
 
 int axg_fifo_pcm_new(struct snd_soc_pcm_runtime *rtd, unsigned int type);
 int axg_fifo_probe(struct platform_device *pdev);
-- 
2.20.1
