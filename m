From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Convert DA7210 to table based DAPM init
Date: Fri, 14 Oct 2011 20:28:56 +0100
Message-ID: <1318620536-17352-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1279424469
	for <alsa-devel@alsa-project.org>;
	Fri, 14 Oct 2011 21:29:00 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ashish Chavan <ashish.chavan@kpitcummins.com>, David Dajun Chen <david.chen@diasemi.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/da7210.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/da7210.c b/sound/soc/codecs/da7210.c
index ff68247..3b5dc0d 100644
--- a/sound/soc/codecs/da7210.c
+++ b/sound/soc/codecs/da7210.c
@@ -528,9 +528,6 @@ static int da7210_probe(struct snd_soc_codec *codec)
 	/* Activate all enabled subsystem */
 	snd_soc_write(codec, DA7210_STARTUP1, DA7210_SC_MST_EN);
 
-	snd_soc_add_controls(codec, da7210_snd_controls,
-			     ARRAY_SIZE(da7210_snd_controls));
-
 	dev_info(codec->dev, "DA7210 Audio Codec %s\n", DA7210_VERSION);
 
 	return 0;
@@ -542,6 +539,9 @@ static struct snd_soc_codec_driver soc_codec_dev_da7210 = {
 	.reg_word_size		= sizeof(u8),
 	.reg_cache_default	= da7210_reg,
 	.volatile_register	= da7210_volatile_register,
+
+	.controls		= da7210_snd_controls,
+	.num_controls		= ARRAY_SIZE(da7210_snd_controls),
 };
 
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
-- 
1.7.6.3
