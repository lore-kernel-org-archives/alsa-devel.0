From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/3] ASoC: Add signal generator widget type
Date: Wed, 30 Nov 2011 20:57:03 +0000
Message-ID: <1322686625-16488-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 72B20103BCE
	for <alsa-devel@alsa-project.org>; Wed, 30 Nov 2011 21:57:09 +0100 (CET)
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

A signal generator behaves as an input would but is not considered for
any of the special behaviour associated with external input pins. This
is especially useful when automatically working out not connected widgets.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc-dapm.h |    4 ++++
 sound/soc/soc-dapm.c     |    7 +++++++
 2 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 0c159a7..d26a9b7 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -43,6 +43,9 @@
 	.num_kcontrols = 0}
 
 /* platform domain */
+#define SND_SOC_DAPM_SIGGEN(wname) \
+{	.id = snd_soc_dapm_siggen, .name = wname, .kcontrol_news = NULL, \
+	.num_kcontrols = 0, .reg = SND_SOC_NOPM }
 #define SND_SOC_DAPM_INPUT(wname) \
 {	.id = snd_soc_dapm_input, .name = wname, .kcontrol_news = NULL, \
 	.num_kcontrols = 0, .reg = SND_SOC_NOPM }
@@ -410,6 +413,7 @@ enum snd_soc_dapm_type {
 	snd_soc_dapm_supply,		/* power/clock supply */
 	snd_soc_dapm_aif_in,		/* audio interface input */
 	snd_soc_dapm_aif_out,		/* audio interface output */
+	snd_soc_dapm_siggen,		/* signal generator */
 };
 
 /*
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index da5c1ae..6bb327e 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -339,6 +339,7 @@ static void dapm_set_path_status(struct snd_soc_dapm_widget *w,
 	case snd_soc_dapm_output:
 	case snd_soc_dapm_adc:
 	case snd_soc_dapm_input:
+	case snd_soc_dapm_siggen:
 	case snd_soc_dapm_dac:
 	case snd_soc_dapm_micbias:
 	case snd_soc_dapm_vmid:
@@ -772,6 +773,11 @@ static int is_connected_input_ep(struct snd_soc_dapm_widget *widget)
 			return widget->inputs;
 		}
 
+		/* signal generator */
+		if (widget->id == snd_soc_dapm_siggen) {
+			widget->inputs = snd_soc_dapm_suspend_check(widget);
+			return widget->inputs;
+		}
 	}
 
 	list_for_each_entry(path, &widget->sources, list_sink) {
@@ -1982,6 +1988,7 @@ static int snd_soc_dapm_add_route(struct snd_soc_dapm_context *dapm,
 	case snd_soc_dapm_out_drv:
 	case snd_soc_dapm_input:
 	case snd_soc_dapm_output:
+	case snd_soc_dapm_siggen:
 	case snd_soc_dapm_micbias:
 	case snd_soc_dapm_vmid:
 	case snd_soc_dapm_pre:
-- 
1.7.7.3
