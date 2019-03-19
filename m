From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH 12/12] ASoC: wm_adsp: Add WDT expiry IRQ
	handling support for Halo core
Date: Tue, 19 Mar 2019 11:52:15 +0000
Message-ID: <20190319115215.22960-13-ckeepax@opensource.cirrus.com>
References: <20190319115215.22960-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C1871F89693
 for <alsa-devel@alsa-project.org>; Tue, 19 Mar 2019 12:52:19 +0100 (CET)
In-Reply-To: <20190319115215.22960-1-ckeepax@opensource.cirrus.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: broonie@kernel.org
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, david.rhodes@cirrus.com
List-Id: alsa-devel@alsa-project.org

From: Stuart Henderson <stuarth@opensource.cirrus.com>

Signed-off-by: Stuart Henderson <stuarth@opensource.cirrus.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/codecs/wm_adsp.c | 29 +++++++++++++++++++++++++++++
 sound/soc/codecs/wm_adsp.h |  1 +
 2 files changed, 30 insertions(+)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 3e74cbb80d3c5..644aaf1d27403 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -242,6 +242,7 @@
 #define HALO_SCRATCH4                        0x005d8
 #define HALO_CCM_CORE_CONTROL                0x41000
 #define HALO_CORE_SOFT_RESET                 0x00010
+#define HALO_WDT_CONTROL                     0x47000
 
 /*
  * HALO MPU banks
@@ -292,6 +293,11 @@
 #define HALO_CORE_SOFT_RESET_MASK           0x00000001
 
 /*
+ * HALO_WDT_CONTROL
+ */
+#define HALO_WDT_EN_MASK                    0x00000001
+
+/*
  * HALO_MPU_?M_VIO_STATUS
  */
 #define HALO_MPU_VIO_STS_MASK               0x007e0000
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
index 521dccbf3a2e1..3631c9200c5d6 100644
--- a/sound/soc/codecs/wm_adsp.h
+++ b/sound/soc/codecs/wm_adsp.h
@@ -176,6 +176,7 @@ int wm_adsp_early_event(struct snd_soc_dapm_widget *w,
 
 irqreturn_t wm_adsp2_bus_error(struct wm_adsp *adsp);
 irqreturn_t wm_halo_bus_error(struct wm_adsp *dsp);
+irqreturn_t wm_halo_wdt_expire(int irq, void *data);
 
 int wm_adsp_event(struct snd_soc_dapm_widget *w,
 		  struct snd_kcontrol *kcontrol, int event);
-- 
2.11.0
