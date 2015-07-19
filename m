From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 1/2] ASoC: cs4349: Set .writeable_reg for
	cs4349_regmap
Date: Sun, 19 Jul 2015 09:14:23 +0800
Message-ID: <1437268463.11309.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f41.google.com (mail-pa0-f41.google.com
 [209.85.220.41])
 by alsa0.perex.cz (Postfix) with ESMTP id E66B9260504
 for <alsa-devel@alsa-project.org>; Sun, 19 Jul 2015 03:14:30 +0200 (CEST)
Received: by padck2 with SMTP id ck2so81122245pad.0
 for <alsa-devel@alsa-project.org>; Sat, 18 Jul 2015 18:14:29 -0700 (PDT)
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
Cc: Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Tim Howe <tim.howe@cirrus.com>
List-Id: alsa-devel@alsa-project.org

The first valid register index is 1 rather than 0, and the CS4349_CHIPID
is readonly. So set .writeable_reg to avoid writing to these registers.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/cs4349.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/cs4349.c b/sound/soc/codecs/cs4349.c
index f4fccc6..eb55889 100644
--- a/sound/soc/codecs/cs4349.c
+++ b/sound/soc/codecs/cs4349.c
@@ -54,14 +54,17 @@ struct  cs4349_private {
 static bool cs4349_readable_register(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
-	case CS4349_CHIPID:
-	case CS4349_MODE:
-	case CS4349_VMI:
-	case CS4349_MUTE:
-	case CS4349_VOLA:
-	case CS4349_VOLB:
-	case CS4349_RMPFLT:
-	case CS4349_MISC:
+	case CS4349_CHIPID ... CS4349_MISC:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool cs4349_writeable_register(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case CS4349_MODE ...  CS4349_MISC:
 		return true;
 	default:
 		return false;
@@ -272,6 +275,7 @@ static const struct regmap_config cs4349_regmap = {
 	.reg_defaults		= cs4349_reg_defaults,
 	.num_reg_defaults	= ARRAY_SIZE(cs4349_reg_defaults),
 	.readable_reg		= cs4349_readable_register,
+	.writeable_reg		= cs4349_writeable_register,
 	.cache_type		= REGCACHE_RBTREE,
 };
 
-- 
2.1.0
