From: Vladimir Zapolskiy <vz@mleia.com>
Subject: [PATCH 3/7] ASoC: wm8903: generalize GPIO control
	register bits
Date: Tue,  2 Jun 2015 02:09:14 +0300
Message-ID: <1433200158-6890-3-git-send-email-vz@mleia.com>
References: <1433200031-6748-1-git-send-email-vz@mleia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.mleia.com (li271-223.members.linode.com [178.79.152.223])
 by alsa0.perex.cz (Postfix) with ESMTP id 5AA44260429
 for <alsa-devel@alsa-project.org>; Tue,  2 Jun 2015 01:09:30 +0200 (CEST)
In-Reply-To: <1433200031-6748-1-git-send-email-vz@mleia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <acourbot@nvidia.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Axel Lin <axel.lin@ingics.com>, Takashi Iwai <tiwai@suse.de>, patches@opensource.wolfsonmicro.com, linux-gpio@vger.kernel.org, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

All GPIO1/2/3/4/5 control registers have the same bit map, but in
implementation of gpiolib callbacks WM8903_GPn_*, WM8903_GP1_* and
WM8903_GP2_* macro are mixed up. Replace particular GPIOn control
register bit definitions with generic ones and save ~150 LoCs.

No functional change.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Axel Lin <axel.lin@ingics.com>
Cc: patches@opensource.wolfsonmicro.com
---
 include/sound/wm8903.h    | 222 ++++++++--------------------------------------
 sound/soc/codecs/wm8903.c |  22 ++---
 2 files changed, 46 insertions(+), 198 deletions(-)

