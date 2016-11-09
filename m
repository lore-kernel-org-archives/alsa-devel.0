From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH 3/5] ASoC: wm_adsp: Add support for SYSTEM firmware controls
Date: Wed, 9 Nov 2016 17:14:16 +0000
Message-ID: <1478711658-23696-3-git-send-email-rf@opensource.wolfsonmicro.com>
References: <1478711658-23696-1-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1478711658-23696-1-git-send-email-rf@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Stuart Henderson <stuarth@opensource.wolfsonmicro.com>

Add support for firmware controls marked SYSTEM. These are
internal to the driver-firmware interface and do not have
a user-accessible ALSA control.

Signed-off-by: Stuart Henderson <stuarth@opensource.wolfsonmicro.com>
Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_adsp.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index eb2ca91..82bb3dc 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -444,6 +444,7 @@ struct wm_coeff_ctl {
 	struct snd_kcontrol *kcontrol;
 	struct soc_bytes_ext bytes_ext;
 	unsigned int flags;
+	unsigned int type;
 };
 
 static const char *wm_adsp_mem_region_name(unsigned int type)
@@ -1075,7 +1076,7 @@ static int wm_adsp_create_control(struct wm_adsp *dsp,
 				  const struct wm_adsp_alg_region *alg_region,
 				  unsigned int offset, unsigned int len,
 				  const char *subname, unsigned int subname_len,
-				  unsigned int flags)
+				  unsigned int flags, unsigned int type)
 {
 	struct wm_coeff_ctl *ctl;
 	struct wmfw_ctl_work *ctl_work;
@@ -1083,9 +1084,6 @@ static int wm_adsp_create_control(struct wm_adsp *dsp,
 	const char *region_name;
 	int ret;
 
-	if (flags & WMFW_CTL_FLAG_SYS)
-		return 0;
-
 	region_name = wm_adsp_mem_region_name(alg_region->type);
 	if (!region_name) {
 		adsp_err(dsp, "Unknown region type: %d\n", alg_region->type);
@@ -1143,6 +1141,7 @@ static int wm_adsp_create_control(struct wm_adsp *dsp,
 	ctl->dsp = dsp;
 
 	ctl->flags = flags;
+	ctl->type = type;
 	ctl->offset = offset;
 	ctl->len = len;
 	ctl->cache = kzalloc(ctl->len, GFP_KERNEL);
@@ -1153,6 +1152,9 @@ static int wm_adsp_create_control(struct wm_adsp *dsp,
 
 	list_add(&ctl->list, &dsp->ctl_list);
 
+	if (flags & WMFW_CTL_FLAG_SYS)
+		return 0;
+
 	ctl_work = kzalloc(sizeof(*ctl_work), GFP_KERNEL);
 	if (!ctl_work) {
 		ret = -ENOMEM;
@@ -1342,7 +1344,8 @@ static int wm_adsp_parse_coeff(struct wm_adsp *dsp,
 					     coeff_blk.len,
 					     coeff_blk.name,
 					     coeff_blk.name_len,
-					     coeff_blk.flags);
+					     coeff_blk.flags,
+					     coeff_blk.ctl_type);
 		if (ret < 0)
 			adsp_err(dsp, "Failed to create control: %.*s, %d\n",
 				 coeff_blk.name_len, coeff_blk.name, ret);
@@ -1742,7 +1745,8 @@ static int wm_adsp1_setup_algs(struct wm_adsp *dsp)
 				len -= be32_to_cpu(adsp1_alg[i].dm);
 				len *= 4;
 				wm_adsp_create_control(dsp, alg_region, 0,
-						       len, NULL, 0, 0);
+						     len, NULL, 0, 0,
+						     SNDRV_CTL_ELEM_TYPE_BYTES);
 			} else {
 				adsp_warn(dsp, "Missing length info for region DM with ID %x\n",
 					  be32_to_cpu(adsp1_alg[i].alg.id));
@@ -1762,7 +1766,8 @@ static int wm_adsp1_setup_algs(struct wm_adsp *dsp)
 				len -= be32_to_cpu(adsp1_alg[i].zm);
 				len *= 4;
 				wm_adsp_create_control(dsp, alg_region, 0,
-						       len, NULL, 0, 0);
+						     len, NULL, 0, 0,
+						     SNDRV_CTL_ELEM_TYPE_BYTES);
 			} else {
 				adsp_warn(dsp, "Missing length info for region ZM with ID %x\n",
 					  be32_to_cpu(adsp1_alg[i].alg.id));
@@ -1853,7 +1858,8 @@ static int wm_adsp2_setup_algs(struct wm_adsp *dsp)
 				len -= be32_to_cpu(adsp2_alg[i].xm);
 				len *= 4;
 				wm_adsp_create_control(dsp, alg_region, 0,
-						       len, NULL, 0, 0);
+						     len, NULL, 0, 0,
+						     SNDRV_CTL_ELEM_TYPE_BYTES);
 			} else {
 				adsp_warn(dsp, "Missing length info for region XM with ID %x\n",
 					  be32_to_cpu(adsp2_alg[i].alg.id));
@@ -1873,7 +1879,8 @@ static int wm_adsp2_setup_algs(struct wm_adsp *dsp)
 				len -= be32_to_cpu(adsp2_alg[i].ym);
 				len *= 4;
 				wm_adsp_create_control(dsp, alg_region, 0,
-						       len, NULL, 0, 0);
+						     len, NULL, 0, 0,
+						     SNDRV_CTL_ELEM_TYPE_BYTES);
 			} else {
 				adsp_warn(dsp, "Missing length info for region YM with ID %x\n",
 					  be32_to_cpu(adsp2_alg[i].alg.id));
@@ -1893,7 +1900,8 @@ static int wm_adsp2_setup_algs(struct wm_adsp *dsp)
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
1.9.1
