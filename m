From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH] ASoC: rt5665: remove rt5668 support
Date: Mon, 29 Jan 2018 19:15:38 +0800
Message-ID: <1517224538-29983-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id C3F1D266D06
 for <alsa-devel@alsa-project.org>; Mon, 29 Jan 2018 12:15:53 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, shawn.lee@realtek.com, shumingf@realtek.com, Bard Liao <bardliao@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

Remove rt5668 support from rt5665 codec driver since rt5668 will
not go into mass production.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 Documentation/devicetree/bindings/sound/rt5665.txt | 4 ++--
 sound/soc/codecs/rt5665.c                          | 5 -----
 sound/soc/codecs/rt5665.h                          | 1 -
 3 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/rt5665.txt b/Documentation/devicetree/bindings/sound/rt5665.txt
index 419c892..8df1705 100644
--- a/Documentation/devicetree/bindings/sound/rt5665.txt
+++ b/Documentation/devicetree/bindings/sound/rt5665.txt
@@ -1,10 +1,10 @@
-RT5665/RT5666/RT5668 audio CODEC
+RT5665/RT5666 audio CODEC
 
 This device supports I2C only.
 
 Required properties:
 
-- compatible : One of "realtek,rt5665", "realtek,rt5666" or "realtek,rt5668".
+- compatible : One of "realtek,rt5665", "realtek,rt5666".
 
 - reg : The I2C address of the device.
 
diff --git a/sound/soc/codecs/rt5665.c b/sound/soc/codecs/rt5665.c
index f05d362..e1b558b 100644
--- a/sound/soc/codecs/rt5665.c
+++ b/sound/soc/codecs/rt5665.c
@@ -4828,9 +4828,6 @@ static int rt5665_i2c_probe(struct i2c_client *i2c,
 	case 0x0:
 		rt5665->id = CODEC_5666;
 		break;
-	case 0x6:
-		rt5665->id = CODEC_5668;
-		break;
 	case 0x3:
 	default:
 		rt5665->id = CODEC_5665;
@@ -4963,7 +4960,6 @@ static void rt5665_i2c_shutdown(struct i2c_client *client)
 static const struct of_device_id rt5665_of_match[] = {
 	{.compatible = "realtek,rt5665"},
 	{.compatible = "realtek,rt5666"},
-	{.compatible = "realtek,rt5668"},
 	{},
 };
 MODULE_DEVICE_TABLE(of, rt5665_of_match);
@@ -4973,7 +4969,6 @@ MODULE_DEVICE_TABLE(of, rt5665_of_match);
 static const struct acpi_device_id rt5665_acpi_match[] = {
 	{"10EC5665", 0,},
 	{"10EC5666", 0,},
-	{"10EC5668", 0,},
 	{},
 };
 MODULE_DEVICE_TABLE(acpi, rt5665_acpi_match);
diff --git a/sound/soc/codecs/rt5665.h b/sound/soc/codecs/rt5665.h
index 5ddebd6..5abff0f 100644
--- a/sound/soc/codecs/rt5665.h
+++ b/sound/soc/codecs/rt5665.h
@@ -1978,7 +1978,6 @@ enum {
 enum {
 	CODEC_5665,
 	CODEC_5666,
-	CODEC_5668,
 };
 
 /* filter mask */
-- 
2.7.4
