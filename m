From: Liam Girdwood <lrg@ti.com>
Subject: [PATCH 2/3] ASoC: core - Add platform widget IO
Date: Mon, 4 Jul 2011 22:10:52 +0100
Message-ID: <1309813853-7142-3-git-send-email-lrg@ti.com>
References: <1309813853-7142-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id A47E6103889
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Jul 2011 23:11:01 +0200 (CEST)
In-Reply-To: <1309813853-7142-1-git-send-email-lrg@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Allow platform driver widgets to perform any IO required for DAPM.

Signed-off-by: Liam Girdwood <lrg@ti.com>
---
 include/sound/soc-dapm.h |    2 ++
 include/sound/soc.h      |    2 ++
 sound/soc/soc-core.c     |    4 ++++
 sound/soc/soc-dapm.c     |   13 +++++++++++--
 4 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 602024d..e09505c 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -447,6 +447,7 @@ struct snd_soc_dapm_widget {
 	char *name;		/* widget name */
 	char *sname;	/* stream name */
 	struct snd_soc_codec *codec;
+	struct snd_soc_platform *platform;
 	struct list_head list;
 	struct snd_soc_dapm_context *dapm;
 
@@ -510,6 +511,7 @@ struct snd_soc_dapm_context {
 
 	struct device *dev; /* from parent - for debug */
 	struct snd_soc_codec *codec; /* parent codec */
+	struct snd_soc_platform *platform; /* parent platform */
 	struct snd_soc_card *card; /* parent card */
 
 	/* used during DAPM updates */
diff --git a/include/sound/soc.h b/include/sound/soc.h
index c421501..6ce8dc3 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -682,6 +682,8 @@ struct snd_soc_platform {
 	struct snd_soc_card *card;
 	struct list_head list;
 	struct list_head card_list;
+
+	struct snd_soc_dapm_context dapm;
 };
 
 struct snd_soc_dai_link {
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index a69b87a..36e71e9 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -993,6 +993,7 @@ static int soc_probe_platform(struct snd_soc_card *card,
 	const struct snd_soc_platform_driver *driver = platform->driver;
 
 	platform->card = card;
+	platform->dapm.card = card;
 
 	if (!try_module_get(platform->dev->driver->owner))
 		return -ENODEV;
@@ -1010,6 +1011,7 @@ static int soc_probe_platform(struct snd_soc_card *card,
 	/* mark platform as probed and add to card platform list */
 	platform->probed = 1;
 	list_add(&platform->card_list, &card->platform_dev_list);
+	list_add(&platform->dapm.list, &card->dapm_list);
 
 	return 0;
 
@@ -3124,6 +3126,8 @@ int snd_soc_register_platform(struct device *dev,
 
 	platform->dev = dev;
 	platform->driver = platform_drv;
+	platform->dapm.dev = dev;
+	platform->dapm.platform = platform;
 
 	mutex_lock(&client_mutex);
 	list_add(&platform->list, &platform_list);
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 605c225..0a78482 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -128,14 +128,22 @@ static int soc_widget_read(struct snd_soc_dapm_widget *w, int reg)
 {
 	if (w->codec)
 		return snd_soc_read(w->codec, reg);
-	return 0;
+	else if (w->platform)
+		return snd_soc_platform_read(w->platform, reg);
+
+	dev_err(w->dapm->dev, "no valid widget read method\n");
+	return -1;
 }
 
 static int soc_widget_write(struct snd_soc_dapm_widget *w, int reg, int val)
 {
 	if (w->codec)
 		return snd_soc_write(w->codec, reg, val);
-	return 0;
+	else if (w->platform)
+		return snd_soc_platform_write(w->platform, reg, val);
+
+	dev_err(w->dapm->dev, "no valid widget write method\n");
+	return -1;
 }
 
 static int soc_widget_update_bits(struct snd_soc_dapm_widget *w,
@@ -2489,6 +2497,7 @@ int snd_soc_dapm_new_control(struct snd_soc_dapm_context *dapm,
 	dapm->n_widgets++;
 	w->dapm = dapm;
 	w->codec = dapm->codec;
+	w->platform = dapm->platform;
 	INIT_LIST_HEAD(&w->sources);
 	INIT_LIST_HEAD(&w->sinks);
 	INIT_LIST_HEAD(&w->list);
-- 
1.7.4.1
