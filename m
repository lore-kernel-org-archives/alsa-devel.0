From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH] ASoC: Intel: Add TDM support to HSW/BDW SSP
	port
Date: Thu, 16 Oct 2014 15:29:15 +0100
Message-ID: <1413469757-6200-2-git-send-email-liam.r.girdwood@linux.intel.com>
References: <1413469757-6200-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 31D222605DA
 for <alsa-devel@alsa-project.org>; Thu, 16 Oct 2014 16:29:35 +0200 (CEST)
In-Reply-To: <1413469757-6200-1-git-send-email-liam.r.girdwood@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Add TDM support to SSP port via DSP IPC SetDeviceFormat message.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 sound/soc/intel/sst-haswell-ipc.c | 4 ++++
 sound/soc/intel/sst-haswell-ipc.h | 4 +++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/sst-haswell-ipc.c b/sound/soc/intel/sst-haswell-ipc.c
index b629151..92d625a 100644
--- a/sound/soc/intel/sst-haswell-ipc.c
+++ b/sound/soc/intel/sst-haswell-ipc.c
@@ -1630,6 +1630,10 @@ int sst_hsw_device_set_config(struct sst_hsw *hsw,
 	config.clock_frequency = mclk;
 	config.mode = mode;
 	config.clock_divider = clock_divider;
+	if (mode == SST_HSW_DEVICE_TDM_CLOCK_MASTER)
+		config.channels = 4;
+	else
+		config.channels = 2;
 
 	trace_hsw_device_config_req(&config);
 
diff --git a/sound/soc/intel/sst-haswell-ipc.h b/sound/soc/intel/sst-haswell-ipc.h
index 2ac194a..063dd6b 100644
--- a/sound/soc/intel/sst-haswell-ipc.h
+++ b/sound/soc/intel/sst-haswell-ipc.h
@@ -84,6 +84,7 @@ enum sst_hsw_device_mclk {
 enum sst_hsw_device_mode {
 	SST_HSW_DEVICE_CLOCK_SLAVE   = 0,
 	SST_HSW_DEVICE_CLOCK_MASTER  = 1,
+	SST_HSW_DEVICE_TDM_CLOCK_MASTER = 2,
 };
 
 /* DX Power State */
@@ -295,7 +296,8 @@ struct sst_hsw_ipc_device_config_req {
 	u32 clock_frequency;
 	u32 mode;
 	u16 clock_divider;
-	u16 reserved;
+	u8 channels;
+	u8 reserved;
 } __attribute__((packed));
 
 /* Audio Data formats */
-- 
1.9.1
