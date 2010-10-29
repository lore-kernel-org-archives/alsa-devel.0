From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [RFC_iii/iv 2/2] ASoC: Allow register dailess codecs
	in machine driver
Date: Fri, 29 Oct 2010 15:03:00 +0300
Message-ID: <1288353780-22041-2-git-send-email-jhnikula@gmail.com>
References: <1288353780-22041-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 5C5EB103891
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Oct 2010 14:01:54 +0200 (CEST)
Received: by mail-ey0-f179.google.com with SMTP id 24so1790696eyg.38
	for <alsa-devel@alsa-project.org>; Fri, 29 Oct 2010 05:01:54 -0700 (PDT)
In-Reply-To: <1288353780-22041-1-git-send-email-jhnikula@gmail.com>
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

This makes possible to register dailess codecs in a machine driver. Term
dailess is used here for amplifiers and codecs without DAI or DAI being
unused.

Dailess codecs are registered by letting cpu_dai_name, codec_dai_name and
platform_name to be NULL in struct snd_soc_dev_map. Other fields remain the
same so machine driver can setup paths and widgets for dailess codecs as
usual. Only difference is that the PCM is not created.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
 include/sound/soc.h  |    1 +
 sound/soc/soc-core.c |   32 ++++++++++++++++++++++----------
 2 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 49e48f0..17f985c 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -603,6 +603,7 @@ struct snd_soc_pcm_runtime  {
 
 	unsigned int complete:1;
 	unsigned int dev_registered:1;
+	unsigned int dailess:1;
 
 	/* Symmetry data - only valid if symmetry is being enforced */
 	unsigned int rate;
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index fa05fa8..b904a20 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1217,7 +1217,7 @@ static int soc_bind_dev_map(struct snd_soc_card *card, int num)
 	dev_dbg(card->dev, "binding %s at idx %d\n", dev_map->name, num);
 
 	/* do we already have the CPU DAI for this link ? */
-	if (rtd->cpu_dai) {
+	if (rtd->cpu_dai  || !dev_map->cpu_dai_name) {
 		goto find_codec;
 	}
 	/* no, then find CPU DAI from registered DAIs*/
@@ -1248,6 +1248,9 @@ find_codec:
 			if (!try_module_get(codec->dev->driver->owner))
 				return -ENODEV;
 
+			if (!dev_map->codec_dai_name)
+				goto find_platform;
+
 			/* CODEC found, so find CODEC DAI from registered DAIs from this CODEC*/
 			list_for_each_entry(codec_dai, &dai_list, list) {
 				if (codec->dev == codec_dai->dev &&
@@ -1267,7 +1270,7 @@ find_codec:
 
 find_platform:
 	/* do we already have the CODEC DAI for this link ? */
-	if (rtd->platform) {
+	if (rtd->platform || !dev_map->platform_name) {
 		goto out;
 	}
 	/* no, then find CPU DAI from registered DAIs*/
@@ -1287,8 +1290,12 @@ find_platform:
 	return 0;
 
 out:
+	rtd->dailess = (!dev_map->platform_name && !dev_map->cpu_dai_name &&
+			!dev_map->codec_dai_name);
 	/* mark rtd as complete if we found all 4 of our client devices */
-	if (rtd->codec && rtd->codec_dai && rtd->platform && rtd->cpu_dai) {
+	if (rtd->codec &&
+	    ((rtd->codec_dai && rtd->platform && rtd->cpu_dai) ||
+	     rtd->dailess)) {
 		rtd->complete = 1;
 		card->num_rtd++;
 	}
@@ -1378,19 +1385,21 @@ static int soc_probe_dev_map(struct snd_soc_card *card, int num)
 	dev_dbg(card->dev, "probe %s dai link %d\n", card->name, num);
 
 	/* config components */
-	codec_dai->codec = codec;
 	codec->card = card;
-	cpu_dai->platform = platform;
 	rtd->card = card;
 	rtd->dev.parent = card->dev;
-	codec_dai->card = card;
-	cpu_dai->card = card;
+	if (!rtd->dailess) {
+		codec_dai->codec = codec;
+		codec_dai->card = card;
+		cpu_dai->platform = platform;
+		cpu_dai->card = card;
+	}
 
 	/* set default power off timeout */
 	rtd->pmdown_time = pmdown_time;
 
 	/* probe the cpu_dai */
-	if (!cpu_dai->probed) {
+	if (cpu_dai && !cpu_dai->probed) {
 		if (cpu_dai->driver->probe) {
 			ret = cpu_dai->driver->probe(cpu_dai);
 			if (ret < 0) {
@@ -1425,7 +1434,7 @@ static int soc_probe_dev_map(struct snd_soc_card *card, int num)
 	}
 
 	/* probe the platform */
-	if (!platform->probed) {
+	if (platform && !platform->probed) {
 		if (platform->driver->probe) {
 			ret = platform->driver->probe(platform);
 			if (ret < 0) {
@@ -1440,7 +1449,7 @@ static int soc_probe_dev_map(struct snd_soc_card *card, int num)
 	}
 
 	/* probe the CODEC DAI */
-	if (!codec_dai->probed) {
+	if (codec_dai && !codec_dai->probed) {
 		if (codec_dai->driver->probe) {
 			ret = codec_dai->driver->probe(codec_dai);
 			if (ret < 0) {
@@ -1495,6 +1504,9 @@ static int soc_probe_dev_map(struct snd_soc_card *card, int num)
 	if (ret < 0)
 		printk(KERN_WARNING "asoc: failed to add codec sysfs files\n");
 
+	if (rtd->dailess)
+		return 0;
+
 	/* create the pcm */
 	ret = soc_new_pcm(rtd, num);
 	if (ret < 0) {
-- 
1.7.2.3
