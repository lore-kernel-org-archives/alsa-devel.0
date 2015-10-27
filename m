From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 16/17] ASoC: Intel: Skylake: Fix to remove
	channel_map calculation
Date: Tue, 27 Oct 2015 09:22:59 +0900
Message-ID: <1445905380-18167-17-git-send-email-vinod.koul@intel.com>
References: <1445905380-18167-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id E22D8265361
 for <alsa-devel@alsa-project.org>; Tue, 27 Oct 2015 01:24:08 +0100 (CET)
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
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Jeeja KP <jeeja.kp@intel.com>, Vinod Koul <vinod.koul@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

Widget FW topology private data already has the information
on the channel map, ch_cfg and interleaving. This patch removes
the calculation of channel_map in driver and reads the value
directly from widget private data.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-messages.c | 98 ++--------------------------------
 1 file changed, 5 insertions(+), 93 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index 07d3bf4a8bdd..bfde60bb8119 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -182,94 +182,6 @@ enum skl_bitdepth skl_get_bit_depth(int params)
 	}
 }
 
-static u32 skl_create_channel_map(enum skl_ch_cfg ch_cfg)
-{
-	u32 config;
-
-	switch (ch_cfg) {
-	case SKL_CH_CFG_MONO:
-		config =  (0xFFFFFFF0 | SKL_CHANNEL_LEFT);
-		break;
-
-	case SKL_CH_CFG_STEREO:
-		config = (0xFFFFFF00 | SKL_CHANNEL_LEFT
-			| (SKL_CHANNEL_RIGHT << 4));
-		break;
-
-	case SKL_CH_CFG_2_1:
-		config = (0xFFFFF000 | SKL_CHANNEL_LEFT
-			| (SKL_CHANNEL_RIGHT << 4)
-			| (SKL_CHANNEL_LFE << 8));
-		break;
-
-	case SKL_CH_CFG_3_0:
-		config =  (0xFFFFF000 | SKL_CHANNEL_LEFT
-			| (SKL_CHANNEL_CENTER << 4)
-			| (SKL_CHANNEL_RIGHT << 8));
-		break;
-
-	case SKL_CH_CFG_3_1:
-		config = (0xFFFF0000 | SKL_CHANNEL_LEFT
-			| (SKL_CHANNEL_CENTER << 4)
-			| (SKL_CHANNEL_RIGHT << 8)
-			| (SKL_CHANNEL_LFE << 12));
-		break;
-
-	case SKL_CH_CFG_QUATRO:
-		config = (0xFFFF0000 | SKL_CHANNEL_LEFT
-			| (SKL_CHANNEL_RIGHT << 4)
-			| (SKL_CHANNEL_LEFT_SURROUND << 8)
-			| (SKL_CHANNEL_RIGHT_SURROUND << 12));
-		break;
-
-	case SKL_CH_CFG_4_0:
-		config = (0xFFFF0000 | SKL_CHANNEL_LEFT
-			| (SKL_CHANNEL_CENTER << 4)
-			| (SKL_CHANNEL_RIGHT << 8)
-			| (SKL_CHANNEL_CENTER_SURROUND << 12));
-		break;
-
-	case SKL_CH_CFG_5_0:
-		config = (0xFFF00000 | SKL_CHANNEL_LEFT
-			| (SKL_CHANNEL_CENTER << 4)
-			| (SKL_CHANNEL_RIGHT << 8)
-			| (SKL_CHANNEL_LEFT_SURROUND << 12)
-			| (SKL_CHANNEL_RIGHT_SURROUND << 16));
-		break;
-
-	case SKL_CH_CFG_5_1:
-		config = (0xFF000000 | SKL_CHANNEL_CENTER
-			| (SKL_CHANNEL_LEFT << 4)
-			| (SKL_CHANNEL_RIGHT << 8)
-			| (SKL_CHANNEL_LEFT_SURROUND << 12)
-			| (SKL_CHANNEL_RIGHT_SURROUND << 16)
-			| (SKL_CHANNEL_LFE << 20));
-		break;
-
-	case SKL_CH_CFG_DUAL_MONO:
-		config = (0xFFFFFF00 | SKL_CHANNEL_LEFT
-			| (SKL_CHANNEL_LEFT << 4));
-		break;
-
-	case SKL_CH_CFG_I2S_DUAL_STEREO_0:
-		config = (0xFFFFFF00 | SKL_CHANNEL_LEFT
-			| (SKL_CHANNEL_RIGHT << 4));
-		break;
-
-	case SKL_CH_CFG_I2S_DUAL_STEREO_1:
-		config = (0xFFFF00FF | (SKL_CHANNEL_LEFT << 8)
-			| (SKL_CHANNEL_RIGHT << 12));
-		break;
-
-	default:
-		config =  0xFFFFFFFF;
-		break;
-
-	}
-
-	return config;
-}
-
 /*
  * Each module in DSP expects a base module configuration, which consists of
  * PCM format information, which we calculate in driver and resource values
@@ -293,10 +205,9 @@ static void skl_set_base_module_format(struct skl_sst *ctx,
 			format->bit_depth, format->valid_bit_depth,
 			format->ch_cfg);
 
-	base_cfg->audio_fmt.channel_map = skl_create_channel_map(
-					base_cfg->audio_fmt.ch_cfg);
+	base_cfg->audio_fmt.channel_map = format->ch_map;
 
-	base_cfg->audio_fmt.interleaving = SKL_INTERLEAVING_PER_CHANNEL;
+	base_cfg->audio_fmt.interleaving = format->interleaving_style;
 
 	base_cfg->cps = mconfig->mcps;
 	base_cfg->ibs = mconfig->ibs;
@@ -407,8 +318,9 @@ static void skl_setup_out_format(struct skl_sst *ctx,
 	out_fmt->valid_bit_depth = format->valid_bit_depth;
 	out_fmt->ch_cfg = format->ch_cfg;
 
-	out_fmt->channel_map = skl_create_channel_map(out_fmt->ch_cfg);
-	out_fmt->interleaving = SKL_INTERLEAVING_PER_CHANNEL;
+	out_fmt->channel_map = format->ch_map;
+	out_fmt->interleaving = format->interleaving_style;
+	out_fmt->sample_type = format->sample_type;
 
 	dev_dbg(ctx->dev, "copier out format chan=%d fre=%d bitdepth=%d\n",
 		out_fmt->number_of_channels, format->s_freq, format->bit_depth);
-- 
2.4.3
