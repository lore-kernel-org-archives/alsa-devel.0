From: Sachin Kamat <sachin.kamat@samsung.com>
Subject: [PATCH Resend 1/1] ASoC: mc13783: Add missing
	of_node_put
Date: Fri, 20 Jun 2014 14:41:58 +0530
Message-ID: <1403255518-30011-1-git-send-email-sachin.kamat@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f179.google.com (mail-pd0-f179.google.com
 [209.85.192.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 442DF261A50
 for <alsa-devel@alsa-project.org>; Fri, 20 Jun 2014 11:15:08 +0200 (CEST)
Received: by mail-pd0-f179.google.com with SMTP id w10so2773203pde.24
 for <alsa-devel@alsa-project.org>; Fri, 20 Jun 2014 02:15:06 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, s.hauer@pengutronix.de, broonie@kernel.org, spk.linux@gmail.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

of_get_child_by_name expects of_node_put be called when done.

Signed-off-by: Sachin Kamat <sachin.kamat@samsung.com>
---
 sound/soc/codecs/mc13783.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/mc13783.c b/sound/soc/codecs/mc13783.c
index 9965277b595a..388f90a597fa 100644
--- a/sound/soc/codecs/mc13783.c
+++ b/sound/soc/codecs/mc13783.c
@@ -766,11 +766,11 @@ static int __init mc13783_codec_probe(struct platform_device *pdev)
 
 		ret = of_property_read_u32(np, "adc-port", &priv->adc_ssi_port);
 		if (ret)
-			return ret;
+			goto out;
 
 		ret = of_property_read_u32(np, "dac-port", &priv->dac_ssi_port);
 		if (ret)
-			return ret;
+			goto out;
 	}
 
 	dev_set_drvdata(&pdev->dev, priv);
@@ -783,6 +783,8 @@ static int __init mc13783_codec_probe(struct platform_device *pdev)
 		ret = snd_soc_register_codec(&pdev->dev, &soc_codec_dev_mc13783,
 			mc13783_dai_async, ARRAY_SIZE(mc13783_dai_async));
 
+out:
+	of_node_put(np);
 	return ret;
 }
 
-- 
1.7.9.5
