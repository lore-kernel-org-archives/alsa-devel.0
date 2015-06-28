From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH RFT] ASoC: ak4642: Fix up max_register setting
Date: Sun, 28 Jun 2015 10:46:51 +0800
Message-ID: <1435459611.15772.2.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f171.google.com (mail-pd0-f171.google.com
 [209.85.192.171])
 by alsa0.perex.cz (Postfix) with ESMTP id 3DC532605E1
 for <alsa-devel@alsa-project.org>; Sun, 28 Jun 2015 04:46:58 +0200 (CEST)
Received: by pdcu2 with SMTP id u2so96543688pdc.3
 for <alsa-devel@alsa-project.org>; Sat, 27 Jun 2015 19:46:57 -0700 (PDT)
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org

The max_register setting for ak4642, ak4643 and ak4648 are wrong, fix it.

According to the datasheet:
        the maximum valid register for ak4642 is 0x1f
        the maximum valid register for ak4643 is 0x24
        the maximum valid register for ak4648 is 0x27

The default settings for ak4642 and ak4643 are the same for 0x0 ~ 0x1f
registers, so it's fine to use the same reg_default table with different
num_reg_defaults setting.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
Hi,
I don't have this h/w to test.
I'd appreciate if someone can review and test this patch.
Thanks,
Axel
 sound/soc/codecs/ak4642.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/ak4642.c b/sound/soc/codecs/ak4642.c
index 7c0f6552..7f27345 100644
--- a/sound/soc/codecs/ak4642.c
+++ b/sound/soc/codecs/ak4642.c
@@ -64,12 +64,15 @@
 #define FIL1_0		0x1c
 #define FIL1_1		0x1d
 #define FIL1_2		0x1e
-#define FIL1_3		0x1f
+#define FIL1_3		0x1f	/* The maximum valid register for ak4642 */
 #define PW_MGMT4	0x20
 #define MD_CTL5		0x21
 #define LO_MS		0x22
 #define HP_MS		0x23
-#define SPK_MS		0x24
+#define SPK_MS		0x24	/* The maximum valid register for ak4643 */
+#define EQ_FBEQAB	0x25
+#define EQ_FBEQCD	0x26
+#define EQ_FBEQE	0x27	/* The maximum valid register for ak4648 */
 
 /* PW_MGMT1*/
 #define PMVCM		(1 << 6) /* VCOM Power Management */
@@ -535,17 +538,25 @@ static struct snd_soc_codec_driver soc_codec_dev_ak4642 = {
 static const struct regmap_config ak4642_regmap = {
 	.reg_bits		= 8,
 	.val_bits		= 8,
-	.max_register		= ARRAY_SIZE(ak4642_reg) + 1,
+	.max_register		= FIL1_3,
 	.reg_defaults		= ak4642_reg,
-	.num_reg_defaults	= ARRAY_SIZE(ak4642_reg),
+	.num_reg_defaults	= FIL1_3 + 1,
+};
+
+static const struct regmap_config ak4643_regmap = {
+	.reg_bits		= 8,
+	.val_bits		= 8,
+	.max_register		= SPK_MS,
+	.reg_defaults		= ak4642_reg,
+	.num_reg_defaults	= SPK_MS + 1,
 };
 
 static const struct regmap_config ak4648_regmap = {
 	.reg_bits		= 8,
 	.val_bits		= 8,
-	.max_register		= ARRAY_SIZE(ak4648_reg) + 1,
+	.max_register		= EQ_FBEQE,
 	.reg_defaults		= ak4648_reg,
-	.num_reg_defaults	= ARRAY_SIZE(ak4648_reg),
+	.num_reg_defaults	= EQ_FBEQE + 1,
 };
 
 static const struct ak4642_drvdata ak4642_drvdata = {
@@ -553,7 +564,7 @@ static const struct ak4642_drvdata ak4642_drvdata = {
 };
 
 static const struct ak4642_drvdata ak4643_drvdata = {
-	.regmap_config = &ak4642_regmap,
+	.regmap_config = &ak4643_regmap,
 };
 
 static const struct ak4642_drvdata ak4648_drvdata = {
-- 
2.1.0
