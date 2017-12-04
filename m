From: Guneshwor Singh <guneshwor.o.singh@intel.com>
Subject: [PATCH 1/2] ASoC: Intel: Skylake: Make local functions
	static
Date: Mon,  4 Dec 2017 10:30:11 +0530
Message-ID: <20171204050012.21498-1-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id 8C8F226710B
 for <alsa-devel@alsa-project.org>; Mon,  4 Dec 2017 06:00:03 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Patches Audio <patches.audio@intel.com>
List-Id: alsa-devel@alsa-project.org

Some functions are local to the source and do not need to be in global
scope, so make them static.

Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
---
 sound/soc/intel/skylake/skl-nhlt.c | 4 ++--
 sound/soc/intel/skylake/skl.c      | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-nhlt.c b/sound/soc/intel/skylake/skl-nhlt.c
index 6734a439196b..e2121ddc8ef0 100644
--- a/sound/soc/intel/skylake/skl-nhlt.c
+++ b/sound/soc/intel/skylake/skl-nhlt.c
@@ -283,7 +283,7 @@ void skl_nhlt_remove_sysfs(struct skl *skl)
  * stores all possible rates supported in a rate table for the corresponding
  * sclk/sclkfs.
  */
-void skl_get_ssp_clks(struct skl *skl, struct skl_ssp_clk *ssp_clks,
+static void skl_get_ssp_clks(struct skl *skl, struct skl_ssp_clk *ssp_clks,
 				struct nhlt_fmt *fmt, u8 id)
 {
 	struct skl_i2s_config_blob_legacy *i2s_config;
@@ -374,7 +374,7 @@ void skl_get_ssp_clks(struct skl *skl, struct skl_ssp_clk *ssp_clks,
 	}
 }
 
-void skl_get_mclk(struct skl *skl, struct skl_ssp_clk *mclk,
+static void skl_get_mclk(struct skl *skl, struct skl_ssp_clk *mclk,
 				struct nhlt_fmt *fmt, u8 id)
 {
 	struct skl_i2s_config_blob_legacy *i2s_config;
diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 9e90a50dd9cd..90cc207869c7 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -568,7 +568,7 @@ struct skl_clk_parent_src *skl_get_parent_clk(u8 clk_id)
 	return NULL;
 }
 
-void init_skl_xtal_rate(int pci_id)
+static void init_skl_xtal_rate(int pci_id)
 {
 	switch (pci_id) {
 	case 0x9d70:
-- 
2.15.1
