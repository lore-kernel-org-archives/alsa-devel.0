From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Fix to use the actual
	size for TLV control" to the asoc tree
Date: Fri, 08 Jul 2016 14:48:29 +0200
Message-ID: <E1bLVCn-0007Ku-RF@finisterre>
References: <1467981903-29691-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E0059265957
 for <alsa-devel@alsa-project.org>; Fri,  8 Jul 2016 14:49:02 +0200 (CEST)
In-Reply-To: <1467981903-29691-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dharageswari R <dharageswari.r@intel.com>
Cc: Vinod Koul <vinod.koul@intel.com>, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Fix to use the actual size for TLV control

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

>From 0d6821040034b8bfc9d9a4e6c2236f3a9e02650f Mon Sep 17 00:00:00 2001
From: Dharageswari R <dharageswari.r@intel.com>
Date: Fri, 8 Jul 2016 18:15:03 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Fix to use the actual size for TLV
 control

DSP expects the actual length of parameters that is set through
TLV to be passed in large config set, so pass the actual size
received in tlv_control_set() instead of max size.

Signed-off-by: Dharageswari R <dharageswari.r@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-topology.c | 13 +++++++++----
 sound/soc/intel/skylake/skl-topology.h |  1 +
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 3e036b0349b9..c15b7f8962b3 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -448,7 +448,7 @@ static int skl_tplg_set_module_params(struct snd_soc_dapm_widget *w,
 
 			if (bc->set_params == SKL_PARAM_SET) {
 				ret = skl_set_module_params(ctx,
-						(u32 *)bc->params, bc->max,
+						(u32 *)bc->params, bc->size,
 						bc->param_id, mconfig);
 				if (ret < 0)
 					return ret;
@@ -483,7 +483,7 @@ static int skl_tplg_set_module_init_data(struct snd_soc_dapm_widget *w)
 				continue;
 
 			mconfig->formats_config.caps = (u32 *)&bc->params;
-			mconfig->formats_config.caps_size = bc->max;
+			mconfig->formats_config.caps_size = bc->size;
 
 			break;
 		}
@@ -1102,7 +1102,7 @@ static int skl_tplg_tlv_control_get(struct snd_kcontrol *kcontrol,
 
 	if (w->power)
 		skl_get_module_params(skl->skl_sst, (u32 *)bc->params,
-				      bc->max, bc->param_id, mconfig);
+				      bc->size, bc->param_id, mconfig);
 
 	/* decrement size for TLV header */
 	size -= 2 * sizeof(u32);
@@ -1136,6 +1136,10 @@ static int skl_tplg_tlv_control_set(struct snd_kcontrol *kcontrol,
 	struct skl *skl = get_skl_ctx(w->dapm->dev);
 
 	if (ac->params) {
+		if (size > ac->max)
+			return -EINVAL;
+
+		ac->size = size;
 		/*
 		 * if the param_is is of type Vendor, firmware expects actual
 		 * parameter id and size from the control.
@@ -1151,7 +1155,7 @@ static int skl_tplg_tlv_control_set(struct snd_kcontrol *kcontrol,
 
 		if (w->power)
 			return skl_set_module_params(skl->skl_sst,
-						(u32 *)ac->params, ac->max,
+						(u32 *)ac->params, ac->size,
 						ac->param_id, mconfig);
 	}
 
@@ -1683,6 +1687,7 @@ static int skl_init_algo_data(struct device *dev, struct soc_bytes_ext *be,
 	ac->max = dfw_ac->max;
 	ac->param_id = dfw_ac->param_id;
 	ac->set_params = dfw_ac->set_params;
+	ac->size = dfw_ac->max;
 
 	if (ac->max) {
 		ac->params = (char *) devm_kzalloc(dev, ac->max, GFP_KERNEL);
diff --git a/sound/soc/intel/skylake/skl-topology.h b/sound/soc/intel/skylake/skl-topology.h
index e4b399cd7868..28d1d2c68528 100644
--- a/sound/soc/intel/skylake/skl-topology.h
+++ b/sound/soc/intel/skylake/skl-topology.h
@@ -319,6 +319,7 @@ struct skl_algo_data {
 	u32 param_id;
 	u32 set_params;
 	u32 max;
+	u32 size;
 	char *params;
 };
 
-- 
2.8.1
