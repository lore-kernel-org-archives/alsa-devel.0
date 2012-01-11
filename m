From: Javier Martin <javier.martin@vista-silicon.com>
Subject: [PATCH v2] ASoC: Route Mic Bias in Visstrim_M10 board.
Date: Wed, 11 Jan 2012 13:21:05 +0100
Message-ID: <1326284465-8440-1-git-send-email-javier.martin@vista-silicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f41.google.com (mail-ww0-f41.google.com [74.125.82.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 82CDC246AA
	for <alsa-devel@alsa-project.org>; Wed, 11 Jan 2012 13:21:17 +0100 (CET)
Received: by wgbed3 with SMTP id ed3so3765319wgb.2
	for <alsa-devel@alsa-project.org>; Wed, 11 Jan 2012 04:21:16 -0800 (PST)
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
Cc: broonie@opensource.wolfsonmicro.com, lrg@ti.com, lars@metafoo.de, Javier Martin <javier.martin@vista-silicon.com>
List-Id: alsa-devel@alsa-project.org

Visstrim_M10 board uses an external microphone
that can be enabled/disabled by the user

---
Changes since v1:
 - Change "audio_map" to "aic32x4_dapm_routes".
 - Use snd_soc_card fields to register controls,
   routes and widgets.

Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>
---
 sound/soc/imx/mx27vis-aic32x4.c |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/sound/soc/imx/mx27vis-aic32x4.c b/sound/soc/imx/mx27vis-aic32x4.c
index 054110b..30adbe1 100644
--- a/sound/soc/imx/mx27vis-aic32x4.c
+++ b/sound/soc/imx/mx27vis-aic32x4.c
@@ -74,6 +74,24 @@ static struct snd_soc_ops mx27vis_aic32x4_snd_ops = {
 	.hw_params	= mx27vis_aic32x4_hw_params,
 };
 
+static const struct snd_kcontrol_new mx27vis_aic32x4_controls[] = {
+	SOC_DAPM_PIN_SWITCH("External Mic"),
+};
+
+static const struct snd_soc_dapm_widget aic32x4_dapm_widgets[] = {
+	SND_SOC_DAPM_MIC("External Mic", NULL),
+};
+
+static const struct snd_soc_dapm_route aic32x4_dapm_routes[] = {
+	{"Mic Bias", NULL, "External Mic"},
+	{"IN1_R", NULL, "Mic Bias"},
+	{"IN2_R", NULL, "Mic Bias"},
+	{"IN3_R", NULL, "Mic Bias"},
+	{"IN1_L", NULL, "Mic Bias"},
+	{"IN2_L", NULL, "Mic Bias"},
+	{"IN3_L", NULL, "Mic Bias"},
+};
+
 static struct snd_soc_dai_link mx27vis_aic32x4_dai = {
 	.name		= "tlv320aic32x4",
 	.stream_name	= "TLV320AIC32X4",
@@ -88,6 +106,12 @@ static struct snd_soc_card mx27vis_aic32x4 = {
 	.name		= "visstrim_m10-audio",
 	.dai_link	= &mx27vis_aic32x4_dai,
 	.num_links	= 1,
+	.controls	= mx27vis_aic32x4_controls,
+	.num_controls	= ARRAY_SIZE(mx27vis_aic32x4_controls),
+	.dapm_widgets	= aic32x4_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(aic32x4_dapm_widgets),
+	.dapm_routes	= aic32x4_dapm_routes,
+	.num_dapm_routes = ARRAY_SIZE(aic32x4_dapm_routes),
 };
 
 static struct platform_device *mx27vis_aic32x4_snd_device;
-- 
1.7.0.4
