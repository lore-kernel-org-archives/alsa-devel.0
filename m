From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 07/17] ASoC: Intel: Skylake: Fix bit depth when
	querying the NHLT blob
Date: Tue, 27 Oct 2015 09:22:50 +0900
Message-ID: <1445905380-18167-8-git-send-email-vinod.koul@intel.com>
References: <1445905380-18167-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 0136A26519F
 for <alsa-devel@alsa-project.org>; Tue, 27 Oct 2015 01:23:34 +0100 (CET)
In-Reply-To: <1445905380-18167-1-git-send-email-vinod.koul@intel.com>
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
Cc: tiwai@suse.de, patches.audio@intel.com, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

Bps calculation is not correct as this needs to be based on valid
bit depth.  16 bit fmt bit depth is 16 bit and for 24 and 32 bit
as it is container size This patch fixes the bps.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-nhlt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-nhlt.c b/sound/soc/intel/skylake/skl-nhlt.c
index b0c7bd113aac..3ff22eba5875 100644
--- a/sound/soc/intel/skylake/skl-nhlt.c
+++ b/sound/soc/intel/skylake/skl-nhlt.c
@@ -115,7 +115,7 @@ struct nhlt_specific_cfg
 	struct device *dev = bus->dev;
 	struct nhlt_specific_cfg *sp_config;
 	struct nhlt_acpi_table *nhlt = (struct nhlt_acpi_table *)skl->nhlt;
-	u16 bps = num_ch * s_fmt;
+	u16 bps = (s_fmt == 16) ? 16 : 32;
 	u8 j;
 
 	dump_config(dev, instance, link_type, s_fmt, num_ch, s_rate, dirn, bps);
-- 
2.4.3
