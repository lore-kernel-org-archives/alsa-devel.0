From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm_adsp: Add support for SYSTEM firmware controls" to the asoc tree
Date: Fri, 11 Nov 2016 16:00:54 +0000
Message-ID: <E1c5EG6-0003hR-LZ@finisterre>
References: <1478711658-23696-3-git-send-email-rf@opensource.wolfsonmicro.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1478711658-23696-3-git-send-email-rf@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Stuart Henderson <stuarth@opensource.wolfsonmicro.com>
Cc: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>, Mark Brown <broonie@kernel.org>broonie@kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm_adsp: Add support for SYSTEM firmware controls

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

>From 8eb084d066baeca2b2911632bb4edddbc2b762c1 Mon Sep 17 00:00:00 2001
From: Stuart Henderson <stuarth@opensource.wolfsonmicro.com>
Date: Wed, 9 Nov 2016 17:14:16 +0000
Subject: [PATCH] ASoC: wm_adsp: Add support for SYSTEM firmware controls

Add support for firmware controls marked SYSTEM. These are
internal to the driver-firmware interface and do not have
a user-accessible ALSA control.

Signed-off-by: Stuart Henderson <stuarth@opensource.wolfsonmicro.com>
Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm_adsp.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index ef33de651028..d13dd9a9c817 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -452,6 +452,7 @@ struct wm_coeff_ctl {
 	struct snd_kcontrol *kcontrol;
 	struct soc_bytes_ext bytes_ext;
 	unsigned int flags;
+	unsigned int type;
 };
 
 static const char *wm_adsp_mem_region_name(unsigned int type)
@@ -1159,7 +1160,7 @@ static int wm_adsp_create_control(struct wm_adsp *dsp,
 				  const struct wm_adsp_alg_region *alg_region,
 				  unsigned int offset, unsigned int len,
 				  const char *subname, unsigned int subname_len,
-				  unsigned int flags)
+				  unsigned int flags, unsigned int type)
 {
 	struct wm_coeff_ctl *ctl;
 	struct wmfw_ctl_work *ctl_work;
@@ -1167,9 +1168,6 @@ static int wm_adsp_create_control(struct wm_adsp *dsp,
 	const char *region_name;
 	int ret;
 
-	if (flags & WMFW_CTL_FLAG_SYS)
-		return 0;
-
 	region_name = wm_adsp_mem_region_name(alg_region->type);
 	if (!region_name) {
 		adsp_err(dsp, "Unknown region type: %d\n", alg_region->type);
@@ -1227,6 +1225,7 @@ static int wm_adsp_create_control(struct wm_adsp *dsp,
 	ctl->dsp = dsp;
 
 	ctl->flags = flags;
+	ctl->type = type;
 	ctl->offset = offset;
 	ctl->len = len;
 	ctl->cache = kzalloc(ctl->len, GFP_KERNEL);
@@ -1237,6 +1236,9 @@ static int wm_adsp_create_control(struct wm_adsp *dsp,
 
 	list_add(&ctl->list, &dsp->ctl_list);
 
+	if (flags & WMFW_CTL_FLAG_SYS)
+		return 0;
+
 	ctl_work = kzalloc(sizeof(*ctl_work), GFP_KERNEL);
 	if (!ctl_work) {
 		ret = -ENOMEM;
@@ -1451,7 +1453,8 @@ static int wm_adsp_parse_coeff(struct wm_adsp *dsp,
 					     coeff_blk.len,
 					     coeff_blk.name,
 					     coeff_blk.name_len,
-					     coeff_blk.flags);
+					     coeff_blk.flags,
+					     coeff_blk.ctl_type);
 		if (ret < 0)
 			adsp_err(dsp, "Failed to create control: %.*s, %d\n",
 				 coeff_blk.name_len, coeff_blk.name, ret);
@@ -1851,7 +1854,8 @@ static int wm_adsp1_setup_algs(struct wm_adsp *dsp)
 				len -= be32_to_cpu(adsp1_alg[i].dm);
 				len *= 4;
 				wm_adsp_create_control(dsp, alg_region, 0,
-						       len, NULL, 0, 0);
+						     len, NULL, 0, 0,
+						     SNDRV_CTL_ELEM_TYPE_BYTES);
 			} else {
 				adsp_warn(dsp, "Missing length info for region DM with ID %x\n",
 					  be32_to_cpu(adsp1_alg[i].alg.id));
@@ -1871,7 +1875,8 @@ static int wm_adsp1_setup_algs(struct wm_adsp *dsp)
 				len -= be32_to_cpu(adsp1_alg[i].zm);
 				len *= 4;
 				wm_adsp_create_control(dsp, alg_region, 0,
-						       len, NULL, 0, 0);
+						     len, NULL, 0, 0,
+						     SNDRV_CTL_ELEM_TYPE_BYTES);
 			} else {
 				adsp_warn(dsp, "Missing length info for region ZM with ID %x\n",
 					  be32_to_cpu(adsp1_alg[i].alg.id));
@@ -1962,7 +1967,8 @@ static int wm_adsp2_setup_algs(struct wm_adsp *dsp)
 				len -= be32_to_cpu(adsp2_alg[i].xm);
 				len *= 4;
 				wm_adsp_create_control(dsp, alg_region, 0,
-						       len, NULL, 0, 0);
+						     len, NULL, 0, 0,
+						     SNDRV_CTL_ELEM_TYPE_BYTES);
 			} else {
 				adsp_warn(dsp, "Missing length info for region XM with ID %x\n",
 					  be32_to_cpu(adsp2_alg[i].alg.id));
@@ -1982,7 +1988,8 @@ static int wm_adsp2_setup_algs(struct wm_adsp *dsp)
 				len -= be32_to_cpu(adsp2_alg[i].ym);
 				len *= 4;
 				wm_adsp_create_control(dsp, alg_region, 0,
-						       len, NULL, 0, 0);
+						     len, NULL, 0, 0,
+						     SNDRV_CTL_ELEM_TYPE_BYTES);
 			} else {
 				adsp_warn(dsp, "Missing length info for region YM with ID %x\n",
 					  be32_to_cpu(adsp2_alg[i].alg.id));
@@ -2002,7 +2009,8 @@ static int wm_adsp2_setup_algs(struct wm_adsp *dsp)
 				len -= be32_to_cpu(adsp2_alg[i].zm);
 				len *= 4;
 				wm_adsp_create_control(dsp, alg_region, 0,
-						       len, NULL, 0, 0);
+						     len, NULL, 0, 0,
+						     SNDRV_CTL_ELEM_TYPE_BYTES);
 			} else {
 				adsp_warn(dsp, "Missing length info for region ZM with ID %x\n",
 					  be32_to_cpu(adsp2_alg[i].alg.id));
-- 
2.10.2
