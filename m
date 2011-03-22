From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Support !REGULATOR build for sgtl5000
Date: Tue, 22 Mar 2011 12:22:19 +0000
Message-ID: <1300796539-18519-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C94271038EB
	for <alsa-devel@alsa-project.org>; Tue, 22 Mar 2011 13:22:12 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Zeng Zhaoming <b32542@freescale.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The regulator is optional depending on board design.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/sgtl5000.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 1f7217f..ff29380 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -772,6 +772,7 @@ static int sgtl5000_pcm_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
+#ifdef CONFIG_REGULATOR
 static int ldo_regulator_is_enabled(struct regulator_dev *dev)
 {
 	struct ldo_regulator *ldo = rdev_get_drvdata(dev);
@@ -901,6 +902,19 @@ static int ldo_regulator_remove(struct snd_soc_codec *codec)
 
 	return 0;
 }
+#else
+static int ldo_regulator_register(struct snd_soc_codec *codec,
+				struct regulator_init_data *init_data,
+				int voltage)
+{
+	return -EINVAL;
+}
+
+static int ldo_regulator_remove(struct snd_soc_codec *codec)
+{
+	return 0;
+}
+#endif
 
 /*
  * set dac bias
-- 
1.7.4.1
