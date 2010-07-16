From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] twl6040: fix wrong kfree in twl6040_remove and
	twl6040_codec_remove
Date: Fri, 16 Jul 2010 17:26:48 +0800
Message-ID: <1279272408.2594.1.camel@mola>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Margarita Olaya Cabrera <magi.olaya@ti.com>, Jorge Eduardo Candelaria <jorge.candelaria@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Memory allocation part:
We allocate a memory in twl6040_codec_probe():
        priv = kzalloc(sizeof(struct twl6040_data), GFP_KERNEL);
        twl6040_codec = codec = &priv->codec;

Memory release part:
In twl6040_codec_remove() we should kfree(priv) instead of kfree(twl6040_codec).
In twl6040_remove(), no need and should not kfree(codec).

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/twl6040.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index af36346..9d4a85f 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -1068,7 +1068,6 @@ static int twl6040_remove(struct platform_device *pdev)
 	twl6040_set_bias_level(codec, SND_SOC_BIAS_OFF);
 	snd_soc_free_pcms(socdev);
 	snd_soc_dapm_free(socdev);
-	kfree(codec);
 
 	return 0;
 }
@@ -1214,7 +1213,7 @@ static int __devexit twl6040_codec_remove(struct platform_device *pdev)
 	snd_soc_unregister_dai(&twl6040_dai);
 	snd_soc_unregister_codec(twl6040_codec);
 
-	kfree(twl6040_codec);
+	kfree(priv);
 	twl6040_codec = NULL;
 
 	return 0;
-- 
1.5.4.3
