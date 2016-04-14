From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH v3 9/9] ASoC: Intel: Skylake: Update channel
	map based on runtime params
Date: Thu, 14 Apr 2016 10:07:36 +0530
Message-ID: <1460608656-8860-10-git-send-email-subhransu.s.prusty@intel.com>
References: <1460608656-8860-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 9A3CD26667C
 for <alsa-devel@alsa-project.org>; Thu, 14 Apr 2016 06:38:53 +0200 (CEST)
In-Reply-To: <1460608656-8860-1-git-send-email-subhransu.s.prusty@intel.com>
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
Cc: tiwai@suse.de, lgirdwood@gmail.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

Default channel map is set for 2 channels. Fix the channel map
based on runtime params to support multichannel.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-topology.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index cdb78b7..1f4fe0e 100644
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
1.9.1
