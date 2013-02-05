From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH v3] ASoC: soc-compress: Add support for not
	memory mapped	DSPs
Date: Tue, 5 Feb 2013 10:41:47 +0000
Message-ID: <20130205104147.GA22562@opensource.wolfsonmicro.com>
References: <1359104400-18527-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <20130128040416.GJ26562@intel.com>
 <20130128045609.GA5683@opensource.wolfsonmicro.com>
 <20130128060914.GM26562@intel.com>
 <20130128064440.GB5683@opensource.wolfsonmicro.com>
 <20130128093449.GO26562@intel.com>
 <20130128104910.GB14418@opensource.wolfsonmicro.com>
 <20130129185116.GA27083@opensource.wolfsonmicro.com>
 <20130131030232.GB3143@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4B5EB265131
 for <alsa-devel@alsa-project.org>; Tue,  5 Feb 2013 11:47:56 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20130131030232.GB3143@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, tiwai@suse.de, patches@opensource.wolfsonmicro.com, liam.r.girdwood@intel.com, vinod.koul@linux.jf.intel.com
List-Id: alsa-devel@alsa-project.org

The ASoC compressed API did not implement the copy callback in its
compressed ops which is required for DSPs that are not memory mapped.

This patch creates a local copy of the compress ops for each runtime and
modifies them with a copy callback as appropriate.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/soc-compress.c |   38 +++++++++++++++++++++++++++++++++++---
 1 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
index 3ea7956..c81aeec 100644
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
@@ -319,6 +335,7 @@ static struct snd_compr_ops soc_compr_ops = {
 int soc_new_compress(struct snd_soc_pcm_runtime *rtd, int num)
 {
 	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_platform *platform = rtd->platform;
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	struct snd_compr *compr;
@@ -335,14 +352,25 @@ int soc_new_compress(struct snd_soc_pcm_runtime *rtd, int num)
 		return -ENOMEM;
 	}
 
-	compr->ops = &soc_compr_ops;
+	compr->ops = devm_kzalloc(rtd->card->dev, sizeof(soc_compr_ops),
+				  GFP_KERNEL);
+	if (compr->ops == NULL) {
+		dev_err(rtd->card->dev, "Cannot allocate compressed ops\n");
+		ret = -ENOMEM;
+		goto compr_err;
+	}
+	memcpy(compr->ops, &soc_compr_ops, sizeof(soc_compr_ops));
+
+	/* Add copy callback for not memory mapped DSPs */
+	if (platform->driver->compr_ops && platform->driver->compr_ops->copy)
+		compr->ops->copy = soc_compr_copy;
+
 	mutex_init(&compr->lock);
 	ret = snd_compress_new(rtd->card->snd_card, num, direction, compr);
 	if (ret < 0) {
 		pr_err("compress asoc: can't create compress for codec %s\n",
 			codec->name);
-		kfree(compr);
-		return ret;
+		goto compr_err;
 	}
 
 	/* DAPM dai link stream work */
@@ -354,4 +382,8 @@ int soc_new_compress(struct snd_soc_pcm_runtime *rtd, int num)
 	printk(KERN_INFO "compress asoc: %s <-> %s mapping ok\n", codec_dai->name,
 		cpu_dai->name);
 	return ret;
+
+compr_err:
+	kfree(compr);
+	return ret;
 }
-- 
1.7.2.5
