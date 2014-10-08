From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: mc13783: Ensure we only try to
	dereference valid of_nodes
Date: Wed,  8 Oct 2014 15:40:04 +0100
Message-ID: <1412779204-30876-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 45D56260468
 for <alsa-devel@alsa-project.org>; Wed,  8 Oct 2014 16:40:26 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Reported-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/mc13783.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/mc13783.c b/sound/soc/codecs/mc13783.c
index 388f90a597fa..71f775aad7c7 100644
--- a/sound/soc/codecs/mc13783.c
+++ b/sound/soc/codecs/mc13783.c
@@ -765,12 +765,18 @@ static int __init mc13783_codec_probe(struct platform_device *pdev)
 			return -ENOSYS;
 
 		ret = of_property_read_u32(np, "adc-port", &priv->adc_ssi_port);
-		if (ret)
-			goto out;
+		if (ret) {
+			of_node_put(np);
+			return ret;
+		}
 
 		ret = of_property_read_u32(np, "dac-port", &priv->dac_ssi_port);
-		if (ret)
-			goto out;
+		if (ret) {
+			of_node_put(np);
+			return ret;
+		}
+
+		of_node_put(np);
 	}
 
 	dev_set_drvdata(&pdev->dev, priv);
@@ -783,8 +789,6 @@ static int __init mc13783_codec_probe(struct platform_device *pdev)
 		ret = snd_soc_register_codec(&pdev->dev, &soc_codec_dev_mc13783,
 			mc13783_dai_async, ARRAY_SIZE(mc13783_dai_async));
 
-out:
-	of_node_put(np);
 	return ret;
 }
 
-- 
2.1.1
