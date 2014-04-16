From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 11/20] ASoC: omap-abe-twl6040: Use the
	cpu_dai node to specify the platform driver
Date: Wed, 16 Apr 2014 15:46:21 +0300
Message-ID: <1397652390-852-12-git-send-email-peter.ujfalusi@ti.com>
References: <1397652390-852-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 2C40D26549C
 for <alsa-devel@alsa-project.org>; Wed, 16 Apr 2014 14:47:04 +0200 (CEST)
In-Reply-To: <1397652390-852-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, Jyri Sarha <jsarha@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, notasas@gmail.com
List-Id: alsa-devel@alsa-project.org

Now that the platform driver is registered with the cpu_dai's device we
can use the same node for it instead of the hardwired name.
We can also remove the cpu_dai_name and platform_name from the dai_link
struct since we only support DT boot on OMAP4/5

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/omap-abe-twl6040.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/sound/soc/omap/omap-abe-twl6040.c b/sound/soc/omap/omap-abe-twl6040.c
index 024dafc3e298..1a89e5b1be16 100644
--- a/sound/soc/omap/omap-abe-twl6040.c
+++ b/sound/soc/omap/omap-abe-twl6040.c
@@ -214,9 +214,7 @@ static struct snd_soc_dai_link abe_twl6040_dai_links[] = {
 	{
 		.name = "TWL6040",
 		.stream_name = "TWL6040",
-		.cpu_dai_name = "omap-mcpdm",
 		.codec_dai_name = "twl6040-legacy",
-		.platform_name = "omap-pcm-audio",
 		.codec_name = "twl6040-codec",
 		.init = omap_abe_twl6040_init,
 		.ops = &omap_abe_ops,
@@ -224,9 +222,7 @@ static struct snd_soc_dai_link abe_twl6040_dai_links[] = {
 	{
 		.name = "DMIC",
 		.stream_name = "DMIC Capture",
-		.cpu_dai_name = "omap-dmic",
 		.codec_dai_name = "dmic-hifi",
-		.platform_name = "omap-pcm-audio",
 		.codec_name = "dmic-codec",
 		.init = omap_abe_dmic_init,
 		.ops = &omap_abe_dmic_ops,
@@ -281,14 +277,14 @@ static int omap_abe_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "McPDM node is not provided\n");
 		return -EINVAL;
 	}
-	abe_twl6040_dai_links[0].cpu_dai_name  = NULL;
 	abe_twl6040_dai_links[0].cpu_of_node = dai_node;
+	abe_twl6040_dai_links[0].platform_of_node = dai_node;
 
 	dai_node = of_parse_phandle(node, "ti,dmic", 0);
 	if (dai_node) {
 		num_links = 2;
-		abe_twl6040_dai_links[1].cpu_dai_name  = NULL;
 		abe_twl6040_dai_links[1].cpu_of_node = dai_node;
+		abe_twl6040_dai_links[1].platform_of_node = dai_node;
 
 		priv->dmic_codec_dev = platform_device_register_simple(
 						"dmic-codec", -1, NULL, 0);
-- 
1.9.2
