From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 4/5] ASoC: Factor out widget power check
	operation
Date: Mon,  3 Oct 2011 21:32:17 +0100
Message-ID: <1317673938-11716-4-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1317673938-11716-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 21E6C103813
	for <alsa-devel@alsa-project.org>;
	Mon,  3 Oct 2011 22:32:23 +0200 (CEST)
In-Reply-To: <1317673938-11716-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

We've got the same code in two different places, let's have it in a single
place instead.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-dapm.c |   21 ++++++++++-----------
 1 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 8d76044..c1f3563 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -771,6 +771,14 @@ int dapm_reg_event(struct snd_soc_dapm_widget *w,
 }
 EXPORT_SYMBOL_GPL(dapm_reg_event);
 
+static int dapm_widget_power_check(struct snd_soc_dapm_widget *w)
+{
+	if (w->force)
+		return 1;
+	else
+		return w->power_check(w);
+}
+
 /* Generic check to see if a widget should be powered.
  */
 static int dapm_generic_check_power(struct snd_soc_dapm_widget *w)
@@ -840,13 +848,7 @@ static int dapm_supply_check_power(struct snd_soc_dapm_widget *w)
 		if (!path->sink)
 			continue;
 
-		if (path->sink->force) {
-			power = 1;
-			break;
-		}
-
-		if (path->sink->power_check &&
-		    path->sink->power_check(path->sink)) {
+		if (dapm_widget_power_check(path->sink)) {
 			power = 1;
 			break;
 		}
@@ -1234,10 +1236,7 @@ static void dapm_power_one_widget(struct snd_soc_dapm_widget *w,
 		break;
 
 	default:
-		if (!w->force)
-			power = w->power_check(w);
-		else
-			power = 1;
+		power = dapm_widget_power_check(w);
 
 		dapm_widget_set_power(w, power, up_list, down_list);
 		break;
-- 
1.7.6.3
