From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/9] ASoC: Add support for automatically going
	to BIAS_OFF on suspend
Date: Thu,  4 Sep 2014 19:44:06 +0200
Message-ID: <1409852652-27939-4-git-send-email-lars@metafoo.de>
References: <1409852652-27939-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-125.synserver.de (smtp-out-125.synserver.de
 [212.40.185.125])
 by alsa0.perex.cz (Postfix) with ESMTP id 2FF872656AD
 for <alsa-devel@alsa-project.org>; Thu,  4 Sep 2014 19:44:43 +0200 (CEST)
In-Reply-To: <1409852652-27939-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

There is a substantial amount of drivers that in go to SND_SOC_BIAS_OFF on
suspend and go back to SND_SOC_BIAS_SUSPEND on resume (Often this is even
the only thing done in the suspend and resume handlers). This patch
introduces a new suspend_bias_off flag, which when set by a driver will let
the ASoC core automatically put the device's DAPM context at the
SND_SOC_BIAS_OFF level during suspend. Once the device is resumed the DAPM
context will go back to SND_SOC_BIAS_STANDBY (if the context is idle,
otherwise to SND_SOC_BIAS_ON).

This will allow us to remove a fair bit of duplicated code from the drivers.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc-dapm.h |  3 ++-
 include/sound/soc.h      |  1 +
 sound/soc/soc-core.c     |  1 +
 sound/soc/soc-dapm.c     | 20 ++++++++++++++++++--
 4 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index aac04ff..f955d65 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -587,7 +587,8 @@ struct snd_soc_dapm_context {
 	enum snd_soc_bias_level suspend_bias_level;
 	struct delayed_work delayed_work;
 	unsigned int idle_bias_off:1; /* Use BIAS_OFF instead of STANDBY */
-
+	/* Go to BIAS_OFF in suspend if the DAPM context is idle */
+	unsigned int suspend_bias_off:1;
 	void (*seq_notifier)(struct snd_soc_dapm_context *,
 			     enum snd_soc_dapm_type, int);
 
diff --git a/include/sound/soc.h b/include/sound/soc.h
index 29650de..882300d 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -848,6 +848,7 @@ struct snd_soc_codec_driver {
 	int (*set_bias_level)(struct snd_soc_codec *,
 			      enum snd_soc_bias_level level);
 	bool idle_bias_off;
+	bool suspend_bias_off;
 
 	void (*seq_notifier)(struct snd_soc_dapm_context *,
 			     enum snd_soc_dapm_type, int);
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 42f3690..e7c8b11 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -4402,6 +4402,7 @@ int snd_soc_register_codec(struct device *dev,
 	codec->component.ignore_pmdown_time = codec_drv->ignore_pmdown_time;
 	codec->dapm.codec = codec;
 	codec->dapm.idle_bias_off = codec_drv->idle_bias_off;
+	codec->dapm.suspend_bias_off = codec_drv->suspend_bias_off;
 	if (codec_drv->seq_notifier)
 		codec->dapm.seq_notifier = codec_drv->seq_notifier;
 	if (codec_drv->set_bias_level)
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 177bd86..7efe4fa 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1683,6 +1683,22 @@ static void dapm_power_one_widget(struct snd_soc_dapm_widget *w,
 	}
 }
 
+static bool dapm_idle_bias_off(struct snd_soc_dapm_context *dapm)
+{
+	if (dapm->idle_bias_off)
+		return true;
+
+	switch (snd_power_get_state(dapm->card->snd_card)) {
+	case SNDRV_CTL_POWER_D3hot:
+	case SNDRV_CTL_POWER_D3cold:
+		return dapm->suspend_bias_off;
+	default:
+		break;
+	}
+
+	return false;
+}
+
 /*
  * Scan each dapm widget for complete audio path.
  * A complete path is a route that has valid endpoints i.e.:-
@@ -1706,7 +1722,7 @@ static int dapm_power_widgets(struct snd_soc_card *card, int event)
 	trace_snd_soc_dapm_start(card);
 
 	list_for_each_entry(d, &card->dapm_list, list) {
-		if (d->idle_bias_off)
+		if (dapm_idle_bias_off(d))
 			d->target_bias_level = SND_SOC_BIAS_OFF;
 		else
 			d->target_bias_level = SND_SOC_BIAS_STANDBY;
@@ -1772,7 +1788,7 @@ static int dapm_power_widgets(struct snd_soc_card *card, int event)
 		if (d->target_bias_level > bias)
 			bias = d->target_bias_level;
 	list_for_each_entry(d, &card->dapm_list, list)
-		if (!d->idle_bias_off)
+		if (!dapm_idle_bias_off(d))
 			d->target_bias_level = bias;
 
 	trace_snd_soc_dapm_walk_done(card);
-- 
1.8.0
