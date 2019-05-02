From: Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 09/14] soundwire: intel: more alignment fixes
Date: Thu,  2 May 2019 16:29:25 +0530
Message-ID: <20190502105930.9889-10-vkoul@kernel.org>
References: <20190502105930.9889-1-vkoul@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 48A03F8973A
 for <alsa-devel@alsa-project.org>; Thu,  2 May 2019 13:00:36 +0200 (CEST)
In-Reply-To: <20190502105930.9889-1-vkoul@kernel.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: Greg KH <gregkh@linuxfoundation.org>, Sanyog Kale <sanyog.r.kale@intel.com>, Vinod Koul <vkoul@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Shreyas NC <shreyas.nc@intel.com>
List-Id: alsa-devel@alsa-project.org

Found few more issues reported checkpatch on code alignment so fix those
as well in the intel module.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/soundwire/intel.c           | 36 ++++++++++++++---------------
 include/linux/soundwire/sdw_intel.h |  2 +-
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 9774dc1e4029..31336b0271b0 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -691,9 +691,9 @@ static int intel_create_dai(struct sdw_cdns *cdns,
 			return -ENOMEM;
 
 		if (type == INTEL_PDI_BD || type == INTEL_PDI_OUT) {
-			dais[i].playback.stream_name = kasprintf(GFP_KERNEL,
-							"SDW%d Tx%d",
-							cdns->instance, i);
+			dais[i].playback.stream_name =
+				kasprintf(GFP_KERNEL, "SDW%d Tx%d",
+					  cdns->instance, i);
 			if (!dais[i].playback.stream_name) {
 				kfree(dais[i].name);
 				return -ENOMEM;
@@ -706,9 +706,9 @@ static int intel_create_dai(struct sdw_cdns *cdns,
 		}
 
 		if (type == INTEL_PDI_BD || type == INTEL_PDI_IN) {
-			dais[i].capture.stream_name = kasprintf(GFP_KERNEL,
-							"SDW%d Rx%d",
-							cdns->instance, i);
+			dais[i].capture.stream_name =
+				kasprintf(GFP_KERNEL, "SDW%d Rx%d",
+					  cdns->instance, i);
 			if (!dais[i].capture.stream_name) {
 				kfree(dais[i].name);
 				kfree(dais[i].playback.stream_name);
@@ -749,40 +749,40 @@ static int intel_register_dai(struct sdw_intel *sdw)
 	/* Create PCM DAIs */
 	stream = &cdns->pcm;
 
-	ret = intel_create_dai(cdns, dais, INTEL_PDI_IN,
-			stream->num_in, off, stream->num_ch_in, true);
+	ret = intel_create_dai(cdns, dais, INTEL_PDI_IN, stream->num_in,
+			       off, stream->num_ch_in, true);
 	if (ret)
 		return ret;
 
 	off += cdns->pcm.num_in;
-	ret = intel_create_dai(cdns, dais, INTEL_PDI_OUT,
-			cdns->pcm.num_out, off, stream->num_ch_out, true);
+	ret = intel_create_dai(cdns, dais, INTEL_PDI_OUT, cdns->pcm.num_out,
+			       off, stream->num_ch_out, true);
 	if (ret)
 		return ret;
 
 	off += cdns->pcm.num_out;
-	ret = intel_create_dai(cdns, dais, INTEL_PDI_BD,
-			cdns->pcm.num_bd, off, stream->num_ch_bd, true);
+	ret = intel_create_dai(cdns, dais, INTEL_PDI_BD, cdns->pcm.num_bd,
+			       off, stream->num_ch_bd, true);
 	if (ret)
 		return ret;
 
 	/* Create PDM DAIs */
 	stream = &cdns->pdm;
 	off += cdns->pcm.num_bd;
-	ret = intel_create_dai(cdns, dais, INTEL_PDI_IN,
-			cdns->pdm.num_in, off, stream->num_ch_in, false);
+	ret = intel_create_dai(cdns, dais, INTEL_PDI_IN, cdns->pdm.num_in,
+			       off, stream->num_ch_in, false);
 	if (ret)
 		return ret;
 
 	off += cdns->pdm.num_in;
-	ret = intel_create_dai(cdns, dais, INTEL_PDI_OUT,
-			cdns->pdm.num_out, off, stream->num_ch_out, false);
+	ret = intel_create_dai(cdns, dais, INTEL_PDI_OUT, cdns->pdm.num_out,
+			       off, stream->num_ch_out, false);
 	if (ret)
 		return ret;
 
 	off += cdns->pdm.num_bd;
-	ret = intel_create_dai(cdns, dais, INTEL_PDI_BD,
-			cdns->pdm.num_bd, off, stream->num_ch_bd, false);
+	ret = intel_create_dai(cdns, dais, INTEL_PDI_BD, cdns->pdm.num_bd,
+			       off, stream->num_ch_bd, false);
 	if (ret)
 		return ret;
 
diff --git a/include/linux/soundwire/sdw_intel.h b/include/linux/soundwire/sdw_intel.h
index 0848f9d38bcb..4d70da45363d 100644
--- a/include/linux/soundwire/sdw_intel.h
+++ b/include/linux/soundwire/sdw_intel.h
@@ -11,7 +11,7 @@
  */
 struct sdw_intel_ops {
 	int (*config_stream)(void *arg, void *substream,
-			void *dai, void *hw_params, int stream_num);
+			     void *dai, void *hw_params, int stream_num);
 };
 
 /**
-- 
2.20.1
