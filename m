From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH 01/11] ASoC: Intel: Skylake: Fix ibs/obs calc
	for non-integral sampling rates
Date: Tue, 12 Apr 2016 10:31:23 +0530
Message-ID: <1460437293-8509-2-git-send-email-subhransu.s.prusty@intel.com>
References: <1460437293-8509-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id BFA4B265347
 for <alsa-devel@alsa-project.org>; Tue, 12 Apr 2016 07:02:28 +0200 (CEST)
In-Reply-To: <1460437293-8509-1-git-send-email-subhransu.s.prusty@intel.com>
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

FW expects sampling rate rounded up to next higher integer value
when calculating ibs/obs. For example for 44.1k, it should be
rounded up to 45 to calculate ibs/obs.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-topology.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 5a85f3a..cdb78b7 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -239,6 +239,7 @@ static void skl_tplg_update_buffer_size(struct skl_sst *ctx,
 {
 	int multiplier = 1;
 	struct skl_module_fmt *in_fmt, *out_fmt;
+	int in_rate, out_rate;
 
 
 	/* Since fixups is applied to pin 0 only, ibs, obs needs
@@ -249,15 +250,24 @@ static void skl_tplg_update_buffer_size(struct skl_sst *ctx,
 
 	if (mcfg->m_type == SKL_MODULE_TYPE_SRCINT)
 		multiplier = 5;
-	mcfg->ibs = (in_fmt->s_freq / 1000) *
-				(mcfg->in_fmt->channels) *
-				(mcfg->in_fmt->bit_depth >> 3) *
-				multiplier;
-
-	mcfg->obs = (mcfg->out_fmt->s_freq / 1000) *
-				(mcfg->out_fmt->channels) *
-				(mcfg->out_fmt->bit_depth >> 3) *
-				multiplier;
+
+	if (in_fmt->s_freq % 1000)
+		in_rate = (in_fmt->s_freq / 1000) + 1;
+	else
+		in_rate = (in_fmt->s_freq / 1000);
+
+	mcfg->ibs = in_rate * (mcfg->in_fmt->channels) *
+			(mcfg->in_fmt->bit_depth >> 3) *
+			multiplier;
+
+	if (mcfg->out_fmt->s_freq % 1000)
+		out_rate = (mcfg->out_fmt->s_freq / 1000) + 1;
+	else
+		out_rate = (mcfg->out_fmt->s_freq / 1000);
+
+	mcfg->obs = out_rate * (mcfg->out_fmt->channels) *
+			(mcfg->out_fmt->bit_depth >> 3) *
+			multiplier;
 }
 
 static int skl_tplg_update_be_blob(struct snd_soc_dapm_widget *w,
-- 
1.9.1
