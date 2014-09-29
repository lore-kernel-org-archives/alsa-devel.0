From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/3] ASoC: Remove CODEC pointer from
	snd_soc_dapm_context
Date: Mon, 29 Sep 2014 11:40:42 +0200
Message-ID: <1411983642-12793-3-git-send-email-lars@metafoo.de>
References: <1411983642-12793-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-039.synserver.de (smtp-out-039.synserver.de
 [212.40.185.39])
 by alsa0.perex.cz (Postfix) with ESMTP id A48D02605D1
 for <alsa-devel@alsa-project.org>; Mon, 29 Sep 2014 11:40:33 +0200 (CEST)
In-Reply-To: <1411983642-12793-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, patches@opensource.wolfsonmicro.com, Peter Ujfalusi <peter.ujfalusi@ti.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

The only remaining user of the CODEC pointer in the DAPM struct is to
initialize the CODEC pointer in the widget struct. The later is scheduled
for removal, but has still a few users left. For now use
dapm->component->codec to initialize it.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc-dapm.h | 1 -
 sound/soc/soc-core.c     | 1 -
 sound/soc/soc-dapm.c     | 2 +-
 3 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index f955d65..fa03217 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -594,7 +594,6 @@ struct snd_soc_dapm_context {
 
 	struct device *dev; /* from parent - for debug */
 	struct snd_soc_component *component; /* parent component */
-	struct snd_soc_codec *codec; /* parent codec */
 	struct snd_soc_card *card; /* parent card */
 
 	/* used during DAPM updates */
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 263514a..3d8cff6 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -4353,7 +4353,6 @@ int snd_soc_register_codec(struct device *dev,
 	if (codec_drv->read)
 		codec->component.read = snd_soc_codec_drv_read;
 	codec->component.ignore_pmdown_time = codec_drv->ignore_pmdown_time;
-	codec->dapm.codec = codec;
 	codec->dapm.idle_bias_off = codec_drv->idle_bias_off;
 	codec->dapm.suspend_bias_off = codec_drv->suspend_bias_off;
 	if (codec_drv->seq_notifier)
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 7efe4fa..2d06892 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3125,7 +3125,7 @@ snd_soc_dapm_new_control(struct snd_soc_dapm_context *dapm,
 	}
 
 	w->dapm = dapm;
-	w->codec = dapm->codec;
+	w->codec = dapm->component->codec;
 	INIT_LIST_HEAD(&w->sources);
 	INIT_LIST_HEAD(&w->sinks);
 	INIT_LIST_HEAD(&w->list);
-- 
1.8.0
