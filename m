From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: Add DAPM widget and path data to
	CODEC driver structure
Date: Mon,  7 Mar 2011 16:41:25 +0000
Message-ID: <1299516086-23638-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BEF63103830
	for <alsa-devel@alsa-project.org>; Mon,  7 Mar 2011 17:41:05 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Allow a slight simplification of CODEC drivers by allowing DAPM routes and
widgets to be provided in a table. They will be instantiated at the end of
CODEC probe.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc.h  |    6 ++++++
 sound/soc/soc-core.c |   12 ++++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index a23f5a5..363e3a8 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -563,6 +563,12 @@ struct snd_soc_codec_driver {
 			pm_message_t state);
 	int (*resume)(struct snd_soc_codec *);
 
+	/* Default DAPM setup, added after probe() is run */
+	const struct snd_soc_dapm_widget *dapm_widgets;
+	int num_dapm_widgets;
+	const struct snd_soc_dapm_route *dapm_routes;
+	int num_dapm_routes;
+
 	/* codec IO */
 	unsigned int (*read)(struct snd_soc_codec *, unsigned int);
 	int (*write)(struct snd_soc_codec *, unsigned int, unsigned int);
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 8926d38..286a385 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1464,6 +1464,7 @@ static int soc_probe_codec(struct snd_soc_card *card,
 			   struct snd_soc_codec *codec)
 {
 	int ret = 0;
+	const struct snd_soc_codec_driver *driver = codec->driver;
 
 	codec->card = card;
 	codec->dapm.card = card;
@@ -1472,8 +1473,8 @@ static int soc_probe_codec(struct snd_soc_card *card,
 	if (!try_module_get(codec->dev->driver->owner))
 		return -ENODEV;
 
-	if (codec->driver->probe) {
-		ret = codec->driver->probe(codec);
+	if (driver->probe) {
+		ret = driver->probe(codec);
 		if (ret < 0) {
 			dev_err(codec->dev,
 				"asoc: failed to probe CODEC %s: %d\n",
@@ -1482,6 +1483,13 @@ static int soc_probe_codec(struct snd_soc_card *card,
 		}
 	}
 
+	if (driver->dapm_widgets)
+		snd_soc_dapm_new_controls(&codec->dapm, driver->dapm_widgets,
+					  driver->num_dapm_widgets);
+	if (driver->dapm_routes)
+		snd_soc_dapm_add_routes(&codec->dapm, driver->dapm_routes,
+					driver->num_dapm_routes);
+
 	soc_init_codec_debugfs(codec);
 
 	/* mark codec as probed and add to card codec list */
-- 
1.7.2.3
