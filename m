From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH 1/1] ASoC: soc_compress: Add set_metadata
Date: Mon, 25 Nov 2013 10:16:48 +0000
Message-ID: <20131125101648.GA1818@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, broonie@kernel.org
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, ckeepax@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org


Pass the set_metadata() calls through to the codec driver.

Signed-off-by: Zhao Weijia <weijia.zhao@capelabs.com>
Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
---
 sound/soc/soc-compress.c |   18 +++++++++++++++++-
 1 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
index 53c9ecd..186802b 100644
--- a/sound/soc/soc-compress.c
+++ b/sound/soc/soc-compress.c
@@ -318,6 +318,21 @@ static int soc_compr_pointer(struct snd_compr_stream *cstream,
 	mutex_unlock(&rtd->pcm_mutex);
 	return 0;
 }
+static int soc_compr_set_metadata(struct snd_compr_stream *cstream,
+			struct snd_compr_metadata *metadata)
+{
+	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
+	struct snd_soc_platform *platform = rtd->platform;
+
+	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
+
+	if (platform->driver->compr_ops && platform->driver->compr_ops->set_metadata)
+		 platform->driver->compr_ops->set_metadata(cstream, metadata);
+
+	mutex_unlock(&rtd->pcm_mutex);
+	return 0;
+}
+
 
 static int soc_compr_copy(struct snd_compr_stream *cstream,
 			  char __user *buf, size_t count)
@@ -372,7 +387,8 @@ static struct snd_compr_ops soc_compr_ops = {
 	.pointer	= soc_compr_pointer,
 	.ack		= soc_compr_ack,
 	.get_caps	= soc_compr_get_caps,
-	.get_codec_caps = soc_compr_get_codec_caps
+	.get_codec_caps = soc_compr_get_codec_caps,
+	.set_metadata = soc_compr_set_metadata,
 };
 
 /* create a new compress */
-- 
1.7.2.5
