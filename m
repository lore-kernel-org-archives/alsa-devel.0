From: Liam Girdwood <lrg@ti.com>
Subject: [PATCH] ASoC: utils - Add support for a dummy codec
	driver.
Date: Mon,  9 Jan 2012 12:36:24 +0000
Message-ID: <1326112584-14942-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog115.obsmtp.com (na3sys009aog115.obsmtp.com
	[74.125.149.238])
	by alsa0.perex.cz (Postfix) with ESMTP id 25E771039DB
	for <alsa-devel@alsa-project.org>; Mon,  9 Jan 2012 13:36:28 +0100 (CET)
Received: by mail-ww0-f53.google.com with SMTP id dt10so1266508wgb.22
	for <alsa-devel@alsa-project.org>; Mon, 09 Jan 2012 04:36:27 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

This is useful to create dummy codec devices where we need to have some
DAI links without a real Codec. e.g. could be used to represent dumb FM,
MODEM, etc

This is also used by dynamic PCM for DAI links that have no codec.

Signed-off-by: Liam Girdwood <lrg@ti.com>
---
 sound/soc/soc-utils.c |   20 +++++++++++++++++++-
 1 files changed, 19 insertions(+), 1 deletions(-)

diff --git a/sound/soc/soc-utils.c b/sound/soc/soc-utils.c
index 4220bb0..329122d 100644
--- a/sound/soc/soc-utils.c
+++ b/sound/soc/soc-utils.c
@@ -89,14 +89,32 @@ static struct snd_soc_platform_driver dummy_platform = {
 	.ops = &dummy_dma_ops,
 };
 
+static struct snd_soc_codec_driver dummy_codec;
+static struct snd_soc_dai_driver dummy_dai = {
+		.name = "snd-soc-dummy-dai",
+};
+
 static __devinit int snd_soc_dummy_probe(struct platform_device *pdev)
 {
-	return snd_soc_register_platform(&pdev->dev, &dummy_platform);
+	int ret;
+
+	ret = snd_soc_register_codec(&pdev->dev, &dummy_codec, &dummy_dai, 1);
+	if (ret < 0)
+		return ret;
+
+	ret = snd_soc_register_platform(&pdev->dev, &dummy_platform);
+	if (ret < 0) {
+		snd_soc_unregister_codec(&pdev->dev);
+		return ret;
+	}
+
+	return ret;
 }
 
 static __devexit int snd_soc_dummy_remove(struct platform_device *pdev)
 {
 	snd_soc_unregister_platform(&pdev->dev);
+	snd_soc_unregister_codec(&pdev->dev);
 
 	return 0;
 }
-- 
1.7.5.4
