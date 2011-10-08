From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Fix DAPM sync for TLV320AIC3x custom
	DAPM widget
Date: Sat,  8 Oct 2011 13:44:21 +0100
Message-ID: <1318077861-24901-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 42BA42436E
	for <alsa-devel@alsa-project.org>;
	Sat,  8 Oct 2011 14:44:27 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@bitmer.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

We really should be doing this in the core, not in a driver...

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc-dapm.h       |    3 +++
 sound/soc/codecs/tlv320aic3x.c |    4 ++++
 sound/soc/soc-dapm.c           |    3 ++-
 3 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index e2853da..5b2202f 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -381,6 +381,9 @@ int snd_soc_dapm_force_enable_pin(struct snd_soc_dapm_context *dapm,
 int snd_soc_dapm_ignore_suspend(struct snd_soc_dapm_context *dapm,
 				const char *pin);
 
+/* Mostly internal - should not normally be used */
+void dapm_mark_dirty(struct snd_soc_dapm_widget *w, const char *reason);
+
 /* dapm widget types */
 enum snd_soc_dapm_type {
 	snd_soc_dapm_input = 0,		/* input pin */
diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index d877b39..be55b7f 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -197,6 +197,10 @@ static int snd_soc_dapm_put_volsw_aic3x(struct snd_kcontrol *kcontrol,
 			else
 				/* old connection must be powered down */
 				path->connect = invert ? 1 : 0;
+
+			dapm_mark_dirty(path->source, "tlv320aic3x source");
+			dapm_mark_dirty(path->sink, "tlv320aic3x sink");
+
 			break;
 		}
 
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index e49c56d..b9836ab 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -124,7 +124,7 @@ static bool dapm_dirty_widget(struct snd_soc_dapm_widget *w)
 	return !list_empty(&w->dirty);
 }
 
-static void dapm_mark_dirty(struct snd_soc_dapm_widget *w, const char *reason)
+void dapm_mark_dirty(struct snd_soc_dapm_widget *w, const char *reason)
 {
 	if (!dapm_dirty_widget(w)) {
 		dev_vdbg(w->dapm->dev, "Marking %s dirty due to %s\n",
@@ -132,6 +132,7 @@ static void dapm_mark_dirty(struct snd_soc_dapm_widget *w, const char *reason)
 		list_add_tail(&w->dirty, &w->dapm->card->dapm_dirty);
 	}
 }
+EXPORT_SYMBOL_GPL(dapm_mark_dirty);
 
 /* create a new dapm widget */
 static inline struct snd_soc_dapm_widget *dapm_cnew_widget(
-- 
1.7.6.3
