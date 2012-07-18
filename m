From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: littlemill: Add userspace control of the
	WM1250 I/O
Date: Wed, 18 Jul 2012 19:16:36 +0100
Message-ID: <1342635396-21286-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A922A260312
 for <alsa-devel@alsa-project.org>; Wed, 18 Jul 2012 20:16:35 +0200 (CEST)
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

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/samsung/littlemill.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/samsung/littlemill.c b/sound/soc/samsung/littlemill.c
index c82c646..ee52c8a0 100644
--- a/sound/soc/samsung/littlemill.c
+++ b/sound/soc/samsung/littlemill.c
@@ -211,6 +211,11 @@ static int bbclk_ev(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
+static const struct snd_kcontrol_new controls[] = {
+	SOC_DAPM_PIN_SWITCH("WM1250 Input"),
+	SOC_DAPM_PIN_SWITCH("WM1250 Output"),
+};
+
 static struct snd_soc_dapm_widget widgets[] = {
 	SND_SOC_DAPM_HP("Headphone", NULL),
 
@@ -282,6 +287,8 @@ static struct snd_soc_card littlemill = {
 	.set_bias_level = littlemill_set_bias_level,
 	.set_bias_level_post = littlemill_set_bias_level_post,
 
+	.controls = controls,
+	.num_controls = ARRAY_SIZE(controls),
 	.dapm_widgets = widgets,
 	.num_dapm_widgets = ARRAY_SIZE(widgets),
 	.dapm_routes = audio_paths,
-- 
1.7.10.4
