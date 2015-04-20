From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH v2 2/2] ASoC: wm_adsp: Add support for DSP
	control flags
Date: Mon, 20 Apr 2015 13:52:45 +0100
Message-ID: <1429534365-13439-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1429534365-13439-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3D1F5265867
 for <alsa-devel@alsa-project.org>; Mon, 20 Apr 2015 14:59:33 +0200 (CEST)
In-Reply-To: <1429534365-13439-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, fengguang.wu@intel.com, lgirdwood@gmail.com, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

The DSP control information contains various hints about the usage of
the control use these when handling the control.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---

Changes since v1:
 - Set the actual control access flags rather than implementing that
   in the get and put callbacks.

Thanks,
Charles

 sound/soc/codecs/wm_adsp.c |   43 +++++++++++++++++++++++++++++++++++--------
 sound/soc/codecs/wmfw.h    |    5 +++++
 2 files changed, 40 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 53fc7f8..f6642c1 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -240,6 +240,7 @@ struct wm_coeff_ctl {
 	size_t len;
 	unsigned int set:1;
 	struct snd_kcontrol *kcontrol;
+	unsigned int flags;
 };
 
 static int wm_adsp_fw_get(struct snd_kcontrol *kcontrol,
@@ -472,7 +473,15 @@ static int wm_coeff_get(struct snd_kcontrol *kcontrol,
 	struct wm_coeff_ctl *ctl = (struct wm_coeff_ctl *)kcontrol->private_value;
 	char *p = ucontrol->value.bytes.data;
 
+	if (ctl->flags & WMFW_CTL_FLAG_VOLATILE) {
+		if (ctl->enabled)
+			return wm_coeff_read_control(ctl, p, ctl->len);
+		else
+			return -EPERM;
+	}
+
 	memcpy(p, ctl->cache, ctl->len);
+
 	return 0;
 }
 
@@ -501,6 +510,15 @@ static int wmfw_add_ctl(struct wm_adsp *dsp, struct wm_coeff_ctl *ctl)
 	kcontrol->put = wm_coeff_put;
 	kcontrol->private_value = (unsigned long)ctl;
 
+	if (ctl->flags) {
+		if (ctl->flags & WMFW_CTL_FLAG_WRITEABLE)
+			kcontrol->access |= SNDRV_CTL_ELEM_ACCESS_WRITE;
+		if (ctl->flags & WMFW_CTL_FLAG_READABLE)
+			kcontrol->access |= SNDRV_CTL_ELEM_ACCESS_READ;
+		if (ctl->flags & WMFW_CTL_FLAG_VOLATILE)
+			kcontrol->access |= SNDRV_CTL_ELEM_ACCESS_VOLATILE;
+	}
+
 	ret = snd_soc_add_card_controls(dsp->card,
 					kcontrol, 1);
 	if (ret < 0)
@@ -526,6 +544,9 @@ static int wm_coeff_init_control_caches(struct wm_adsp *dsp)
 	list_for_each_entry(ctl, &dsp->ctl_list, list) {
 		if (!ctl->enabled || ctl->set)
 			continue;
+		if (ctl->flags & WMFW_CTL_FLAG_VOLATILE)
+			continue;
+
 		ret = wm_coeff_read_control(ctl,
 					    ctl->cache,
 					    ctl->len);
@@ -544,7 +565,7 @@ static int wm_coeff_sync_controls(struct wm_adsp *dsp)
 	list_for_each_entry(ctl, &dsp->ctl_list, list) {
 		if (!ctl->enabled)
 			continue;
-		if (ctl->set) {
+		if (ctl->set && !(ctl->flags & WMFW_CTL_FLAG_VOLATILE)) {
 			ret = wm_coeff_write_control(ctl,
 						     ctl->cache,
 						     ctl->len);
@@ -569,7 +590,8 @@ static void wm_adsp_ctl_work(struct work_struct *work)
 static int wm_adsp_create_control(struct wm_adsp *dsp,
 				  const struct wm_adsp_alg_region *alg_region,
 				  unsigned int offset, unsigned int len,
-				  const char *subname, unsigned int subname_len)
+				  const char *subname, unsigned int subname_len,
+				  unsigned int flags)
 {
 	struct wm_coeff_ctl *ctl;
 	struct wmfw_ctl_work *ctl_work;
@@ -577,6 +599,9 @@ static int wm_adsp_create_control(struct wm_adsp *dsp,
 	char *region_name;
 	int ret;
 
+	if (flags & WMFW_CTL_FLAG_SYS)
+		return 0;
+
 	switch (alg_region->type) {
 	case WMFW_ADSP1_PM:
 		region_name = "PM";
@@ -649,6 +674,7 @@ static int wm_adsp_create_control(struct wm_adsp *dsp,
 	ctl->ops.xput = wm_coeff_put;
 	ctl->dsp = dsp;
 
+	ctl->flags = flags;
 	ctl->offset = offset;
 	if (len > 512) {
 		adsp_warn(dsp, "Truncating control %s from %d\n",
@@ -852,7 +878,8 @@ static int wm_adsp_parse_coeff(struct wm_adsp *dsp,
 					     coeff_blk.offset,
 					     coeff_blk.len,
 					     coeff_blk.name,
-					     coeff_blk.name_len);
+					     coeff_blk.name_len,
+					     coeff_blk.flags);
 		if (ret < 0)
 			adsp_err(dsp, "Failed to create control: %.*s, %d\n",
 				 coeff_blk.name_len, coeff_blk.name, ret);
@@ -1237,7 +1264,7 @@ static int wm_adsp1_setup_algs(struct wm_adsp *dsp)
 				len -= be32_to_cpu(adsp1_alg[i].dm);
 				len *= 4;
 				wm_adsp_create_control(dsp, alg_region, 0,
-						       len, NULL, 0);
+						       len, NULL, 0, 0);
 			} else {
 				adsp_warn(dsp, "Missing length info for region DM with ID %x\n",
 					  be32_to_cpu(adsp1_alg[i].alg.id));
@@ -1257,7 +1284,7 @@ static int wm_adsp1_setup_algs(struct wm_adsp *dsp)
 				len -= be32_to_cpu(adsp1_alg[i].zm);
 				len *= 4;
 				wm_adsp_create_control(dsp, alg_region, 0,
-						       len, NULL, 0);
+						       len, NULL, 0, 0);
 			} else {
 				adsp_warn(dsp, "Missing length info for region ZM with ID %x\n",
 					  be32_to_cpu(adsp1_alg[i].alg.id));
@@ -1347,7 +1374,7 @@ static int wm_adsp2_setup_algs(struct wm_adsp *dsp)
 				len -= be32_to_cpu(adsp2_alg[i].xm);
 				len *= 4;
 				wm_adsp_create_control(dsp, alg_region, 0,
-						       len, NULL, 0);
+						       len, NULL, 0, 0);
 			} else {
 				adsp_warn(dsp, "Missing length info for region XM with ID %x\n",
 					  be32_to_cpu(adsp2_alg[i].alg.id));
@@ -1367,7 +1394,7 @@ static int wm_adsp2_setup_algs(struct wm_adsp *dsp)
 				len -= be32_to_cpu(adsp2_alg[i].ym);
 				len *= 4;
 				wm_adsp_create_control(dsp, alg_region, 0,
-						       len, NULL, 0);
+						       len, NULL, 0, 0);
 			} else {
 				adsp_warn(dsp, "Missing length info for region YM with ID %x\n",
 					  be32_to_cpu(adsp2_alg[i].alg.id));
@@ -1387,7 +1414,7 @@ static int wm_adsp2_setup_algs(struct wm_adsp *dsp)
 				len -= be32_to_cpu(adsp2_alg[i].zm);
 				len *= 4;
 				wm_adsp_create_control(dsp, alg_region, 0,
-						       len, NULL, 0);
+						       len, NULL, 0, 0);
 			} else {
 				adsp_warn(dsp, "Missing length info for region ZM with ID %x\n",
 					  be32_to_cpu(adsp2_alg[i].alg.id));
diff --git a/sound/soc/codecs/wmfw.h b/sound/soc/codecs/wmfw.h
index 04690b2..7613d60 100644
--- a/sound/soc/codecs/wmfw.h
+++ b/sound/soc/codecs/wmfw.h
@@ -21,6 +21,11 @@
 #define WMFW_MAX_COEFF_NAME       256
 #define WMFW_MAX_COEFF_DESCR_NAME 256
 
+#define WMFW_CTL_FLAG_SYS         0x8000
+#define WMFW_CTL_FLAG_VOLATILE    0x0004
+#define WMFW_CTL_FLAG_WRITEABLE   0x0002
+#define WMFW_CTL_FLAG_READABLE    0x0001
+
 struct wmfw_header {
 	char magic[4];
 	__le32 len;
-- 
1.7.2.5
