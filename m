From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 1/8] ASoC: Intel: Create an ops to check for
	DSP busy
Date: Mon, 18 May 2015 16:55:54 +0530
Message-ID: <1431948361-12756-2-git-send-email-vinod.koul@intel.com>
References: <1431948361-12756-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 6E844260526
 for <alsa-devel@alsa-project.org>; Mon, 18 May 2015 13:25:07 +0200 (CEST)
In-Reply-To: <1431948361-12756-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>

Created an ops to check if DSP busy, to avoid using platform
specific registers in common IPC.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/common/sst-ipc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/intel/common/sst-ipc.h b/sound/soc/intel/common/sst-ipc.h
index 125ea451a373..77a3befd16b0 100644
--- a/sound/soc/intel/common/sst-ipc.h
+++ b/sound/soc/intel/common/sst-ipc.h
@@ -51,6 +51,7 @@ struct sst_plat_ipc_ops {
 	void (*shim_dbg)(struct sst_generic_ipc *, const char *);
 	void (*tx_data_copy)(struct ipc_message *, char *, size_t);
 	u64  (*reply_msg_match)(u64 header, u64 *mask);
+	bool (*is_dsp_busy)(struct sst_dsp *dsp);
 };
 
 /* SST generic IPC data */
-- 
1.9.1
