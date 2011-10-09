From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/5] ASoC: Convert H1940 to table based init
Date: Sun,  9 Oct 2011 11:28:28 +0100
Message-ID: <1318156113-3344-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F4207245D4
	for <alsa-devel@alsa-project.org>;
	Sun,  9 Oct 2011 12:28:37 +0200 (CEST)
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
 sound/soc/samsung/h1940_uda1380.c |   17 +++++------------
 1 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/sound/soc/samsung/h1940_uda1380.c b/sound/soc/samsung/h1940_uda1380.c
index cdaed90..03cfa5f 100644
--- a/sound/soc/samsung/h1940_uda1380.c
+++ b/sound/soc/samsung/h1940_uda1380.c
@@ -183,18 +183,6 @@ static int h1940_uda1380_init(struct snd_soc_pcm_runtime *rtd)
 	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	int err;
 
-	/* Add h1940 specific widgets */
-	err = snd_soc_dapm_new_controls(dapm, uda1380_dapm_widgets,
-				  ARRAY_SIZE(uda1380_dapm_widgets));
-	if (err)
-		return err;
-
-	/* Set up h1940 specific audio path audio_mapnects */
-	err = snd_soc_dapm_add_routes(dapm, audio_map,
-				      ARRAY_SIZE(audio_map));
-	if (err)
-		return err;
-
 	snd_soc_dapm_enable_pin(dapm, "Headphone Jack");
 	snd_soc_dapm_enable_pin(dapm, "Speaker");
 	snd_soc_dapm_enable_pin(dapm, "Mic Jack");
@@ -229,6 +217,11 @@ static struct snd_soc_card h1940_asoc = {
 	.name = "h1940",
 	.dai_link = h1940_uda1380_dai,
 	.num_links = ARRAY_SIZE(h1940_uda1380_dai),
+
+	.dapm_widgets = uda1380_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(uda1380_dapm_widgets),
+	.dapm_routes = audio_map,
+	.num_dapm_routes = ARRAY_SIZE(audio_map),
 };
 
 static int __init h1940_init(void)
-- 
1.7.6.3
