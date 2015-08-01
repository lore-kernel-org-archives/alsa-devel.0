From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v2 1/6] ASoC: Intel: Skylake: Fix the NHLT rate
	size
Date: Sat,  1 Aug 2015 19:40:39 +0530
Message-ID: <1438438244-17974-2-git-send-email-vinod.koul@intel.com>
References: <1438438244-17974-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id DBFAD261584
 for <alsa-devel@alsa-project.org>; Sat,  1 Aug 2015 16:08:59 +0200 (CEST)
In-Reply-To: <1438438244-17974-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

Sampling rate type needs to be u32 instead of u8, nhlt wav format
description expected u32 for rate, passing u8 will fetch NULL
config in skl_get_ep_blob().

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-nhlt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-nhlt.c b/sound/soc/intel/skylake/skl-nhlt.c
index 5c0895eaa10a..a14009b47b29 100644
--- a/sound/soc/intel/skylake/skl-nhlt.c
+++ b/sound/soc/intel/skylake/skl-nhlt.c
@@ -56,7 +56,7 @@ void skl_nhlt_free(void __iomem *addr)
 
 static struct nhlt_specific_cfg *skl_get_specific_cfg(
 		struct device *dev, struct nhlt_fmt *fmt,
-		u8 no_ch, u8 rate, u16 bps)
+		u8 no_ch, u32 rate, u16 bps)
 {
 	struct nhlt_specific_cfg *sp_config;
 	struct wav_fmt *wfmt;
-- 
1.9.1
