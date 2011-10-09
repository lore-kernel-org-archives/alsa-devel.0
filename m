From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 4/5] ASoC: Convert SmartQ to table based init
Date: Sun,  9 Oct 2011 11:28:32 +0100
Message-ID: <1318156113-3344-5-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1318156113-3344-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 05F13245D6
	for <alsa-devel@alsa-project.org>;
	Sun,  9 Oct 2011 12:28:38 +0200 (CEST)
In-Reply-To: <1318156113-3344-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sangbeom Kim <sbkim73@samsung.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/samsung/smartq_wm8987.c |   21 +++++++--------------
 1 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/sound/soc/samsung/smartq_wm8987.c b/sound/soc/samsung/smartq_wm8987.c
index 16bf48f..a22fc44 100644
--- a/sound/soc/samsung/smartq_wm8987.c
+++ b/sound/soc/samsung/smartq_wm8987.c
@@ -154,20 +154,6 @@ static int smartq_wm8987_init(struct snd_soc_pcm_runtime *rtd)
 	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	int err = 0;
 
-	/* Add SmartQ specific widgets */
-	snd_soc_dapm_new_controls(dapm, wm8987_dapm_widgets,
-				  ARRAY_SIZE(wm8987_dapm_widgets));
-
-	/* add SmartQ specific controls */
-	err = snd_soc_add_controls(codec, wm8987_smartq_controls,
-				   ARRAY_SIZE(wm8987_smartq_controls));
-
-	if (err < 0)
-		return err;
-
-	/* setup SmartQ specific audio path */
-	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
-
 	/* set endpoints to not connected */
 	snd_soc_dapm_nc_pin(dapm, "LINPUT1");
 	snd_soc_dapm_nc_pin(dapm, "RINPUT1");
@@ -214,6 +200,13 @@ static struct snd_soc_card snd_soc_smartq = {
 	.name = "SmartQ",
 	.dai_link = smartq_dai,
 	.num_links = ARRAY_SIZE(smartq_dai),
+
+	.dapm_widgets = wm8987_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(wm8987_dapm_widgets),
+	.dapm_routes = audio_map,
+	.num_dapm_routes = ARRAY_SIZE(audio_map),
+	.controls = wm8987_smartq_controls,
+	.num_controls = ARRAY_SIZE(wm8987_smartq_controls),
 };
 
 static struct platform_device *smartq_snd_device;
-- 
1.7.6.3
