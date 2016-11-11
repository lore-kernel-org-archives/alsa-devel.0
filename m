From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm_adsp: factor out getting region name from type" to the asoc tree
Date: Fri, 11 Nov 2016 16:01:02 +0000
Message-ID: <E1c5EGE-0003iH-HE@finisterre>
References: <1478711658-23696-2-git-send-email-rf@opensource.wolfsonmicro.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1478711658-23696-2-git-send-email-rf@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: Mark Brown <broonie@kernel.org>broonie@kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm_adsp: factor out getting region name from type

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

>From 9ce5e6e61122cdd6556d4e61657aa47b207042a1 Mon Sep 17 00:00:00 2001
From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Date: Wed, 9 Nov 2016 17:14:15 +0000
Subject: [PATCH] ASoC: wm_adsp: factor out getting region name from type

This patch factors out converting a memory region type into
a name string, mainly so that it can be used in log commands.

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm_adsp.c | 53 +++++++++++++++++++---------------------------
 1 file changed, 22 insertions(+), 31 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 07cf7cb93301..ef33de651028 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -454,6 +454,24 @@ struct wm_coeff_ctl {
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
@@ -1146,29 +1164,14 @@ static int wm_adsp_create_control(struct wm_adsp *dsp,
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
@@ -1601,23 +1604,11 @@ static int wm_adsp_load(struct wm_adsp *dsp)
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
2.10.2
