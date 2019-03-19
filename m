From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH] ASoC: wm_adsp: Correct some minor issues
Date: Tue, 19 Mar 2019 17:43:09 +0000
Message-ID: <20190319174309.27640-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AE0B2F80792
 for <alsa-devel@alsa-project.org>; Tue, 19 Mar 2019 18:43:12 +0100 (CET)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: broonie@kernel.org
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The wm_adsp_ops structures should be static and correct two printf
specifiers.

Fixes: 170b1e123f38 ("ASoC: wm_adsp: Add support for new Halo core DSPs")
Fixes: 4e08d50d1fb6 ("ASoC: wm_adsp: Factor out DSP specific operations")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/codecs/wm_adsp.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 644aaf1d27403..5e615fbddf9a7 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -306,9 +306,9 @@
 #define HALO_MPU_VIO_ERR_SRC_MASK           0x00007fff
 #define HALO_MPU_VIO_ERR_SRC_SHIFT                   0
 
-struct wm_adsp_ops wm_adsp1_ops;
-struct wm_adsp_ops wm_adsp2_ops[];
-struct wm_adsp_ops wm_halo_ops;
+static struct wm_adsp_ops wm_adsp1_ops;
+static struct wm_adsp_ops wm_adsp2_ops[];
+static struct wm_adsp_ops wm_halo_ops;
 
 struct wm_adsp_buf {
 	struct list_head list;
@@ -2142,7 +2142,7 @@ static void wmfw_parse_id_header(struct wm_adsp *dsp,
 	dsp->fw_id = be32_to_cpu(fw->id);
 	dsp->fw_id_version = be32_to_cpu(fw->ver);
 
-	adsp_info(dsp, "Firmware: %x v%d.%d.%d, %zu algorithms\n",
+	adsp_info(dsp, "Firmware: %x v%d.%d.%d, %d algorithms\n",
 		  dsp->fw_id, (dsp->fw_id_version & 0xff0000) >> 16,
 		  (dsp->fw_id_version & 0xff00) >> 8, dsp->fw_id_version & 0xff,
 		  nalgs);
@@ -2155,7 +2155,7 @@ static void wmfw_v3_parse_id_header(struct wm_adsp *dsp,
 	dsp->fw_id_version = be32_to_cpu(fw->ver);
 	dsp->fw_vendor_id = be32_to_cpu(fw->vendor_id);
 
-	adsp_info(dsp, "Firmware: %x vendor: 0x%x v%d.%d.%d, %zu algorithms\n",
+	adsp_info(dsp, "Firmware: %x vendor: 0x%x v%d.%d.%d, %d algorithms\n",
 		  dsp->fw_id, dsp->fw_vendor_id,
 		  (dsp->fw_id_version & 0xff0000) >> 16,
 		  (dsp->fw_id_version & 0xff00) >> 8, dsp->fw_id_version & 0xff,
@@ -4407,13 +4407,13 @@ irqreturn_t wm_halo_wdt_expire(int irq, void *data)
 }
 EXPORT_SYMBOL_GPL(wm_halo_wdt_expire);
 
-struct wm_adsp_ops wm_adsp1_ops = {
+static struct wm_adsp_ops wm_adsp1_ops = {
 	.validate_version = wm_adsp_validate_version,
 	.parse_sizes = wm_adsp1_parse_sizes,
 	.region_to_reg = wm_adsp_region_to_reg,
 };
 
-struct wm_adsp_ops wm_adsp2_ops[] = {
+static struct wm_adsp_ops wm_adsp2_ops[] = {
 	{
 		.sys_config_size = sizeof(struct wm_adsp_system_config_xm_hdr),
 		.parse_sizes = wm_adsp2_parse_sizes,
@@ -4474,7 +4474,7 @@ struct wm_adsp_ops wm_adsp2_ops[] = {
 	},
 };
 
-struct wm_adsp_ops wm_halo_ops = {
+static struct wm_adsp_ops wm_halo_ops = {
 	.sys_config_size = sizeof(struct wm_halo_system_config_xm_hdr),
 	.parse_sizes = wm_adsp2_parse_sizes,
 	.validate_version = wm_halo_validate_version,
-- 
2.11.0
