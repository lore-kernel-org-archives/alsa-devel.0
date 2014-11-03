From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/2] ASoC: Remove platform field from
	snd_soc_dai
Date: Mon,  3 Nov 2014 10:31:48 +0100
Message-ID: <1415007108-18895-2-git-send-email-lars@metafoo.de>
References: <1415007108-18895-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-246.synserver.de (smtp-out-246.synserver.de
 [212.40.185.246])
 by alsa0.perex.cz (Postfix) with ESMTP id 765D3260483
 for <alsa-devel@alsa-project.org>; Mon,  3 Nov 2014 10:31:49 +0100 (CET)
In-Reply-To: <1415007108-18895-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Typically a DAI does not need direct access to the platform. Currently the
only user of this field is in a platform driver where we have a more direct
way of getting a pointer to the platform. This patch updates the driver to
use the more direct way and then removes the platform field from the
snd_soc_dai struct.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc-dai.h   | 1 -
 sound/soc/soc-core.c      | 2 --
 sound/soc/txx9/txx9aclc.c | 2 +-
 3 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index e8b3080..45d0fa1 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -268,7 +268,6 @@ struct snd_soc_dai {
 	unsigned int sample_bits;
 
 	/* parent platform/codec */
-	struct snd_soc_platform *platform;
 	struct snd_soc_codec *codec;
 	struct snd_soc_component *component;
 
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 00e944e..3818cf3 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1309,7 +1309,6 @@ static int soc_probe_link_dais(struct snd_soc_card *card, int num, int order)
 {
 	struct snd_soc_dai_link *dai_link = &card->dai_link[num];
 	struct snd_soc_pcm_runtime *rtd = &card->rtd[num];
-	struct snd_soc_platform *platform = rtd->platform;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	int i, ret;
 
@@ -1317,7 +1316,6 @@ static int soc_probe_link_dais(struct snd_soc_card *card, int num, int order)
 			card->name, num, order);
 
 	/* config components */
-	cpu_dai->platform = platform;
 	cpu_dai->card = card;
 	for (i = 0; i < rtd->num_codecs; i++)
 		rtd->codec_dais[i]->card = card;
diff --git a/sound/soc/txx9/txx9aclc.c b/sound/soc/txx9/txx9aclc.c
index cd71fd8..00b7e2d 100644
--- a/sound/soc/txx9/txx9aclc.c
+++ b/sound/soc/txx9/txx9aclc.c
@@ -292,7 +292,7 @@ static int txx9aclc_pcm_new(struct snd_soc_pcm_runtime *rtd)
 	struct snd_card *card = rtd->card->snd_card;
 	struct snd_soc_dai *dai = rtd->cpu_dai;
 	struct snd_pcm *pcm = rtd->pcm;
-	struct platform_device *pdev = to_platform_device(dai->platform->dev);
+	struct platform_device *pdev = to_platform_device(rtd->platform->dev);
 	struct txx9aclc_soc_device *dev;
 	struct resource *r;
 	int i;
-- 
1.8.0
