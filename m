From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH v2 05/13] ASoC: Intel: add generic parameter
	set interface
Date: Thu, 10 Jul 2014 10:14:49 +0530
Message-ID: <1404967497-22537-6-git-send-email-subhransu.s.prusty@intel.com>
References: <1404967497-22537-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id E24632651E6
 for <alsa-devel@alsa-project.org>; Thu, 10 Jul 2014 07:06:35 +0200 (CEST)
In-Reply-To: <1404967497-22537-1-git-send-email-subhransu.s.prusty@intel.com>
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

This will be used by subsequent patches to send DSP cmds on DAPM widgets
enable/disable

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
---
 sound/soc/intel/sst-mfld-platform.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/sst-mfld-platform.h b/sound/soc/intel/sst-mfld-platform.h
index 9dc962ff1e1d..79dfee1fbdfe 100644
--- a/sound/soc/intel/sst-mfld-platform.h
+++ b/sound/soc/intel/sst-mfld-platform.h
@@ -63,7 +63,12 @@ enum sst_controls {
 	SST_SND_BUFFER_POINTER =	0x05,
 	SST_SND_STREAM_INIT =		0x06,
 	SST_SND_START	 =		0x07,
-	SST_MAX_CONTROLS =		0x07,
+	SST_SET_RUNTIME_PARAMS =	0x08,
+	SST_SET_ALGO_PARAMS =		0x09,
+	SST_SET_BYTE_STREAM =		0x0A,
+	SST_GET_BYTE_STREAM =		0x0B,
+
+	SST_MAX_CONTROLS =		SST_GET_BYTE_STREAM,
 };
 
 enum sst_stream_ops {
@@ -127,6 +132,7 @@ struct compress_sst_ops {
 struct sst_ops {
 	int (*open) (struct snd_sst_params *str_param);
 	int (*device_control) (int cmd, void *arg);
+	int (*set_generic_params)(enum sst_controls cmd, void *arg);
 	int (*close) (unsigned int str_id);
 };
 
-- 
1.9.0
