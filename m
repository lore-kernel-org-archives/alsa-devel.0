From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ASoC: cs35l33: mark PM functions as __maybe_unused
Date: Wed, 29 Jun 2016 16:33:17 +0200
Message-ID: <20160629143416.45214-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Brian Austin <brian.austin@cirrus.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Liam Girdwood <lgirdwood@gmail.com>, Axel Lin <axel.lin@ingics.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The newly added cs35l33 driver produces a harmless warning when
CONFIG_PM is disabled:

sound/soc/codecs/cs35l33.c:908:12: error: 'cs35l33_runtime_suspend' defined but not used [-Werror=unused-function]
sound/soc/codecs/cs35l33.c:868:12: error: 'cs35l33_runtime_resume' defined but not used [-Werror=unused-function]

This adds __maybe_unused annotations to shut up the warning
regardless of the configuration.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/codecs/cs35l33.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cs35l33.c b/sound/soc/codecs/cs35l33.c
index 622a1111b21c..d8b5fc3fc45d 100644
--- a/sound/soc/codecs/cs35l33.c
+++ b/sound/soc/codecs/cs35l33.c
@@ -862,7 +862,7 @@ static const struct regmap_config cs35l33_regmap = {
 	.use_single_rw = true,
 };
 
-static int cs35l33_runtime_resume(struct device *dev)
+static int __maybe_unused cs35l33_runtime_resume(struct device *dev)
 {
 	struct cs35l33_private *cs35l33 = dev_get_drvdata(dev);
 	int ret;
@@ -902,7 +902,7 @@ err:
 	return ret;
 }
 
-static int cs35l33_runtime_suspend(struct device *dev)
+static int __maybe_unused cs35l33_runtime_suspend(struct device *dev)
 {
 	struct cs35l33_private *cs35l33 = dev_get_drvdata(dev);
 
-- 
2.9.0
