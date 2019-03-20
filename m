From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm_adsp: Correct some minor issues" to
	the asoc tree
Date: Wed, 20 Mar 2019 17:29:25 +0000 (GMT)
Message-ID: <20190320172925.C17F01126E4D@debutante.sirena.org.uk>
References: <20190319174309.27640-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 295B9F80791
 for <alsa-devel@alsa-project.org>; Wed, 20 Mar 2019 18:29:31 +0100 (CET)
In-Reply-To: <20190319174309.27640-1-ckeepax@opensource.cirrus.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org, broonie@kernel.org, kbuild test robot <lkp@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm_adsp: Correct some minor issues

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From cd537873729cf939996a6984df080e6a0dfac0fb Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.cirrus.com>
Date: Tue, 19 Mar 2019 17:43:09 +0000
Subject: [PATCH] ASoC: wm_adsp: Correct some minor issues

The wm_adsp_ops structures should be static and correct two printf
specifiers.

Fixes: 170b1e123f38 ("ASoC: wm_adsp: Add support for new Halo core DSPs")
Fixes: 4e08d50d1fb6 ("ASoC: wm_adsp: Factor out DSP specific operations")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm_adsp.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 644aaf1d2740..5e615fbddf9a 100644
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
2.20.1
