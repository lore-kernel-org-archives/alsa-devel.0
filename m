From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v3 2/3] ASoC: soc-dapm: API to attach
	DAPM_SUPPLY to be used for dai
Date: Fri, 26 Aug 2011 16:33:22 +0300
Message-ID: <1314365603-8947-3-git-send-email-peter.ujfalusi@ti.com>
References: <1314365603-8947-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id B26BE24623
	for <alsa-devel@alsa-project.org>;
	Fri, 26 Aug 2011 15:33:26 +0200 (CEST)
In-Reply-To: <1314365603-8947-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

There are cpu dais, which require special ordering during stream
stop (OMAP4's McPDM interface for example) in a system level.
OMAP4 McPDM required to be stopped after the attached codec's
(twl6040) DAC/ADC has been stopped.

This requironment can be solved with a use of DAPM_SUPPLY
widget attached to the codec's ADC/DAC from machine driver.

Provide generic enough API from core which can be used from
other drivers, if needed.

The snd_soc_dapm_attach_dai_supply function can be used to attach
the DAPM_SUPPLY widget to the specified dapm_context.
The resulting widget's private_data will be initialized with
the dai's drvdata.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 include/sound/soc-dapm.h |    5 +++++
 sound/soc/soc-dapm.c     |   27 +++++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index c10d4cc..e540bb2 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -381,6 +381,11 @@ int snd_soc_dapm_force_enable_pin(struct snd_soc_dapm_context *dapm,
 int snd_soc_dapm_ignore_suspend(struct snd_soc_dapm_context *dapm,
 				const char *pin);
 
+int snd_soc_dapm_attach_dai_supply(struct snd_soc_dapm_context *dapm,
+	struct snd_soc_dai *dai, char *wname,
+	int (*wevent)(struct snd_soc_dapm_widget*, struct snd_kcontrol *, int),
+	unsigned short wflags);
+
 /* dapm widget types */
 enum snd_soc_dapm_type {
 	snd_soc_dapm_input = 0,		/* input pin */
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 7e15914..8839202 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2776,6 +2776,33 @@ void snd_soc_dapm_free(struct snd_soc_dapm_context *dapm)
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_free);
 
+/**
+ * snd_soc_dapm_attach_dai_supply - attach supply widget on behalf of a dai
+ * @dapm: DAPM context
+ * @dai: DAI, which requesting the widget
+ * @wname: name of the DAPM_SUPPLY widget
+ * @wevent: event handler callback
+ * @wflags: DAPM event flags
+ *
+ * Creates DAPM_SUPPLY widget on behalf of a dai. The new widget's private_data
+ * will inherit the dai's driver data pointer, which is going to be available
+ * in the event handler.
+ */
+int snd_soc_dapm_attach_dai_supply(struct snd_soc_dapm_context *dapm,
+	struct snd_soc_dai *dai, char *wname,
+	int (*wevent)(struct snd_soc_dapm_widget*, struct snd_kcontrol *, int),
+	unsigned short wflags)
+{
+	void *pdata = snd_soc_dai_get_drvdata(dai);
+	struct snd_soc_dapm_widget dai_widget =
+		SND_SOC_DAPM_SUPPLY(wname, SND_SOC_NOPM, 0, 0, wevent, wflags);
+
+	snd_soc_dapm_widget_set_pdata(&dai_widget, pdata);
+
+	return snd_soc_dapm_new_control(dapm, &dai_widget);
+}
+EXPORT_SYMBOL_GPL(snd_soc_dapm_attach_dai_supply);
+
 static void soc_dapm_shutdown_codec(struct snd_soc_dapm_context *dapm)
 {
 	struct snd_soc_dapm_widget *w;
-- 
1.7.6.1
