From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Make local functions
	static" to the asoc tree
Date: Mon, 04 Dec 2017 18:49:16 +0000
Message-ID: <E1eLvno-0000QN-St@debutante>
References: <20171204050012.21498-1-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id AF28D26760B
 for <alsa-devel@alsa-project.org>; Mon,  4 Dec 2017 19:49:21 +0100 (CET)
In-Reply-To: <20171204050012.21498-1-guneshwor.o.singh@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Guneshwor Singh <guneshwor.o.singh@intel.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Patches Audio <patches.audio@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Make local functions static

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 8e79ec98e1f613f6fda5d91b16f5e38cf0bd4627 Mon Sep 17 00:00:00 2001
From: Guneshwor Singh <guneshwor.o.singh@intel.com>
Date: Mon, 4 Dec 2017 10:30:11 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Make local functions static

Some functions are local to the source and do not need to be in global
scope, so make them static.

Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-nhlt.c | 4 ++--
 sound/soc/intel/skylake/skl.c      | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-nhlt.c b/sound/soc/intel/skylake/skl-nhlt.c
index 4d2136c0389a..ca5dc2be7b68 100644
--- a/sound/soc/intel/skylake/skl-nhlt.c
+++ b/sound/soc/intel/skylake/skl-nhlt.c
@@ -269,7 +269,7 @@ void skl_nhlt_remove_sysfs(struct skl *skl)
  * stores all possible rates supported in a rate table for the corresponding
  * sclk/sclkfs.
  */
-void skl_get_ssp_clks(struct skl *skl, struct skl_ssp_clk *ssp_clks,
+static void skl_get_ssp_clks(struct skl *skl, struct skl_ssp_clk *ssp_clks,
 				struct nhlt_fmt *fmt, u8 id)
 {
 	struct skl_i2s_config_blob_legacy *i2s_config;
@@ -360,7 +360,7 @@ void skl_get_ssp_clks(struct skl *skl, struct skl_ssp_clk *ssp_clks,
 	}
 }
 
-void skl_get_mclk(struct skl *skl, struct skl_ssp_clk *mclk,
+static void skl_get_mclk(struct skl *skl, struct skl_ssp_clk *mclk,
 				struct nhlt_fmt *fmt, u8 id)
 {
 	struct skl_i2s_config_blob_legacy *i2s_config;
diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 63e5456ef401..a89592b2850e 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -545,7 +545,7 @@ struct skl_clk_parent_src *skl_get_parent_clk(u8 clk_id)
 	return NULL;
 }
 
-void init_skl_xtal_rate(int pci_id)
+static void init_skl_xtal_rate(int pci_id)
 {
 	switch (pci_id) {
 	case 0x9d70:
-- 
2.15.0
