From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/4] ASoC: dapm: Allow regulators to bypass as
	well as disable when idle
Date: Fri,  7 Sep 2012 13:01:54 +0800
Message-ID: <1346994116-17873-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1346994116-17873-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4DF94261687
 for <alsa-devel@alsa-project.org>; Fri,  7 Sep 2012 07:02:21 +0200 (CEST)
In-Reply-To: <1346994116-17873-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Allow regulators managed via DAPM to make use of the bypass support that
has recently been added to the regulator API by setting a flag
SND_SOC_DAPM_REGULATOR_BYPASS. When this flag is set the regulator will
be put into bypass mode before being disabled, allowing the regulator to
fall into bypass mode if it can't be disabled due to other users.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc-dapm.h |    3 +++
 sound/soc/soc-dapm.c     |   23 +++++++++++++++++++++--
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index c96bf5a..e1ef63d 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -320,6 +320,9 @@ struct device;
 #define SND_SOC_DAPM_EVENT_OFF(e)	\
 	(e & (SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMD))
 
+/* regulator widget flags */
+#define SND_SOC_DAPM_REGULATOR_BYPASS     0x1     /* bypass when disabled */
+
 struct snd_soc_dapm_widget;
 enum snd_soc_dapm_type;
 struct snd_soc_dapm_path;
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index fd97dd7..5ad593c 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1019,10 +1019,29 @@ EXPORT_SYMBOL_GPL(dapm_reg_event);
 int dapm_regulator_event(struct snd_soc_dapm_widget *w,
 		   struct snd_kcontrol *kcontrol, int event)
 {
-	if (SND_SOC_DAPM_EVENT_ON(event))
+	int ret;
+
+	if (SND_SOC_DAPM_EVENT_ON(event)) {
+		if (w->invert & SND_SOC_DAPM_REGULATOR_BYPASS) {
+			ret = regulator_allow_bypass(w->regulator, true);
+			if (ret != 0)
+				dev_warn(w->dapm->dev,
+					 "Failed to bypass %s: %d\n",
+					 w->name, ret);
+		}
+
 		return regulator_enable(w->regulator);
-	else
+	} else {
+		if (w->invert & SND_SOC_DAPM_REGULATOR_BYPASS) {
+			ret = regulator_allow_bypass(w->regulator, false);
+			if (ret != 0)
+				dev_warn(w->dapm->dev,
+					 "Failed to unbypass %s: %d\n",
+					 w->name, ret);
+		}
+
 		return regulator_disable_deferred(w->regulator, w->shift);
+	}
 }
 EXPORT_SYMBOL_GPL(dapm_regulator_event);
 
-- 
1.7.10.4
