From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 11/16] ASoC: Intel: Skylake: update mailbox
	uplink window offset and size
Date: Sat, 28 Nov 2015 15:01:56 +0530
Message-ID: <1448703121-5831-12-git-send-email-vinod.koul@intel.com>
References: <1448703121-5831-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id D84672651EB
 for <alsa-devel@alsa-project.org>; Sat, 28 Nov 2015 10:32:59 +0100 (CET)
In-Reply-To: <1448703121-5831-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, Omair M Abdullah <omair.m.abdullah@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Omair M Abdullah <omair.m.abdullah@intel.com>

SKL actual mailbox size is 0x10000 and initial values were 0x800,
so update these accordingly

Signed-off-by: Omair M Abdullah <omair.m.abdullah@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-sst-dsp.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-sst-dsp.h b/sound/soc/intel/skylake/skl-sst-dsp.h
index 5d0947935e2b..cbb40751c37e 100644
--- a/sound/soc/intel/skylake/skl-sst-dsp.h
+++ b/sound/soc/intel/skylake/skl-sst-dsp.h
@@ -58,9 +58,9 @@ struct sst_dsp_device;
 
 #define SKL_ADSP_MMIO_LEN		0x10000
 
-#define SKL_ADSP_W0_STAT_SZ		0x800
+#define SKL_ADSP_W0_STAT_SZ		0x1000
 
-#define SKL_ADSP_W0_UP_SZ		0x800
+#define SKL_ADSP_W0_UP_SZ		0x1000
 
 #define SKL_ADSP_W1_SZ			0x1000
 
-- 
2.4.3
