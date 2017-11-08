From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Add channel map in
	updown mixer module IPC" to the asoc tree
Date: Wed, 08 Nov 2017 21:33:31 +0000
Message-ID: <E1eCXyV-0005a9-6Q@debutante>
References: <20171107104626.25800-3-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 93BB02676C3
 for <alsa-devel@alsa-project.org>; Wed,  8 Nov 2017 22:36:54 +0100 (CET)
In-Reply-To: <20171107104626.25800-3-guneshwor.o.singh@intel.com>
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

   ASoC: Intel: Skylake: Add channel map in updown mixer module IPC

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

>From da3417fe1f6d54c864b05fd5710979bdffe78034 Mon Sep 17 00:00:00 2001
From: Guneshwor Singh <guneshwor.o.singh@intel.com>
Date: Tue, 7 Nov 2017 16:16:17 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Add channel map in updown mixer module
 IPC

DSP expects channel map to be sent in the IPC for updown mixer module.
So add ch_map info in updown mixer module config.

Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-messages.c | 1 +
 sound/soc/intel/skylake/skl-topology.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index 55414be23b82..b9c205c8bb73 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -706,6 +706,7 @@ static void skl_set_updown_mixer_format(struct skl_sst *ctx,
 	skl_set_base_module_format(ctx,	mconfig,
 		(struct skl_base_cfg *)mixer_mconfig);
 	mixer_mconfig->out_ch_cfg = fmt->ch_cfg;
+	mixer_mconfig->ch_map = fmt->ch_map;
 }
 
 /*
diff --git a/sound/soc/intel/skylake/skl-topology.h b/sound/soc/intel/skylake/skl-topology.h
index 16cea466018c..bc3c29161ed0 100644
--- a/sound/soc/intel/skylake/skl-topology.h
+++ b/sound/soc/intel/skylake/skl-topology.h
@@ -161,6 +161,7 @@ struct skl_up_down_mixer_cfg {
 	u32 coeff_sel;
 	/* Pass the user coeff in this array */
 	s32 coeff[UP_DOWN_MIXER_MAX_COEFF];
+	u32 ch_map;
 } __packed;
 
 struct skl_algo_cfg {
-- 
2.15.0
