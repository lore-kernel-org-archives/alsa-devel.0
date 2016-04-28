From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Update channel map
	based on runtime params" to the asoc tree
Date: Thu, 28 Apr 2016 18:55:09 +0100
Message-ID: <E1avq9d-0002vu-0i@debutante>
References: <1460437293-8509-12-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id ACD4326518B
 for <alsa-devel@alsa-project.org>; Thu, 28 Apr 2016 19:55:17 +0200 (CEST)
In-Reply-To: <1460437293-8509-12-git-send-email-subhransu.s.prusty@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, lgirdwood@gmail.com, patches.audio@intel.com, tiwai@suse.de, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Update channel map based on runtime params

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From ea5a137d0fe263854ae6267a0fa208c544d83452 Mon Sep 17 00:00:00 2001
From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Date: Thu, 14 Apr 2016 10:07:36 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Update channel map based on runtime
 params

Default channel map is set for 2 channels. Fix the channel map
based on runtime params to support multichannel.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-topology.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 545b4e77b8aa..8fceb7a04147 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -154,13 +154,32 @@ static void skl_dump_mconfig(struct skl_sst *ctx,
 	dev_dbg(ctx->dev, "ch_cfg = %d\n", mcfg->out_fmt[0].ch_cfg);
 }
 
+static void skl_tplg_update_chmap(struct skl_module_fmt *fmt, int chs)
+{
+	int slot_map = 0xFFFFFFFF;
+	int start_slot = 0;
+	int i;
+
+	for (i = 0; i < chs; i++) {
+		/*
+		 * For 2 channels with starting slot as 0, slot map will
+		 * look like 0xFFFFFF10.
+		 */
+		slot_map &= (~(0xF << (4 * i)) | (start_slot << (4 * i)));
+		start_slot++;
+	}
+	fmt->ch_map = slot_map;
+}
+
 static void skl_tplg_update_params(struct skl_module_fmt *fmt,
 			struct skl_pipe_params *params, int fixup)
 {
 	if (fixup & SKL_RATE_FIXUP_MASK)
 		fmt->s_freq = params->s_freq;
-	if (fixup & SKL_CH_FIXUP_MASK)
+	if (fixup & SKL_CH_FIXUP_MASK) {
 		fmt->channels = params->ch;
+		skl_tplg_update_chmap(fmt, fmt->channels);
+	}
 	if (fixup & SKL_FMT_FIXUP_MASK) {
 		fmt->valid_bit_depth = skl_get_bit_depth(params->s_fmt);
 
-- 
2.8.0.rc3
