From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH 1/2] ASoC: Intel: haswell: fix initialize 'NULL
	device *' issue
Date: Tue, 28 Jul 2015 16:01:05 +0800
Message-ID: <1438070466-30008-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 16417260451
 for <alsa-devel@alsa-project.org>; Tue, 28 Jul 2015 09:56:05 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

Add initialization for sst_hsw.dev at init stage, which fix the
'NULL device *' warning issues.

Signed-off-by: Jie Yang <yang.jie@intel.com>
---
 sound/soc/intel/haswell/sst-haswell-ipc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/intel/haswell/sst-haswell-ipc.c b/sound/soc/intel/haswell/sst-haswell-ipc.c
index f95f271..f6efa9d 100644
--- a/sound/soc/intel/haswell/sst-haswell-ipc.c
+++ b/sound/soc/intel/haswell/sst-haswell-ipc.c
@@ -2119,6 +2119,8 @@ int sst_hsw_dsp_init(struct device *dev, struct sst_pdata *pdata)
 	if (hsw == NULL)
 		return -ENOMEM;
 
+	hsw->dev = dev;
+
 	ipc = &hsw->ipc;
 	ipc->dev = dev;
 	ipc->ops.tx_msg = hsw_tx_msg;
-- 
1.9.1
