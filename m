From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/4] ASoC: Add verbose debugging showing why
	widgets get marked dirty
Date: Tue,  4 Oct 2011 23:01:22 +0100
Message-ID: <1317765685-8683-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 657551039A1
	for <alsa-devel@alsa-project.org>;
	Wed,  5 Oct 2011 00:01:30 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Help diagnose why we're checking widgets by providing some logging when
we first dirty them. This should possibly be a trace point if it's useful
but can be absurdly verbose if enabled, we can always change it later if
desired.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-dapm.c |   26 +++++++++++++++-----------
 1 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 214a709..e6a0882 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -124,10 +124,13 @@ static bool dapm_dirty_widget(struct snd_soc_dapm_widget *w)
 	return !list_empty(&w->dirty);
 }
 
-static void dapm_mark_dirty(struct snd_soc_dapm_widget *w)
+static void dapm_mark_dirty(struct snd_soc_dapm_widget *w, const char *reason)
 {
-	if (!dapm_dirty_widget(w))
+	if (!dapm_dirty_widget(w)) {
+		dev_vdbg(w->dapm->dev, "Marking %s dirty due to %s\n",
+			 w->name, reason);
 		list_add_tail(&w->dirty, &w->dapm->card->dapm_dirty);
+	}
 }
 
 /* create a new dapm widget */
@@ -1227,7 +1230,7 @@ static void dapm_widget_set_peer_power(struct snd_soc_dapm_widget *peer,
 	/* If the peer is already in the state we're moving to then we
 	 * won't have an impact on it. */
 	if (power != peer->power)
-		dapm_mark_dirty(peer);
+		dapm_mark_dirty(peer, "peer state change");
 }
 
 static void dapm_widget_set_power(struct snd_soc_dapm_widget *w, bool power,
@@ -1624,16 +1627,17 @@ static int dapm_mux_update_power(struct snd_soc_dapm_widget *widget,
 		/* we now need to match the string in the enum to the path */
 		if (!(strcmp(path->name, e->texts[mux]))) {
 			path->connect = 1; /* new connection */
-			dapm_mark_dirty(path->source);
+			dapm_mark_dirty(path->source, "mux connection");
 		} else {
 			if (path->connect)
-				dapm_mark_dirty(path->source);
+				dapm_mark_dirty(path->source,
+						"mux disconnection");
 			path->connect = 0; /* old connection must be powered down */
 		}
 	}
 
 	if (found) {
-		dapm_mark_dirty(widget);
+		dapm_mark_dirty(widget, "mux change");
 		dapm_power_widgets(widget->dapm, SND_SOC_DAPM_STREAM_NOP);
 	}
 
@@ -1660,11 +1664,11 @@ static int dapm_mixer_update_power(struct snd_soc_dapm_widget *widget,
 		/* found, now check type */
 		found = 1;
 		path->connect = connect;
-		dapm_mark_dirty(path->source);
+		dapm_mark_dirty(path->source, "mixer connection");
 	}
 
 	if (found) {
-		dapm_mark_dirty(widget);
+		dapm_mark_dirty(widget, "mixer update");
 		dapm_power_widgets(widget->dapm, SND_SOC_DAPM_STREAM_NOP);
 	}
 
@@ -1810,7 +1814,7 @@ static int snd_soc_dapm_set_pin(struct snd_soc_dapm_context *dapm,
 	w->connected = status;
 	if (status == 0)
 		w->force = 0;
-	dapm_mark_dirty(w);
+	dapm_mark_dirty(w, "pin configuration");
 
 	return 0;
 }
@@ -2699,7 +2703,7 @@ static void soc_dapm_stream_event(struct snd_soc_dapm_context *dapm,
 		dev_vdbg(w->dapm->dev, "widget %s\n %s stream %s event %d\n",
 			w->name, w->sname, stream, event);
 		if (strstr(w->sname, stream)) {
-			dapm_mark_dirty(w);
+			dapm_mark_dirty(w, "stream event");
 			switch(event) {
 			case SND_SOC_DAPM_STREAM_START:
 				w->active = 1;
@@ -2789,7 +2793,7 @@ int snd_soc_dapm_force_enable_pin(struct snd_soc_dapm_context *dapm,
 	dev_dbg(w->dapm->dev, "dapm: force enable pin %s\n", pin);
 	w->connected = 1;
 	w->force = 1;
-	dapm_mark_dirty(w);
+	dapm_mark_dirty(w, "force enable");
 
 	return 0;
 }
-- 
1.7.6.3
