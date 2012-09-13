From: Eric Millbrandt <emillbrandt@dekaresearch.com>
Subject: [PATCH 5/7] ASoC: fsl: convert pcm030-audio-fabric to
	a platform-driver
Date: Thu, 13 Sep 2012 17:43:14 -0400
Message-ID: <1347572596-37540-6-git-send-email-emillbrandt@dekaresearch.com>
References: <1347572596-37540-1-git-send-email-emillbrandt@dekaresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from norco.coldhaus.com (norco.coldhaus.com [64.32.230.18])
 by alsa0.perex.cz (Postfix) with ESMTP id 23453262608
 for <alsa-devel@alsa-project.org>; Thu, 13 Sep 2012 23:43:28 +0200 (CEST)
In-Reply-To: <1347572596-37540-1-git-send-email-emillbrandt@dekaresearch.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Grant Likely <grant.likely@secretlab.ca>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Anatolij Gustschin <agust@denx.de>
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, Eric Millbrandt <emillbrandt@dekaresearch.com>
List-Id: alsa-devel@alsa-project.org

This patch converts the pcm030-audio-fabric driver to a platform-driver and
adds a remove function.

Signed-off-by: Eric Millbrandt <emillbrandt@dekaresearch.com>

diff --git a/sound/soc/fsl/pcm030-audio-fabric.c b/sound/soc/fsl/pcm030-audio-fabric.c
index 1353e8f..5c8e2d6 100644
--- a/sound/soc/fsl/pcm030-audio-fabric.c
+++ b/sound/soc/fsl/pcm030-audio-fabric.c
@@ -48,7 +48,7 @@ static struct snd_soc_card card = {
 	.num_links = ARRAY_SIZE(pcm030_fabric_dai),
 };
 
-static __init int pcm030_fabric_init(void)
+static int __init pcm030_fabric_probe(struct platform_device *op)
 {
 	struct platform_device *pdev;
 	int rc;
@@ -62,6 +62,7 @@ static __init int pcm030_fabric_init(void)
 		return -ENODEV;
 	}
 
+	platform_set_drvdata(op, pdev);
 	platform_set_drvdata(pdev, &card);
 
 	rc = platform_device_add(pdev);
@@ -73,7 +74,32 @@ static __init int pcm030_fabric_init(void)
 	return 0;
 }
 
-module_init(pcm030_fabric_init);
+static int __devexit pcm030_fabric_remove(struct platform_device *op)
+{
+	struct platform_device *pdev = platform_get_drvdata(op);
+
+	platform_device_unregister(pdev);
+
+	return 0;
+}
+
+static struct of_device_id pcm030_audio_match[] = {
+	{ .compatible = "phytec,pcm030-audio-fabric", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, pcm030_audio_match);
+
+static struct platform_driver pcm030_fabric_driver = {
+	.probe		= pcm030_fabric_probe,
+	.remove		= __devexit_p(pcm030_fabric_remove),
+	.driver		= {
+		.name	= DRV_NAME,
+		.owner	= THIS_MODULE,
+		.of_match_table    = pcm030_audio_match,
+	},
+};
+
+module_platform_driver(pcm030_fabric_driver);
 
 
 MODULE_AUTHOR("Jon Smirl <jonsmirl@gmail.com>");
-- 
1.7.2.5
