From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: Disable regmap helpers if regmap is
	disabled
Date: Tue, 25 Nov 2014 21:41:03 +0100
Message-ID: <1416948063-1692-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-210.synserver.de (smtp-out-210.synserver.de
 [212.40.185.210])
 by alsa0.perex.cz (Postfix) with ESMTP id A21352605A8
 for <alsa-devel@alsa-project.org>; Tue, 25 Nov 2014 21:41:06 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Olof Johansson <olof@lixom.net>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

If regmap is disabled there will be no users of the ASoC regmap helpers.
Furthermore regmap_exit() will no be defined causing the following compile
error:
	sound/soc/soc-core.c: In function 'snd_soc_component_exit_regmap':
	sound/soc/soc-core.c:2645:2: error: implicit declaration of function
		'regmap_exit' [-Werror=implicit-function-declaration]

So disable the helpers if regmap is disabled.

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Fixes: 20feb881988c ASoC: Add helper functions for deferred regmap setup")
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc.h  | 4 ++++
 sound/soc/soc-core.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 879e2b3..4cef90cc 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1283,6 +1283,8 @@ void snd_soc_component_async_complete(struct snd_soc_component *component);
 int snd_soc_component_test_bits(struct snd_soc_component *component,
 	unsigned int reg, unsigned int mask, unsigned int value);
 
+#ifdef CONFIG_REGMAP
+
 void snd_soc_component_init_regmap(struct snd_soc_component *component,
 	struct regmap *regmap);
 void snd_soc_component_exit_regmap(struct snd_soc_component *component);
@@ -1318,6 +1320,8 @@ static inline void snd_soc_codec_exit_regmap(struct snd_soc_codec *codec)
 	snd_soc_component_exit_regmap(&codec->component);
 }
 
+#endif
+
 /* device driver data */
 
 static inline void snd_soc_card_set_drvdata(struct snd_soc_card *card,
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index cc52ea1..7904eda 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2612,6 +2612,8 @@ static void snd_soc_component_setup_regmap(struct snd_soc_component *component)
 		component->val_bytes = val_bytes;
 }
 
+#ifdef CONFIG_REGMAP
+
 /**
  * snd_soc_component_init_regmap() - Initialize regmap instance for the component
  * @component: The component for which to initialize the regmap instance
@@ -2647,6 +2649,8 @@ void snd_soc_component_exit_regmap(struct snd_soc_component *component)
 }
 EXPORT_SYMBOL_GPL(snd_soc_component_exit_regmap);
 
+#endif
+
 static void snd_soc_component_add_unlocked(struct snd_soc_component *component)
 {
 	if (!component->write && !component->read) {
-- 
1.8.0
