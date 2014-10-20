From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 03/12] ASoC: dapm: Only mark paths dirty when
	the connection status changed
Date: Mon, 20 Oct 2014 19:36:35 +0200
Message-ID: <1413826604-3212-4-git-send-email-lars@metafoo.de>
References: <1413826604-3212-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-205.synserver.de (smtp-out-205.synserver.de
 [212.40.185.205])
 by alsa0.perex.cz (Postfix) with ESMTP id 83B902658B7
 for <alsa-devel@alsa-project.org>; Mon, 20 Oct 2014 19:36:48 +0200 (CEST)
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

Rework soc_dapm_{mixer,mux}_update_power() to only mark a path dirty if the
connect state if the path has actually changed. This avoids unnecessary
power state checks for the widgets involved.

Also factor out the common code that is involved in this into a helper
function.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-dapm.c | 43 ++++++++++++++++++++++++++++++-------------
 1 file changed, 30 insertions(+), 13 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 12f9f5f..518c532 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2002,12 +2002,35 @@ static inline void dapm_debugfs_cleanup(struct snd_soc_dapm_context *dapm)
 
 #endif
 
+/**
+ * soc_dapm_connect_path() - Connects or disconnects a path
+ * @path: The path to update
+ * @connect: The new connect state of the path. True if the path is connected,
+ *  false if it is disconneted.
+ * @reason: The reason why the path changed (for debugging only)
+ *
+ * Returns true if the path connect state changed, false otherwise.
+ */
+static bool soc_dapm_connect_path(struct snd_soc_dapm_path *path,
+	bool connect, const char *reason)
+{
+	if (path->connect == connect)
+		return false;
+
+	path->connect = connect;
+	dapm_mark_dirty(path->source, reason);
+	dapm_mark_dirty(path->sink, reason);
+
+	return true;
+}
+
 /* test and update the power status of a mux widget */
 static int soc_dapm_mux_update_power(struct snd_soc_card *card,
 				 struct snd_kcontrol *kcontrol, int mux, struct soc_enum *e)
 {
 	struct snd_soc_dapm_path *path;
 	int found = 0;
+	bool connect;
 
 	lockdep_assert_held(&card->dapm_mutex);
 
@@ -2018,16 +2041,12 @@ static int soc_dapm_mux_update_power(struct snd_soc_card *card,
 
 		found = 1;
 		/* we now need to match the string in the enum to the path */
-		if (!(strcmp(path->name, e->texts[mux]))) {
-			path->connect = 1; /* new connection */
-			dapm_mark_dirty(path->source, "mux connection");
-		} else {
-			if (path->connect)
-				dapm_mark_dirty(path->source,
-						"mux disconnection");
-			path->connect = 0; /* old connection must be powered down */
-		}
-		dapm_mark_dirty(path->sink, "mux change");
+		if (!(strcmp(path->name, e->texts[mux])))
+			connect = true;
+		else
+			connect = false;
+
+		soc_dapm_connect_path(path, connect, "mux update");
 	}
 
 	if (found)
@@ -2066,9 +2085,7 @@ static int soc_dapm_mixer_update_power(struct snd_soc_card *card,
 	/* find dapm widget path assoc with kcontrol */
 	dapm_kcontrol_for_each_path(path, kcontrol) {
 		found = 1;
-		path->connect = connect;
-		dapm_mark_dirty(path->source, "mixer connection");
-		dapm_mark_dirty(path->sink, "mixer update");
+		soc_dapm_connect_path(path, connect, "mixer update");
 	}
 
 	if (found)
-- 
1.8.0
