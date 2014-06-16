From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 11/11] ASoC: dapm: Remove platform field
	from widget and dapm context struct
Date: Mon, 16 Jun 2014 18:13:11 +0200
Message-ID: <1402935191-18398-12-git-send-email-lars@metafoo.de>
References: <1402935191-18398-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-035.synserver.de (smtp-out-035.synserver.de
 [212.40.185.35])
 by alsa0.perex.cz (Postfix) with ESMTP id D344C265455
 for <alsa-devel@alsa-project.org>; Mon, 16 Jun 2014 18:13:30 +0200 (CEST)
In-Reply-To: <1402935191-18398-1-git-send-email-lars@metafoo.de>
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
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The platform field in the snd_soc_dapm_widget and snd_soc_dapm_context structs
is now unused can be removed. New code that wants to get the platform for a
widget or dapm context should use snd_soc_dapm_to_platform(w->dapm) or
snd_soc_dapm_to_platform(dapm).

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc-dapm.h | 2 --
 sound/soc/soc-core.c     | 1 -
 sound/soc/soc-dapm.c     | 1 -
 3 files changed, 4 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index e292683..aac04ff 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -526,7 +526,6 @@ struct snd_soc_dapm_widget {
 	const char *name;		/* widget name */
 	const char *sname;	/* stream name */
 	struct snd_soc_codec *codec;
-	struct snd_soc_platform *platform;
 	struct list_head list;
 	struct snd_soc_dapm_context *dapm;
 
@@ -595,7 +594,6 @@ struct snd_soc_dapm_context {
 	struct device *dev; /* from parent - for debug */
 	struct snd_soc_component *component; /* parent component */
 	struct snd_soc_codec *codec; /* parent codec */
-	struct snd_soc_platform *platform; /* parent platform */
 	struct snd_soc_card *card; /* parent card */
 
 	/* used during DAPM updates */
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 19dfa80..7ad4838 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -4176,7 +4176,6 @@ int snd_soc_add_platform(struct device *dev, struct snd_soc_platform *platform,
 
 	platform->dev = dev;
 	platform->driver = platform_drv;
-	platform->component.dapm.platform = platform;
 	if (platform_drv->write)
 		platform->component.write = snd_soc_platform_drv_write;
 	if (platform_drv->read)
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 4702b92..4bf08cf 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3097,7 +3097,6 @@ snd_soc_dapm_new_control(struct snd_soc_dapm_context *dapm,
 
 	w->dapm = dapm;
 	w->codec = dapm->codec;
-	w->platform = dapm->platform;
 	INIT_LIST_HEAD(&w->sources);
 	INIT_LIST_HEAD(&w->sinks);
 	INIT_LIST_HEAD(&w->list);
-- 
1.8.0
