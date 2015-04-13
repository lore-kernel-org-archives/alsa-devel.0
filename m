From: Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH] ASoC: Intel: Remove invalid kfree of devm
	allocated data
Date: Mon, 13 Apr 2015 14:20:54 +0800
Message-ID: <1428906054-17613-1-git-send-email-yao.jin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 3A71B261609
 for <alsa-devel@alsa-project.org>; Mon, 13 Apr 2015 08:13:45 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, liam.r.girdwood@intel.com
Cc: alsa-devel@alsa-project.org, Jin Yao <yao.jin@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

kbuild robot reports following warning:
"sound/soc/intel/haswell/sst-haswell-ipc.c:2204:1-6:
 WARNING: invalid free of devm_ allocated data"

As julia explains to me, the memory allocated with devm_kalloc
is freed automatically on failure of a probe function. So this
kfree should be removed otherwise the double free will be got in
error handler path.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 sound/soc/intel/haswell/sst-haswell-ipc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/intel/haswell/sst-haswell-ipc.c b/sound/soc/intel/haswell/sst-haswell-ipc.c
index 344a1e9..324eceb 100644
--- a/sound/soc/intel/haswell/sst-haswell-ipc.c
+++ b/sound/soc/intel/haswell/sst-haswell-ipc.c
@@ -2201,7 +2201,6 @@ dma_err:
 dsp_new_err:
 	sst_ipc_fini(ipc);
 ipc_init_err:
-	kfree(hsw);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(sst_hsw_dsp_init);
-- 
1.9.1
