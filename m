From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 3/5] ASoC: codecs: tas5086: add more register
	defines
Date: Mon, 24 Jun 2013 16:25:30 +0200
Message-ID: <1372083932-4318-3-git-send-email-zonque@gmail.com>
References: <1372083932-4318-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 77366265066
 for <alsa-devel@alsa-project.org>; Mon, 24 Jun 2013 16:25:31 +0200 (CEST)
In-Reply-To: <1372083932-4318-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: broonie@kernel.org, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Add register definitions for input and output mux registers, and rewrite
the tas5086_accessible_reg() function.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 sound/soc/codecs/tas5086.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/tas5086.c b/sound/soc/codecs/tas5086.c
index 833bccd..b2aea5d 100644
--- a/sound/soc/codecs/tas5086.c
+++ b/sound/soc/codecs/tas5086.c
@@ -83,6 +83,10 @@
 #define TAS5086_SPLIT_CAP_CHARGE	0x1a	/* Split cap charge period register */
 #define TAS5086_OSC_TRIM		0x1b	/* Oscillator trim register */
 #define TAS5086_BKNDERR 		0x1c
+#define TAS5086_INPUT_MUX		0x20
+#define TAS5086_PWM_OUTPUT_MUX		0x25
+
+#define TAS5086_MAX_REGISTER		TAS5086_PWM_OUTPUT_MUX
 
 /*
  * Default TAS5086 power-up configuration
@@ -124,6 +128,9 @@ static int tas5086_register_size(struct device *dev, unsigned int reg)
 	switch (reg) {
 	case TAS5086_DEV_ID ... TAS5086_BKNDERR:
 		return 1;
+	case TAS5086_INPUT_MUX:
+	case TAS5086_PWM_OUTPUT_MUX:
+		return 4;
 	}
 
 	dev_err(dev, "Unsupported register address: %d\n", reg);
@@ -132,7 +139,14 @@ static int tas5086_register_size(struct device *dev, unsigned int reg)
 
 static bool tas5086_accessible_reg(struct device *dev, unsigned int reg)
 {
-	return !((reg == 0x0f) || (reg >= 0x11 && reg <= 0x17));
+	switch (reg) {
+	case 0x0f:
+	case 0x11 ... 0x17:
+	case 0x1d ... 0x1f:
+		return false;
+	default:
+		return true;
+	}
 }
 
 static bool tas5086_volatile_reg(struct device *dev, unsigned int reg)
@@ -581,8 +595,8 @@ MODULE_DEVICE_TABLE(i2c, tas5086_i2c_id);
 
 static const struct regmap_config tas5086_regmap = {
 	.reg_bits		= 8,
-	.val_bits		= 8,
-	.max_register		= ARRAY_SIZE(tas5086_reg_defaults),
+	.val_bits		= 32,
+	.max_register		= TAS5086_MAX_REGISTER,
 	.reg_defaults		= tas5086_reg_defaults,
 	.num_reg_defaults	= ARRAY_SIZE(tas5086_reg_defaults),
 	.cache_type		= REGCACHE_RBTREE,
-- 
1.8.1.4
