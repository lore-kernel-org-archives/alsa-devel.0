From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm_adsp: Don't overrun firmware file buffer when reading region data" to the asoc tree
Date: Tue, 20 Dec 2016 11:39:18 +0000
Message-ID: <E1cJIlK-00006G-Ab@debutante>
References: <1482229752-9108-1-git-send-email-rf@opensource.wolfsonmicro.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1482229752-9108-1-git-send-email-rf@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: Mark Brown <broonie@kernel.org>broonie@kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm_adsp: Don't overrun firmware file buffer when reading region data

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 1cab2a84f470e15ecc8e5143bfe9398c6e888032 Mon Sep 17 00:00:00 2001
From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Date: Tue, 20 Dec 2016 10:29:12 +0000
Subject: [PATCH] ASoC: wm_adsp: Don't overrun firmware file buffer when
 reading region data

Protect against corrupt firmware files by ensuring that the length we
get for the data in a region actually lies within the available firmware
file data buffer.

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm_adsp.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 593b7d1aed46..d72ccef9e238 100644
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
2.11.0
