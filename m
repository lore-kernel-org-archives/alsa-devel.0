From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 5/9] ASoC: Intel: Baytrail: remove unneeded
	variable
Date: Sun, 16 Dec 2018 16:49:06 -0600
Message-ID: <20181216224910.16198-6-pierre-louis.bossart@linux.intel.com>
References: <20181216224910.16198-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 8CE39267A79
 for <alsa-devel@alsa-project.org>; Sun, 16 Dec 2018 23:49:21 +0100 (CET)
In-Reply-To: <20181216224910.16198-1-pierre-louis.bossart@linux.intel.com>
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
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, Filip Kaczmarski <filip.kaczmarski@intel.com>, tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, Michal Wasko <michal.wasko@intel.com>, Gustaw Lewandowski <gustaw.lewandowski@intel.com>
List-Id: alsa-devel@alsa-project.org

Detected with Coccinelle

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/baytrail/sst-baytrail-ipc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/intel/baytrail/sst-baytrail-ipc.c b/sound/soc/intel/baytrail/sst-baytrail-ipc.c
index 260447da32b8..2cd8f9668b50 100644
--- a/sound/soc/intel/baytrail/sst-baytrail-ipc.c
+++ b/sound/soc/intel/baytrail/sst-baytrail-ipc.c
@@ -278,7 +278,6 @@ static int sst_byt_process_notification(struct sst_byt *byt,
 	struct sst_byt_stream *stream;
 	u64 header;
 	u8 msg_id, stream_id;
-	int handled = 1;
 
 	header = sst_dsp_shim_read64_unlocked(sst, SST_IPCD);
 	msg_id = sst_byt_header_msg_id(header);
@@ -298,7 +297,7 @@ static int sst_byt_process_notification(struct sst_byt *byt,
 		break;
 	}
 
-	return handled;
+	return 1;
 }
 
 static irqreturn_t sst_byt_irq_thread(int irq, void *context)
-- 
2.17.1
