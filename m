From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH 1/5] ASoC: wm_adsp: factor out getting base register for a control
Date: Wed, 9 Nov 2016 17:14:14 +0000
Message-ID: <1478711658-23696-1-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The lookup of the base register corresponding to a control is
duplicated in read and write so factor it out into a separate
function.

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_adsp.c | 46 ++++++++++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 7320fca..049ff20 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -727,6 +727,24 @@ static inline struct wm_coeff_ctl *bytes_ext_to_ctl(struct soc_bytes_ext *ext)
 	return container_of(ext, struct wm_coeff_ctl, bytes_ext);
 }
 
+static int wm_coeff_base_reg(struct wm_coeff_ctl *ctl, unsigned int *reg)
+{
+	const struct wm_adsp_alg_region *alg_region = &ctl->alg_region;
+	struct wm_adsp *dsp = ctl->dsp;
+	const struct wm_adsp_region *mem;
+
+	mem = wm_adsp_find_region(dsp, alg_region->type);
+	if (!mem) {
+		adsp_err(dsp, "No base for region %x\n",
+			 alg_region->type);
+		return -EINVAL;
+	}
+
+	*reg = wm_adsp_region_to_reg(mem, ctl->alg_region.base + ctl->offset);
+
+	return 0;
+}
+
 static int wm_coeff_info(struct snd_kcontrol *kctl,
 			 struct snd_ctl_elem_info *uinfo)
 {
@@ -742,22 +760,14 @@ static int wm_coeff_info(struct snd_kcontrol *kctl,
 static int wm_coeff_write_control(struct wm_coeff_ctl *ctl,
 				  const void *buf, size_t len)
 {
-	struct wm_adsp_alg_region *alg_region = &ctl->alg_region;
-	const struct wm_adsp_region *mem;
 	struct wm_adsp *dsp = ctl->dsp;
 	void *scratch;
 	int ret;
 	unsigned int reg;
 
-	mem = wm_adsp_find_region(dsp, alg_region->type);
-	if (!mem) {
-		adsp_err(dsp, "No base for region %x\n",
-			 alg_region->type);
-		return -EINVAL;
-	}
-
-	reg = ctl->alg_region.base + ctl->offset;
-	reg = wm_adsp_region_to_reg(mem, reg);
+	ret = wm_coeff_base_reg(ctl, &reg);
+	if (ret)
+		return ret;
 
 	scratch = kmemdup(buf, len, GFP_KERNEL | GFP_DMA);
 	if (!scratch)
@@ -826,22 +836,14 @@ static int wm_coeff_tlv_put(struct snd_kcontrol *kctl,
 static int wm_coeff_read_control(struct wm_coeff_ctl *ctl,
 				 void *buf, size_t len)
 {
-	struct wm_adsp_alg_region *alg_region = &ctl->alg_region;
-	const struct wm_adsp_region *mem;
 	struct wm_adsp *dsp = ctl->dsp;
 	void *scratch;
 	int ret;
 	unsigned int reg;
 
-	mem = wm_adsp_find_region(dsp, alg_region->type);
-	if (!mem) {
-		adsp_err(dsp, "No base for region %x\n",
-			 alg_region->type);
-		return -EINVAL;
-	}
-
-	reg = ctl->alg_region.base + ctl->offset;
-	reg = wm_adsp_region_to_reg(mem, reg);
+	ret = wm_coeff_base_reg(ctl, &reg);
+	if (ret)
+		return ret;
 
 	scratch = kmalloc(len, GFP_KERNEL | GFP_DMA);
 	if (!scratch)
-- 
1.9.1
