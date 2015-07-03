From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v2 3/6] ASoC: Intel: Reorganize the common dsp
	structure
Date: Fri,  3 Jul 2015 16:04:04 +0530
Message-ID: <1435919647-14049-4-git-send-email-vinod.koul@intel.com>
References: <1435919647-14049-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id C8955260527
 for <alsa-devel@alsa-project.org>; Fri,  3 Jul 2015 12:32:35 +0200 (CEST)
In-Reply-To: <1435919647-14049-1-git-send-email-vinod.koul@intel.com>
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

We will add SKL platform data. So organizing common and platform
specific data helps.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/common/sst-dsp-priv.h | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/sound/soc/intel/common/sst-dsp-priv.h b/sound/soc/intel/common/sst-dsp-priv.h
index 396d54510350..50af167b7bc7 100644
--- a/sound/soc/intel/common/sst-dsp-priv.h
+++ b/sound/soc/intel/common/sst-dsp-priv.h
@@ -258,6 +258,8 @@ struct sst_mem_block {
  */
 struct sst_dsp {
 
+	/* Shared for all platforms */
+
 	/* runtime */
 	struct sst_dsp_device *sst_dev;
 	spinlock_t spinlock;	/* IPC locking */
@@ -268,10 +270,6 @@ struct sst_dsp {
 	int irq;
 	u32 id;
 
-	/* list of free and used ADSP memory blocks */
-	struct list_head used_block_list;
-	struct list_head free_block_list;
-
 	/* operations */
 	struct sst_ops *ops;
 
@@ -284,6 +282,12 @@ struct sst_dsp {
 	/* mailbox */
 	struct sst_mailbox mailbox;
 
+	/* HSW/Byt data */
+
+	/* list of free and used ADSP memory blocks */
+	struct list_head used_block_list;
+	struct list_head free_block_list;
+
 	/* SST FW files loaded and their modules */
 	struct list_head module_list;
 	struct list_head fw_list;
-- 
1.9.1
