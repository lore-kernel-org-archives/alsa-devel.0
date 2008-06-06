From: Timur Tabi <timur@freescale.com>
Subject: [PATCH][ASoC V2] Update snd_soc_card_get_codec() to
	take the codec number
Date: Fri,  6 Jun 2008 11:01:45 -0500
Message-ID: <1212768105-20738-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 8ABD824424
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Jun 2008 18:01:51 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, lg@opensource.wolfsonmicro.com, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Update function snd_soc_card_get_codec() and all the drivers that call it
to take a codec number in addition to a codec name.  This is necessary for
codec drivers that register multiple instances of themselves that differ
only by codec number.

Signed-off-by: Timur Tabi <timur@freescale.com>
---

I have only tested this code on the MPC8610, so please test this on other
platforms before committing.

 include/sound/soc-card.h         |    2 +-
 sound/soc/at91/eti_b1_wm8731.c   |    2 +-
 sound/soc/fsl/mpc8610_hpcd.c     |   10 +++++-----
 sound/soc/imx/imx32ads-wm8350.c  |    2 +-
 sound/soc/pxa/amesom_tlv320.c    |    2 +-
 sound/soc/pxa/corgi.c            |    2 +-
 sound/soc/pxa/e800_wm9712.c      |    2 +-
 sound/soc/pxa/h5000.c            |    2 +-
 sound/soc/pxa/magician.c         |    2 +-
 sound/soc/pxa/mainstone_wm8753.c |    2 +-
 sound/soc/pxa/mainstone_wm9712.c |    2 +-
 sound/soc/pxa/mainstone_wm9713.c |    2 +-
 sound/soc/pxa/poodle.c           |    2 +-
 sound/soc/pxa/spitz.c            |    2 +-
 sound/soc/pxa/tosa.c             |    2 +-
 sound/soc/pxa/zylonite.c         |    2 +-
 sound/soc/soc-core.c             |    5 +++--
 17 files changed, 23 insertions(+), 22 deletions(-)

diff --git a/include/sound/soc-card.h b/include/sound/soc-card.h
index 9b8600d..290f649 100644
--- a/include/sound/soc-card.h
+++ b/include/sound/soc-card.h
@@ -44,7 +44,7 @@ struct snd_ac97_bus_ops *snd_soc_card_get_ac97_ops(
 	struct snd_soc_card *soc_card, const char *dai_id);
 
 struct snd_soc_codec *snd_soc_card_get_codec(struct snd_soc_card *soc_card,
-	const char *codec_id);
+	const char *codec_name, int codec_num);
 
 struct snd_soc_platform * snd_soc_card_get_platform(
 	struct snd_soc_card *soc_card, const char *platform_id);
diff --git a/sound/soc/at91/eti_b1_wm8731.c b/sound/soc/at91/eti_b1_wm8731.c
index bcee769..a70fffe 100644
--- a/sound/soc/at91/eti_b1_wm8731.c
+++ b/sound/soc/at91/eti_b1_wm8731.c
@@ -242,7 +242,7 @@ static int eti_b1_init(struct snd_soc_card *soc_card)
 	struct at91_ssc_periph *ssc;
 	int ret;
 
-	codec = snd_soc_card_get_codec(soc_card, wm8731_codec_id);
+	codec = snd_soc_card_get_codec(soc_card, wm8731_codec_id, 0);
 	if (codec == NULL)
 		return -ENODEV;
 
diff --git a/sound/soc/fsl/mpc8610_hpcd.c b/sound/soc/fsl/mpc8610_hpcd.c
index 45c3311..8813291 100644
--- a/sound/soc/fsl/mpc8610_hpcd.c
+++ b/sound/soc/fsl/mpc8610_hpcd.c
@@ -38,7 +38,6 @@
  * MPC8610 HPCD.  Some of the data is taken from the device tree.
  */
 struct mpc8610_hpcd_data {
-	char codec_name[32];
 	struct snd_soc_card soc_card;
 	struct ccsr_guts __iomem *guts;
 	unsigned int num_configs;
@@ -47,8 +46,6 @@ struct mpc8610_hpcd_data {
 		char pcm_name[32];
 		char ssi_name[32];
 		char codec_name[32];
-		char platform_name[32];
-		char cpu_dai_name[32];
 	} names[MAX_SSI];
 };
 
@@ -99,7 +96,8 @@ static int mpc8610_hpcd_audio_init(struct snd_soc_card *soc_card)
 
 	for (i = 0; i < soc_card_data->num_configs; i++) {
 		codec = snd_soc_card_get_codec(soc_card,
-			soc_card_data->names[i].codec_name);
+			soc_card_data->names[i].codec_name,
+			soc_card_data->configs[i].codec_num);
 
 		if (!codec) {
 			dev_err(soc_card->dev, "could not find codec\n");
@@ -111,7 +109,9 @@ static int mpc8610_hpcd_audio_init(struct snd_soc_card *soc_card)
 		 */
 		ret = snd_soc_card_init_codec(codec, soc_card);
 		if (ret < 0) {
-			dev_err(soc_card->dev, "could not initialize codec\n");
+			dev_err(soc_card->dev,
+				"could not initialize codec %s-%u\n",
+				codec->name, codec->num);
 			continue;
 		}
 	}
