From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ASoC: intel: remove unused variable data and
	associated code
Date: Wed, 22 Mar 2017 14:36:44 +0000
Message-ID: <20170322143644.29051-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id A6DA8266A73
 for <alsa-devel@alsa-project.org>; Wed, 22 Mar 2017 15:36:53 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jie Yang <yang.jie@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

The variable 'data' is assigned null and never re-assigned. There
is also a redundant check for data being non-null which is always
false, so remove this and the variable data and dma_addr as they
are not used once the dead code has been removed.

Detected with CoverityScan, CID#1324015 ("'Constant' variable gaurds
dead code")

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/intel/haswell/sst-haswell-ipc.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/sound/soc/intel/haswell/sst-haswell-ipc.c b/sound/soc/intel/haswell/sst-haswell-ipc.c
index a3459d1682a6..d33bdaf92c57 100644
--- a/sound/soc/intel/haswell/sst-haswell-ipc.c
+++ b/sound/soc/intel/haswell/sst-haswell-ipc.c
@@ -2000,10 +2000,8 @@ int sst_hsw_module_set_param(struct sst_hsw *hsw,
 	u32 param_size, char *param)
 {
 	int ret;
-	unsigned char *data = NULL;
 	u32 header = 0;
 	u32 payload_size = 0, transfer_parameter_size = 0;
-	dma_addr_t dma_addr = 0;
 	struct sst_hsw_transfer_parameter *parameter;
 	struct device *dev = hsw->dev;
 
@@ -2047,10 +2045,6 @@ int sst_hsw_module_set_param(struct sst_hsw *hsw,
 
 	kfree(parameter);
 
-	if (data)
-		dma_free_coherent(hsw->dsp->dma_dev,
-			param_size, (void *)data, dma_addr);
-
 	return ret;
 }
 
-- 
2.11.0
