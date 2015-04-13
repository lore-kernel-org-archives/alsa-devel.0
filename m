From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 11/13] ASoC: wm_adsp: Add support for DSP
	control flags
Date: Mon, 13 Apr 2015 13:28:03 +0100
Message-ID: <1428928085-20250-12-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1428928085-20250-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 78F68265158
 for <alsa-devel@alsa-project.org>; Mon, 13 Apr 2015 14:34:13 +0200 (CEST)
In-Reply-To: <1428928085-20250-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The DSP control information contains various hints about the usage of
the controls use these when handling the control.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_adsp.c |   40 ++++++++++++++++++++++++++++++++--------
 sound/soc/codecs/wmfw.h    |    5 +++++
 2 files changed, 37 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 16b308a..edf3ba3 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -240,6 +240,7 @@ struct wm_coeff_ctl {
 	size_t len;
 	unsigned int set:1;
 	struct snd_kcontrol *kcontrol;
+	unsigned int flags;
 };
 
 static int wm_adsp_fw_get(struct snd_kcontrol *kcontrol,
@@ -418,6 +419,9 @@ static int wm_coeff_put(struct snd_kcontrol *kcontrol,
 	struct wm_coeff_ctl *ctl = (struct wm_coeff_ctl *)kcontrol->private_value;
 	char *p = ucontrol->value.bytes.data;
 
+	if (ctl->flags && !(ctl->flags & WMFW_CTL_FLAG_WRITEABLE))
+		return -EPERM;
+
 	memcpy(ctl->cache, p, ctl->len);
 
 	ctl->set = 1;
@@ -472,7 +476,18 @@ static int wm_coeff_get(struct snd_kcontrol *kcontrol,
 	struct wm_coeff_ctl *ctl = (struct wm_coeff_ctl *)kcontrol->private_value;
 	char *p = ucontrol->value.bytes.data;
 
+	if (ctl->flags && !(ctl->flags & WMFW_CTL_FLAG_READABLE))
+		return -EPERM;
+
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
 
@@ -526,6 +541,9 @@ static int wm_coeff_init_control_caches(struct wm_adsp *dsp)
 	list_for_each_entry(ctl, &dsp->ctl_list, list) {
 		if (!ctl->enabled || ctl->set)
 			continue;
+		if (ctl->flags & WMFW_CTL_FLAG_VOLATILE)
+			continue;
+
 		ret = wm_coeff_read_control(ctl,
 					    ctl->cache,
 					    ctl->len);
@@ -544,7 +562,7 @@ static int wm_coeff_sync_controls(struct wm_adsp *dsp)
 	list_for_each_entry(ctl, &dsp->ctl_list, list) {
 		if (!ctl->enabled)
 			continue;
-		if (ctl->set) {
+		if (ctl->set && !(ctl->flags & WMFW_CTL_FLAG_VOLATILE)) {
 			ret = wm_coeff_write_control(ctl,
 						     ctl->cache,
 						     ctl->len);
@@ -569,7 +587,8 @@ static void wm_adsp_ctl_work(struct work_struct *work)
 static int wm_adsp_create_control(struct wm_adsp *dsp,
 				  const struct wm_adsp_alg_region *alg_region,
 				  unsigned int offset, unsigned int len,
-				  const char *subname, unsigned int subname_len)
+				  const char *subname, unsigned int subname_len,
+				  unsigned int flags)
 {
 	struct wm_coeff_ctl *ctl;
 	struct wmfw_ctl_work *ctl_work;
@@ -577,6 +596,9 @@ static int wm_adsp_create_control(struct wm_adsp *dsp,
 	char *region_name;
 	int ret;
 
+	if (flags & WMFW_CTL_FLAG_SYS)
+		return 0;
+
 	switch (alg_region->type) {
 	case WMFW_ADSP1_PM:
 		region_name = "PM";
@@ -626,6 +648,7 @@ static int wm_adsp_create_control(struct wm_adsp *dsp,
 	ctl->ops.xput = wm_coeff_put;
 	ctl->dsp = dsp;
 
+	ctl->flags = flags;
 	ctl->offset = offset;
 	if (len > 512) {
 		adsp_warn(dsp, "Truncating control %s from %d\n",
@@ -752,7 +775,8 @@ static int wm_adsp_parse_coeff(struct wm_adsp *dsp,
 					     coeff_blk.offset,
 					     coeff_blk.len,
 					     coeff_blk.name,
-					     coeff_blk.name_len);
+					     coeff_blk.name_len,
+					     coeff_blk.flags);
 		if (ret < 0)
 			adsp_err(dsp, "Failed to create control: %.*s, %d\n",
 				 coeff_blk.name_len, coeff_blk.name, ret);
@@ -1133,7 +1157,7 @@ static int wm_adsp1_setup_algs(struct wm_adsp *dsp)
 				len -= be32_to_cpu(adsp1_alg[i].dm);
 				len *= 4;
 				wm_adsp_create_control(dsp, alg_region, 0,
-						       len, NULL, 0);
+						       len, NULL, 0, 0);
 			} else {
 				adsp_warn(dsp, "Missing length info for region DM with ID %x\n",
 					  be32_to_cpu(adsp1_alg[i].alg.id));
@@ -1153,7 +1177,7 @@ static int wm_adsp1_setup_algs(struct wm_adsp *dsp)
 				len -= be32_to_cpu(adsp1_alg[i].zm);
 				len *= 4;
 				wm_adsp_create_control(dsp, alg_region, 0,
-						       len, NULL, 0);
+						       len, NULL, 0, 0);
 			} else {
 				adsp_warn(dsp, "Missing length info for region ZM with ID %x\n",
 					  be32_to_cpu(adsp1_alg[i].alg.id));
@@ -1243,7 +1267,7 @@ static int wm_adsp2_setup_algs(struct wm_adsp *dsp)
 				len -= be32_to_cpu(adsp2_alg[i].xm);
 				len *= 4;
 				wm_adsp_create_control(dsp, alg_region, 0,
-						       len, NULL, 0);
+						       len, NULL, 0, 0);
 			} else {
 				adsp_warn(dsp, "Missing length info for region XM with ID %x\n",
 					  be32_to_cpu(adsp2_alg[i].alg.id));
@@ -1263,7 +1287,7 @@ static int wm_adsp2_setup_algs(struct wm_adsp *dsp)
 				len -= be32_to_cpu(adsp2_alg[i].ym);
 				len *= 4;
 				wm_adsp_create_control(dsp, alg_region, 0,
-						       len, NULL, 0);
+						       len, NULL, 0, 0);
 			} else {
 				adsp_warn(dsp, "Missing length info for region YM with ID %x\n",
 					  be32_to_cpu(adsp2_alg[i].alg.id));
@@ -1283,7 +1307,7 @@ static int wm_adsp2_setup_algs(struct wm_adsp *dsp)
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
