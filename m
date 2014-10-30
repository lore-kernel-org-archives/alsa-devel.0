From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 2/4] ASoC: Intel: use correct firmware name
Date: Thu, 30 Oct 2014 16:20:57 +0530
Message-ID: <1414666259-4450-3-git-send-email-vinod.koul@intel.com>
References: <1414666259-4450-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 0ED2A2605DF
 for <alsa-devel@alsa-project.org>; Thu, 30 Oct 2014 12:31:52 +0100 (CET)
In-Reply-To: <1414666259-4450-1-git-send-email-vinod.koul@intel.com>
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
Cc: "Fang, Yang A" <yang.a.fang@intel.com>, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

From: Fang, Yang A <yang.a.fang@intel.com>

The firmware name was used worngly, so fix it up

Signed-off-by: Fang, Yang A <yang.a.fang@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/sst/sst_loader.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/sound/soc/intel/sst/sst_loader.c b/sound/soc/intel/sst/sst_loader.c
index 00f60c1..b580f96 100644
--- a/sound/soc/intel/sst/sst_loader.c
+++ b/sound/soc/intel/sst/sst_loader.c
@@ -344,12 +344,9 @@ void sst_firmware_load_cb(const struct firmware *fw, void *context)
 static int sst_request_fw(struct intel_sst_drv *sst)
 {
 	int retval = 0;
-	char name[20];
 	const struct firmware *fw;
 
-	dev_dbg(sst->dev, "Requesting FW %s now...\n", name);
-
-	retval = request_firmware(&fw, name, sst->dev);
+	retval = request_firmware(&fw, sst->firmware_name, sst->dev);
 	if (fw == NULL) {
 		dev_err(sst->dev, "fw is returning as null\n");
 		return -EINVAL;
-- 
1.7.0.4
