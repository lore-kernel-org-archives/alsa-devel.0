From: Keyon Jie <yang.jie@linux.intel.com>
Subject: [PATCH 1/2] ASoC: SOF: ipc: update
	sof_ipc_stream_params
Date: Tue,  2 Jul 2019 20:11:43 +0800
Message-ID: <20190702121144.7809-1-yang.jie@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7E84CF80058
 for <alsa-devel@alsa-project.org>; Tue,  2 Jul 2019 14:06:33 +0200 (CEST)
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
Cc: marcin.rajwa@intel.com, Keyon Jie <yang.jie@linux.intel.com>, ranjani.sridharan@linux.intel.com, Marcin Rajwa <marcin.rajwa@linux.intel.com>, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

From: Marcin Rajwa <marcin.rajwa@linux.intel.com>

The host period bytes needs to be passed to firmware.
Currently this field is used as notification for host
about period copy completion. Therefore we need to split these
two informations.

Signed-off-by: Marcin Rajwa <marcin.rajwa@linux.intel.com>
Signed-off-by: Keyon Jie <yang.jie@linux.intel.com>
---
 include/sound/sof/stream.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/sound/sof/stream.h b/include/sound/sof/stream.h
index 643f175cb479..44acfa62fa69 100644
--- a/include/sound/sof/stream.h
+++ b/include/sound/sof/stream.h
@@ -83,10 +83,10 @@ struct sof_ipc_stream_params {
 	uint16_t sample_valid_bytes;
 	uint16_t sample_container_bytes;
 
-	/* for notifying host period has completed - 0 means no period IRQ */
 	uint32_t host_period_bytes;
+	uint16_t no_period_irq; /* 1 means period IRQ mode OFF */
 
-	uint32_t reserved[2];
+	uint16_t reserved[3];
 	uint16_t chmap[SOF_IPC_MAX_CHANNELS];	/**< channel map - SOF_CHMAP_ */
 } __packed;
 
-- 
2.20.1
