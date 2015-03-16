From: han.lu@intel.com
Subject: [PATCH 1/1] Intel: ASoC: remove duplicated code on
	merge
Date: Mon, 16 Mar 2015 12:46:29 +0800
Message-ID: <1426481189-9898-1-git-send-email-han.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id B2441260625
 for <alsa-devel@alsa-project.org>; Mon, 16 Mar 2015 05:46:54 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
Cc: "Lu, Han" <han.lu@intel.com>
List-Id: alsa-devel@alsa-project.org

From: "Lu, Han" <han.lu@intel.com>

Signed-off-by: Lu, Han <han.lu@intel.com>

diff --git a/sound/soc/intel/sst-haswell-ipc.c b/sound/soc/intel/sst-haswell-ipc.c
index d4865a6..43fb5f3 100644
--- a/sound/soc/intel/sst-haswell-ipc.c
+++ b/sound/soc/intel/sst-haswell-ipc.c
@@ -2363,11 +2363,6 @@ int sst_hsw_dsp_init(struct device *dev, struct sst_pdata *pdata)
 	/* init param buffer */
 	sst_hsw_reset_param_buf(hsw);
 
-	/* allocate scratch mem regions */
-	ret = sst_block_alloc_scratch(hsw->dsp);
-	if (ret < 0)
-		goto boot_err;
-
 	/* wait for DSP boot completion */
 	sst_dsp_boot(hsw->dsp);
 	ret = wait_event_timeout(hsw->boot_wait, hsw->boot_complete,
-- 
1.9.1
