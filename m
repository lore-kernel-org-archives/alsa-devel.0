From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH v2] ASoC: wm_adsp: Don't overrun firmware file buffer when reading region data
Date: Tue, 20 Dec 2016 10:29:12 +0000
Message-ID: <1482229752-9108-1-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Protect against corrupt firmware files by ensuring that the length we
get for the data in a region actually lies within the available firmware
file data buffer.

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_adsp.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 593b7d1..d72ccef 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -1551,7 +1551,7 @@ static int wm_adsp_load(struct wm_adsp *dsp)
 	const struct wmfw_region *region;
 	const struct wm_adsp_region *mem;
 	const char *region_name;
-	char *file, *text;
+	char *file, *text = NULL;
 	struct wm_adsp_buf *buf;
 	unsigned int reg;
 	int regions = 0;
@@ -1700,10 +1700,21 @@ static int wm_adsp_load(struct wm_adsp *dsp)
 			 regions, le32_to_cpu(region->len), offset,
 			 region_name);
 
+		if ((pos + le32_to_cpu(region->len) + sizeof(*region)) >
+		    firmware->size) {
+			adsp_err(dsp,
+				 "%s.%d: %s region len %d bytes exceeds file length %zu\n",
+				 file, regions, region_name,
+				 le32_to_cpu(region->len), firmware->size);
+			ret = -EINVAL;
+			goto out_fw;
+		}
+
 		if (text) {
 			memcpy(text, region->data, le32_to_cpu(region->len));
 			adsp_info(dsp, "%s: %s\n", file, text);
 			kfree(text);
+			text = NULL;
 		}
 
 		if (reg) {
@@ -1748,6 +1759,7 @@ static int wm_adsp_load(struct wm_adsp *dsp)
 	regmap_async_complete(regmap);
 	wm_adsp_buf_free(&buf_list);
 	release_firmware(firmware);
+	kfree(text);
 out:
 	kfree(file);
 
@@ -2233,6 +2245,17 @@ static int wm_adsp_load_coeff(struct wm_adsp *dsp)
 		}
 
 		if (reg) {
+			if ((pos + le32_to_cpu(blk->len) + sizeof(*blk)) >
+			    firmware->size) {
+				adsp_err(dsp,
+					 "%s.%d: %s region len %d bytes exceeds file length %zu\n",
+					 file, blocks, region_name,
+					 le32_to_cpu(blk->len),
+					 firmware->size);
+				ret = -EINVAL;
+				goto out_fw;
+			}
+
 			buf = wm_adsp_buf_alloc(blk->data,
 						le32_to_cpu(blk->len),
 						&buf_list);
-- 
1.9.1
