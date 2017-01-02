From: jeeja.kp@intel.com
Subject: [PATCH 4/6] ASoC: Intel: Skylake: Release FW ctx in
	cleanup
Date: Mon,  2 Jan 2017 09:50:05 +0530
Message-ID: <1483330807-9518-5-git-send-email-jeeja.kp@intel.com>
References: <1483330807-9518-1-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 08C342666EC
 for <alsa-devel@alsa-project.org>; Mon,  2 Jan 2017 05:09:32 +0100 (CET)
In-Reply-To: <1483330807-9518-1-git-send-email-jeeja.kp@intel.com>
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
Cc: tiwai@suse.de, patches.audio@intel.com, broonie@kernel.org, liam.r.girdwood@intel.com, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

Saved firmware ctx was not never released, so release Firmware
ctx in cleanup routine.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
---
 sound/soc/intel/skylake/skl-sst.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-sst.c b/sound/soc/intel/skylake/skl-sst.c
index 8fc3178..b30bd38 100644
--- a/sound/soc/intel/skylake/skl-sst.c
+++ b/sound/soc/intel/skylake/skl-sst.c
@@ -515,6 +515,9 @@ EXPORT_SYMBOL_GPL(skl_sst_init_fw);
 
 void skl_sst_dsp_cleanup(struct device *dev, struct skl_sst *ctx)
 {
+
+	if (ctx->dsp->fw)
+		release_firmware(ctx->dsp->fw);
 	skl_clear_module_table(ctx->dsp);
 	skl_freeup_uuid_list(ctx);
 	skl_ipc_free(&ctx->ipc);
-- 
2.5.0
