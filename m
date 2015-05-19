From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v2 5/8] ASoC: Intel: Allow to configure max
	size for mailbox data
Date: Tue, 19 May 2015 15:00:37 +0530
Message-ID: <1432027840-18711-6-git-send-email-vinod.koul@intel.com>
References: <1432027840-18711-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 3C00A2606C2
 for <alsa-devel@alsa-project.org>; Tue, 19 May 2015 11:29:56 +0200 (CEST)
In-Reply-To: <1432027840-18711-1-git-send-email-vinod.koul@intel.com>
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
Cc: tiwai@suse.de, patches.audio@intel.com, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>

Mailbox size can be different for different platforms. So allow the drivers
to configure the size.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/common/sst-ipc.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/intel/common/sst-ipc.h b/sound/soc/intel/common/sst-ipc.h
index 77a3befd16b0..7139afd2547f 100644
--- a/sound/soc/intel/common/sst-ipc.h
+++ b/sound/soc/intel/common/sst-ipc.h
@@ -69,6 +69,8 @@ struct sst_generic_ipc {
 	struct kthread_work kwork;
 	bool pending;
 	struct ipc_message *msg;
+	int tx_data_max_size;
+	int rx_data_max_size;
 
 	struct sst_plat_ipc_ops ops;
 };
-- 
1.9.1
