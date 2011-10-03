From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/5] ASoC: Ensure all DAPM widgets have a power
	check callback
Date: Mon,  3 Oct 2011 21:32:16 +0100
Message-ID: <1317673938-11716-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1317673938-11716-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 03541245C6
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

Makes the code simpler.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-dapm.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 12bd01a..8d76044 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -857,6 +857,11 @@ static int dapm_supply_check_power(struct snd_soc_dapm_widget *w)
 	return power;
 }
 
+static int dapm_always_on_check_power(struct snd_soc_dapm_widget *w)
+{
+	return 1;
+}
+
 static int dapm_seq_compare(struct snd_soc_dapm_widget *a,
 			    struct snd_soc_dapm_widget *b,
 			    bool power_up)
@@ -1229,9 +1234,6 @@ static void dapm_power_one_widget(struct snd_soc_dapm_widget *w,
 		break;
 
 	default:
-		if (!w->power_check)
-			break;
-
 		if (!w->force)
 			power = w->power_check(w);
 		else
@@ -2090,6 +2092,9 @@ int snd_soc_dapm_new_widgets(struct snd_soc_dapm_context *dapm)
 			break;
 		}
 
+		if (!w->power_check)
+			w->power_check = dapm_always_on_check_power;
+
 		/* Read the initial power state from the device */
 		if (w->reg >= 0) {
 			val = soc_widget_read(w, w->reg);
-- 
1.7.6.3
