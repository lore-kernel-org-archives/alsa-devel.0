From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH 1/3] ASoC: Intel: Fix to use byte control
	interface
Date: Mon,  4 Aug 2014 15:04:19 +0530
Message-ID: <1407144861-30475-2-git-send-email-subhransu.s.prusty@intel.com>
References: <1407144861-30475-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id C838826087E
 for <alsa-devel@alsa-project.org>; Mon,  4 Aug 2014 11:55:45 +0200 (CEST)
In-Reply-To: <1407144861-30475-1-git-send-email-subhransu.s.prusty@intel.com>
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

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/sst-mfld-platform.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/intel/sst-mfld-platform.h b/sound/soc/intel/sst-mfld-platform.h
index 6c6a42c08e24..cc3a088df7dd 100644
--- a/sound/soc/intel/sst-mfld-platform.h
+++ b/sound/soc/intel/sst-mfld-platform.h
@@ -63,9 +63,7 @@ enum sst_controls {
 	SST_SND_BUFFER_POINTER =	0x05,
 	SST_SND_STREAM_INIT =		0x06,
 	SST_SND_START	 =		0x07,
-	SST_SET_BYTE_STREAM =           0x100A,
-	SST_GET_BYTE_STREAM =           0x100B,
-	SST_MAX_CONTROLS = SST_GET_BYTE_STREAM,
+	SST_MAX_CONTROLS = 		0x07,
 };
 
 enum sst_stream_ops {
@@ -129,7 +127,7 @@ struct compress_sst_ops {
 struct sst_ops {
 	int (*open) (struct snd_sst_params *str_param);
 	int (*device_control) (int cmd, void *arg);
-	int (*set_generic_params)(enum sst_controls cmd, void *arg);
+	int (*send_byte_stream)(struct snd_sst_bytes_v2 *bytes);
 	int (*close) (unsigned int str_id);
 };
 
-- 
1.9.0
