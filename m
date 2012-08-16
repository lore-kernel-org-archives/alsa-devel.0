From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: [PATCH 1/3] ASoC: add definations for compressed
	operations
Date: Thu, 16 Aug 2012 17:10:40 +0530
Message-ID: <1345117242-26975-2-git-send-email-vinod.koul@linux.intel.com>
References: <1345117242-26975-1-git-send-email-vinod.koul@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id A0BCF265B5D
 for <alsa-devel@alsa-project.org>; Thu, 16 Aug 2012 13:08:58 +0200 (CEST)
In-Reply-To: <1345117242-26975-1-git-send-email-vinod.koul@linux.intel.com>
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
Cc: Vinod Koul <vinod.koul@linux.intel.com>, broonie@opensource.wolfsonmicro.com, Namarta Kohli <namartax.kohli@intel.com>, lrg@ti.com, Ramesh Babu K V <ramesh.babu@intel.com>
List-Id: alsa-devel@alsa-project.org

Here we update the asoc structures to add compress stream definations
First the struct snd_soc_dai_driver adds a new member to indicate if the dai is
compressed or pcm. Next we add a new structre the struct snd_soc_compr_ops in
the struct snd_soc_dai_link. This is to be used for machine driver to perform
any opertaions required for setting up compressed audio streams

next is the compressed data operations, they are added using struct
snd_compr_ops in the struct snd_soc_platform_driver.

Signed-off-by: Namarta Kohli <namartax.kohli@intel.com>
Signed-off-by: Ramesh Babu K V <ramesh.babu@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@linux.intel.com>
---
 include/sound/compress_driver.h |    1 +
 include/sound/soc-dai.h         |    3 +++
 include/sound/soc.h             |   16 +++++++++++++++-
 3 files changed, 19 insertions(+), 1 deletions(-)

diff --git a/include/sound/compress_driver.h b/include/sound/compress_driver.h
index 48f2a1f..f2912ab 100644
--- a/include/sound/compress_driver.h
+++ b/include/sound/compress_driver.h
@@ -61,6 +61,7 @@ struct snd_compr_runtime {
 	u64 total_bytes_available;
 	u64 total_bytes_transferred;
 	wait_queue_head_t sleep;
+	void *private_data;
 };
 
 /**
diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index 1f69e0a..628db7b 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -18,6 +18,7 @@
 
 struct snd_pcm_substream;
 struct snd_soc_dapm_widget;
+struct snd_compr_stream;
 
 /*
  * DAI hardware audio formats.
@@ -205,6 +206,8 @@ struct snd_soc_dai_driver {
 	int (*remove)(struct snd_soc_dai *dai);
 	int (*suspend)(struct snd_soc_dai *dai);
 	int (*resume)(struct snd_soc_dai *dai);
+	/* compress dai */
+	bool compress_dai;
 
 	/* ops */
 	const struct snd_soc_dai_ops *ops;
diff --git a/include/sound/soc.h b/include/sound/soc.h
index e063380..313b766 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -22,6 +22,7 @@
 #include <linux/regmap.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
+#include <sound/compress_driver.h>
 #include <sound/control.h>
 #include <sound/ac97_codec.h>
 
@@ -399,6 +400,7 @@ int snd_soc_platform_read(struct snd_soc_platform *platform,
 int snd_soc_platform_write(struct snd_soc_platform *platform,
 					unsigned int reg, unsigned int val);
 int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num);
+int soc_new_compress(struct snd_soc_pcm_runtime *rtd, int num);
 
 struct snd_pcm_substream *snd_soc_get_dai_substream(struct snd_soc_card *card,
 		const char *dai_link, int stream);
@@ -632,6 +634,13 @@ struct snd_soc_ops {
 	int (*trigger)(struct snd_pcm_substream *, int);
 };
 
+struct snd_soc_compr_ops {
+	int (*startup)(struct snd_compr_stream *);
+	void (*shutdown)(struct snd_compr_stream *);
+	int (*set_params)(struct snd_compr_stream *);
+	int (*trigger)(struct snd_compr_stream *);
+};
+
 /* SoC cache ops */
 struct snd_soc_cache_ops {
 	const char *name;
@@ -787,9 +796,12 @@ struct snd_soc_platform_driver {
 	snd_pcm_sframes_t (*delay)(struct snd_pcm_substream *,
 		struct snd_soc_dai *);
 
-	/* platform stream ops */
+	/* platform stream pcm ops */
 	struct snd_pcm_ops *ops;
 
+	/* platform stream compress ops */
+	struct snd_compr_ops *compr_ops;
+
 	/* platform stream completion event */
 	int (*stream_event)(struct snd_soc_dapm_context *dapm, int event);
 
@@ -891,6 +903,7 @@ struct snd_soc_dai_link {
 
 	/* machine stream operations */
 	struct snd_soc_ops *ops;
+	struct snd_soc_compr_ops *compr_ops;
 };
 
 struct snd_soc_codec_conf {
@@ -1027,6 +1040,7 @@ struct snd_soc_pcm_runtime {
 
 	/* runtime devices */
 	struct snd_pcm *pcm;
+	struct snd_compr *compr;
 	struct snd_soc_codec *codec;
 	struct snd_soc_platform *platform;
 	struct snd_soc_dai *codec_dai;
-- 
1.7.0.4