diff --git a/include/sound/wm8903.h b/include/sound/wm8903.h
index b310c5a..ac2e252 100644
--- a/include/sound/wm8903.h
+++ b/include/sound/wm8903.h
@@ -52,198 +52,46 @@
 
 /*
  * R116 (0x74) - GPIO Control 1
- */
-#define WM8903_GP1_FN_MASK                      0x1F00  /* GP1_FN - [12:8] */
-#define WM8903_GP1_FN_SHIFT                          8  /* GP1_FN - [12:8] */
-#define WM8903_GP1_FN_WIDTH                          5  /* GP1_FN - [12:8] */
-#define WM8903_GP1_DIR                          0x0080  /* GP1_DIR */
-#define WM8903_GP1_DIR_MASK                     0x0080  /* GP1_DIR */
-#define WM8903_GP1_DIR_SHIFT                         7  /* GP1_DIR */
-#define WM8903_GP1_DIR_WIDTH                         1  /* GP1_DIR */
-#define WM8903_GP1_OP_CFG                       0x0040  /* GP1_OP_CFG */
-#define WM8903_GP1_OP_CFG_MASK                  0x0040  /* GP1_OP_CFG */
-#define WM8903_GP1_OP_CFG_SHIFT                      6  /* GP1_OP_CFG */
-#define WM8903_GP1_OP_CFG_WIDTH                      1  /* GP1_OP_CFG */
-#define WM8903_GP1_IP_CFG                       0x0020  /* GP1_IP_CFG */
-#define WM8903_GP1_IP_CFG_MASK                  0x0020  /* GP1_IP_CFG */
-#define WM8903_GP1_IP_CFG_SHIFT                      5  /* GP1_IP_CFG */
-#define WM8903_GP1_IP_CFG_WIDTH                      1  /* GP1_IP_CFG */
-#define WM8903_GP1_LVL                          0x0010  /* GP1_LVL */
-#define WM8903_GP1_LVL_MASK                     0x0010  /* GP1_LVL */
-#define WM8903_GP1_LVL_SHIFT                         4  /* GP1_LVL */
-#define WM8903_GP1_LVL_WIDTH                         1  /* GP1_LVL */
-#define WM8903_GP1_PD                           0x0008  /* GP1_PD */
-#define WM8903_GP1_PD_MASK                      0x0008  /* GP1_PD */
-#define WM8903_GP1_PD_SHIFT                          3  /* GP1_PD */
-#define WM8903_GP1_PD_WIDTH                          1  /* GP1_PD */
-#define WM8903_GP1_PU                           0x0004  /* GP1_PU */
-#define WM8903_GP1_PU_MASK                      0x0004  /* GP1_PU */
-#define WM8903_GP1_PU_SHIFT                          2  /* GP1_PU */
-#define WM8903_GP1_PU_WIDTH                          1  /* GP1_PU */
-#define WM8903_GP1_INTMODE                      0x0002  /* GP1_INTMODE */
-#define WM8903_GP1_INTMODE_MASK                 0x0002  /* GP1_INTMODE */
-#define WM8903_GP1_INTMODE_SHIFT                     1  /* GP1_INTMODE */
-#define WM8903_GP1_INTMODE_WIDTH                     1  /* GP1_INTMODE */
-#define WM8903_GP1_DB                           0x0001  /* GP1_DB */
-#define WM8903_GP1_DB_MASK                      0x0001  /* GP1_DB */
-#define WM8903_GP1_DB_SHIFT                          0  /* GP1_DB */
-#define WM8903_GP1_DB_WIDTH                          1  /* GP1_DB */
-
-/*
  * R117 (0x75) - GPIO Control 2
- */
-#define WM8903_GP2_FN_MASK                      0x1F00  /* GP2_FN - [12:8] */
-#define WM8903_GP2_FN_SHIFT                          8  /* GP2_FN - [12:8] */
-#define WM8903_GP2_FN_WIDTH                          5  /* GP2_FN - [12:8] */
-#define WM8903_GP2_DIR                          0x0080  /* GP2_DIR */
-#define WM8903_GP2_DIR_MASK                     0x0080  /* GP2_DIR */
-#define WM8903_GP2_DIR_SHIFT                         7  /* GP2_DIR */
-#define WM8903_GP2_DIR_WIDTH                         1  /* GP2_DIR */
-#define WM8903_GP2_OP_CFG                       0x0040  /* GP2_OP_CFG */
-#define WM8903_GP2_OP_CFG_MASK                  0x0040  /* GP2_OP_CFG */
-#define WM8903_GP2_OP_CFG_SHIFT                      6  /* GP2_OP_CFG */
-#define WM8903_GP2_OP_CFG_WIDTH                      1  /* GP2_OP_CFG */
-#define WM8903_GP2_IP_CFG                       0x0020  /* GP2_IP_CFG */
-#define WM8903_GP2_IP_CFG_MASK                  0x0020  /* GP2_IP_CFG */
-#define WM8903_GP2_IP_CFG_SHIFT                      5  /* GP2_IP_CFG */
-#define WM8903_GP2_IP_CFG_WIDTH                      1  /* GP2_IP_CFG */
-#define WM8903_GP2_LVL                          0x0010  /* GP2_LVL */
-#define WM8903_GP2_LVL_MASK                     0x0010  /* GP2_LVL */
-#define WM8903_GP2_LVL_SHIFT                         4  /* GP2_LVL */
-#define WM8903_GP2_LVL_WIDTH                         1  /* GP2_LVL */
-#define WM8903_GP2_PD                           0x0008  /* GP2_PD */
-#define WM8903_GP2_PD_MASK                      0x0008  /* GP2_PD */
-#define WM8903_GP2_PD_SHIFT                          3  /* GP2_PD */
-#define WM8903_GP2_PD_WIDTH                          1  /* GP2_PD */
-#define WM8903_GP2_PU                           0x0004  /* GP2_PU */
-#define WM8903_GP2_PU_MASK                      0x0004  /* GP2_PU */
-#define WM8903_GP2_PU_SHIFT                          2  /* GP2_PU */
-#define WM8903_GP2_PU_WIDTH                          1  /* GP2_PU */
-#define WM8903_GP2_INTMODE                      0x0002  /* GP2_INTMODE */
-#define WM8903_GP2_INTMODE_MASK                 0x0002  /* GP2_INTMODE */
-#define WM8903_GP2_INTMODE_SHIFT                     1  /* GP2_INTMODE */
-#define WM8903_GP2_INTMODE_WIDTH                     1  /* GP2_INTMODE */
-#define WM8903_GP2_DB                           0x0001  /* GP2_DB */
-#define WM8903_GP2_DB_MASK                      0x0001  /* GP2_DB */
-#define WM8903_GP2_DB_SHIFT                          0  /* GP2_DB */
-#define WM8903_GP2_DB_WIDTH                          1  /* GP2_DB */
-
-/*
  * R118 (0x76) - GPIO Control 3
- */
-#define WM8903_GP3_FN_MASK                      0x1F00  /* GP3_FN - [12:8] */
-#define WM8903_GP3_FN_SHIFT                          8  /* GP3_FN - [12:8] */
-#define WM8903_GP3_FN_WIDTH                          5  /* GP3_FN - [12:8] */
-#define WM8903_GP3_DIR                          0x0080  /* GP3_DIR */
-#define WM8903_GP3_DIR_MASK                     0x0080  /* GP3_DIR */
-#define WM8903_GP3_DIR_SHIFT                         7  /* GP3_DIR */
-#define WM8903_GP3_DIR_WIDTH                         1  /* GP3_DIR */
-#define WM8903_GP3_OP_CFG                       0x0040  /* GP3_OP_CFG */
-#define WM8903_GP3_OP_CFG_MASK                  0x0040  /* GP3_OP_CFG */
-#define WM8903_GP3_OP_CFG_SHIFT                      6  /* GP3_OP_CFG */
-#define WM8903_GP3_OP_CFG_WIDTH                      1  /* GP3_OP_CFG */
-#define WM8903_GP3_IP_CFG                       0x0020  /* GP3_IP_CFG */
-#define WM8903_GP3_IP_CFG_MASK                  0x0020  /* GP3_IP_CFG */
-#define WM8903_GP3_IP_CFG_SHIFT                      5  /* GP3_IP_CFG */
-#define WM8903_GP3_IP_CFG_WIDTH                      1  /* GP3_IP_CFG */
-#define WM8903_GP3_LVL                          0x0010  /* GP3_LVL */
-#define WM8903_GP3_LVL_MASK                     0x0010  /* GP3_LVL */
-#define WM8903_GP3_LVL_SHIFT                         4  /* GP3_LVL */
-#define WM8903_GP3_LVL_WIDTH                         1  /* GP3_LVL */
-#define WM8903_GP3_PD                           0x0008  /* GP3_PD */
-#define WM8903_GP3_PD_MASK                      0x0008  /* GP3_PD */
-#define WM8903_GP3_PD_SHIFT                          3  /* GP3_PD */
-#define WM8903_GP3_PD_WIDTH                          1  /* GP3_PD */
-#define WM8903_GP3_PU                           0x0004  /* GP3_PU */
-#define WM8903_GP3_PU_MASK                      0x0004  /* GP3_PU */
-#define WM8903_GP3_PU_SHIFT                          2  /* GP3_PU */
-#define WM8903_GP3_PU_WIDTH                          1  /* GP3_PU */
-#define WM8903_GP3_INTMODE                      0x0002  /* GP3_INTMODE */
-#define WM8903_GP3_INTMODE_MASK                 0x0002  /* GP3_INTMODE */
-#define WM8903_GP3_INTMODE_SHIFT                     1  /* GP3_INTMODE */
-#define WM8903_GP3_INTMODE_WIDTH                     1  /* GP3_INTMODE */
-#define WM8903_GP3_DB                           0x0001  /* GP3_DB */
-#define WM8903_GP3_DB_MASK                      0x0001  /* GP3_DB */
-#define WM8903_GP3_DB_SHIFT                          0  /* GP3_DB */
-#define WM8903_GP3_DB_WIDTH                          1  /* GP3_DB */
-
-/*
  * R119 (0x77) - GPIO Control 4
- */
-#define WM8903_GP4_FN_MASK                      0x1F00  /* GP4_FN - [12:8] */
-#define WM8903_GP4_FN_SHIFT                          8  /* GP4_FN - [12:8] */
-#define WM8903_GP4_FN_WIDTH                          5  /* GP4_FN - [12:8] */
-#define WM8903_GP4_DIR                          0x0080  /* GP4_DIR */
-#define WM8903_GP4_DIR_MASK                     0x0080  /* GP4_DIR */
-#define WM8903_GP4_DIR_SHIFT                         7  /* GP4_DIR */
-#define WM8903_GP4_DIR_WIDTH                         1  /* GP4_DIR */
-#define WM8903_GP4_OP_CFG                       0x0040  /* GP4_OP_CFG */
-#define WM8903_GP4_OP_CFG_MASK                  0x0040  /* GP4_OP_CFG */
-#define WM8903_GP4_OP_CFG_SHIFT                      6  /* GP4_OP_CFG */
-#define WM8903_GP4_OP_CFG_WIDTH                      1  /* GP4_OP_CFG */
-#define WM8903_GP4_IP_CFG                       0x0020  /* GP4_IP_CFG */
-#define WM8903_GP4_IP_CFG_MASK                  0x0020  /* GP4_IP_CFG */
-#define WM8903_GP4_IP_CFG_SHIFT                      5  /* GP4_IP_CFG */
-#define WM8903_GP4_IP_CFG_WIDTH                      1  /* GP4_IP_CFG */
-#define WM8903_GP4_LVL                          0x0010  /* GP4_LVL */
-#define WM8903_GP4_LVL_MASK                     0x0010  /* GP4_LVL */
-#define WM8903_GP4_LVL_SHIFT                         4  /* GP4_LVL */
-#define WM8903_GP4_LVL_WIDTH                         1  /* GP4_LVL */
-#define WM8903_GP4_PD                           0x0008  /* GP4_PD */
-#define WM8903_GP4_PD_MASK                      0x0008  /* GP4_PD */
-#define WM8903_GP4_PD_SHIFT                          3  /* GP4_PD */
-#define WM8903_GP4_PD_WIDTH                          1  /* GP4_PD */
-#define WM8903_GP4_PU                           0x0004  /* GP4_PU */
-#define WM8903_GP4_PU_MASK                      0x0004  /* GP4_PU */
-#define WM8903_GP4_PU_SHIFT                          2  /* GP4_PU */
-#define WM8903_GP4_PU_WIDTH                          1  /* GP4_PU */
-#define WM8903_GP4_INTMODE                      0x0002  /* GP4_INTMODE */
-#define WM8903_GP4_INTMODE_MASK                 0x0002  /* GP4_INTMODE */
-#define WM8903_GP4_INTMODE_SHIFT                     1  /* GP4_INTMODE */
-#define WM8903_GP4_INTMODE_WIDTH                     1  /* GP4_INTMODE */
-#define WM8903_GP4_DB                           0x0001  /* GP4_DB */
-#define WM8903_GP4_DB_MASK                      0x0001  /* GP4_DB */
-#define WM8903_GP4_DB_SHIFT                          0  /* GP4_DB */
-#define WM8903_GP4_DB_WIDTH                          1  /* GP4_DB */
-
-/*
  * R120 (0x78) - GPIO Control 5
  */
