From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: ak4642: Enable cache usage to fix crashes on resume
Date: Wed, 18 May 2016 18:49:22 +0100
Message-ID: <1463593762-31871-1-git-send-email-broonie@kernel.org>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The ak4642 driver is using a regmap cache sync to restore the
configuration of the chip on resume but (as Peter observed) does not
actually define a register cache which means that the resume is never
going to work and we trigger asserts in regmap.  Fix this by enabling
caching.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Reported-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 sound/soc/codecs/ak4642.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/ak4642.c b/sound/soc/codecs/ak4642.c
index 1ee8506c06c7..4d8b9e49e8d6 100644
--- a/sound/soc/codecs/ak4642.c
+++ b/sound/soc/codecs/ak4642.c
@@ -560,6 +560,7 @@ static const struct regmap_config ak4642_regmap = {
 	.max_register		= FIL1_3,
 	.reg_defaults		= ak4642_reg,
 	.num_reg_defaults	= NUM_AK4642_REG_DEFAULTS,
+	.cache_type		= REGCACHE_RBTREE,
 };
 
 static const struct regmap_config ak4643_regmap = {
@@ -568,6 +569,7 @@ static const struct regmap_config ak4643_regmap = {
 	.max_register		= SPK_MS,
 	.reg_defaults		= ak4643_reg,
 	.num_reg_defaults	= ARRAY_SIZE(ak4643_reg),
+	.cache_type		= REGCACHE_RBTREE,
 };
 
 static const struct regmap_config ak4648_regmap = {
@@ -576,6 +578,7 @@ static const struct regmap_config ak4648_regmap = {
 	.max_register		= EQ_FBEQE,
 	.reg_defaults		= ak4648_reg,
 	.num_reg_defaults	= ARRAY_SIZE(ak4648_reg),
+	.cache_type		= REGCACHE_RBTREE,
 };
 
 static const struct ak4642_drvdata ak4642_drvdata = {
-- 
2.8.1
