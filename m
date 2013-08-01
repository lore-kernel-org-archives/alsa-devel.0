From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm0010: Use DMA-safe memory for SPI
	transfers
Date: Thu,  1 Aug 2013 09:53:45 +0100
Message-ID: <1375347225-6453-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 269702616CB
 for <alsa-devel@alsa-project.org>; Thu,  1 Aug 2013 10:53:47 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

We should be allocating our buffers for the SPI transfers
from the DMA zone.

Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm0010.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/wm0010.c b/sound/soc/codecs/wm0010.c
index 10adc41..d5ebcb0 100644
--- a/sound/soc/codecs/wm0010.c
+++ b/sound/soc/codecs/wm0010.c
@@ -420,7 +420,7 @@ static int wm0010_firmware_load(const char *name, struct snd_soc_codec *codec)
 		xfer->codec = codec;
 		list_add_tail(&xfer->list, &xfer_list);
 
-		out = kzalloc(len, GFP_KERNEL);
+		out = kzalloc(len, GFP_KERNEL | GFP_DMA);
 		if (!out) {
 			dev_err(codec->dev,
 				"Failed to allocate RX buffer\n");
@@ -429,7 +429,7 @@ static int wm0010_firmware_load(const char *name, struct snd_soc_codec *codec)
 		}
 		xfer->t.rx_buf = out;
 
-		img = kzalloc(len, GFP_KERNEL);
+		img = kzalloc(len, GFP_KERNEL | GFP_DMA);
 		if (!img) {
 			dev_err(codec->dev,
 				"Failed to allocate image buffer\n");
@@ -523,14 +523,14 @@ static int wm0010_stage2_load(struct snd_soc_codec *codec)
 	dev_dbg(codec->dev, "Downloading %zu byte stage 2 loader\n", fw->size);
 
 	/* Copy to local buffer first as vmalloc causes problems for dma */
-	img = kzalloc(fw->size, GFP_KERNEL);
+	img = kzalloc(fw->size, GFP_KERNEL | GFP_DMA);
 	if (!img) {
 		dev_err(codec->dev, "Failed to allocate image buffer\n");
 		ret = -ENOMEM;
 		goto abort2;
 	}
 
-	out = kzalloc(fw->size, GFP_KERNEL);
+	out = kzalloc(fw->size, GFP_KERNEL | GFP_DMA);
 	if (!out) {
 		dev_err(codec->dev, "Failed to allocate output buffer\n");
 		ret = -ENOMEM;
@@ -670,14 +670,14 @@ static int wm0010_boot(struct snd_soc_codec *codec)
 
 		ret = -ENOMEM;
 		len = pll_rec.length + 8;
-		out = kzalloc(len, GFP_KERNEL);
+		out = kzalloc(len, GFP_KERNEL | GFP_DMA);
 		if (!out) {
 			dev_err(codec->dev,
 				"Failed to allocate RX buffer\n");
 			goto abort;
 		}
 
-		img_swap = kzalloc(len, GFP_KERNEL);
+		img_swap = kzalloc(len, GFP_KERNEL | GFP_DMA);
 		if (!img_swap) {
 			dev_err(codec->dev,
 				"Failed to allocate image buffer\n");
-- 
1.8.3.4
