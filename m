From: Guneshwor Singh <guneshwor.o.singh@intel.com>
Subject: [PATCH 02/11] ASoC: Intel: Skylake: Add channel map in
	updown mixer module IPC
Date: Tue,  7 Nov 2017 16:16:17 +0530
Message-ID: <20171107104626.25800-3-guneshwor.o.singh@intel.com>
References: <20171107104626.25800-1-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 13F9A267386
 for <alsa-devel@alsa-project.org>; Tue,  7 Nov 2017 11:47:09 +0100 (CET)
In-Reply-To: <20171107104626.25800-1-guneshwor.o.singh@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ALSA ML <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Patches Audio <patches.audio@intel.com>
List-Id: alsa-devel@alsa-project.org

DSP expects channel map to be sent in the IPC for updown mixer module.
So add ch_map info in updown mixer module config.

Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
---
 sound/soc/intel/skylake/skl-messages.c | 1 +
 sound/soc/intel/skylake/skl-topology.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index 49e6a4d7adfc..61b5bfa79d13 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -711,6 +711,7 @@ static void skl_set_updown_mixer_format(struct skl_sst *ctx,
 	skl_set_base_module_format(ctx,	mconfig,
 		(struct skl_base_cfg *)mixer_mconfig);
 	mixer_mconfig->out_ch_cfg = fmt->ch_cfg;
+	mixer_mconfig->ch_map = fmt->ch_map;
 }
 
 /*
diff --git a/sound/soc/intel/skylake/skl-topology.h b/sound/soc/intel/skylake/skl-topology.h
index 28316cb4f36f..b6496513fe55 100644
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
2.14.2
