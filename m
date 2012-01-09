From: Javier Martin <javier.martin@vista-silicon.com>
Subject: [PATCH] ASoC: Route Mic Bias in Visstrim_M10 board.
Date: Mon,  9 Jan 2012 12:01:48 +0100
Message-ID: <1326106908-28026-1-git-send-email-javier.martin@vista-silicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f179.google.com (mail-wi0-f179.google.com
	[209.85.212.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 9D0AD103A5E
	for <alsa-devel@alsa-project.org>; Mon,  9 Jan 2012 12:02:01 +0100 (CET)
Received: by wibhm4 with SMTP id hm4so2802154wib.38
	for <alsa-devel@alsa-project.org>; Mon, 09 Jan 2012 03:02:00 -0800 (PST)
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
Cc: broonie@opensource.wolfsonmicro.com, lrg@ti.com, Javier Martin <javier.martin@vista-silicon.com>
List-Id: alsa-devel@alsa-project.org

Visstrim_M10 board uses an external microphone
that can be enabled/disabled by the user.

Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>
---
 sound/soc/imx/mx27vis-aic32x4.c |   38 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/sound/soc/imx/mx27vis-aic32x4.c b/sound/soc/imx/mx27vis-aic32x4.c
index 054110b..7e55a99 100644
--- a/sound/soc/imx/mx27vis-aic32x4.c
+++ b/sound/soc/imx/mx27vis-aic32x4.c
@@ -74,6 +74,43 @@ static struct snd_soc_ops mx27vis_aic32x4_snd_ops = {
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
+static const struct snd_soc_dapm_route audio_map[] = {
+	{"Mic Bias", NULL, "External Mic"},
+	{"IN1_R", NULL, "Mic Bias"},
+	{"IN2_R", NULL, "Mic Bias"},
+	{"IN3_R", NULL, "Mic Bias"},
+	{"IN1_L", NULL, "Mic Bias"},
+	{"IN2_L", NULL, "Mic Bias"},
+	{"IN3_L", NULL, "Mic Bias"},
+};
+
+static int mx27vis_aic32x4_dai_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
+	int err = 0;
+
+	snd_soc_dapm_new_controls(dapm, aic32x4_dapm_widgets,
+				  ARRAY_SIZE(aic32x4_dapm_widgets));
+
+	err = snd_soc_add_controls(codec, mx27vis_aic32x4_controls,
+				   ARRAY_SIZE(mx27vis_aic32x4_controls));
+	if (err < 0)
+		return err;
+
+	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
+
+	return 0;
+}
+
 static struct snd_soc_dai_link mx27vis_aic32x4_dai = {
 	.name		= "tlv320aic32x4",
 	.stream_name	= "TLV320AIC32X4",
@@ -82,6 +119,7 @@ static struct snd_soc_dai_link mx27vis_aic32x4_dai = {
 	.codec_name	= "tlv320aic32x4.0-0018",
 	.cpu_dai_name	= "imx-ssi.0",
 	.ops		= &mx27vis_aic32x4_snd_ops,
+	.init		= mx27vis_aic32x4_dai_init,
 };
 
 static struct snd_soc_card mx27vis_aic32x4 = {
-- 
1.7.0.4
