From: cezary.rojewski@intel.com
Subject: [PATCH 5/7] ASoC: Intel: Common: Fix NULL dereference
	in tx_wait_done
Date: Thu, 13 Jun 2019 21:04:34 +0200
Message-ID: <20190613190436.20156-6-cezary.rojewski@intel.com>
References: <20190613190436.20156-1-cezary.rojewski@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D95E1F89711
 for <alsa-devel@alsa-project.org>; Thu, 13 Jun 2019 21:05:32 +0200 (CEST)
In-Reply-To: <20190613190436.20156-1-cezary.rojewski@intel.com>
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
Cc: lgirdwood@gmail.com, Cezary Rojewski <cezary.rojewski@intel.com>, broonie@kernel.org, tiwai@suse.com, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

From: Cezary Rojewski <cezary.rojewski@intel.com>

rx_data and rx_bytes present for tx_wait_done are optional parameters.
If not provided, function should not attempt to copy received data.
This change fixes memcpy NULL pointer dereference issue occurring when
optional rx_data is NULL while received message size is non-zero.

Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 sound/soc/intel/common/sst-ipc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/common/sst-ipc.c b/sound/soc/intel/common/sst-ipc.c
index dcff13802c00..fc3340f1da3a 100644
--- a/sound/soc/intel/common/sst-ipc.c
+++ b/sound/soc/intel/common/sst-ipc.c
@@ -71,7 +71,7 @@ static int tx_wait_done(struct sst_generic_ipc *ipc,
 	} else {
 
 		/* copy the data returned from DSP */
-		if (msg->rx_size)
+		if (rx_data)
 			memcpy(rx_data, msg->rx_data, msg->rx_size);
 		ret = msg->errno;
 	}
-- 
2.17.1
