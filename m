From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Atom: simplify iomem address and
	casts" to the asoc tree
Date: Wed, 25 Jul 2018 17:40:13 +0100 (BST)
Message-ID: <20180725164013.55AEB1123B08@debutante.sirena.org.uk>
References: <20180724211248.29427-6-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 45B0F267796
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 18:40:15 +0200 (CEST)
In-Reply-To: <20180724211248.29427-6-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, vkoul@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Atom: simplify iomem address and casts

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From ce1cfe295abaa7436f9049bcb2562c843089abfc Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Tue, 24 Jul 2018 16:12:47 -0500
Subject: [PATCH] ASoC: Intel: Atom: simplify iomem address and casts

Simplify code and add relevant casts to make Sparse warnings go away

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/atom/sst/sst_drv_interface.c | 29 ++++++++++----------
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
2.18.0
