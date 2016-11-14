From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm_adsp: factor out getting base register for a control" to the asoc tree
Date: Mon, 14 Nov 2016 13:52:35 +0000
Message-ID: <E1c6HgZ-0003C8-39@finisterre>
References: <1478711658-23696-1-git-send-email-rf@opensource.wolfsonmicro.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1478711658-23696-1-git-send-email-rf@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: Mark Brown <broonie@kernel.org>broonie@kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm_adsp: factor out getting base register for a control

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

>From b396ebca736f94a1a18bdc9a518ad0ca58fbd842 Mon Sep 17 00:00:00 2001
From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Date: Wed, 9 Nov 2016 17:14:14 +0000
Subject: [PATCH] ASoC: wm_adsp: factor out getting base register for a control

The lookup of the base register corresponding to a control is
duplicated in read and write so factor it out into a separate
function.

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm_adsp.c | 46 ++++++++++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 0f705bfd76b4..4fb6e2f035e0 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -756,6 +756,24 @@ static inline struct wm_coeff_ctl *bytes_ext_to_ctl(struct soc_bytes_ext *ext)
 	return container_of(ext, struct wm_coeff_ctl, bytes_ext);
 }
 
+static int wm_coeff_base_reg(struct wm_coeff_ctl *ctl, unsigned int *reg)
+{
+	const struct wm_adsp_alg_region *alg_region = &ctl->alg_region;
+	struct wm_adsp *dsp = ctl->dsp;
+	const struct wm_adsp_region *mem;
+
+	mem = wm_adsp_find_region(dsp, alg_region->type);
+	if (!mem) {
+		adsp_err(dsp, "No base for region %x\n",
+			 alg_region->type);
+		return -EINVAL;
+	}
+
+	*reg = wm_adsp_region_to_reg(mem, ctl->alg_region.base + ctl->offset);
+
+	return 0;
+}
+
 static int wm_coeff_info(struct snd_kcontrol *kctl,
 			 struct snd_ctl_elem_info *uinfo)
 {
@@ -843,22 +861,14 @@ static int wm_coeff_write_acked_control(struct wm_coeff_ctl *ctl,
 static int wm_coeff_write_control(struct wm_coeff_ctl *ctl,
 				  const void *buf, size_t len)
 {
-	struct wm_adsp_alg_region *alg_region = &ctl->alg_region;
-	const struct wm_adsp_region *mem;
 	struct wm_adsp *dsp = ctl->dsp;
 	void *scratch;
 	int ret;
 	unsigned int reg;
 
-	mem = wm_adsp_find_region(dsp, alg_region->type);
-	if (!mem) {
-		adsp_err(dsp, "No base for region %x\n",
-			 alg_region->type);
-		return -EINVAL;
-	}
-
-	reg = ctl->alg_region.base + ctl->offset;
-	reg = wm_adsp_region_to_reg(mem, reg);
+	ret = wm_coeff_base_reg(ctl, &reg);
+	if (ret)
+		return ret;
 
 	scratch = kmemdup(buf, len, GFP_KERNEL | GFP_DMA);
 	if (!scratch)
@@ -951,22 +961,14 @@ static int wm_coeff_put_acked(struct snd_kcontrol *kctl,
 static int wm_coeff_read_control(struct wm_coeff_ctl *ctl,
 				 void *buf, size_t len)
 {
-	struct wm_adsp_alg_region *alg_region = &ctl->alg_region;
-	const struct wm_adsp_region *mem;
 	struct wm_adsp *dsp = ctl->dsp;
 	void *scratch;
 	int ret;
 	unsigned int reg;
 
-	mem = wm_adsp_find_region(dsp, alg_region->type);
-	if (!mem) {
-		adsp_err(dsp, "No base for region %x\n",
-			 alg_region->type);
-		return -EINVAL;
-	}
-
-	reg = ctl->alg_region.base + ctl->offset;
-	reg = wm_adsp_region_to_reg(mem, reg);
+	ret = wm_coeff_base_reg(ctl, &reg);
+	if (ret)
+		return ret;
 
 	scratch = kmalloc(len, GFP_KERNEL | GFP_DMA);
 	if (!scratch)
-- 
2.10.2
