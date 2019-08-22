From: Cezary Rojewski <cezary.rojewski@intel.com>
Subject: [PATCH 07/35] ASoC: Intel: Skylake: Update interrupt
	disabling routine
Date: Thu, 22 Aug 2019 21:03:57 +0200
Message-ID: <20190822190425.23001-8-cezary.rojewski@intel.com>
References: <20190822190425.23001-1-cezary.rojewski@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6C069F805A1
 for <alsa-devel@alsa-project.org>; Thu, 22 Aug 2019 21:04:54 +0200 (CEST)
In-Reply-To: <20190822190425.23001-1-cezary.rojewski@intel.com>
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

CNL disable interrupt routine correctly makes use of locked _update_bits
whereas SKL lagged behind and still invokes unlocked variants. Update
SKL equivalent to match its CNL brother.

Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 sound/soc/intel/skylake/skl-sst-ipc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-sst-ipc.c b/sound/soc/intel/skylake/skl-sst-ipc.c
index 91b5440c643d..4875a518dd54 100644
--- a/sound/soc/intel/skylake/skl-sst-ipc.c
+++ b/sound/soc/intel/skylake/skl-sst-ipc.c
@@ -582,11 +582,11 @@ void skl_ipc_op_int_enable(struct sst_dsp *ctx)
 void skl_ipc_op_int_disable(struct sst_dsp *ctx)
 {
 	/* disable IPC DONE interrupt */
-	sst_dsp_shim_update_bits_unlocked(ctx, SKL_ADSP_REG_HIPCCTL,
+	sst_dsp_shim_update_bits(ctx, SKL_ADSP_REG_HIPCCTL,
 					SKL_ADSP_REG_HIPCCTL_DONE, 0);
 
 	/* Disable IPC BUSY interrupt */
-	sst_dsp_shim_update_bits_unlocked(ctx, SKL_ADSP_REG_HIPCCTL,
+	sst_dsp_shim_update_bits(ctx, SKL_ADSP_REG_HIPCCTL,
 					SKL_ADSP_REG_HIPCCTL_BUSY, 0);
 
 }
-- 
2.17.1
