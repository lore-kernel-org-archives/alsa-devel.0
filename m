From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm_adsp: Use asynchronous I/O to write
	firmware and coefficients
Date: Mon,  4 Feb 2013 19:53:23 +0000
Message-ID: <1360007603-24984-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6C09D261635
 for <alsa-devel@alsa-project.org>; Mon,  4 Feb 2013 20:53:27 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@intel.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Allow the regmap API to use asynchronous I/O where supported to minimise
the delay between transfers, reducing firmware download times.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_adsp.c |   82 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 66 insertions(+), 16 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 5487a94..be45e2b 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -15,6 +15,7 @@
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/firmware.h>
+#include <linux/list.h>
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
@@ -153,6 +154,43 @@
 #define ADSP2_RAM_RDY_SHIFT                    0
 #define ADSP2_RAM_RDY_WIDTH                    1
 
+struct wm_adsp_buf {
+	struct list_head list;
+	void *buf;
+};
+
+static struct wm_adsp_buf *wm_adsp_buf_alloc(const void *src, size_t len,
+					     struct list_head *list)
+{
+	struct wm_adsp_buf *buf = kzalloc(sizeof(*buf), GFP_KERNEL);
+
+	if (buf == NULL)
+		return NULL;
+
+	buf->buf = kmemdup(src, len, GFP_KERNEL | GFP_DMA);
+	if (!buf->buf) {
+		kfree(buf);
+		return NULL;
+	}
+
+	if (list)
+		list_add_tail(&buf->list, list);
+
+	return buf;
+}
+
+static void wm_adsp_buf_free(struct list_head *list)
+{
+	while (!list_empty(list)) {
+		struct wm_adsp_buf *buf = list_first_entry(list,
+							   struct wm_adsp_buf,
+							   list);
+		list_del(&buf->list);
+		kfree(buf->buf);
+		kfree(buf);
+	}
+}
+
 #define WM_ADSP_NUM_FW 4
 
 static const char *wm_adsp_fw_text[WM_ADSP_NUM_FW] = {
@@ -254,6 +292,7 @@ static unsigned int wm_adsp_region_to_reg(struct wm_adsp_region const *region,
 
 static int wm_adsp_load(struct wm_adsp *dsp)
 {
+	LIST_HEAD(buf_list);
 	const struct firmware *firmware;
 	struct regmap *regmap = dsp->regmap;
 	unsigned int pos = 0;
@@ -265,7 +304,7 @@ static int wm_adsp_load(struct wm_adsp *dsp)
 	const struct wm_adsp_region *mem;
 	const char *region_name;
 	char *file, *text;
-	void *buf;
+	struct wm_adsp_buf *buf;
 	unsigned int reg;
 	int regions = 0;
 	int ret, offset, type, sizes;
@@ -420,18 +459,16 @@ static int wm_adsp_load(struct wm_adsp *dsp)
 		}
 
 		if (reg) {
-			buf = kmemdup(region->data, le32_to_cpu(region->len),
-				      GFP_KERNEL | GFP_DMA);
+			buf = wm_adsp_buf_alloc(region->data,
+						le32_to_cpu(region->len),
+						&buf_list);
 			if (!buf) {
 				adsp_err(dsp, "Out of memory\n");
 				return -ENOMEM;
 			}
 
-			ret = regmap_raw_write(regmap, reg, buf,
-					       le32_to_cpu(region->len));
-
-			kfree(buf);
-
+			ret = regmap_raw_write_async(regmap, reg, buf->buf,
+						     le32_to_cpu(region->len));
 			if (ret != 0) {
 				adsp_err(dsp,
 					"%s.%d: Failed to write %d bytes at %d in %s: %d\n",
@@ -445,12 +482,20 @@ static int wm_adsp_load(struct wm_adsp *dsp)
 		pos += le32_to_cpu(region->len) + sizeof(*region);
 		regions++;
 	}
-	
+
+	ret = regmap_async_complete(regmap);
+	if (ret != 0) {
+		adsp_err(dsp, "Failed to complete async write: %d\n", ret);
+		goto out_fw;
+	}
+
 	if (pos > firmware->size)
 		adsp_warn(dsp, "%s.%d: %zu bytes at end of file\n",
 			  file, regions, pos - firmware->size);
 
 out_fw:
+	regmap_async_complete(regmap);
+	wm_adsp_buf_free(&buf_list);
 	release_firmware(firmware);
 out:
 	kfree(file);
@@ -655,6 +700,7 @@ out:
 
 static int wm_adsp_load_coeff(struct wm_adsp *dsp)
 {
+	LIST_HEAD(buf_list);
 	struct regmap *regmap = dsp->regmap;
 	struct wmfw_coeff_hdr *hdr;
 	struct wmfw_coeff_item *blk;
@@ -664,7 +710,7 @@ static int wm_adsp_load_coeff(struct wm_adsp *dsp)
 	const char *region_name;
 	int ret, pos, blocks, type, offset, reg;
 	char *file;
-	void *buf;
+	struct wm_adsp_buf *buf;
 
 	file = kzalloc(PAGE_SIZE, GFP_KERNEL);
 	if (file == NULL)
@@ -776,8 +822,9 @@ static int wm_adsp_load_coeff(struct wm_adsp *dsp)
 		}
 
 		if (reg) {
-			buf = kmemdup(blk->data, le32_to_cpu(blk->len),
-				      GFP_KERNEL | GFP_DMA);
+			buf = wm_adsp_buf_alloc(blk->data,
+						le32_to_cpu(blk->len),
+						&buf_list);
 			if (!buf) {
 				adsp_err(dsp, "Out of memory\n");
 				return -ENOMEM;
@@ -786,27 +833,30 @@ static int wm_adsp_load_coeff(struct wm_adsp *dsp)
 			adsp_dbg(dsp, "%s.%d: Writing %d bytes at %x\n",
 				 file, blocks, le32_to_cpu(blk->len),
 				 reg);
-			ret = regmap_raw_write(regmap, reg, blk->data,
-					       le32_to_cpu(blk->len));
+			ret = regmap_raw_write_async(regmap, reg, buf->buf,
+						     le32_to_cpu(blk->len));
 			if (ret != 0) {
 				adsp_err(dsp,
 					"%s.%d: Failed to write to %x in %s\n",
 					file, blocks, reg, region_name);
 			}
-
-			kfree(buf);
 		}
 
 		pos += le32_to_cpu(blk->len) + sizeof(*blk);
 		blocks++;
 	}
 
+	ret = regmap_async_complete(regmap);
+	if (ret != 0)
+		adsp_err(dsp, "Failed to complete async write: %d\n", ret);
+
 	if (pos > firmware->size)
 		adsp_warn(dsp, "%s.%d: %zu bytes at end of file\n",
 			  file, blocks, pos - firmware->size);
 
 out_fw:
 	release_firmware(firmware);
+	wm_adsp_buf_free(&buf_list);
 out:
 	kfree(file);
 	return 0;
-- 
1.7.10.4
