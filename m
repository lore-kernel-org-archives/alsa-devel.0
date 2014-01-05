From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH 4/5] ASoC: mc13783: trivial: Cleanup module
Date: Sun,  5 Jan 2014 11:38:34 +0400
Message-ID: <1388907515-18975-4-git-send-email-shc_work@mail.ru>
References: <1388907515-18975-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp42.i.mail.ru (smtp42.i.mail.ru [94.100.177.102])
 by alsa0.perex.cz (Postfix) with ESMTP id 1ACEA261B1E
 for <alsa-devel@alsa-project.org>; Sun,  5 Jan 2014 08:38:50 +0100 (CET)
In-Reply-To: <1388907515-18975-1-git-send-email-shc_work@mail.ru>
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
Cc: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Alexander Shiyan <shc_work@mail.ru>
List-Id: alsa-devel@alsa-project.org

This is a trivial cleanup: remove useless variable mc13xxx and
extra spaces. No functional changes.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 sound/soc/codecs/mc13783.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/mc13783.c b/sound/soc/codecs/mc13783.c
index 997f708..582c2bb 100644
--- a/sound/soc/codecs/mc13783.c
+++ b/sound/soc/codecs/mc13783.c
@@ -752,20 +752,14 @@ static struct snd_soc_codec_driver soc_codec_dev_mc13783 = {
 
 static int __init mc13783_codec_probe(struct platform_device *pdev)
 {
-	struct mc13xxx *mc13xxx;
 	struct mc13783_priv *priv;
 	struct mc13xxx_codec_platform_data *pdata = pdev->dev.platform_data;
 	int ret;
 
-	mc13xxx = dev_get_drvdata(pdev->dev.parent);
-
-
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
-	if (priv == NULL)
+	if (!priv)
 		return -ENOMEM;
 
-	dev_set_drvdata(&pdev->dev, priv);
-	priv->mc13xxx = mc13xxx;
 	if (pdata) {
 		priv->adc_ssi_port = pdata->adc_ssi_port;
 		priv->dac_ssi_port = pdata->dac_ssi_port;
@@ -773,6 +767,9 @@ static int __init mc13783_codec_probe(struct platform_device *pdev)
 		return -ENOSYS;
 	}
 
+	dev_set_drvdata(&pdev->dev, priv);
+	priv->mc13xxx = dev_get_drvdata(pdev->dev.parent);
+
 	if (priv->adc_ssi_port == priv->dac_ssi_port)
 		ret = snd_soc_register_codec(&pdev->dev, &soc_codec_dev_mc13783,
 			mc13783_dai_sync, ARRAY_SIZE(mc13783_dai_sync));
@@ -792,9 +789,9 @@ static int mc13783_codec_remove(struct platform_device *pdev)
 
 static struct platform_driver mc13783_codec_driver = {
 	.driver = {
-		   .name = "mc13783-codec",
-		   .owner = THIS_MODULE,
-		   },
+		.name	= "mc13783-codec",
+		.owner	= THIS_MODULE,
+	},
 	.remove = mc13783_codec_remove,
 };
 module_platform_driver_probe(mc13783_codec_driver, mc13783_codec_probe);
-- 
1.8.3.2
