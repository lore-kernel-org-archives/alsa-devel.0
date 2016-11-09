From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH 2/5] ASoC: wm_adsp: factor out getting region name from type
Date: Wed, 9 Nov 2016 17:14:15 +0000
Message-ID: <1478711658-23696-2-git-send-email-rf@opensource.wolfsonmicro.com>
References: <1478711658-23696-1-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1478711658-23696-1-git-send-email-rf@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This patch factors out converting a memory region type into
a name string, mainly so that it can be used in log commands.

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_adsp.c | 53 +++++++++++++++++++---------------------------
 1 file changed, 22 insertions(+), 31 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 049ff20..eb2ca91 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -446,6 +446,24 @@ struct wm_coeff_ctl {
 	unsigned int flags;
 };
 
+static const char *wm_adsp_mem_region_name(unsigned int type)
+{
+	switch (type) {
+	case WMFW_ADSP1_PM:
+		return "PM";
+	case WMFW_ADSP1_DM:
+		return "DM";
+	case WMFW_ADSP2_XM:
+		return "XM";
+	case WMFW_ADSP2_YM:
+		return "YM";
+	case WMFW_ADSP1_ZM:
+		return "ZM";
+	default:
+		return NULL;
+	}
+}
+
 #ifdef CONFIG_DEBUG_FS
 static void wm_adsp_debugfs_save_wmfwname(struct wm_adsp *dsp, const char *s)
 {
@@ -1062,29 +1080,14 @@ static int wm_adsp_create_control(struct wm_adsp *dsp,
 	struct wm_coeff_ctl *ctl;
 	struct wmfw_ctl_work *ctl_work;
 	char name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
-	char *region_name;
+	const char *region_name;
 	int ret;
 
 	if (flags & WMFW_CTL_FLAG_SYS)
 		return 0;
 
-	switch (alg_region->type) {
-	case WMFW_ADSP1_PM:
-		region_name = "PM";
-		break;
-	case WMFW_ADSP1_DM:
-		region_name = "DM";
-		break;
-	case WMFW_ADSP2_XM:
-		region_name = "XM";
-		break;
-	case WMFW_ADSP2_YM:
-		region_name = "YM";
-		break;
-	case WMFW_ADSP1_ZM:
-		region_name = "ZM";
-		break;
-	default:
+	region_name = wm_adsp_mem_region_name(alg_region->type);
+	if (!region_name) {
 		adsp_err(dsp, "Unknown region type: %d\n", alg_region->type);
 		return -EINVAL;
 	}
@@ -1492,23 +1495,11 @@ static int wm_adsp_load(struct wm_adsp *dsp)
 			reg = offset;
 			break;
 		case WMFW_ADSP1_PM:
-			region_name = "PM";
-			reg = wm_adsp_region_to_reg(mem, offset);
-			break;
 		case WMFW_ADSP1_DM:
-			region_name = "DM";
-			reg = wm_adsp_region_to_reg(mem, offset);
-			break;
 		case WMFW_ADSP2_XM:
-			region_name = "XM";
-			reg = wm_adsp_region_to_reg(mem, offset);
-			break;
 		case WMFW_ADSP2_YM:
-			region_name = "YM";
-			reg = wm_adsp_region_to_reg(mem, offset);
-			break;
 		case WMFW_ADSP1_ZM:
-			region_name = "ZM";
+			region_name = wm_adsp_mem_region_name(type);
 			reg = wm_adsp_region_to_reg(mem, offset);
 			break;
 		default:
-- 
1.9.1
