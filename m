From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm_adsp: Ensure that block writes are
	from DMA aligned addresses
Date: Mon,  7 Jan 2013 18:45:04 +0000
Message-ID: <1357584304-703-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0FD78265159
 for <alsa-devel@alsa-project.org>; Mon,  7 Jan 2013 19:45:14 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Otherwise we won't run correctly on systems that require this for larger
data transfers.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_adsp.c |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 5d8bb1d..a765458 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -169,6 +169,7 @@ static int wm_adsp_load(struct wm_adsp *dsp)
 	const struct wm_adsp_region *mem;
 	const char *region_name;
 	char *file, *text;
+	void *buf;
 	unsigned int reg;
 	int regions = 0;
 	int ret, offset, type, sizes;
@@ -322,8 +323,18 @@ static int wm_adsp_load(struct wm_adsp *dsp)
 		}
 
 		if (reg) {
-			ret = regmap_raw_write(regmap, reg, region->data,
+			buf = kmemdup(region->data, le32_to_cpu(region->len),
+				      GFP_KERNEL);
+			if (!buf) {
+				adsp_err(dsp, "Out of memory\n");
+				return -ENOMEM;
+			}
+
+			ret = regmap_raw_write(regmap, reg, buf,
 					       le32_to_cpu(region->len));
+
+			kfree(buf);
+
 			if (ret != 0) {
 				adsp_err(dsp,
 					"%s.%d: Failed to write %d bytes at %d in %s: %d\n",
-- 
1.7.10.4
