From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: dapm: Fix handling of loops
Date: Fri, 22 Feb 2013 17:52:13 +0000
Message-ID: <1361555534-6811-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CACFC2625CB
 for <alsa-devel@alsa-project.org>; Fri, 22 Feb 2013 18:52:18 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Currently if a path loops back on itself we correctly skip over it to
avoid going into an infinite loop but this causes us to ignore the need
to power up the path as we don't count the loop for the purposes of
counting inputs and outputs. This means that internal loopbacks within a
device that have powered devices on them won't be powered up.

Fix this by treating any path that is currently in the process of being
recursed as having a single input or output so that it is counted for
the purposes of power decisions.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc-dapm.h |    1 +
 sound/soc/soc-dapm.c     |   15 +++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 617ac36..38fd652 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -491,6 +491,7 @@ struct snd_soc_dapm_path {
 	/* status */
 	u32 connect:1;	/* source and sink widgets are connected */
 	u32 walked:1;	/* path has been walked */
+	u32 walking:1;  /* path is in the process of being walked */
 	u32 weak:1;	/* path ignored for power management */
 
 	int (*connected)(struct snd_soc_dapm_widget *source,
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 1dc5b72..11047ba 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -821,6 +821,7 @@ static int is_connected_output_ep(struct snd_soc_dapm_widget *widget,
 		    (widget->id == snd_soc_dapm_line &&
 		     !list_empty(&widget->sources))) {
 			widget->outputs = snd_soc_dapm_suspend_check(widget);
+			path->walking = 0;
 			return widget->outputs;
 		}
 	}
@@ -831,6 +832,9 @@ static int is_connected_output_ep(struct snd_soc_dapm_widget *widget,
 		if (path->weak)
 			continue;
 
+		if (path->walking)
+			return 1;
+
 		if (path->walked)
 			continue;
 
@@ -838,6 +842,7 @@ static int is_connected_output_ep(struct snd_soc_dapm_widget *widget,
 
 		if (path->sink && path->connect) {
 			path->walked = 1;
+			path->walking = 1;
 
 			/* do we need to add this widget to the list ? */
 			if (list) {
@@ -847,11 +852,14 @@ static int is_connected_output_ep(struct snd_soc_dapm_widget *widget,
 					dev_err(widget->dapm->dev,
 						"ASoC: could not add widget %s\n",
 						widget->name);
+					path->walking = 0;
 					return con;
 				}
 			}
 
 			con += is_connected_output_ep(path->sink, list);
+
+			path->walking = 0;
 		}
 	}
 
@@ -931,6 +939,9 @@ static int is_connected_input_ep(struct snd_soc_dapm_widget *widget,
 		if (path->weak)
 			continue;
 
+		if (path->walking)
+			return 1;
+
 		if (path->walked)
 			continue;
 
@@ -938,6 +949,7 @@ static int is_connected_input_ep(struct snd_soc_dapm_widget *widget,
 
 		if (path->source && path->connect) {
 			path->walked = 1;
+			path->walking = 1;
 
 			/* do we need to add this widget to the list ? */
 			if (list) {
@@ -947,11 +959,14 @@ static int is_connected_input_ep(struct snd_soc_dapm_widget *widget,
 					dev_err(widget->dapm->dev,
 						"ASoC: could not add widget %s\n",
 						widget->name);
+					path->walking = 0;
 					return con;
 				}
 			}
 
 			con += is_connected_input_ep(path->source, list);
+
+			path->walking = 0;
 		}
 	}
 
-- 
1.7.10.4
