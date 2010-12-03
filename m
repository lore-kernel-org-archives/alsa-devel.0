From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [RFC v2 2/3] ASoC: core: Helper function to request
	reversed widget power up
Date: Fri,  3 Dec 2010 15:31:12 +0200
Message-ID: <1291383073-16048-3-git-send-email-peter.ujfalusi@nokia.com>
References: <1291383073-16048-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-sa01.nokia.com (smtp.nokia.com [147.243.1.47])
	by alsa0.perex.cz (Postfix) with ESMTP id 16441244CE
	for <alsa-devel@alsa-project.org>; Fri,  3 Dec 2010 14:31:20 +0100 (CET)
In-Reply-To: <1291383073-16048-1-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Helper function for drivers to request reversed power up sequence
on a given DAPM widget.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 include/sound/soc-dapm.h |    2 ++
 sound/soc/soc-dapm.c     |   37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index e5a3c74..d5e11df 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -358,6 +358,8 @@ int snd_soc_dapm_force_enable_pin(struct snd_soc_dapm_context *dapm,
 				  const char *pin);
 int snd_soc_dapm_ignore_suspend(struct snd_soc_dapm_context *dapm,
 				const char *pin);
+int snd_soc_dapm_reverse_powerup_sequence(struct snd_soc_dapm_context *dapm,
+					  const char *name);
 
 /* dapm widget types */
 enum snd_soc_dapm_type {
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 7fae969..a3a3e94 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -119,6 +119,19 @@ static inline struct snd_soc_dapm_widget *dapm_cnew_widget(
 	return kmemdup(_widget, sizeof(*_widget), GFP_KERNEL);
 }
 
+/* Find a widget by name */
+static inline struct snd_soc_dapm_widget *snd_soc_dapm_get_widget(
+			struct snd_soc_dapm_context *dapm, const char *name)
+{
+	struct snd_soc_dapm_widget *w;
+
+	list_for_each_entry(w, &dapm->widgets, list) {
+		if (!strcmp(w->name, name))
+			return w;
+	}
+	return NULL;
+}
+
 /**
  * snd_soc_dapm_set_bias_level - set the bias level for the system
  * @card: audio device
@@ -2260,6 +2273,30 @@ int snd_soc_dapm_ignore_suspend(struct snd_soc_dapm_context *dapm,
 EXPORT_SYMBOL_GPL(snd_soc_dapm_ignore_suspend);
 
 /**
+ * snd_soc_dapm_reverse_powerup_sequence - reverse power up sequence on a widget
+ * @codec: audio codec
+ * @pin: Name of the DAPM widget
+ *
+ * Change the power up sequence on a given DAPM widget.
+ *
+ * Returns 0 on success, otherwise -EINVAL.
+ */
+int snd_soc_dapm_reverse_powerup_sequence(struct snd_soc_dapm_context *dapm,
+					  const char *name)
+{
+	int ret = -EINVAL;
+	struct snd_soc_dapm_widget *widget;
+
+	widget = snd_soc_dapm_get_widget(dapm, name);
+	if (widget) {
+		widget->route_change_before_powerup = 1;
+		ret = 0;
+	}
+	return ret;
+}
+EXPORT_SYMBOL_GPL(snd_soc_dapm_reverse_powerup_sequence);
+
+/**
  * snd_soc_dapm_free - free dapm resources
  * @card: SoC device
  *
-- 
1.7.3.2
