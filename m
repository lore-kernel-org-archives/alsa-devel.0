From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 08/12] ASoC: Intel: Bxt: Parse UUIDs once
Date: Tue, 26 Jul 2016 18:06:46 +0530
Message-ID: <1469536610-27606-9-git-send-email-vinod.koul@intel.com>
References: <1469536610-27606-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 297842669C8
 for <alsa-devel@alsa-project.org>; Tue, 26 Jul 2016 14:30:18 +0200 (CEST)
In-Reply-To: <1469536610-27606-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

The firmware manifest contains UUIDs which needs to be passed only once.

So use the newly introduced is_first_boot flag to distinguish and parse
these only once on bxt platform as well.

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/bxt-sst.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/skylake/bxt-sst.c b/sound/soc/intel/skylake/bxt-sst.c
index d6bf32405b3b..90702cef8b64 100644
--- a/sound/soc/intel/skylake/bxt-sst.c
+++ b/sound/soc/intel/skylake/bxt-sst.c
@@ -175,9 +175,12 @@ static int bxt_load_base_firmware(struct sst_dsp *ctx)
 	if (ctx->fw == NULL)
 		goto sst_load_base_firmware_failed;
 
-	ret = snd_skl_parse_uuids(ctx, ctx->fw, BXT_ADSP_FW_BIN_HDR_OFFSET, 0);
-	if (ret < 0)
-		goto sst_load_base_firmware_failed;
+	/* prase uuids on first boot */
+	if (skl->is_first_boot) {
+		ret = snd_skl_parse_uuids(ctx, ctx->fw, BXT_ADSP_FW_BIN_HDR_OFFSET, 0);
+		if (ret < 0)
+			goto sst_load_base_firmware_failed;
+	}
 
 	stripped_fw.data = ctx->fw->data;
 	stripped_fw.size = ctx->fw->size;
-- 
1.9.1
