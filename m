From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Commonize parsing of
	format tokens" to the asoc tree
Date: Sun, 27 Aug 2017 14:38:57 +0100 (BST)
Message-ID: <20170827133857.093E34400E7@finisterre.ee.mobilebroadband>
References: <20170821084646.6525-4-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 2DB37267475
 for <alsa-devel@alsa-project.org>; Sun, 27 Aug 2017 15:38:57 +0200 (CEST)
In-Reply-To: <20170821084646.6525-4-guneshwor.o.singh@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shreyas NC <shreyas.nc@intel.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Patches Audio <patches.audio@intel.com>, Mark Brown <broonie@kernel.org>, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Commonize parsing of format tokens

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

>From ca312fda690e94c704bcb0e21b73b5d5bd1cf1ff Mon Sep 17 00:00:00 2001
From: Shreyas NC <shreyas.nc@intel.com>
Date: Wed, 23 Aug 2017 19:33:50 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Commonize parsing of format tokens

Format resource tokens can be a part of either the widget or manifest
private data. In the current model, format resources come as a part of
widget private data and they come as a part of topology manifest in the
newly introduced model.

So add a common function that can fill up either of the structures.

Signed-off-by: Shreyas NC <shreyas.nc@intel.com>
Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.13.2
