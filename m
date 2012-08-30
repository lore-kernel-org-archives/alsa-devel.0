From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: [PATCH 2/3] ASoC: add device_buffer in asoc
Date: Fri, 31 Aug 2012 00:42:37 +0530
Message-ID: <1346353958-7746-3-git-send-email-vinod.koul@linux.intel.com>
References: <1346353958-7746-1-git-send-email-vinod.koul@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
 by alsa0.perex.cz (Postfix) with ESMTP id 364132662AA
 for <alsa-devel@alsa-project.org>; Thu, 30 Aug 2012 21:05:40 +0200 (CEST)
In-Reply-To: <1346353958-7746-1-git-send-email-vinod.koul@linux.intel.com>
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
Cc: tiwai@suse.de, Vinod Koul <vinod.koul@linux.intel.com>, broonie@opensource.wolfsonmicro.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Vinod Koul <vinod.koul@linux.intel.com>
---
 include/sound/soc-dai.h |    6 ++++++
 include/sound/soc.h     |    7 ++++++-
 sound/soc/soc-pcm.c     |   13 +++++++++++++
 3 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index 628db7b..b0c84df 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -182,6 +182,12 @@ struct snd_soc_dai_ops {
 	 */
 	snd_pcm_sframes_t (*delay)(struct snd_pcm_substream *,
 		struct snd_soc_dai *);
+	/*
+	 * For hardware based buffer reporting
+	 * Optional.
+	 */
+	snd_pcm_sframes_t (*buffer)(struct snd_pcm_substream *,
+		struct snd_soc_dai *);
 };
 
 /*
diff --git a/include/sound/soc.h b/include/sound/soc.h
index 313b766..0d5046b 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -795,7 +795,12 @@ struct snd_soc_platform_driver {
 	 */
 	snd_pcm_sframes_t (*delay)(struct snd_pcm_substream *,
 		struct snd_soc_dai *);
-
+	/*
+	 * For hardware based buffer reporting
+	 * Optional.
+	 */
+	snd_pcm_sframes_t (*buffer)(struct snd_pcm_substream *,
+		struct snd_soc_dai *);
 	/* platform stream pcm ops */
 	struct snd_pcm_ops *ops;
 
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index ef22d0b..cd7b10f 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -674,6 +674,7 @@ static snd_pcm_uframes_t soc_pcm_pointer(struct snd_pcm_substream *substream)
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	snd_pcm_uframes_t offset = 0;
 	snd_pcm_sframes_t delay = 0;
+	snd_pcm_sframes_t buffer = 0;
 
 	if (platform->driver->ops && platform->driver->ops->pointer)
 		offset = platform->driver->ops->pointer(substream);
@@ -687,7 +688,19 @@ static snd_pcm_uframes_t soc_pcm_pointer(struct snd_pcm_substream *substream)
 	if (platform->driver->delay)
 		delay += platform->driver->delay(substream, codec_dai);
 
+	if (cpu_dai->driver->ops->buffer)
+		buffer += cpu_dai->driver->ops->buffer(substream, cpu_dai);
+
+	if (codec_dai->driver->ops->buffer)
+		buffer += codec_dai->driver->ops->buffer(substream, codec_dai);
+
+	if (platform->driver->buffer)
+		buffer += platform->driver->buffer(substream, codec_dai);
+
+
+
 	runtime->delay = delay;
+	runtime->device_buffer = buffer;
 
 	return offset;
 }
-- 
1.7.9.5
