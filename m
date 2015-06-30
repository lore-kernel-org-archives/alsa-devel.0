From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH v2] ASoC: ak4642: Fix up max_register setting
Date: Wed, 01 Jul 2015 00:56:36 +0800
Message-ID: <1435683396.19591.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f52.google.com (mail-pa0-f52.google.com
 [209.85.220.52])
 by alsa0.perex.cz (Postfix) with ESMTP id C93572604D6
 for <alsa-devel@alsa-project.org>; Tue, 30 Jun 2015 18:56:42 +0200 (CEST)
Received: by pabvl15 with SMTP id vl15so8244071pab.1
 for <alsa-devel@alsa-project.org>; Tue, 30 Jun 2015 09:56:42 -0700 (PDT)
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
registers, so it's fine to use the same reg_default table with differnt
num_reg_defaults setting.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
v2:
Improve readability by using below defines (with comment).
 #define ak4642_reg ak4643_reg
 #define NUM_AK4642_REG_DEFAULTS        (FIL1_3 + 1)

 sound/soc/codecs/ak4642.c | 33 ++++++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/ak4642.c b/sound/soc/codecs/ak4642.c
index 7c0f6552..fe963e1 100644
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
@@ -241,7 +244,7 @@ static const struct snd_soc_dapm_route ak4642_intercon[] = {
 /*
  * ak4642 register cache
  */
-static const struct reg_default ak4642_reg[] = {
+static const struct reg_default ak4643_reg[] = {
 	{  0, 0x00 }, {  1, 0x00 }, {  2, 0x01 }, {  3, 0x00 },
 	{  4, 0x02 }, {  5, 0x00 }, {  6, 0x00 }, {  7, 0x00 },
 	{  8, 0xe1 }, {  9, 0xe1 }, { 10, 0x18 }, { 11, 0x00 },
@@ -254,6 +257,14 @@ static const struct reg_default ak4642_reg[] = {
 	{ 36, 0x00 },
 };
 
+/* The default settings for 0x0 ~ 0x1f registers are the same for ak4642
+   and ak4643. So we reuse the ak4643 reg_default for ak4642.
+   The valid registers for ak4642 are 0x0 ~ 0x1f which is a subset of ak4643,
+   so define NUM_AK4642_REG_DEFAULTS for ak4642.
+*/
+#define ak4642_reg ak4643_reg
+#define NUM_AK4642_REG_DEFAULTS	(FIL1_3 + 1)
+
 static const struct reg_default ak4648_reg[] = {
 	{  0, 0x00 }, {  1, 0x00 }, {  2, 0x01 }, {  3, 0x00 },
 	{  4, 0x02 }, {  5, 0x00 }, {  6, 0x00 }, {  7, 0x00 },
@@ -535,15 +546,23 @@ static struct snd_soc_codec_driver soc_codec_dev_ak4642 = {
 static const struct regmap_config ak4642_regmap = {
 	.reg_bits		= 8,
 	.val_bits		= 8,
-	.max_register		= ARRAY_SIZE(ak4642_reg) + 1,
+	.max_register		= FIL1_3,
 	.reg_defaults		= ak4642_reg,
-	.num_reg_defaults	= ARRAY_SIZE(ak4642_reg),
+	.num_reg_defaults	= NUM_AK4642_REG_DEFAULTS,
+};
+
+static const struct regmap_config ak4643_regmap = {
+	.reg_bits		= 8,
+	.val_bits		= 8,
+	.max_register		= SPK_MS,
+	.reg_defaults		= ak4643_reg,
+	.num_reg_defaults	= ARRAY_SIZE(ak4643_reg),
 };
 
 static const struct regmap_config ak4648_regmap = {
 	.reg_bits		= 8,
 	.val_bits		= 8,
-	.max_register		= ARRAY_SIZE(ak4648_reg) + 1,
+	.max_register		= EQ_FBEQE,
 	.reg_defaults		= ak4648_reg,
 	.num_reg_defaults	= ARRAY_SIZE(ak4648_reg),
 };
@@ -553,7 +572,7 @@ static const struct ak4642_drvdata ak4642_drvdata = {
 };
 
 static const struct ak4642_drvdata ak4643_drvdata = {
-	.regmap_config = &ak4642_regmap,
+	.regmap_config = &ak4643_regmap,
 };
 
 static const struct ak4642_drvdata ak4648_drvdata = {
-- 
2.1.0
