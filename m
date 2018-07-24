From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 5/6] ASoC: Intel: Atom: simplify iomem address
	and casts
Date: Tue, 24 Jul 2018 16:12:47 -0500
Message-ID: <20180724211248.29427-6-pierre-louis.bossart@linux.intel.com>
References: <20180724211248.29427-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 088D126770A
 for <alsa-devel@alsa-project.org>; Tue, 24 Jul 2018 23:13:01 +0200 (CEST)
In-Reply-To: <20180724211248.29427-1-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Simplify code and add relevant casts to make Sparse warnings go away

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/atom/sst/sst_drv_interface.c | 29 ++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/sound/soc/intel/atom/sst/sst_drv_interface.c b/sound/soc/intel/atom/sst/sst_drv_interface.c
index 6a8b253c58d2..5455d6e0ab53 100644
--- a/sound/soc/intel/atom/sst/sst_drv_interface.c
+++ b/sound/soc/intel/atom/sst/sst_drv_interface.c
@@ -266,17 +266,15 @@ static int sst_cdev_ack(struct device *dev, unsigned int str_id,
 	stream->cumm_bytes += bytes;
 	dev_dbg(dev, "bytes copied %d inc by %ld\n", stream->cumm_bytes, bytes);
 
-	memcpy_fromio(&fw_tstamp,
-		((void *)(ctx->mailbox + ctx->tstamp)
-		+(str_id * sizeof(fw_tstamp))),
-		sizeof(fw_tstamp));
+	addr =  ((void __iomem *)(ctx->mailbox + ctx->tstamp)) +
+		(str_id * sizeof(fw_tstamp));
+
+	memcpy_fromio(&fw_tstamp, addr, sizeof(fw_tstamp));
 
 	fw_tstamp.bytes_copied = stream->cumm_bytes;
 	dev_dbg(dev, "bytes sent to fw %llu inc by %ld\n",
 			fw_tstamp.bytes_copied, bytes);
 
-	addr =  ((void *)(ctx->mailbox + ctx->tstamp)) +
-			(str_id * sizeof(fw_tstamp));
 	offset =  offsetof(struct snd_sst_tstamp, bytes_copied);
 	sst_shim_write(addr, offset, fw_tstamp.bytes_copied);
 	return 0;
@@ -360,11 +358,12 @@ static int sst_cdev_tstamp(struct device *dev, unsigned int str_id,
 	struct snd_sst_tstamp fw_tstamp = {0,};
 	struct stream_info *stream;
 	struct intel_sst_drv *ctx = dev_get_drvdata(dev);
+	void __iomem *addr;
+
+	addr = (void __iomem *)(ctx->mailbox + ctx->tstamp) +
+		(str_id * sizeof(fw_tstamp));
 
-	memcpy_fromio(&fw_tstamp,
-		((void *)(ctx->mailbox + ctx->tstamp)
-		+(str_id * sizeof(fw_tstamp))),
-		sizeof(fw_tstamp));
+	memcpy_fromio(&fw_tstamp, addr, sizeof(fw_tstamp));
 
 	stream = get_stream_info(ctx, str_id);
 	if (!stream)
@@ -530,6 +529,7 @@ static int sst_read_timestamp(struct device *dev, struct pcm_stream_info *info)
 	struct snd_sst_tstamp fw_tstamp;
 	unsigned int str_id;
 	struct intel_sst_drv *ctx = dev_get_drvdata(dev);
+	void __iomem *addr;
 
 	str_id = info->str_id;
 	stream = get_stream_info(ctx, str_id);
@@ -540,10 +540,11 @@ static int sst_read_timestamp(struct device *dev, struct pcm_stream_info *info)
 		return -EINVAL;
 	substream = stream->pcm_substream;
 
-	memcpy_fromio(&fw_tstamp,
-		((void *)(ctx->mailbox + ctx->tstamp)
-			+ (str_id * sizeof(fw_tstamp))),
-		sizeof(fw_tstamp));
+	addr = (void __iomem *)(ctx->mailbox + ctx->tstamp) +
+		(str_id * sizeof(fw_tstamp));
+
+	memcpy_fromio(&fw_tstamp, addr, sizeof(fw_tstamp));
+
 	return sst_calc_tstamp(ctx, info, substream, &fw_tstamp);
 }
 
-- 
2.14.1