-#define WM8903_GP5_FN_MASK                      0x1F00  /* GP5_FN - [12:8] */
-#define WM8903_GP5_FN_SHIFT                          8  /* GP5_FN - [12:8] */
-#define WM8903_GP5_FN_WIDTH                          5  /* GP5_FN - [12:8] */
-#define WM8903_GP5_DIR                          0x0080  /* GP5_DIR */
-#define WM8903_GP5_DIR_MASK                     0x0080  /* GP5_DIR */
-#define WM8903_GP5_DIR_SHIFT                         7  /* GP5_DIR */
-#define WM8903_GP5_DIR_WIDTH                         1  /* GP5_DIR */
-#define WM8903_GP5_OP_CFG                       0x0040  /* GP5_OP_CFG */
-#define WM8903_GP5_OP_CFG_MASK                  0x0040  /* GP5_OP_CFG */
-#define WM8903_GP5_OP_CFG_SHIFT                      6  /* GP5_OP_CFG */
-#define WM8903_GP5_OP_CFG_WIDTH                      1  /* GP5_OP_CFG */
-#define WM8903_GP5_IP_CFG                       0x0020  /* GP5_IP_CFG */
-#define WM8903_GP5_IP_CFG_MASK                  0x0020  /* GP5_IP_CFG */
-#define WM8903_GP5_IP_CFG_SHIFT                      5  /* GP5_IP_CFG */
-#define WM8903_GP5_IP_CFG_WIDTH                      1  /* GP5_IP_CFG */
-#define WM8903_GP5_LVL                          0x0010  /* GP5_LVL */
-#define WM8903_GP5_LVL_MASK                     0x0010  /* GP5_LVL */
-#define WM8903_GP5_LVL_SHIFT                         4  /* GP5_LVL */
-#define WM8903_GP5_LVL_WIDTH                         1  /* GP5_LVL */
-#define WM8903_GP5_PD                           0x0008  /* GP5_PD */
-#define WM8903_GP5_PD_MASK                      0x0008  /* GP5_PD */
-#define WM8903_GP5_PD_SHIFT                          3  /* GP5_PD */
-#define WM8903_GP5_PD_WIDTH                          1  /* GP5_PD */
-#define WM8903_GP5_PU                           0x0004  /* GP5_PU */
-#define WM8903_GP5_PU_MASK                      0x0004  /* GP5_PU */
-#define WM8903_GP5_PU_SHIFT                          2  /* GP5_PU */
-#define WM8903_GP5_PU_WIDTH                          1  /* GP5_PU */
-#define WM8903_GP5_INTMODE                      0x0002  /* GP5_INTMODE */
-#define WM8903_GP5_INTMODE_MASK                 0x0002  /* GP5_INTMODE */
-#define WM8903_GP5_INTMODE_SHIFT                     1  /* GP5_INTMODE */
-#define WM8903_GP5_INTMODE_WIDTH                     1  /* GP5_INTMODE */
-#define WM8903_GP5_DB                           0x0001  /* GP5_DB */
-#define WM8903_GP5_DB_MASK                      0x0001  /* GP5_DB */
-#define WM8903_GP5_DB_SHIFT                          0  /* GP5_DB */
-#define WM8903_GP5_DB_WIDTH                          1  /* GP5_DB */
+#define WM8903_GPn_FN_MASK                      0x1F00  /* GPn_FN - [12:8] */
+#define WM8903_GPn_FN_SHIFT                          8  /* GPn_FN - [12:8] */
+#define WM8903_GPn_FN_WIDTH                          5  /* GPn_FN - [12:8] */
+#define WM8903_GPn_DIR                          0x0080  /* GPn_DIR */
+#define WM8903_GPn_DIR_MASK                     0x0080  /* GPn_DIR */
+#define WM8903_GPn_DIR_SHIFT                         7  /* GPn_DIR */
+#define WM8903_GPn_DIR_WIDTH                         1  /* GPn_DIR */
+#define WM8903_GPn_OP_CFG                       0x0040  /* GPn_OP_CFG */
+#define WM8903_GPn_OP_CFG_MASK                  0x0040  /* GPn_OP_CFG */
+#define WM8903_GPn_OP_CFG_SHIFT                      6  /* GPn_OP_CFG */
+#define WM8903_GPn_OP_CFG_WIDTH                      1  /* GPn_OP_CFG */
+#define WM8903_GPn_IP_CFG                       0x0020  /* GPn_IP_CFG */
+#define WM8903_GPn_IP_CFG_MASK                  0x0020  /* GPn_IP_CFG */
+#define WM8903_GPn_IP_CFG_SHIFT                      5  /* GPn_IP_CFG */
+#define WM8903_GPn_IP_CFG_WIDTH                      1  /* GPn_IP_CFG */
+#define WM8903_GPn_LVL                          0x0010  /* GPn_LVL */
+#define WM8903_GPn_LVL_MASK                     0x0010  /* GPn_LVL */
+#define WM8903_GPn_LVL_SHIFT                         4  /* GPn_LVL */
+#define WM8903_GPn_LVL_WIDTH                         1  /* GPn_LVL */
+#define WM8903_GPn_PD                           0x0008  /* GPn_PD */
+#define WM8903_GPn_PD_MASK                      0x0008  /* GPn_PD */
+#define WM8903_GPn_PD_SHIFT                          3  /* GPn_PD */
+#define WM8903_GPn_PD_WIDTH                          1  /* GPn_PD */
+#define WM8903_GPn_PU                           0x0004  /* GPn_PU */
+#define WM8903_GPn_PU_MASK                      0x0004  /* GPn_PU */
+#define WM8903_GPn_PU_SHIFT                          2  /* GPn_PU */
+#define WM8903_GPn_PU_WIDTH                          1  /* GPn_PU */
+#define WM8903_GPn_INTMODE                      0x0002  /* GPn_INTMODE */
+#define WM8903_GPn_INTMODE_MASK                 0x0002  /* GPn_INTMODE */
+#define WM8903_GPn_INTMODE_SHIFT                     1  /* GPn_INTMODE */
+#define WM8903_GPn_INTMODE_WIDTH                     1  /* GPn_INTMODE */
+#define WM8903_GPn_DB                           0x0001  /* GPn_DB */
+#define WM8903_GPn_DB_MASK                      0x0001  /* GPn_DB */
+#define WM8903_GPn_DB_SHIFT                          0  /* GPn_DB */
+#define WM8903_GPn_DB_WIDTH                          1  /* GPn_DB */
 
 #define WM8903_NUM_GPIO 5
 
diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index b5322c1..93f1ce0 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -1785,9 +1785,9 @@ static int wm8903_gpio_direction_in(struct gpio_chip *chip, unsigned offset)
 	unsigned int mask, val;
 	int ret;
 
-	mask = WM8903_GP1_FN_MASK | WM8903_GP1_DIR_MASK;
-	val = (WM8903_GPn_FN_GPIO_INPUT << WM8903_GP1_FN_SHIFT) |
-		WM8903_GP1_DIR;
+	mask = WM8903_GPn_FN_MASK | WM8903_GPn_DIR_MASK;
+	val = (WM8903_GPn_FN_GPIO_INPUT << WM8903_GPn_FN_SHIFT) |
+		WM8903_GPn_DIR;
 
 	ret = regmap_update_bits(wm8903->regmap,
 				 WM8903_GPIO_CONTROL_1 + offset, mask, val);
@@ -1804,7 +1804,7 @@ static int wm8903_gpio_get(struct gpio_chip *chip, unsigned offset)
 
 	regmap_read(wm8903->regmap, WM8903_GPIO_CONTROL_1 + offset, &reg);
 
-	return (reg & WM8903_GP1_LVL_MASK) >> WM8903_GP1_LVL_SHIFT;
+	return (reg & WM8903_GPn_LVL_MASK) >> WM8903_GPn_LVL_SHIFT;
 }
 
 static int wm8903_gpio_direction_out(struct gpio_chip *chip,
@@ -1814,9 +1814,9 @@ static int wm8903_gpio_direction_out(struct gpio_chip *chip,
 	unsigned int mask, val;
 	int ret;
 
-	mask = WM8903_GP1_FN_MASK | WM8903_GP1_DIR_MASK | WM8903_GP1_LVL_MASK;
-	val = (WM8903_GPn_FN_GPIO_OUTPUT << WM8903_GP1_FN_SHIFT) |
-		(value << WM8903_GP2_LVL_SHIFT);
+	mask = WM8903_GPn_FN_MASK | WM8903_GPn_DIR_MASK | WM8903_GPn_LVL_MASK;
+	val = (WM8903_GPn_FN_GPIO_OUTPUT << WM8903_GPn_FN_SHIFT) |
+		(value << WM8903_GPn_LVL_SHIFT);
 
 	ret = regmap_update_bits(wm8903->regmap,
 				 WM8903_GPIO_CONTROL_1 + offset, mask, val);
@@ -1831,8 +1831,8 @@ static void wm8903_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 	struct wm8903_priv *wm8903 = gpio_to_wm8903(chip);
 
 	regmap_update_bits(wm8903->regmap, WM8903_GPIO_CONTROL_1 + offset,
-			   WM8903_GP1_LVL_MASK,
-			   !!value << WM8903_GP1_LVL_SHIFT);
+			   WM8903_GPn_LVL_MASK,
+			   !!value << WM8903_GPn_LVL_SHIFT);
 }
 
 static struct gpio_chip wm8903_template_chip = {
@@ -2066,8 +2066,8 @@ static int wm8903_i2c_probe(struct i2c_client *i2c,
 		regmap_write(wm8903->regmap, WM8903_GPIO_CONTROL_1 + i,
 				pdata->gpio_cfg[i] & 0x7fff);
 
-		val = (pdata->gpio_cfg[i] & WM8903_GP1_FN_MASK)
-			>> WM8903_GP1_FN_SHIFT;
+		val = (pdata->gpio_cfg[i] & WM8903_GPn_FN_MASK)
+			>> WM8903_GPn_FN_SHIFT;
 
 		switch (val) {
 		case WM8903_GPn_FN_MICBIAS_CURRENT_DETECT:
-- 
2.1.4
