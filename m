From: Seungwhan Youn <sw.youn@samsung.com>
Subject: [PATCH] ASoC: spdif: Add codec driver to use spdif
	stand-alone
Date: Thu, 27 May 2010 18:13:48 +0900
Message-ID: <1274951628-10572-1-git-send-email-sw.youn@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id F2095103A16
	for <alsa-devel@alsa-project.org>;
	Thu, 27 May 2010 11:20:17 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Seungwhan Youn <sw.youn@samsung.com>, broonie@opensource.wolfsonmicro.com, schen@mvista.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

This patch adds spdif dummy codec driver for using spdif-dit as
a stand-alone. Until this, spdif-dit can be used only with other
codecs like tlv320aci3x in davinci platform.

Signed-off-by: Seungwhan Youn <sw.youn@samsung.com>
---
 sound/soc/codecs/spdif_transciever.c |   93 +++++++++++++++++++++++++++++++++-
 1 files changed, 92 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/spdif_transciever.c b/sound/soc/codecs/spdif_transciever.c
index a631911..f0945ab 100644
--- a/sound/soc/codecs/spdif_transciever.c
+++ b/sound/soc/codecs/spdif_transciever.c
@@ -18,6 +18,7 @@
 #include <linux/moduleparam.h>
 #include <sound/soc.h>
 #include <sound/pcm.h>
+#include <sound/initval.h>
 
 #include "spdif_transciever.h"
 
@@ -26,6 +27,48 @@ MODULE_LICENSE("GPL");
 #define STUB_RATES	SNDRV_PCM_RATE_8000_96000
 #define STUB_FORMATS	SNDRV_PCM_FMTBIT_S16_LE
 
+static struct snd_soc_codec *spdif_dit_codec;
+
+static int spdif_dit_codec_probe(struct platform_device *pdev)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct snd_soc_codec *codec;
+	int ret;
+
+	if (spdif_dit_codec == NULL) {
+		dev_err(&pdev->dev, "Codec device not registered\n");
+		return -ENODEV;
+	}
+
+	socdev->card->codec = spdif_dit_codec;
+	codec = spdif_dit_codec;
+
+	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
+	if (ret < 0) {
+		dev_err(codec->dev, "failed to create pcms: %d\n", ret);
+		goto err_create_pcms;
+	}
+
+	return 0;
+
+err_create_pcms:
+	return ret;
+}
+
+static int spdif_dit_codec_remove(struct platform_device *pdev)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+
+	snd_soc_free_pcms(socdev);
+
+	return 0;
+}
+
+struct snd_soc_codec_device soc_codec_dev_spdif_dit = {
+	.probe		= spdif_dit_codec_probe,
+	.remove		= spdif_dit_codec_remove,
+}; EXPORT_SYMBOL_GPL(soc_codec_dev_spdif_dit);
+
 struct snd_soc_dai dit_stub_dai = {
 	.name		= "DIT",
 	.playback 	= {
@@ -40,13 +83,61 @@ EXPORT_SYMBOL_GPL(dit_stub_dai);
 
 static int spdif_dit_probe(struct platform_device *pdev)
 {
+	struct snd_soc_codec *codec;
+	int ret;
+
+	if (spdif_dit_codec) {
+		dev_err(&pdev->dev, "Another Codec is registered\n");
+		ret = -EINVAL;
+		goto err_reg_codec;
+	}
+
+	codec = kzalloc(sizeof(struct snd_soc_codec), GFP_KERNEL);
+	if (codec == NULL)
+		return -ENOMEM;
+
+	codec->dev = &pdev->dev;
+
+	mutex_init(&codec->mutex);
+
+	INIT_LIST_HEAD(&codec->dapm_widgets);
+	INIT_LIST_HEAD(&codec->dapm_paths);
+
+	codec->name = "spdif-dit";
+	codec->owner = THIS_MODULE;
+	codec->dai = &dit_stub_dai;
+	codec->num_dai = 1;
+
+	spdif_dit_codec = codec;
+
+	ret = snd_soc_register_codec(codec);
+	if (ret < 0) {
+		dev_err(codec->dev, "Failed to register codec: %d\n", ret);
+		goto err_reg_codec;
+	}
+
 	dit_stub_dai.dev = &pdev->dev;
-	return snd_soc_register_dai(&dit_stub_dai);
+	ret = snd_soc_register_dai(&dit_stub_dai);
+	if (ret < 0) {
+		dev_err(codec->dev, "Failed to register dai: %d\n", ret);
+		goto err_reg_dai;
+	}
+
+	return 0;
+
+err_reg_dai:
+	snd_soc_unregister_codec(codec);
+err_reg_codec:
+	kfree(spdif_dit_codec);
+	return ret;
 }
 
 static int spdif_dit_remove(struct platform_device *pdev)
 {
 	snd_soc_unregister_dai(&dit_stub_dai);
+	snd_soc_unregister_codec(spdif_dit_codec);
+	kfree(spdif_dit_codec);
+	spdif_dit_codec = NULL;
 	return 0;
 }
 
-- 
1.6.2.5
