From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Convert Simtec machines to table based
	DAPM init
Date: Sat,  8 Oct 2011 12:19:12 +0100
Message-ID: <1318072752-4584-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E3A382417D
	for <alsa-devel@alsa-project.org>;
	Sat,  8 Oct 2011 13:19:15 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ben Dooks <ben@simtec.co.uk>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/samsung/s3c24xx_simtec_hermes.c      |   10 +++++-----
 sound/soc/samsung/s3c24xx_simtec_tlv320aic23.c |   10 +++++-----
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/sound/soc/samsung/s3c24xx_simtec_hermes.c b/sound/soc/samsung/s3c24xx_simtec_hermes.c
index 2422117..cbed1da 100644
--- a/sound/soc/samsung/s3c24xx_simtec_hermes.c
+++ b/sound/soc/samsung/s3c24xx_simtec_hermes.c
@@ -66,11 +66,6 @@ static int simtec_hermes_init(struct snd_soc_pcm_runtime *rtd)
 	struct snd_soc_codec *codec = rtd->codec;
 	struct snd_soc_dapm_context *dapm = &codec->dapm;
 
-	snd_soc_dapm_new_controls(dapm, dapm_widgets,
-				  ARRAY_SIZE(dapm_widgets));
-
-	snd_soc_dapm_add_routes(dapm, base_map, ARRAY_SIZE(base_map));
-
 	snd_soc_dapm_enable_pin(dapm, "Headphone Jack");
 	snd_soc_dapm_enable_pin(dapm, "Line In");
 	snd_soc_dapm_enable_pin(dapm, "Line Out");
@@ -97,6 +92,11 @@ static struct snd_soc_card snd_soc_machine_simtec_aic33 = {
 	.name		= "Simtec-Hermes",
 	.dai_link	= &simtec_dai_aic33,
 	.num_links	= 1,
+
+	.dapm_widgets	= dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(dapm_widgets),
+	.dapm_routes	= base_map,
+	.num_dapm_routes = ARRAY_SIZE(base_map),
 };
 
 static int __devinit simtec_audio_hermes_probe(struct platform_device *pd)
diff --git a/sound/soc/samsung/s3c24xx_simtec_tlv320aic23.c b/sound/soc/samsung/s3c24xx_simtec_tlv320aic23.c
index 57aee5e..15961e2 100644
--- a/sound/soc/samsung/s3c24xx_simtec_tlv320aic23.c
+++ b/sound/soc/samsung/s3c24xx_simtec_tlv320aic23.c
@@ -55,11 +55,6 @@ static int simtec_tlv320aic23_init(struct snd_soc_pcm_runtime *rtd)
 	struct snd_soc_codec *codec = rtd->codec;
 	struct snd_soc_dapm_context *dapm = &codec->dapm;
 
-	snd_soc_dapm_new_controls(dapm, dapm_widgets,
-				  ARRAY_SIZE(dapm_widgets));
-
-	snd_soc_dapm_add_routes(dapm, base_map, ARRAY_SIZE(base_map));
-
 	snd_soc_dapm_enable_pin(dapm, "Headphone Jack");
 	snd_soc_dapm_enable_pin(dapm, "Line In");
 	snd_soc_dapm_enable_pin(dapm, "Line Out");
@@ -86,6 +81,11 @@ static struct snd_soc_card snd_soc_machine_simtec_aic23 = {
 	.name		= "Simtec",
 	.dai_link	= &simtec_dai_aic23,
 	.num_links	= 1,
+
+	.dapm_widgets	= dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(dapm_widgets),
+	.dapm_routes	= base_map,
+	.num_dapm_routes = ARRAY_SIZE(base_map),
 };
 
 static int __devinit simtec_audio_tlv320aic23_probe(struct platform_device *pd)
-- 
1.7.6.3
