From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: soc-compress: Add support for not memory
	mapped DSPs
Date: Fri, 25 Jan 2013 09:00:00 +0000
Message-ID: <1359104400-18527-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7A7C3261718
 for <alsa-devel@alsa-project.org>; Fri, 25 Jan 2013 10:02:40 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com
Cc: vinod.koul@linux.intel.com, tiwai@suse.de, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, liam.r.girdwood@intel.com, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The ASoC compressed API did not implement the copy callback in its
compressed ops which is required for DSPs that are not memory mapped.
This patch adds a second set of compressed ops which does implement the
copy callback and uses that when copy is defined in the platform
compressed ops, ie. when the DSP is not memory mapped.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/soc-compress.c |   36 +++++++++++++++++++++++++++++++++++-
 1 files changed, 35 insertions(+), 1 deletions(-)

diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
index 3ea7956..f9fb112 100644
--- a/sound/soc/soc-compress.c
+++ b/sound/soc/soc-compress.c
@@ -302,6 +302,22 @@ static int soc_compr_pointer(struct snd_compr_stream *cstream,
 	return 0;
 }
 
+static int soc_compr_copy(struct snd_compr_stream *cstream,
+			  const char __user *buf, size_t count)
+{
+	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
+	struct snd_soc_platform *platform = rtd->platform;
+	int ret = 0;
+
+	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
+
+	if (platform->driver->compr_ops && platform->driver->compr_ops->copy)
+		ret = platform->driver->compr_ops->copy(cstream, buf, count);
+
+	mutex_unlock(&rtd->pcm_mutex);
+	return ret;
+}
+
 /* ASoC Compress operations */
 static struct snd_compr_ops soc_compr_ops = {
 	.open		= soc_compr_open,
@@ -315,10 +331,25 @@ static struct snd_compr_ops soc_compr_ops = {
 	.get_codec_caps = soc_compr_get_codec_caps
 };
 
+/* ASoC Compress operations for non memory mapped DSPs */
+static struct snd_compr_ops soc_compr_nomap_ops = {
+	.open		= soc_compr_open,
+	.free		= soc_compr_free,
+	.set_params	= soc_compr_set_params,
+	.get_params	= soc_compr_get_params,
+	.trigger	= soc_compr_trigger,
+	.pointer	= soc_compr_pointer,
+	.copy		= soc_compr_copy,
+	.ack		= soc_compr_ack,
+	.get_caps	= soc_compr_get_caps,
+	.get_codec_caps = soc_compr_get_codec_caps
+};
+
 /* create a new compress */
 int soc_new_compress(struct snd_soc_pcm_runtime *rtd, int num)
 {
 	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_platform *platform = rtd->platform;
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	struct snd_compr *compr;
@@ -335,7 +366,10 @@ int soc_new_compress(struct snd_soc_pcm_runtime *rtd, int num)
 		return -ENOMEM;
 	}
 
-	compr->ops = &soc_compr_ops;
+	if (platform->driver->compr_ops && platform->driver->compr_ops->copy)
+		compr->ops = &soc_compr_nomap_ops;
+	else
+		compr->ops = &soc_compr_ops;
 	mutex_init(&compr->lock);
 	ret = snd_compress_new(rtd->card->snd_card, num, direction, compr);
 	if (ret < 0) {
-- 
1.7.2.5
