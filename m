From: Keyon Jie <yang.jie@linux.intel.com>
Subject: [PATCH v3 1/2] ASoC: SOF: add flag for position update
	ipc
Date: Thu, 18 Jul 2019 11:11:12 +0800
Message-ID: <20190718031113.25040-1-yang.jie@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E4A3DF802BC
 for <alsa-devel@alsa-project.org>; Thu, 18 Jul 2019 05:05:51 +0200 (CEST)
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
Cc: kai.vehmanen@linux.intel.com, Marcin Rajwa <marcin.rajwa@linux.intel.com>, marcin.rajwa@intel.com, Keyon Jie <yang.jie@linux.intel.com>, ranjani.sridharan@linux.intel.com, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

From: Marcin Rajwa <marcin.rajwa@linux.intel.com>

In some cases, FW might need to use the host_period_bytes field to
synchronize the DMA copying (with host side) but the driver does not
need any position information returned over the IPC channel by the
firmware. The current IPC definition prevents this capability, so add
new field.

Signed-off-by: Marcin Rajwa <marcin.rajwa@linux.intel.com>
Signed-off-by: Keyon Jie <yang.jie@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 include/sound/sof/stream.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/sound/sof/stream.h b/include/sound/sof/stream.h
index 643f175cb479..06af4ecb2584 100644
--- a/include/sound/sof/stream.h
+++ b/include/sound/sof/stream.h
@@ -83,10 +83,10 @@ struct sof_ipc_stream_params {
 	uint16_t sample_valid_bytes;
 	uint16_t sample_container_bytes;
 
-	/* for notifying host period has completed - 0 means no period IRQ */
 	uint32_t host_period_bytes;
+	uint32_t no_position_ipc; /* 1 means no IPC for position upadte */
 
-	uint32_t reserved[2];
+	uint16_t reserved[3];
 	uint16_t chmap[SOF_IPC_MAX_CHANNELS];	/**< channel map - SOF_CHMAP_ */
 } __packed;
 
-- 
2.20.1
