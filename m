From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ALSA: compress: Pass id string to snd_compress_new
Date: Wed, 25 Nov 2015 09:48:38 +0000
Message-ID: <1448444918-29760-3-git-send-email-rf@opensource.wolfsonmicro.com>
References: <1448444918-29760-1-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1448444918-29760-1-git-send-email-rf@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, tiwai@suse.com, broonie@kernel.org
Cc: perex@perex.cz, lgirdwood@gmail.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Make snd_compress_new take an id string (like snd_pcm_new).
This string can be included in the procfs info.

This patch also updates soc_new_compress() to create an ID
based on the stream and dai name, as done for PCM streams.

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
---
 include/sound/compress_driver.h | 2 +-
 sound/core/compress_offload.c   | 6 +++++-
 sound/soc/soc-compress.c        | 8 +++++++-
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/include/sound/compress_driver.h b/include/sound/compress_driver.h
index 85c4237..c0abcdc 100644
--- a/include/sound/compress_driver.h
+++ b/include/sound/compress_driver.h
@@ -163,7 +163,7 @@ struct snd_compr {
 int snd_compress_register(struct snd_compr *device);
 int snd_compress_deregister(struct snd_compr *device);
 int snd_compress_new(struct snd_card *card, int device,
-			int type, struct snd_compr *compr);
+			int type, const char *id, struct snd_compr *compr);
 
 /* dsp driver callback apis
  * For playback: driver should call snd_compress_fragment_elapsed() to let the
diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index d133915..dd70926 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -976,7 +976,7 @@ static int snd_compress_dev_free(struct snd_device *device)
  * @compr: compress device pointer
  */
 int snd_compress_new(struct snd_card *card, int device,
-			int dirn, struct snd_compr *compr)
+			int dirn, const char *id, struct snd_compr *compr)
 {
 	static struct snd_device_ops ops = {
 		.dev_free = snd_compress_dev_free,
@@ -989,6 +989,10 @@ int snd_compress_new(struct snd_card *card, int device,
 	compr->device = device;
 	compr->direction = dirn;
 
+	if (IS_ENABLED(CONFIG_SND_VERBOSE_PROCFS))
+		if (id)
+			strlcpy(compr->id, id, sizeof(compr->id));
+
 	snd_device_initialize(&compr->dev, card);
 	dev_set_name(&compr->dev, "comprC%iD%i", card->number, device);
 
diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
index 12a9820..fffbe6f 100644
--- a/sound/soc/soc-compress.c
+++ b/sound/soc/soc-compress.c
@@ -689,7 +689,13 @@ int snd_soc_new_compress(struct snd_soc_pcm_runtime *rtd, int num)
 		compr->ops->copy = soc_compr_copy;
 
 	mutex_init(&compr->lock);
-	ret = snd_compress_new(rtd->card->snd_card, num, direction, compr);
+
+	snprintf(new_name, sizeof(new_name), "%s %s-%d",
+		 rtd->dai_link->stream_name,
+		 rtd->codec_dai->name, num);
+
+	ret = snd_compress_new(rtd->card->snd_card, num, direction,
+				new_name, compr);
 	if (ret < 0) {
 		pr_err("compress asoc: can't create compress for codec %s\n",
 			codec->component.name);
-- 
1.9.1
