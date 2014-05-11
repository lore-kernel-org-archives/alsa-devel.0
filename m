From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: dapm: Handle SND_SOC_DAPM_REG()
	generically
Date: Sun, 11 May 2014 19:27:47 +0200
Message-ID: <1399829267-18755-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-016.synserver.de (smtp-out-079.synserver.de
 [212.40.185.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 705A8261ABF
 for <alsa-devel@alsa-project.org>; Sun, 11 May 2014 19:28:02 +0200 (CEST)
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

Commit commit de9ba98b6d ("ASoC: dapm: Make widget power register settings more
flexible") added generic support for on_val/off_val in the DAPM core. With this
in place there is no need anymore for having a special event callback for
SND_SOC_DAPM_REG() widgets.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc-dapm.h |  7 ++-----
 sound/soc/soc-dapm.c     | 20 --------------------
 2 files changed, 2 insertions(+), 25 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 75020f5..5932d66 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -256,9 +256,8 @@ struct device;
 /* generic widgets */
 #define SND_SOC_DAPM_REG(wid, wname, wreg, wshift, wmask, won_val, woff_val) \
 {	.id = wid, .name = wname, .kcontrol_news = NULL, .num_kcontrols = 0, \
-	.reg = -((wreg) + 1), .shift = wshift, .mask = wmask, \
-	.on_val = won_val, .off_val = woff_val, .event = dapm_reg_event, \
-	.event_flags = SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD}
+	.reg = wreg, .shift = wshift, .mask = wmask, \
+	.on_val = won_val, .off_val = woff_val, }
 #define SND_SOC_DAPM_SUPPLY(wname, wreg, wshift, winvert, wevent, wflags) \
 {	.id = snd_soc_dapm_supply, .name = wname, \
 	SND_SOC_DAPM_INIT_REG_VAL(wreg, wshift, winvert), \
@@ -362,8 +361,6 @@ struct regulator;
 struct snd_soc_dapm_widget_list;
 struct snd_soc_dapm_update;
 
-int dapm_reg_event(struct snd_soc_dapm_widget *w,
-		   struct snd_kcontrol *kcontrol, int event);
 int dapm_regulator_event(struct snd_soc_dapm_widget *w,
 			 struct snd_kcontrol *kcontrol, int event);
 int dapm_clock_event(struct snd_soc_dapm_widget *w,
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index fb6c7b7..56fcd6f 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1059,26 +1059,6 @@ int snd_soc_dapm_dai_get_connected_widgets(struct snd_soc_dai *dai, int stream,
 }
 
 /*
- * Handler for generic register modifier widget.
- */
-int dapm_reg_event(struct snd_soc_dapm_widget *w,
-		   struct snd_kcontrol *kcontrol, int event)
-{
-	unsigned int val;
-
-	if (SND_SOC_DAPM_EVENT_ON(event))
-		val = w->on_val;
-	else
-		val = w->off_val;
-
-	soc_widget_update_bits(w, -(w->reg + 1),
-			    w->mask << w->shift, val << w->shift);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(dapm_reg_event);
-
-/*
  * Handler for regulator supply widget.
  */
 int dapm_regulator_event(struct snd_soc_dapm_widget *w,
-- 
1.8.0