diff --git a/sound/soc/imx/imx32ads-wm8350.c b/sound/soc/imx/imx32ads-wm8350.c
index feb83cc..94de723 100644
--- a/sound/soc/imx/imx32ads-wm8350.c
+++ b/sound/soc/imx/imx32ads-wm8350.c
@@ -407,7 +407,7 @@ int imx32_audio_init(struct snd_soc_card *soc_card)
 	if (pcm_runtime == NULL)
 		return -ENODEV;
 
-	codec = snd_soc_card_get_codec(soc_card, wm8350_codec_id);
+	codec = snd_soc_card_get_codec(soc_card, wm8350_codec_id, 0);
 	if (codec == NULL)
 		return -ENODEV;
 
diff --git a/sound/soc/pxa/amesom_tlv320.c b/sound/soc/pxa/amesom_tlv320.c
index 9be4db0..c2ba22a 100644
--- a/sound/soc/pxa/amesom_tlv320.c
+++ b/sound/soc/pxa/amesom_tlv320.c
@@ -134,7 +134,7 @@ static int amesom_tlv320_init(struct snd_soc_card *soc_card)
 {
 	struct snd_soc_codec *codec;
 
-	codec = snd_soc_card_get_codec(soc_card, tlv320_codec_id);
+	codec = snd_soc_card_get_codec(soc_card, tlv320_codec_id, 0);
 	if (codec == NULL)
 		return -ENODEV;
 
diff --git a/sound/soc/pxa/corgi.c b/sound/soc/pxa/corgi.c
index c24d76b..9f30f12 100644
--- a/sound/soc/pxa/corgi.c
+++ b/sound/soc/pxa/corgi.c
@@ -313,7 +313,7 @@ static int corgi_init(struct snd_soc_card *soc_card)
 	struct snd_soc_codec *codec;
 	int ret;
 
-	codec = snd_soc_card_get_codec(soc_card, wm8731_codec_id);
+	codec = snd_soc_card_get_codec(soc_card, wm8731_codec_id, 0);
 	if (codec == NULL)
 		return -ENODEV;
 
diff --git a/sound/soc/pxa/e800_wm9712.c b/sound/soc/pxa/e800_wm9712.c
index 987106a..9159d03 100644
--- a/sound/soc/pxa/e800_wm9712.c
+++ b/sound/soc/pxa/e800_wm9712.c
@@ -50,7 +50,7 @@ static int e800_init(struct snd_soc_card *soc_card)
 	struct snd_ac97_bus_ops *ac97_ops;
 	int ret;
 
-	codec = snd_soc_card_get_codec(soc_card, wm9712_codec_id);
+	codec = snd_soc_card_get_codec(soc_card, wm9712_codec_id, 0);
 	if (codec == NULL)
 		return -ENODEV;
 
diff --git a/sound/soc/pxa/h5000.c b/sound/soc/pxa/h5000.c
index 54ff23c..fa340f4 100644
--- a/sound/soc/pxa/h5000.c
+++ b/sound/soc/pxa/h5000.c
@@ -272,7 +272,7 @@ static int h5000_ak4535_init (struct snd_soc_card *soc_card)
 	struct snd_soc_codec *codec;
 	int ret;
 
-	codec = snd_soc_card_get_codec(soc_card, ak4535_codec_id);
+	codec = snd_soc_card_get_codec(soc_card, ak4535_codec_id, 0);
 	if (codec == NULL)
 		return -ENODEV;
 
diff --git a/sound/soc/pxa/magician.c b/sound/soc/pxa/magician.c
index ad6dea7..0d7b145 100644
--- a/sound/soc/pxa/magician.c
+++ b/sound/soc/pxa/magician.c
@@ -436,7 +436,7 @@ static int magician_uda1380_init(struct snd_soc_card *soc_card)
 	struct snd_soc_codec *codec;
 	int ret;
 
-	codec = snd_soc_card_get_codec(soc_card, uda1380_codec_id);
+	codec = snd_soc_card_get_codec(soc_card, uda1380_codec_id, 0);
 	if (codec == NULL)
 		return -ENODEV;
 
diff --git a/sound/soc/pxa/mainstone_wm8753.c b/sound/soc/pxa/mainstone_wm8753.c
index f7ab6fb..2bef9e9 100644
--- a/sound/soc/pxa/mainstone_wm8753.c
+++ b/sound/soc/pxa/mainstone_wm8753.c
@@ -328,7 +328,7 @@ static int mainstone_wm8753_init(struct snd_soc_card *soc_card)
 	struct snd_soc_codec *codec;
 	int ret;
 
-	codec = snd_soc_card_get_codec(soc_card, wm8753_codec_id);
+	codec = snd_soc_card_get_codec(soc_card, wm8753_codec_id, 0);
 	if (codec == NULL)
 		return -ENODEV;
 
diff --git a/sound/soc/pxa/mainstone_wm9712.c b/sound/soc/pxa/mainstone_wm9712.c
index b87362b..f2ded1d 100644
--- a/sound/soc/pxa/mainstone_wm9712.c
+++ b/sound/soc/pxa/mainstone_wm9712.c
@@ -81,7 +81,7 @@ static int mainstone_wm9712_init(struct snd_soc_card *soc_card)
 	struct snd_ac97_bus_ops *ac97_ops;
 	int ret;
 
-	codec = snd_soc_card_get_codec(soc_card, wm9712_codec_id);
+	codec = snd_soc_card_get_codec(soc_card, wm9712_codec_id, 0);
 	if (codec == NULL)
 		return -ENODEV;
 
diff --git a/sound/soc/pxa/mainstone_wm9713.c b/sound/soc/pxa/mainstone_wm9713.c
index 9492b3e..f9723e1 100644
--- a/sound/soc/pxa/mainstone_wm9713.c
+++ b/sound/soc/pxa/mainstone_wm9713.c
@@ -163,7 +163,7 @@ static int mainstone_wm9713_init(struct snd_soc_card *soc_card)
 	struct snd_ac97_bus_ops *ac97_ops;
 	int ret;
 
-	codec = snd_soc_card_get_codec(soc_card, wm9713_codec_id);
+	codec = snd_soc_card_get_codec(soc_card, wm9713_codec_id, 0);
 	if (codec == NULL)
 		return -ENODEV;
 
diff --git a/sound/soc/pxa/poodle.c b/sound/soc/pxa/poodle.c
index 4ce0ce4..126ba5b 100644
--- a/sound/soc/pxa/poodle.c
+++ b/sound/soc/pxa/poodle.c
@@ -264,7 +264,7 @@ static int poodle_init(struct snd_soc_card *soc_card)
 	struct snd_soc_codec *codec;
 	int ret;
 
-	codec = snd_soc_card_get_codec(soc_card, wm8731_codec_id);
+	codec = snd_soc_card_get_codec(soc_card, wm8731_codec_id, 0);
 	if (codec == NULL)
 		return -ENODEV;
 
diff --git a/sound/soc/pxa/spitz.c b/sound/soc/pxa/spitz.c
index 497b3b2..393adda 100644
--- a/sound/soc/pxa/spitz.c
+++ b/sound/soc/pxa/spitz.c
@@ -315,7 +315,7 @@ static int spitz_init(struct snd_soc_card *soc_card)
 	struct snd_soc_codec *codec;
 	int ret;
 
-	codec = snd_soc_card_get_codec(soc_card, wm8750_codec_id);
+	codec = snd_soc_card_get_codec(soc_card, wm8750_codec_id, 0);
 	if (codec == NULL)
 		return -ENODEV;
 
diff --git a/sound/soc/pxa/tosa.c b/sound/soc/pxa/tosa.c
index 77688e2..18e8e4b 100644
--- a/sound/soc/pxa/tosa.c
+++ b/sound/soc/pxa/tosa.c
@@ -211,7 +211,7 @@ static int tosa_init(struct snd_soc_card *soc_card)
 	struct snd_ac97_bus_ops *ac97_ops;
 	int ret;
 
-	codec = snd_soc_card_get_codec(soc_card, wm9712_codec_id);
+	codec = snd_soc_card_get_codec(soc_card, wm9712_codec_id, 0);
 	if (codec == NULL)
 		return -ENODEV;
 
diff --git a/sound/soc/pxa/zylonite.c b/sound/soc/pxa/zylonite.c
index a7e8ab7..4209fc2 100644
--- a/sound/soc/pxa/zylonite.c
+++ b/sound/soc/pxa/zylonite.c
@@ -93,7 +93,7 @@ static int zylonite_init(struct snd_soc_card *card)
 	struct snd_ac97_bus_ops *ac97_ops;
 	int ret;
 
-	codec = snd_soc_card_get_codec(card, wm9713_codec_id);
+	codec = snd_soc_card_get_codec(card, wm9713_codec_id, 0);
 	if (codec == NULL) {
 		printk(KERN_ERR "Unable to obtain WM9713 codec\n");
 		return -ENODEV;
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 520469b..a88e3a0 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2172,12 +2172,13 @@ EXPORT_SYMBOL_GPL(snd_soc_card_free);
  * Get a codec from a codec ID.
  */
 struct snd_soc_codec *snd_soc_card_get_codec(struct snd_soc_card *soc_card,
-	const char *codec_id)
+	const char *codec_name, int codec_num)
 {
 	struct soc_pcm_config *config;
 
 	list_for_each_entry(config, &soc_card->config_list, list) {
-		if (config->codec && !strcmp(config->codec->name, codec_id))
+		if (config->codec && !strcmp(config->codec->name, codec_name)
+		    && config->codec->num == codec_num)
 			return config->codec;
 	}
 	return NULL;
-- 
1.5.5
