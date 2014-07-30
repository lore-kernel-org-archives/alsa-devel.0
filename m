From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [v3 04/13] ASoC: Intel: Fix to use byte control
	interface
Date: Wed, 30 Jul 2014 18:32:21 +0530
Message-ID: <1406725350-23275-5-git-send-email-subhransu.s.prusty@intel.com>
References: <1406725350-23275-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id ECDAF2618ED
 for <alsa-devel@alsa-project.org>; Wed, 30 Jul 2014 15:24:00 +0200 (CEST)
In-Reply-To: <1406725350-23275-1-git-send-email-subhransu.s.prusty@intel.com>
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
Cc: vinod.koul@intel.com, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

From: Vinod Koul <vinod.koul@intel.com>

Using a byte control interface instead of generic_params ioctl.

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
---
 sound/soc/intel/sst-mfld-platform.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/sst-mfld-platform.h b/sound/soc/intel/sst-mfld-platform.h
index 6c6a42c08e24..4b536feda3ec 100644
--- a/sound/soc/intel/sst-mfld-platform.h
+++ b/sound/soc/intel/sst-mfld-platform.h
@@ -63,6 +63,8 @@ enum sst_controls {
 	SST_SND_BUFFER_POINTER =	0x05,
 	SST_SND_STREAM_INIT =		0x06,
 	SST_SND_START	 =		0x07,
+	SST_SET_RUNTIME_PARAMS =	0x08,
+	SST_SET_ALGO_PARAMS =		0x09,
 	SST_SET_BYTE_STREAM =           0x100A,
 	SST_GET_BYTE_STREAM =           0x100B,
 	SST_MAX_CONTROLS = SST_GET_BYTE_STREAM,
@@ -129,7 +131,7 @@ struct compress_sst_ops {
 struct sst_ops {
 	int (*open) (struct snd_sst_params *str_param);
 	int (*device_control) (int cmd, void *arg);
-	int (*set_generic_params)(enum sst_controls cmd, void *arg);
+	int (*send_byte_stream)(void *arg);
 	int (*close) (unsigned int str_id);
 };
 
-- 
1.9.0
