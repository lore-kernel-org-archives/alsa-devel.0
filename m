From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/5] ASoC: Convert RX1950 to table based init
Date: Sun,  9 Oct 2011 11:28:31 +0100
Message-ID: <1318156113-3344-4-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1318156113-3344-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 069B9245D7
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
 sound/soc/samsung/rx1950_uda1380.c |   31 +++++++++++--------------------
 1 files changed, 11 insertions(+), 20 deletions(-)

diff --git a/sound/soc/samsung/rx1950_uda1380.c b/sound/soc/samsung/rx1950_uda1380.c
index d197100..71b4c02 100644
--- a/sound/soc/samsung/rx1950_uda1380.c
+++ b/sound/soc/samsung/rx1950_uda1380.c
@@ -91,12 +91,6 @@ static struct snd_soc_dai_link rx1950_uda1380_dai[] = {
 	},
 };
 
-static struct snd_soc_card rx1950_asoc = {
-	.name = "rx1950",
-	.dai_link = rx1950_uda1380_dai,
-	.num_links = ARRAY_SIZE(rx1950_uda1380_dai),
-};
-
 /* rx1950 machine dapm widgets */
 static const struct snd_soc_dapm_widget uda1380_dapm_widgets[] = {
 	SND_SOC_DAPM_HP("Headphone Jack", NULL),
@@ -118,6 +112,17 @@ static const struct snd_soc_dapm_route audio_map[] = {
 	{"VINM", NULL, "Mic Jack"},
 };
 
+static struct snd_soc_card rx1950_asoc = {
+	.name = "rx1950",
+	.dai_link = rx1950_uda1380_dai,
+	.num_links = ARRAY_SIZE(rx1950_uda1380_dai),
+
+	.dapm_widgets = uda1380_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(uda1380_dapm_widgets),
+	.dapm_routes = audio_map,
+	.num_dapm_routes = ARRAY_SIZE(audio_map),
+};
+
 static struct platform_device *s3c24xx_snd_device;
 
 static int rx1950_startup(struct snd_pcm_substream *substream)
@@ -221,20 +226,6 @@ static int rx1950_uda1380_init(struct snd_soc_pcm_runtime *rtd)
 	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	int err;
 
-	/* Add rx1950 specific widgets */
-	err = snd_soc_dapm_new_controls(dapm, uda1380_dapm_widgets,
-				  ARRAY_SIZE(uda1380_dapm_widgets));
-
-	if (err)
-		return err;
-
-	/* Set up rx1950 specific audio path audio_mapnects */
-	err = snd_soc_dapm_add_routes(dapm, audio_map,
-				      ARRAY_SIZE(audio_map));
-
-	if (err)
-		return err;
-
 	snd_soc_dapm_enable_pin(dapm, "Headphone Jack");
 	snd_soc_dapm_enable_pin(dapm, "Speaker");
 	snd_soc_dapm_enable_pin(dapm, "Mic Jack");
-- 
1.7.6.3
