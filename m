From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm_adsp: wm_coeff_{read|write}_control
	should use passed length" to the asoc tree
Date: Sun, 21 Feb 2016 03:10:41 +0900
Message-ID: <E1aXBzN-0001lJ-DN@finisterre>
References: <1455893084-4556-4-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id F04D7261687
 for <alsa-devel@alsa-project.org>; Sat, 20 Feb 2016 19:10:47 +0100 (CET)
In-Reply-To: <1455893084-4556-4-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm_adsp: wm_coeff_{read|write}_control should use passed length

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

>From 4f8ea6d759f6ed5d448472143cef7681e319c958 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Date: Fri, 19 Feb 2016 14:44:44 +0000
Subject: [PATCH] ASoC: wm_adsp: wm_coeff_{read|write}_control should use
 passed length

wm_coeff_{read|write}_control were using the control length rather than
the length parameter passed to them. This is not causing any issues as
the two values are currently always the same, but this needs fixed to
allow future improvements.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm_adsp.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 0f6eeb1..36687db 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -721,19 +721,19 @@ static int wm_coeff_write_control(struct wm_coeff_ctl *ctl,
 	reg = ctl->alg_region.base + ctl->offset;
 	reg = wm_adsp_region_to_reg(mem, reg);
 
-	scratch = kmemdup(buf, ctl->len, GFP_KERNEL | GFP_DMA);
+	scratch = kmemdup(buf, len, GFP_KERNEL | GFP_DMA);
 	if (!scratch)
 		return -ENOMEM;
 
 	ret = regmap_raw_write(dsp->regmap, reg, scratch,
-			       ctl->len);
+			       len);
 	if (ret) {
 		adsp_err(dsp, "Failed to write %zu bytes to %x: %d\n",
-			 ctl->len, reg, ret);
+			 len, reg, ret);
 		kfree(scratch);
 		return ret;
 	}
-	adsp_dbg(dsp, "Wrote %zu bytes to %x\n", ctl->len, reg);
+	adsp_dbg(dsp, "Wrote %zu bytes to %x\n", len, reg);
 
 	kfree(scratch);
 
@@ -780,20 +780,20 @@ static int wm_coeff_read_control(struct wm_coeff_ctl *ctl,
 	reg = ctl->alg_region.base + ctl->offset;
 	reg = wm_adsp_region_to_reg(mem, reg);
 
-	scratch = kmalloc(ctl->len, GFP_KERNEL | GFP_DMA);
+	scratch = kmalloc(len, GFP_KERNEL | GFP_DMA);
 	if (!scratch)
 		return -ENOMEM;
 
-	ret = regmap_raw_read(dsp->regmap, reg, scratch, ctl->len);
+	ret = regmap_raw_read(dsp->regmap, reg, scratch, len);
 	if (ret) {
 		adsp_err(dsp, "Failed to read %zu bytes from %x: %d\n",
 			 ctl->len, reg, ret);
 		kfree(scratch);
 		return ret;
 	}
-	adsp_dbg(dsp, "Read %zu bytes from %x\n", ctl->len, reg);
+	adsp_dbg(dsp, "Read %zu bytes from %x\n", len, reg);
 
-	memcpy(buf, scratch, ctl->len);
+	memcpy(buf, scratch, len);
 	kfree(scratch);
 
 	return 0;
-- 
2.7.0
