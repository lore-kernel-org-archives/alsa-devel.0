From: jeeja.kp@intel.com
Subject: [PATCH v2 05/11] ASoC: Intel: Skylake: Don't unload
	module when in use
Date: Fri, 24 Mar 2017 23:10:28 +0530
Message-ID: <1490377234-30257-6-git-send-email-jeeja.kp@intel.com>
References: <1490377234-30257-1-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 648002674BC
 for <alsa-devel@alsa-project.org>; Fri, 24 Mar 2017 18:28:31 +0100 (CET)
In-Reply-To: <1490377234-30257-1-git-send-email-jeeja.kp@intel.com>
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
Cc: tiwai@suse.de, patches.audio@intel.com, broonie@kernel.org, liam.r.girdwood@intel.com, Jeeja KP <jeeja.kp@intel.com>, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Vinod Koul <vinod.koul@intel.com>

A module may have multiple instances in DSP, so unload only when usage
count is zero.

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
---
 sound/soc/intel/skylake/skl-sst.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-sst.c b/sound/soc/intel/skylake/skl-sst.c
index 39d4aaa..5395297 100644
--- a/sound/soc/intel/skylake/skl-sst.c
+++ b/sound/soc/intel/skylake/skl-sst.c
@@ -417,6 +417,11 @@ static int skl_unload_module(struct sst_dsp *ctx, u16 mod_id)
 		dev_err(ctx->dev, "Module bad usage cnt!:%d\n", usage_cnt);
 		return -EIO;
 	}
+
+	/* if module is used by others return, no need to unload */
+	if (usage_cnt > 0)
+		return 0;
+
 	ret = skl_ipc_unload_modules(&skl->ipc,
 			SKL_NUM_MODULES, &mod_id);
 	if (ret < 0) {
-- 
2.5.0
