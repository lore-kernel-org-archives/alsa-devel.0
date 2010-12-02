From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH 3/3] ASoC: soc-core: Generalize
	snd_soc_prefix_map and rename to snd_soc_codec_conf
Date: Thu,  2 Dec 2010 14:53:03 +0000
Message-ID: <1291301583-15491-4-git-send-email-dp@opensource.wolfsonmicro.com>
References: <1291301583-15491-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0CE00103AB3
	for <alsa-devel@alsa-project.org>; Thu,  2 Dec 2010 15:53:14 +0100 (CET)
In-Reply-To: <1291301583-15491-1-git-send-email-dp@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

The snd_soc_codec_conf struct now holds codec specific configuration
information.

A new configuration option has been added to allow machine drivers to
override the compression type set by the codec driver.

In the absence of providing an snd_soc_codec_conf struct or when providing
one but not setting the compress_type member to anything, the one supplied
by the codec driver will be used instead.  In all other cases the one
set in the snd_soc_codec_conf struct takes effect.

Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 include/sound/soc.h  |   22 +++++++++++++++-------
 sound/soc/soc-core.c |    6 +++---
 2 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index a26cdf9..4409e97 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -579,9 +579,20 @@ struct snd_soc_dai_link {
 	struct snd_soc_ops *ops;
 };
 
-struct snd_soc_prefix_map {
+struct snd_soc_codec_conf {
 	const char *dev_name;
+
+	/*
+	 * optional map of kcontrol, widget and path name prefixes that are
+	 * associated per device
+	 */
 	const char *name_prefix;
+
+	/*
+	 * set this to the desired compression type if you want to
+	 * override the one supplied in codec->driver->compress_type
+	 */
+	enum snd_soc_compress_type compress_type;
 };
 
 struct snd_soc_aux_dev {
@@ -626,12 +637,9 @@ struct snd_soc_card {
 	struct snd_soc_pcm_runtime *rtd;
 	int num_rtd;
 
-	/*
-	 * optional map of kcontrol, widget and path name prefixes that are
-	 * associated per device
-	 */
-	struct snd_soc_prefix_map *prefix_map;
-	int num_prefixes;
+	/* optional codec specific configuration */
+	struct snd_soc_codec_conf *codec_conf;
+	int num_configs;
 
 	/*
 	 * optional auxiliary devices such as amplifiers or codecs with DAI
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 1f142ae..a6565eb 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1401,11 +1401,11 @@ static void soc_set_name_prefix(struct snd_soc_card *card,
 {
 	int i;
 
-	if (card->prefix_map == NULL)
+	if (card->codec_conf == NULL)
 		return;
 
-	for (i = 0; i < card->num_prefixes; i++) {
-		struct snd_soc_prefix_map *map = &card->prefix_map[i];
+	for (i = 0; i < card->num_configs; i++) {
+		struct snd_soc_codec_conf *map = &card->codec_conf[i];
 		if (map->dev_name && !strcmp(codec->name, map->dev_name)) {
 			codec->name_prefix = map->name_prefix;
 			break;
-- 
1.7.3.2
