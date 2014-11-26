From: Zidan Wang <b50113@freescale.com>
Subject: [PATCH] ASoC: wm8960: LRCM operation should after
	software reset
Date: Wed, 26 Nov 2014 19:02:20 +0800
Message-ID: <1416999740-21805-1-git-send-email-b50113@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0124.outbound.protection.outlook.com [207.46.100.124])
 by alsa0.perex.cz (Postfix) with ESMTP id EF1E1265B55
 for <alsa-devel@alsa-project.org>; Wed, 26 Nov 2014 12:01:40 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, tiwai@suse.de, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, Li.Xiubo@freescale.com, Zidan Wang <b50113@freescale.com>, ckeepax@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

When shared_lrclk is set, LRCM will be enabled. But the following software
reset in wm8960_probe will reset it to the default state. So LRCM operation
should after software reset.

Signed-off-by: Zidan Wang <b50113@freescale.com>
---
 sound/soc/codecs/wm8960.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index bc8793cd..21db90c 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -960,6 +960,14 @@ static int wm8960_probe(struct snd_soc_codec *codec)
 		return ret;
 	}
 
+	if (pdata->shared_lrclk) {
+		ret = snd_soc_update_bits(codec, WM8960_ADDCTL2, 0x4, 0x4);
+		if (ret < 0) {
+			dev_err(codec->dev, "Failed to enable LRCM: %d\n", ret);
+			return ret;
+		}
+	}
+
 	/* Latch the update bits */
 	snd_soc_update_bits(codec, WM8960_LINVOL, 0x100, 0x100);
 	snd_soc_update_bits(codec, WM8960_RINVOL, 0x100, 0x100);
@@ -1030,15 +1038,6 @@ static int wm8960_i2c_probe(struct i2c_client *i2c,
 	else if (i2c->dev.of_node)
 		wm8960_set_pdata_from_of(i2c, &wm8960->pdata);
 
-	if (pdata && pdata->shared_lrclk) {
-		ret = regmap_update_bits(wm8960->regmap, WM8960_ADDCTL2,
-					 0x4, 0x4);
-		if (ret != 0) {
-			dev_err(&i2c->dev, "Failed to enable LRCM: %d\n",
-				ret);
-			return ret;
-		}
-	}
 
 	i2c_set_clientdata(i2c, wm8960);
 
-- 
1.9.1
