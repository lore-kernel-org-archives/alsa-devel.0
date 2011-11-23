From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Add fully_routed flag to Speyside
	machines
Date: Wed, 23 Nov 2011 21:46:23 +0000
Message-ID: <1322084784-26390-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4D80F103B20
	for <alsa-devel@alsa-project.org>; Wed, 23 Nov 2011 22:46:38 +0100 (CET)
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

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/samsung/speyside.c        |    3 +--
 sound/soc/samsung/speyside_wm8962.c |    1 +
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/samsung/speyside.c b/sound/soc/samsung/speyside.c
index 85bf541..efa5187 100644
--- a/sound/soc/samsung/speyside.c
+++ b/sound/soc/samsung/speyside.c
@@ -222,8 +222,6 @@ static struct snd_soc_dai_link speyside_dai[] = {
 
 static int speyside_wm9081_init(struct snd_soc_dapm_context *dapm)
 {
-	snd_soc_dapm_nc_pin(dapm, "LINEOUT");
-
 	/* At any time the WM9081 is active it will have this clock */
 	return snd_soc_codec_set_sysclk(dapm->codec, WM9081_SYSCLK_MCLK, 0,
 					48000 * 256, 0);
@@ -308,6 +306,7 @@ static struct snd_soc_card speyside = {
 	.num_dapm_widgets = ARRAY_SIZE(widgets),
 	.dapm_routes = audio_paths,
 	.num_dapm_routes = ARRAY_SIZE(audio_paths),
+	.fully_routed = true,
 
 	.late_probe = speyside_late_probe,
 };
diff --git a/sound/soc/samsung/speyside_wm8962.c b/sound/soc/samsung/speyside_wm8962.c
index e3e2716..a681c8d 100644
--- a/sound/soc/samsung/speyside_wm8962.c
+++ b/sound/soc/samsung/speyside_wm8962.c
@@ -208,6 +208,7 @@ static struct snd_soc_card speyside_wm8962 = {
 	.num_dapm_widgets = ARRAY_SIZE(widgets),
 	.dapm_routes = audio_paths,
 	.num_dapm_routes = ARRAY_SIZE(audio_paths),
+	.fully_routed = true,
 
 	.late_probe = speyside_wm8962_late_probe,
 };
-- 
1.7.7.3
