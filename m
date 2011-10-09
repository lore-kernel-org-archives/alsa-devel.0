From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/5] ASoC: Convert Jive to table based init
Date: Sun,  9 Oct 2011 11:28:30 +0100
Message-ID: <1318156113-3344-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1318156113-3344-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 00A3E245D5
	for <alsa-devel@alsa-project.org>;
	Sun,  9 Oct 2011 12:28:37 +0200 (CEST)
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
 sound/soc/samsung/jive_wm8750.c |   16 +++++-----------
 1 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/sound/soc/samsung/jive_wm8750.c b/sound/soc/samsung/jive_wm8750.c
index 5a1e0cb..1826acf 100644
--- a/sound/soc/samsung/jive_wm8750.c
+++ b/sound/soc/samsung/jive_wm8750.c
@@ -111,17 +111,6 @@ static int jive_wm8750_init(struct snd_soc_pcm_runtime *rtd)
 	snd_soc_dapm_nc_pin(dapm, "OUT3");
 	snd_soc_dapm_nc_pin(dapm, "MONO");
 
-	/* Add jive specific widgets */
-	err = snd_soc_dapm_new_controls(dapm, wm8750_dapm_widgets,
-					ARRAY_SIZE(wm8750_dapm_widgets));
-	if (err) {
-		printk(KERN_ERR "%s: failed to add widgets (%d)\n",
-		       __func__, err);
-		return err;
-	}
-
-	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
-
 	return 0;
 }
 
@@ -141,6 +130,11 @@ static struct snd_soc_card snd_soc_machine_jive = {
 	.name		= "Jive",
 	.dai_link	= &jive_dai,
 	.num_links	= 1,
+
+	.dapm_widgtets	= wm8750_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(wm8750_dapm_widgets),
+	.dapm_routes	= audio_map,
+	.num_dapm_routes = ARRAY_SIZE(audio_map),
 };
 
 static struct platform_device *jive_snd_device;
-- 
1.7.6.3
