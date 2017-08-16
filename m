From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH] ASoC: codecs: make snd_compr_ops const
Date: Wed, 16 Aug 2017 16:09:01 +0530
Message-ID: <1502879941-16010-1-git-send-email-bhumirks@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: julia.lawall@lip6.fr, brian.austin@cirrus.com, Paul.Handrigan@cirrus.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
List-Id: alsa-devel@alsa-project.org

Make these const as they are only stored in the compr_ops field of a
snd_soc_platform_driver structure, which is of type const.
Done using Coccinelle

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 sound/soc/codecs/cs47l24.c | 2 +-
 sound/soc/codecs/wm5102.c  | 2 +-
 sound/soc/codecs/wm5110.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/cs47l24.c b/sound/soc/codecs/cs47l24.c
index 505dbc9..e09fc8f 100644
--- a/sound/soc/codecs/cs47l24.c
+++ b/sound/soc/codecs/cs47l24.c
@@ -1203,7 +1203,7 @@ static struct regmap *cs47l24_get_regmap(struct device *dev)
 	},
 };
 
-static struct snd_compr_ops cs47l24_compr_ops = {
+static const struct snd_compr_ops cs47l24_compr_ops = {
 	.open = cs47l24_open,
 	.free = wm_adsp_compr_free,
 	.set_params = wm_adsp_compr_set_params,
diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index f500692..72486bf 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -2017,7 +2017,7 @@ static struct regmap *wm5102_get_regmap(struct device *dev)
 	},
 };
 
-static struct snd_compr_ops wm5102_compr_ops = {
+static const struct snd_compr_ops wm5102_compr_ops = {
 	.open = wm5102_open,
 	.free = wm_adsp_compr_free,
 	.set_params = wm_adsp_compr_set_params,
diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index d6fae139..858a24f 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -2372,7 +2372,7 @@ static struct regmap *wm5110_get_regmap(struct device *dev)
 	},
 };
 
-static struct snd_compr_ops wm5110_compr_ops = {
+static const struct snd_compr_ops wm5110_compr_ops = {
 	.open = wm5110_open,
 	.free = wm_adsp_compr_free,
 	.set_params = wm_adsp_compr_set_params,
-- 
1.9.1
