From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm0010: Fix resource leak
Date: Wed, 31 Jul 2013 10:15:18 +0100
Message-ID: <1375262118-9183-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 04A97265475
 for <alsa-devel@alsa-project.org>; Wed, 31 Jul 2013 11:15:20 +0200 (CEST)
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

This fixes "https://bugzilla.kernel.org/show_bug.cgi?id=60650".

Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm0010.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/wm0010.c b/sound/soc/codecs/wm0010.c
index f5e8356..285026c 100644
--- a/sound/soc/codecs/wm0010.c
+++ b/sound/soc/codecs/wm0010.c
@@ -410,6 +410,13 @@ static int wm0010_firmware_load(const char *name, struct snd_soc_codec *codec)
 			rec->command, rec->length);
 		len = rec->length + 8;
 
+		xfer = kzalloc(sizeof(*xfer), GFP_KERNEL | GFP_DMA);
+		if (!xfer) {
+			dev_err(codec->dev, "Failed to allocate xfer\n");
+			ret = -ENOMEM;
+			goto abort1;
+		}
+
 		out = kzalloc(len, GFP_KERNEL);
 		if (!out) {
 			dev_err(codec->dev,
@@ -417,6 +424,7 @@ static int wm0010_firmware_load(const char *name, struct snd_soc_codec *codec)
 			ret = -ENOMEM;
 			goto abort1;
 		}
+		xfer->t.rx_buf = out;
 
 		img = kzalloc(len, GFP_KERNEL);
 		if (!img) {
@@ -425,24 +433,16 @@ static int wm0010_firmware_load(const char *name, struct snd_soc_codec *codec)
 			ret = -ENOMEM;
 			goto abort1;
 		}
+		xfer->t.tx_buf = img;
 
 		byte_swap_64((u64 *)&rec->command, img, len);
 
-		xfer = kzalloc(sizeof(*xfer), GFP_KERNEL);
-		if (!xfer) {
-			dev_err(codec->dev, "Failed to allocate xfer\n");
-			ret = -ENOMEM;
-			goto abort1;
-		}
-
 		xfer->codec = codec;
 		list_add_tail(&xfer->list, &xfer_list);
 
 		spi_message_init(&xfer->m);
 		xfer->m.complete = wm0010_boot_xfer_complete;
 		xfer->m.context = xfer;
-		xfer->t.tx_buf = img;
-		xfer->t.rx_buf = out;
 		xfer->t.len = len;
 		xfer->t.bits_per_word = 8;
 
-- 
1.8.3.4
