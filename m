From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 10/18] ASoC: omap-twl4030: Use the same
	name/node for platform as the cpu_dai
Date: Wed, 16 Apr 2014 12:23:23 +0300
Message-ID: <1397640211-15447-11-git-send-email-peter.ujfalusi@ti.com>
References: <1397640211-15447-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id 9D2B12652E8
 for <alsa-devel@alsa-project.org>; Wed, 16 Apr 2014 11:24:01 +0200 (CEST)
In-Reply-To: <1397640211-15447-1-git-send-email-peter.ujfalusi@ti.com>
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
Cc: alsa-devel@alsa-project.org, Jyri Sarha <jsarha@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, notasas@gmail.com
List-Id: alsa-devel@alsa-project.org

Now that the platform driver is registered with the cpu_dai's device we
can use the same name/node for it.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/omap-twl4030.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/sound/soc/omap/omap-twl4030.c b/sound/soc/omap/omap-twl4030.c
index 6a8d6b5f160d..0c83e206e957 100644
--- a/sound/soc/omap/omap-twl4030.c
+++ b/sound/soc/omap/omap-twl4030.c
@@ -239,7 +239,7 @@ static struct snd_soc_dai_link omap_twl4030_dai_links[] = {
 		.stream_name = "TWL4030 HiFi",
 		.cpu_dai_name = "omap-mcbsp.2",
 		.codec_dai_name = "twl4030-hifi",
-		.platform_name = "omap-pcm-audio",
+		.platform_name = "omap-mcbsp.2",
 		.codec_name = "twl4030-codec",
 		.init = omap_twl4030_init,
 		.ops = &omap_twl4030_ops,
@@ -249,7 +249,7 @@ static struct snd_soc_dai_link omap_twl4030_dai_links[] = {
 		.stream_name = "TWL4030 Voice",
 		.cpu_dai_name = "omap-mcbsp.3",
 		.codec_dai_name = "twl4030-voice",
-		.platform_name = "omap-pcm-audio",
+		.platform_name = "omap-mcbsp.2",
 		.codec_name = "twl4030-codec",
 		.dai_fmt = SND_SOC_DAIFMT_DSP_A | SND_SOC_DAIFMT_IB_NF |
 			   SND_SOC_DAIFMT_CBM_CFM,
@@ -299,12 +299,18 @@ static int omap_twl4030_probe(struct platform_device *pdev)
 		omap_twl4030_dai_links[0].cpu_dai_name  = NULL;
 		omap_twl4030_dai_links[0].cpu_of_node = dai_node;
 
+		omap_twl4030_dai_links[0].platform_name  = NULL;
+		omap_twl4030_dai_links[0].platform_of_node = dai_node;
+
 		dai_node = of_parse_phandle(node, "ti,mcbsp-voice", 0);
 		if (!dai_node) {
 			card->num_links = 1;
 		} else {
 			omap_twl4030_dai_links[1].cpu_dai_name  = NULL;
 			omap_twl4030_dai_links[1].cpu_of_node = dai_node;
+
+			omap_twl4030_dai_links[1].platform_name  = NULL;
+			omap_twl4030_dai_links[1].platform_of_node = dai_node;
 		}
 
 		priv->jack_detect = of_get_named_gpio(node,
-- 
1.9.2
