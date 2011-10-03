From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/5] ASoC: Factor write of widget power out
	into a separate function
Date: Mon,  3 Oct 2011 21:32:14 +0100
Message-ID: <1317673938-11716-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 01A65245C5
	for <alsa-devel@alsa-project.org>;
	Mon,  3 Oct 2011 22:32:23 +0200 (CEST)
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

Split the decision about what the new power should be out from the
implementation of that decision.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-dapm.c |   29 ++++++++++++++++++-----------
 1 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index c277228..dcbd468 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1197,6 +1197,23 @@ static void dapm_post_sequence_async(void *data, async_cookie_t cookie)
 	}
 }
 
+static void dapm_widget_set_power(struct snd_soc_dapm_widget *w, bool power,
+				  struct list_head *up_list,
+				  struct list_head *down_list)
+{
+	if (w->power == power)
+		return;
+
+	trace_snd_soc_dapm_widget_power(w, power);
+
+	if (power)
+		dapm_seq_insert(w, up_list, true);
+	else
+		dapm_seq_insert(w, down_list, false);
+
+	w->power = power;
+}
+
 static void dapm_power_one_widget(struct snd_soc_dapm_widget *w,
 				  struct list_head *up_list,
 				  struct list_head *down_list)
@@ -1241,17 +1258,7 @@ static void dapm_power_one_widget(struct snd_soc_dapm_widget *w,
 			}
 		}
 
-		if (w->power == power)
-			break;
-
-		trace_snd_soc_dapm_widget_power(w, power);
-
-		if (power)
-			dapm_seq_insert(w, up_list, true);
-		else
-			dapm_seq_insert(w, down_list, false);
-
-		w->power = power;
+		dapm_widget_set_power(w, power, up_list, down_list);
 		break;
 	}
 }
-- 
1.7.6.3
