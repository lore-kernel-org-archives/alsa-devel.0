From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 3/3] ASoC: soc-compress: Split copy into
	seperate read and write callbacks
Date: Wed,  3 Apr 2013 13:13:29 +0100
Message-ID: <1364991209-24653-3-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1364991209-24653-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 195A1265CEA
 for <alsa-devel@alsa-project.org>; Wed,  3 Apr 2013 14:22:50 +0200 (CEST)
In-Reply-To: <1364991209-24653-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, vinod.koul@intel.com, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The compress API for non-memory mapped DSPs shares a copy callback for
both read and write, however the file operation of write passes a const
buffer. Thus we can't maintain const correctness for the copy callback
and support both read and write.

This patch seperates the read and write callbacks in the ASoC compressed
API.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/soc-compress.c |   34 +++++++++++++++++++++++++++-------
 1 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
index f9b2197..0148d82 100644
--- a/sound/soc/soc-compress.c
+++ b/sound/soc/soc-compress.c
@@ -306,8 +306,8 @@ static int soc_compr_pointer(struct snd_compr_stream *cstream,
 	return 0;
 }
 
-static int soc_compr_copy(struct snd_compr_stream *cstream,
-			  const char __user *buf, size_t count)
+static int soc_compr_write(struct snd_compr_stream *cstream,
+			   const char __user *buf, size_t count)
 {
 	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
 	struct snd_soc_platform *platform = rtd->platform;
@@ -315,8 +315,24 @@ static int soc_compr_copy(struct snd_compr_stream *cstream,
 
 	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
 
-	if (platform->driver->compr_ops && platform->driver->compr_ops->copy)
-		ret = platform->driver->compr_ops->copy(cstream, buf, count);
+	if (platform->driver->compr_ops && platform->driver->compr_ops->write)
+		ret = platform->driver->compr_ops->write(cstream, buf, count);
+
+	mutex_unlock(&rtd->pcm_mutex);
+	return ret;
+}
+
+static int soc_compr_read(struct snd_compr_stream *cstream,
+			  char __user *buf, size_t count)
+{
+	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
+	struct snd_soc_platform *platform = rtd->platform;
+	int ret = 0;
+
+	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
+
+	if (platform->driver->compr_ops && platform->driver->compr_ops->read)
+		ret = platform->driver->compr_ops->read(cstream, buf, count);
 
 	mutex_unlock(&rtd->pcm_mutex);
 	return ret;
@@ -392,9 +408,13 @@ int soc_new_compress(struct snd_soc_pcm_runtime *rtd, int num)
 	}
 	memcpy(compr->ops, &soc_compr_ops, sizeof(soc_compr_ops));
 
-	/* Add copy callback for not memory mapped DSPs */
-	if (platform->driver->compr_ops && platform->driver->compr_ops->copy)
-		compr->ops->copy = soc_compr_copy;
+	/* Add write/read callback for not memory mapped DSPs */
+	if (platform->driver->compr_ops) {
+		if (platform->driver->compr_ops->write)
+			compr->ops->write = soc_compr_write;
+		if (platform->driver->compr_ops->read)
+			compr->ops->read = soc_compr_read;
+	}
 
 	mutex_init(&compr->lock);
 	ret = snd_compress_new(rtd->card->snd_card, num, direction, compr);
-- 
1.7.2.5
