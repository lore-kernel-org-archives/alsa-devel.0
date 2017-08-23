From: Guneshwor Singh <guneshwor.o.singh@intel.com>
Subject: [PATCH v2 3/7] ASoC: Intel: Skylake: Commonize parsing
	of format tokens
Date: Wed, 23 Aug 2017 19:33:50 +0530
Message-ID: <20170823140354.792-4-guneshwor.o.singh@intel.com>
References: <20170823140354.792-1-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id CF1412664EB
 for <alsa-devel@alsa-project.org>; Wed, 23 Aug 2017 16:04:17 +0200 (CEST)
In-Reply-To: <20170823140354.792-1-guneshwor.o.singh@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Patches Audio <patches.audio@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, Shreyas NC <shreyas.nc@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Shreyas NC <shreyas.nc@intel.com>

Format resource tokens can be a part of either the widget or manifest
private data. In the current model, format resources come as a part of
widget private data and they come as a part of topology manifest in the
newly introduced model.

So add a common function that can fill up either of the structures.

Signed-off-by: Shreyas NC <shreyas.nc@intel.com>
Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
---
 sound/soc/intel/skylake/skl-topology.c | 47 +++++++++++++++++++---------------
 1 file changed, 26 insertions(+), 21 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index f14b373f65d7..df808fbf14b5 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -1948,27 +1948,9 @@ static int skl_tplg_fill_pins_info(struct device *dev,
  * on the direction
  */
 static int skl_tplg_fill_fmt(struct device *dev,
-		struct skl_module_cfg *mconfig,	u32 tkn,
-		u32 value, u32 dir, u32 pin_count)
+		struct skl_module_fmt *dst_fmt,
+		u32 tkn, u32 value)
 {
-	struct skl_module_fmt *dst_fmt;
-
-	switch (dir) {
-	case SKL_DIR_IN:
-		dst_fmt = mconfig->in_fmt;
-		dst_fmt += pin_count;
-		break;
-
-	case SKL_DIR_OUT:
-		dst_fmt = mconfig->out_fmt;
-		dst_fmt += pin_count;
-		break;
-
-	default:
-		dev_err(dev, "Invalid direction value\n");
-		return -EINVAL;
-	}
-
 	switch (tkn) {
 	case SKL_TKN_U32_FMT_CH:
 		dst_fmt->channels  = value;
@@ -2010,6 +1992,29 @@ static int skl_tplg_fill_fmt(struct device *dev,
 	return 0;
 }
 
+static int skl_tplg_widget_fill_fmt(struct device *dev,
+		struct skl_module_cfg *mconfig,
+		u32 tkn, u32 val, u32 dir, int fmt_idx)
+{
+	struct skl_module_fmt *dst_fmt;
+
+	switch (dir) {
+	case SKL_DIR_IN:
+		dst_fmt = &mconfig->in_fmt[fmt_idx];
+		break;
+
+	case SKL_DIR_OUT:
+		dst_fmt = &mconfig->out_fmt[fmt_idx];
+		break;
+
+	default:
+		dev_err(dev, "Invalid direction: %d\n", dir);
+		return -EINVAL;
+	}
+
+	return skl_tplg_fill_fmt(dev, dst_fmt, tkn, val);
+}
+
 static int skl_tplg_get_uuid(struct device *dev, struct skl_module_cfg *mconfig,
 	      struct snd_soc_tplg_vendor_uuid_elem *uuid_tkn)
 {
@@ -2190,7 +2195,7 @@ static int skl_tplg_get_token(struct device *dev,
 	case SKL_TKN_U32_FMT_INTERLEAVE:
 	case SKL_TKN_U32_FMT_SAMPLE_TYPE:
 	case SKL_TKN_U32_FMT_CH_MAP:
-		ret = skl_tplg_fill_fmt(dev, mconfig, tkn_elem->token,
+		ret = skl_tplg_widget_fill_fmt(dev, mconfig, tkn_elem->token,
 				tkn_elem->value, dir, pin_index);
 
 		if (ret < 0)
-- 
2.14.1
