From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 04/13] ASoC: Intel: add support for pause and
	resume in sst
Date: Thu, 12 Feb 2015 09:59:56 +0530
Message-ID: <1423715405-4562-5-git-send-email-vinod.koul@intel.com>
References: <1423715405-4562-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 6FFF9265130
 for <alsa-devel@alsa-project.org>; Thu, 12 Feb 2015 05:32:56 +0100 (CET)
In-Reply-To: <1423715405-4562-1-git-send-email-vinod.koul@intel.com>
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
Cc: Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

This adds missing pcm pause and resume ops in the driver

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/sst/sst_drv_interface.c |   31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/sound/soc/intel/sst/sst_drv_interface.c b/sound/soc/intel/sst/sst_drv_interface.c
index 5f75ef3cdd22..5d56fcdd58d8 100644
--- a/sound/soc/intel/sst/sst_drv_interface.c
+++ b/sound/soc/intel/sst/sst_drv_interface.c
@@ -572,6 +572,35 @@ static int sst_stream_drop(struct device *dev, int str_id)
 	return sst_drop_stream(ctx, str_id);
 }
 
+static int sst_stream_pause(struct device *dev, int str_id)
+{
+	struct stream_info *str_info;
+	struct intel_sst_drv *ctx = dev_get_drvdata(dev);
+
+	if (ctx->sst_state != SST_FW_RUNNING)
+		return 0;
+
+	str_info = get_stream_info(ctx, str_id);
+	if (!str_info)
+		return -EINVAL;
+
+	return sst_pause_stream(ctx, str_id);
+}
+
+static int sst_stream_resume(struct device *dev, int str_id)
+{
+	struct stream_info *str_info;
+	struct intel_sst_drv *ctx = dev_get_drvdata(dev);
+
+	if (ctx->sst_state != SST_FW_RUNNING)
+		return 0;
+
+	str_info = get_stream_info(ctx, str_id);
+	if (!str_info)
+		return -EINVAL;
+	return sst_resume_stream(ctx, str_id);
+}
+
 static int sst_stream_init(struct device *dev, struct pcm_stream_info *str_info)
 {
 	int str_id = 0;
@@ -633,6 +662,8 @@ static struct sst_ops pcm_ops = {
 	.stream_init = sst_stream_init,
 	.stream_start = sst_stream_start,
 	.stream_drop = sst_stream_drop,
+	.stream_pause = sst_stream_pause,
+	.stream_pause_release = sst_stream_resume,
 	.stream_read_tstamp = sst_read_timestamp,
 	.send_byte_stream = sst_send_byte_stream,
 	.close = sst_close_pcm_stream,
-- 
1.7.9.5
