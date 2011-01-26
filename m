From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/3] ASoC: Replace pdev with card in machine
	driver probe and remove
Date: Wed, 26 Jan 2011 17:08:28 +0000
Message-ID: <1296061709-12494-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1296061709-12494-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0B65C2459A
	for <alsa-devel@alsa-project.org>; Wed, 26 Jan 2011 18:08:37 +0100 (CET)
In-Reply-To: <1296061709-12494-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

In order to support cards instantiated without using soc-audio remove
the use of the platform device in the card probe() and remove() ops.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc.h          |    4 ++--
 sound/soc/fsl/mpc8610_hpcd.c |    6 ++----
 sound/soc/fsl/p1022_ds.c     |    6 ++----
 sound/soc/pxa/tosa.c         |    4 ++--
 sound/soc/pxa/zylonite.c     |    4 ++--
 sound/soc/soc-core.c         |    8 +++-----
 6 files changed, 13 insertions(+), 19 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index d1cc1a2..a6a9013 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -650,8 +650,8 @@ struct snd_soc_card {
 
 	bool instantiated;
 
-	int (*probe)(struct platform_device *pdev);
-	int (*remove)(struct platform_device *pdev);
+	int (*probe)(struct snd_soc_card *card);
+	int (*remove)(struct snd_soc_card *card);
 
 	/* the pre and post PM functions are used to do any PM work before and
 	 * after the codec and DAI's do any PM work. */
diff --git a/sound/soc/fsl/mpc8610_hpcd.c b/sound/soc/fsl/mpc8610_hpcd.c
index 7d7847a..c16c6b2 100644
--- a/sound/soc/fsl/mpc8610_hpcd.c
+++ b/sound/soc/fsl/mpc8610_hpcd.c
@@ -53,9 +53,8 @@ struct mpc8610_hpcd_data {
  *
  * Here we program the DMACR and PMUXCR registers.
  */
-static int mpc8610_hpcd_machine_probe(struct platform_device *sound_device)
+static int mpc8610_hpcd_machine_probe(struct snd_soc_card *card)
 {
-	struct snd_soc_card *card = platform_get_drvdata(sound_device);
 	struct mpc8610_hpcd_data *machine_data =
 		container_of(card, struct mpc8610_hpcd_data, card);
 	struct ccsr_guts_86xx __iomem *guts;
@@ -138,9 +137,8 @@ static int mpc8610_hpcd_startup(struct snd_pcm_substream *substream)
  * This function is called to remove the sound device for one SSI.  We
  * de-program the DMACR and PMUXCR register.
  */
-static int mpc8610_hpcd_machine_remove(struct platform_device *sound_device)
+static int mpc8610_hpcd_machine_remove(struct snd_soc_card *card)
 {
-	struct snd_soc_card *card = platform_get_drvdata(sound_device);
 	struct mpc8610_hpcd_data *machine_data =
 		container_of(card, struct mpc8610_hpcd_data, card);
 	struct ccsr_guts_86xx __iomem *guts;
diff --git a/sound/soc/fsl/p1022_ds.c b/sound/soc/fsl/p1022_ds.c
index 026b756..66e0b68 100644
--- a/sound/soc/fsl/p1022_ds.c
+++ b/sound/soc/fsl/p1022_ds.c
@@ -85,9 +85,8 @@ struct machine_data {
  *
  * Here we program the DMACR and PMUXCR registers.
  */
-static int p1022_ds_machine_probe(struct platform_device *sound_device)
+static int p1022_ds_machine_probe(struct snd_soc_card *card)
 {
-	struct snd_soc_card *card = platform_get_drvdata(sound_device);
 	struct machine_data *mdata =
 		container_of(card, struct machine_data, card);
 	struct ccsr_guts_85xx __iomem *guts;
@@ -160,9 +159,8 @@ static int p1022_ds_startup(struct snd_pcm_substream *substream)
  * This function is called to remove the sound device for one SSI.  We
  * de-program the DMACR and PMUXCR register.
  */
-static int p1022_ds_machine_remove(struct platform_device *sound_device)
+static int p1022_ds_machine_remove(struct snd_soc_card *card)
 {
-	struct snd_soc_card *card = platform_get_drvdata(sound_device);
 	struct machine_data *mdata =
 		container_of(card, struct machine_data, card);
 	struct ccsr_guts_85xx __iomem *guts;
diff --git a/sound/soc/pxa/tosa.c b/sound/soc/pxa/tosa.c
index f75804e..489139a 100644
--- a/sound/soc/pxa/tosa.c
+++ b/sound/soc/pxa/tosa.c
@@ -237,7 +237,7 @@ static struct snd_soc_dai_link tosa_dai[] = {
 },
 };
 
-static int tosa_probe(struct platform_device *dev)
+static int tosa_probe(struct snd_soc_card *card)
 {
 	int ret;
 
@@ -251,7 +251,7 @@ static int tosa_probe(struct platform_device *dev)
 	return ret;
 }
 
-static int tosa_remove(struct platform_device *dev)
+static int tosa_remove(struct snd_soc_card *card)
 {
 	gpio_free(TOSA_GPIO_L_MUTE);
 	return 0;
diff --git a/sound/soc/pxa/zylonite.c b/sound/soc/pxa/zylonite.c
index 7b72901..c585829 100644
--- a/sound/soc/pxa/zylonite.c
+++ b/sound/soc/pxa/zylonite.c
@@ -189,7 +189,7 @@ static struct snd_soc_dai_link zylonite_dai[] = {
 },
 };
 
-static int zylonite_probe(struct platform_device *pdev)
+static int zylonite_probe(struct snd_soc_card *card)
 {
 	int ret;
 
@@ -216,7 +216,7 @@ static int zylonite_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int zylonite_remove(struct platform_device *pdev)
+static int zylonite_remove(struct snd_soc_card *card)
 {
 	if (clk_pout) {
 		clk_disable(pout);
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 446838e..4bc2365 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1717,7 +1717,6 @@ static int snd_soc_init_codec_cache(struct snd_soc_codec *codec,
 
 static void snd_soc_instantiate_card(struct snd_soc_card *card)
 {
-	struct platform_device *pdev = to_platform_device(card->dev);
 	struct snd_soc_codec *codec;
 	struct snd_soc_codec_conf *codec_conf;
 	enum snd_soc_compress_type compress_type;
@@ -1781,7 +1780,7 @@ static void snd_soc_instantiate_card(struct snd_soc_card *card)
 
 	/* initialise the sound card only once */
 	if (card->probe) {
-		ret = card->probe(pdev);
+		ret = card->probe(card);
 		if (ret < 0)
 			goto card_probe_error;
 	}
@@ -1842,7 +1841,7 @@ probe_dai_err:
 
 card_probe_error:
 	if (card->remove)
-		card->remove(pdev);
+		card->remove(card);
 
 	snd_card_free(card->snd_card);
 
@@ -1888,7 +1887,6 @@ static int soc_probe(struct platform_device *pdev)
 
 static int soc_cleanup_card_resources(struct snd_soc_card *card)
 {
-	struct platform_device *pdev = to_platform_device(card->dev);
 	int i;
 
 	/* make sure any delayed work runs */
@@ -1909,7 +1907,7 @@ static int soc_cleanup_card_resources(struct snd_soc_card *card)
 
 	/* remove the card */
 	if (card->remove)
-		card->remove(pdev);
+		card->remove(card);
 
 	kfree(card->rtd);
 	snd_card_free(card->snd_card);
-- 
1.7.2.3
