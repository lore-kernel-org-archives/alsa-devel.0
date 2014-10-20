From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 10/12] ASoC: dapm: Mark endpoints instead of IO
	widgets dirty during suspend/resume
Date: Mon, 20 Oct 2014 19:36:42 +0200
Message-ID: <1413826604-3212-11-git-send-email-lars@metafoo.de>
References: <1413826604-3212-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-205.synserver.de (smtp-out-205.synserver.de
 [212.40.185.205])
 by alsa0.perex.cz (Postfix) with ESMTP id 953A32658CD
 for <alsa-devel@alsa-project.org>; Mon, 20 Oct 2014 19:36:54 +0200 (CEST)
In-Reply-To: <1413826604-3212-1-git-send-email-lars@metafoo.de>
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

The state of endpoint widgets is affected by that card's power state.
Endpoint widgets that do no have the ignore_suspend flag set will be
considered inactive during suspend. So they have to be re-checked and marked
dirty after the card's power state changes. Currently the input and output
widgets are marked dirty instead, this works most of the time since
typically a path from one endpoint to another will go via a input or output
widget. But marking the endpoints dirty is technically more correct and will
also work for odd corner cases.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc-dapm.h |  2 +-
 sound/soc/soc-core.c     |  8 ++++----
 sound/soc/soc-dapm.c     | 15 ++++-----------
 3 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index e7ebeb7..43ca165 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -435,7 +435,7 @@ void snd_soc_dapm_auto_nc_pins(struct snd_soc_card *card);
 unsigned int dapm_kcontrol_get_value(const struct snd_kcontrol *kcontrol);
 
 /* Mostly internal - should not normally be used */
-void dapm_mark_io_dirty(struct snd_soc_dapm_context *dapm);
+void dapm_mark_endpoints_dirty(struct snd_soc_card *card);
 
 /* dapm path query */
 int snd_soc_dapm_dai_get_connected_widgets(struct snd_soc_dai *dai, int stream,
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 4c8f8a2..443be00 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -629,8 +629,8 @@ int snd_soc_suspend(struct device *dev)
 					  SND_SOC_DAPM_STREAM_SUSPEND);
 	}
 
-	/* Recheck all analogue paths too */
-	dapm_mark_io_dirty(&card->dapm);
+	/* Recheck all endpoints too, their state is affected by suspend */
+	dapm_mark_endpoints_dirty(card);
 	snd_soc_dapm_sync(&card->dapm);
 
 	/* suspend all CODECs */
@@ -796,8 +796,8 @@ static void soc_resume_deferred(struct work_struct *work)
 	/* userspace can access us now we are back as we were before */
 	snd_power_change_state(card->snd_card, SNDRV_CTL_POWER_D0);
 
-	/* Recheck all analogue paths too */
-	dapm_mark_io_dirty(&card->dapm);
+	/* Recheck all endpoints too, their state is affected by suspend */
+	dapm_mark_endpoints_dirty(card);
 	snd_soc_dapm_sync(&card->dapm);
 }
 
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index a7d5acf..8792e47 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -159,27 +159,20 @@ static void dapm_mark_dirty(struct snd_soc_dapm_widget *w, const char *reason)
 	}
 }
 
-void dapm_mark_io_dirty(struct snd_soc_dapm_context *dapm)
+void dapm_mark_endpoints_dirty(struct snd_soc_card *card)
 {
-	struct snd_soc_card *card = dapm->card;
 	struct snd_soc_dapm_widget *w;
 
 	mutex_lock(&card->dapm_mutex);
 
 	list_for_each_entry(w, &card->widgets, list) {
-		switch (w->id) {
-		case snd_soc_dapm_input:
-		case snd_soc_dapm_output:
-			dapm_mark_dirty(w, "Rechecking inputs and outputs");
-			break;
-		default:
-			break;
-		}
+		if (w->is_sink || w->is_source)
+			dapm_mark_dirty(w, "Rechecking endpoints");
 	}
 
 	mutex_unlock(&card->dapm_mutex);
 }
-EXPORT_SYMBOL_GPL(dapm_mark_io_dirty);
+EXPORT_SYMBOL_GPL(dapm_mark_endpoints_dirty);
 
 /* create a new dapm widget */
 static inline struct snd_soc_dapm_widget *dapm_cnew_widget(
-- 
1.8.0
