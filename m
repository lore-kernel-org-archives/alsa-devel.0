From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 6/6] ASoC: Intel -atom: fix
	sst_platform_compr_ops declaration
Date: Fri, 19 Jun 2015 23:55:31 +0530
Message-ID: <1434738331-12518-7-git-send-email-vinod.koul@intel.com>
References: <1434738331-12518-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 6C56A2665CA
 for <alsa-devel@alsa-project.org>; Fri, 19 Jun 2015 20:24:38 +0200 (CEST)
In-Reply-To: <1434738331-12518-1-git-send-email-vinod.koul@intel.com>
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

Sparse complains that sst_platform_compr_ops should be static, but the
declaration of this symbol was not correct so declare the symbol as
extern in header file

sound/soc/intel/atom/sst-mfld-platform-compress.c:257:22: warning: symbol
'sst_platform_compr_ops' was not declared. Should it be static?

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/atom/sst-mfld-platform-pcm.c | 1 -
 sound/soc/intel/atom/sst-mfld-platform.h     | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/atom/sst-mfld-platform-pcm.c b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
index 641ebe61dc08..683e50116152 100644
--- a/sound/soc/intel/atom/sst-mfld-platform-pcm.c
+++ b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
@@ -33,7 +33,6 @@
 
 struct sst_device *sst;
 static DEFINE_MUTEX(sst_lock);
-extern struct snd_compr_ops sst_platform_compr_ops;
 
 int sst_register_dsp(struct sst_device *dev)
 {
diff --git a/sound/soc/intel/atom/sst-mfld-platform.h b/sound/soc/intel/atom/sst-mfld-platform.h
index 2409b23eeacf..cb32cc7e5ec1 100644
--- a/sound/soc/intel/atom/sst-mfld-platform.h
+++ b/sound/soc/intel/atom/sst-mfld-platform.h
@@ -25,6 +25,7 @@
 #include "sst-atom-controls.h"
 
 extern struct sst_device *sst;
+extern struct snd_compr_ops sst_platform_compr_ops;
 
 #define SST_MONO		1
 #define SST_STEREO		2
-- 
1.9.1
