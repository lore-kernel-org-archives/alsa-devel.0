From: Ola Lilja <ola.o.lilja@stericsson.com>
Subject: [PATCH 02/11] ASoC: core: Add method
	snd_soc_dapm_get_regulator_status
Date: Tue, 8 May 2012 15:56:32 +0200
Message-ID: <1336485392-27113-1-git-send-email-ola.o.lilja@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog116.obsmtp.com (eu1sys200aog116.obsmtp.com
	[207.126.144.141])
	by alsa0.perex.cz (Postfix) with ESMTP id 4194E24470
	for <alsa-devel@alsa-project.org>;
	Tue,  8 May 2012 15:56:41 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: alsa-devel@alsa-project.org

Add method to get the status of a regulator supply widget.

Signed-off-by: Ola Lilja <ola.o.lilja@stericsson.com>
---
 include/sound/soc-dapm.h |    3 +++
 sound/soc/soc-dapm.c     |   23 +++++++++++++++++++++++
 2 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 8da3c24..1649ef2 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -399,6 +399,9 @@ int snd_soc_dapm_ignore_suspend(struct snd_soc_dapm_context *dapm,
 				const char *pin);
 void snd_soc_dapm_auto_nc_codec_pins(struct snd_soc_codec *codec);
 
+int snd_soc_dapm_get_regulator_status(struct snd_soc_dapm_context *dapm,
+				const char *pin);
+
 /* Mostly internal - should not normally be used */
 void dapm_mark_dirty(struct snd_soc_dapm_widget *w, const char *reason);
 
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 5cbd2d7..b6c9df5 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3092,6 +3092,29 @@ int snd_soc_dapm_get_pin_status(struct snd_soc_dapm_context *dapm,
 EXPORT_SYMBOL_GPL(snd_soc_dapm_get_pin_status);
 
 /**
+ * snd_soc_dapm_get_regulator_status - get regulator supply status
+ * @dapm: DAPM context
+ * @pin: Regulator supply name
+ *
+ * Get regulator supply status - Enabled or disabled.
+ *
+ * Returns -1 for failure.
+ * Returns 0 if disabled.
+ * Returns 1 if enabled.
+ */
+int snd_soc_dapm_get_regulator_status(struct snd_soc_dapm_context *dapm,
+				const char *pin)
+{
+	struct snd_soc_dapm_widget *w = dapm_find_widget(dapm, pin, true);
+
+	if (!w)
+		return -1;
+
+	return regulator_is_enabled((struct regulator *)w->priv);
+}
+EXPORT_SYMBOL_GPL(snd_soc_dapm_get_regulator_status);
+
+/**
  * snd_soc_dapm_ignore_suspend - ignore suspend status for DAPM endpoint
  * @dapm: DAPM context
  * @pin: audio signal pin endpoint (or start point)
-- 
1.7.8.3
