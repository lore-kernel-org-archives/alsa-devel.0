From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 1/4] ASoC: omap-abe-twl6040: Keep only one
	snd_soc_dai_link structure
Date: Tue,  8 May 2012 15:15:11 +0300
Message-ID: <1336479314-27766-2-git-send-email-peter.ujfalusi@ti.com>
References: <1336479314-27766-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog102.obsmtp.com (na3sys009aog102.obsmtp.com
	[74.125.149.69])
	by alsa0.perex.cz (Postfix) with ESMTP id 4742E1042B3
	for <alsa-devel@alsa-project.org>;
	Tue,  8 May 2012 14:15:16 +0200 (CEST)
Received: by lahj13 with SMTP id j13so1063629lah.11
	for <alsa-devel@alsa-project.org>; Tue, 08 May 2012 05:15:13 -0700 (PDT)
In-Reply-To: <1336479314-27766-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

There is no need to have two snd_soc_dai_link structure for the two setup
the machine driver supports.
We can just tell core to register only the first link if the DMIC link is
not in use on the device.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/omap-abe-twl6040.c |   30 +++++++++---------------------
 1 files changed, 9 insertions(+), 21 deletions(-)

diff --git a/sound/soc/omap/omap-abe-twl6040.c b/sound/soc/omap/omap-abe-twl6040.c
index 93bb8ee..31ab6fe 100644
--- a/sound/soc/omap/omap-abe-twl6040.c
+++ b/sound/soc/omap/omap-abe-twl6040.c
@@ -235,7 +235,7 @@ static int omap_abe_dmic_init(struct snd_soc_pcm_runtime *rtd)
 }
 
 /* Digital audio interface glue - connects codec <--> CPU */
-static struct snd_soc_dai_link twl6040_dmic_dai[] = {
+static struct snd_soc_dai_link abe_twl6040_dai_links[] = {
 	{
 		.name = "TWL6040",
 		.stream_name = "TWL6040",
@@ -258,19 +258,6 @@ static struct snd_soc_dai_link twl6040_dmic_dai[] = {
 	},
 };
 
-static struct snd_soc_dai_link twl6040_only_dai[] = {
-	{
-		.name = "TWL6040",
-		.stream_name = "TWL6040",
-		.cpu_dai_name = "omap-mcpdm",
-		.codec_dai_name = "twl6040-legacy",
-		.platform_name = "omap-pcm-audio",
-		.codec_name = "twl6040-codec",
-		.init = omap_abe_twl6040_init,
-		.ops = &omap_abe_ops,
-	},
-};
-
 /* Audio machine driver */
 static struct snd_soc_card omap_abe_card = {
 	.owner = THIS_MODULE,
@@ -285,6 +272,7 @@ static __devinit int omap_abe_probe(struct platform_device *pdev)
 {
 	struct omap_abe_twl6040_data *pdata = dev_get_platdata(&pdev->dev);
 	struct snd_soc_card *card = &omap_abe_card;
+	int num_links = 0;
 	int ret;
 
 	card->dev = &pdev->dev;
@@ -306,13 +294,13 @@ static __devinit int omap_abe_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	if (pdata->has_dmic) {
-		card->dai_link = twl6040_dmic_dai;
-		card->num_links = ARRAY_SIZE(twl6040_dmic_dai);
-	} else {
-		card->dai_link = twl6040_only_dai;
-		card->num_links = ARRAY_SIZE(twl6040_only_dai);
-	}
+	if (pdata->has_dmic)
+		num_links = 2;
+	else
+		num_links = 1;
+
+	card->dai_link = abe_twl6040_dai_links;
+	card->num_links = num_links;
 
 	ret = snd_soc_register_card(card);
 	if (ret)
-- 
1.7.8.6
