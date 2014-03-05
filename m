From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm_adsp: Split firmware load into
	smaller chunks
Date: Wed,  5 Mar 2014 14:28:16 +0000
Message-ID: <1394029696-25975-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A4C922650D5
 for <alsa-devel@alsa-project.org>; Wed,  5 Mar 2014 15:36:36 +0100 (CET)
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

The firmware files can be quite large and allocating the whole firmware
a single DMA safe buffer can be problematic if the system is under a
high memory load. Ease the requirements slightly by writing the firmware
out in page sized chunks.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_adsp.c |   50 ++++++++++++++++++++++++++++---------------
 1 files changed, 32 insertions(+), 18 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index f9fd564..937af6f 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -684,24 +684,38 @@ static int wm_adsp_load(struct wm_adsp *dsp)
 		}
 
 		if (reg) {
-			buf = wm_adsp_buf_alloc(region->data,
-						le32_to_cpu(region->len),
-						&buf_list);
-			if (!buf) {
-				adsp_err(dsp, "Out of memory\n");
-				ret = -ENOMEM;
-				goto out_fw;
-			}
+			size_t to_write = PAGE_SIZE;
+			size_t remain = le32_to_cpu(region->len);
+			const u8 *data = region->data;
+
+			while (remain > 0) {
+				if (remain < PAGE_SIZE)
+					to_write = remain;
+
+				buf = wm_adsp_buf_alloc(data,
+							to_write,
+							&buf_list);
+				if (!buf) {
+					adsp_err(dsp, "Out of memory\n");
+					ret = -ENOMEM;
+					goto out_fw;
+				}
 
-			ret = regmap_raw_write_async(regmap, reg, buf->buf,
-						     le32_to_cpu(region->len));
-			if (ret != 0) {
-				adsp_err(dsp,
-					"%s.%d: Failed to write %d bytes at %d in %s: %d\n",
-					file, regions,
-					le32_to_cpu(region->len), offset,
-					region_name, ret);
-				goto out_fw;
+				ret = regmap_raw_write_async(regmap, reg,
+							     buf->buf,
+							     to_write);
+				if (ret != 0) {
+					adsp_err(dsp,
+						"%s.%d: Failed to write %d bytes at %d in %s: %d\n",
+						file, regions,
+						to_write, offset,
+						region_name, ret);
+					goto out_fw;
+				}
+
+				data += to_write;
+				reg += to_write / 2;
+				remain -= to_write;
 			}
 		}
 
-- 
1.7.2.5
