From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 1/5] ASoC: Intel: add frame and data polarity
	to ssp config
Date: Wed,  6 May 2015 22:06:40 +0530
Message-ID: <1430930204-32184-2-git-send-email-vinod.koul@intel.com>
References: <1430930204-32184-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 073F92617C6
 for <alsa-devel@alsa-project.org>; Wed,  6 May 2015 18:36:25 +0200 (CEST)
In-Reply-To: <1430930204-32184-1-git-send-email-vinod.koul@intel.com>
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
Cc: patches.audio@intel.com, praveen.diwakar@intel.com, liam.r.girdwood@linux.intel.com, yang.a.fang@intel.com, broonie@kernel.org, sathyanarayana.nujella@intel.com, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

The current ssp configuration was not configuring the frame sync polarity
and data polarity. Some codecs do need these different so add them in ssp
configuration now

Signed-off-by: Praveen Diwakar <praveen.diwakar@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/atom/sst-atom-controls.c | 2 ++
 sound/soc/intel/atom/sst-atom-controls.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/sound/soc/intel/atom/sst-atom-controls.c b/sound/soc/intel/atom/sst-atom-controls.c
index 90aa5c0476f3..59517b3fa04d 100644
--- a/sound/soc/intel/atom/sst-atom-controls.c
+++ b/sound/soc/intel/atom/sst-atom-controls.c
@@ -789,6 +789,8 @@ static const struct sst_ssp_config sst_ssp_configs = {
 	.fs_frequency = SSP_FS_48_KHZ,
 	.active_slot_map = 0xF,
 	.start_delay = 0,
+	.frame_sync_polarity = SSP_FS_ACTIVE_HIGH,
+	.data_polarity = 1,
 };
 
 int send_ssp_cmd(struct snd_soc_dai *dai, const char *id, bool enable)
diff --git a/sound/soc/intel/atom/sst-atom-controls.h b/sound/soc/intel/atom/sst-atom-controls.h
index c55f76a535b3..eea715605130 100644
--- a/sound/soc/intel/atom/sst-atom-controls.h
+++ b/sound/soc/intel/atom/sst-atom-controls.h
@@ -562,6 +562,8 @@ struct sst_ssp_config {
 	u8 active_slot_map;
 	u8 start_delay;
 	u16 fs_width;
+	u8 frame_sync_polarity;
+	u8 data_polarity;
 };
 
 struct sst_ssp_cfg {
-- 
1.9.1
