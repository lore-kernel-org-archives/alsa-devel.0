From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm_adsp: Add WDT expiry IRQ handling
	support for Halo core" to the asoc tree
Date: Tue, 19 Mar 2019 13:12:57 +0000 (GMT)
Message-ID: <20190319131257.1286711288DF@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5A11AF8070E
 for <alsa-devel@alsa-project.org>; Tue, 19 Mar 2019 14:13:04 +0100 (CET)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Stuart Henderson <stuarth@opensource.cirrus.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.cirrus.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm_adsp: Add WDT expiry IRQ handling support for Halo core

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

>From 8bc144f90b6c813b2888f34842eba6a06a588429 Mon Sep 17 00:00:00 2001
From: Stuart Henderson <stuarth@opensource.cirrus.com>
Date: Tue, 19 Mar 2019 11:52:15 +0000
Subject: [PATCH] ASoC: wm_adsp: Add WDT expiry IRQ handling support for Halo
 core

Signed-off-by: Stuart Henderson <stuarth@opensource.cirrus.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm_adsp.c | 29 +++++++++++++++++++++++++++++
 sound/soc/codecs/wm_adsp.h |  1 +
 2 files changed, 30 insertions(+)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 3e74cbb80d3c..644aaf1d2740 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -242,6 +242,7 @@
 #define HALO_SCRATCH4                        0x005d8
 #define HALO_CCM_CORE_CONTROL                0x41000
 #define HALO_CORE_SOFT_RESET                 0x00010
+#define HALO_WDT_CONTROL                     0x47000
 
 /*
  * HALO MPU banks
@@ -291,6 +292,11 @@
  */
 #define HALO_CORE_SOFT_RESET_MASK           0x00000001
 
+/*
+ * HALO_WDT_CONTROL
+ */
+#define HALO_WDT_EN_MASK                    0x00000001
+
 /*
  * HALO_MPU_?M_VIO_STATUS
  */
@@ -3083,6 +3089,12 @@ static void wm_adsp_stop_watchdog(struct wm_adsp *dsp)
 			   ADSP2_WDT_ENA_MASK, 0);
 }
 
+static void wm_halo_stop_watchdog(struct wm_adsp *dsp)
+{
+	regmap_update_bits(dsp->regmap, dsp->base + HALO_WDT_CONTROL,
+			   HALO_WDT_EN_MASK, 0);
+}
+
 int wm_adsp_early_event(struct snd_soc_dapm_widget *w,
 			struct snd_kcontrol *kcontrol, int event)
 {
@@ -4379,6 +4391,22 @@ irqreturn_t wm_halo_bus_error(struct wm_adsp *dsp)
 }
 EXPORT_SYMBOL_GPL(wm_halo_bus_error);
 
+irqreturn_t wm_halo_wdt_expire(int irq, void *data)
+{
+	struct wm_adsp *dsp = data;
+
+	mutex_lock(&dsp->pwr_lock);
+
+	adsp_warn(dsp, "WDT Expiry Fault\n");
+	wm_halo_stop_watchdog(dsp);
+	wm_adsp_fatal_error(dsp);
+
+	mutex_unlock(&dsp->pwr_lock);
+
+	return IRQ_HANDLED;
+}
+EXPORT_SYMBOL_GPL(wm_halo_wdt_expire);
+
 struct wm_adsp_ops wm_adsp1_ops = {
 	.validate_version = wm_adsp_validate_version,
 	.parse_sizes = wm_adsp1_parse_sizes,
@@ -4454,6 +4482,7 @@ struct wm_adsp_ops wm_halo_ops = {
 	.region_to_reg = wm_halo_region_to_reg,
 
 	.show_fw_status = wm_halo_show_fw_status,
+	.stop_watchdog = wm_halo_stop_watchdog,
 
 	.lock_memory = wm_halo_configure_mpu,
 
diff --git a/sound/soc/codecs/wm_adsp.h b/sound/soc/codecs/wm_adsp.h
index 521dccbf3a2e..3631c9200c5d 100644
--- a/sound/soc/codecs/wm_adsp.h
+++ b/sound/soc/codecs/wm_adsp.h
@@ -176,6 +176,7 @@ int wm_adsp_early_event(struct snd_soc_dapm_widget *w,
 
 irqreturn_t wm_adsp2_bus_error(struct wm_adsp *adsp);
 irqreturn_t wm_halo_bus_error(struct wm_adsp *dsp);
+irqreturn_t wm_halo_wdt_expire(int irq, void *data);
 
 int wm_adsp_event(struct snd_soc_dapm_widget *w,
 		  struct snd_kcontrol *kcontrol, int event);
-- 
2.20.1
