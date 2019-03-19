From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH 09/12] ASoC: wm_adsp: Factor out DSP specific
	operations
Date: Tue, 19 Mar 2019 11:52:12 +0000
Message-ID: <20190319115215.22960-10-ckeepax@opensource.cirrus.com>
References: <20190319115215.22960-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1E277F89713
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

In preparation for the addition of more types of DSP core refactor the
handling of DSP specific operations such as starting the memory or
enabling the core into a set of callbacks. This should make it easier to
add new core types and allow for more code reuse between them.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/codecs/cs47l24.c |   2 +-
 sound/soc/codecs/wm5102.c  |   2 +-
 sound/soc/codecs/wm5110.c  |   2 +-
 sound/soc/codecs/wm_adsp.c | 383 ++++++++++++++++++++++++++++-----------------
 sound/soc/codecs/wm_adsp.h |  35 ++++-
 5 files changed, 271 insertions(+), 153 deletions(-)

diff --git a/sound/soc/codecs/cs47l24.c b/sound/soc/codecs/cs47l24.c
index e056d871fafb8..eebbf02e1c395 100644
--- a/sound/soc/codecs/cs47l24.c
+++ b/sound/soc/codecs/cs47l24.c
@@ -77,7 +77,7 @@ static int cs47l24_adsp_power_ev(struct snd_soc_dapm_widget *w,
 
 	wm_adsp2_set_dspclk(w, v);
 
-	return wm_adsp2_early_event(w, kcontrol, event);
+	return wm_adsp_early_event(w, kcontrol, event);
 }
 
 static DECLARE_TLV_DB_SCALE(eq_tlv, -1200, 100, 0);
diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index c972591f1cc4f..b32e8313954d3 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -661,7 +661,7 @@ static int wm5102_adsp_power_ev(struct snd_soc_dapm_widget *w,
 		break;
 	}
 
-	return wm_adsp2_early_event(w, kcontrol, event);
+	return wm_adsp_early_event(w, kcontrol, event);
 }
 
 static int wm5102_out_comp_coeff_get(struct snd_kcontrol *kcontrol,
diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index c543b73e2f205..1f500cc8d96a6 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -213,7 +213,7 @@ static int wm5110_adsp_power_ev(struct snd_soc_dapm_widget *w,
 
 	wm_adsp2_set_dspclk(w, v);
 
-	return wm_adsp2_early_event(w, kcontrol, event);
+	return wm_adsp_early_event(w, kcontrol, event);
 }
 
 static const struct reg_sequence wm5110_no_dre_left_enable[] = {
diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index acb57dd2c2ad7..eccc640d61845 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -227,6 +227,9 @@
  */
 #define WM_ADSP_FW_EVENT_SHUTDOWN            0x000001
 
+struct wm_adsp_ops wm_adsp1_ops;
+struct wm_adsp_ops wm_adsp2_ops[];
+
 struct wm_adsp_buf {
 	struct list_head list;
 	void *buf;
@@ -1640,6 +1643,52 @@ static int wm_adsp_parse_coeff(struct wm_adsp *dsp,
 	return 0;
 }
 
+static unsigned int wm_adsp1_parse_sizes(struct wm_adsp *dsp,
+					 const char * const file,
+					 unsigned int pos,
+					 const struct firmware *firmware)
+{
+	const struct wmfw_adsp1_sizes *adsp1_sizes;
+
+	adsp1_sizes = (void *)&firmware->data[pos];
+
+	adsp_dbg(dsp, "%s: %d DM, %d PM, %d ZM\n", file,
+		 le32_to_cpu(adsp1_sizes->dm), le32_to_cpu(adsp1_sizes->pm),
+		 le32_to_cpu(adsp1_sizes->zm));
+
+	return pos + sizeof(*adsp1_sizes);
+}
+
+static unsigned int wm_adsp2_parse_sizes(struct wm_adsp *dsp,
+					 const char * const file,
+					 unsigned int pos,
+					 const struct firmware *firmware)
+{
+	const struct wmfw_adsp2_sizes *adsp2_sizes;
+
+	adsp2_sizes = (void *)&firmware->data[pos];
+
+	adsp_dbg(dsp, "%s: %d XM, %d YM %d PM, %d ZM\n", file,
+		 le32_to_cpu(adsp2_sizes->xm), le32_to_cpu(adsp2_sizes->ym),
+		 le32_to_cpu(adsp2_sizes->pm), le32_to_cpu(adsp2_sizes->zm));
+
+	return pos + sizeof(*adsp2_sizes);
+}
+
+static bool wm_adsp_validate_version(struct wm_adsp *dsp, unsigned int version)
+{
+	switch (version) {
+	case 0:
+		adsp_warn(dsp, "Deprecated file format %d\n", version);
+		return true;
+	case 1:
+	case 2:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static int wm_adsp_load(struct wm_adsp *dsp)
 {
 	LIST_HEAD(buf_list);
@@ -1648,7 +1697,6 @@ static int wm_adsp_load(struct wm_adsp *dsp)
 	unsigned int pos = 0;
 	const struct wmfw_header *header;
 	const struct wmfw_adsp1_sizes *adsp1_sizes;
-	const struct wmfw_adsp2_sizes *adsp2_sizes;
 	const struct wmfw_footer *footer;
 	const struct wmfw_region *region;
 	const struct wm_adsp_region *mem;
@@ -1657,7 +1705,7 @@ static int wm_adsp_load(struct wm_adsp *dsp)
 	struct wm_adsp_buf *buf;
 	unsigned int reg;
 	int regions = 0;
-	int ret, offset, type, sizes;
+	int ret, offset, type;
 
 	file = kzalloc(PAGE_SIZE, GFP_KERNEL);
 	if (file == NULL)
@@ -1688,15 +1736,7 @@ static int wm_adsp_load(struct wm_adsp *dsp)
 		goto out_fw;
 	}
 
-	switch (header->ver) {
-	case 0:
-		adsp_warn(dsp, "%s: Depreciated file format %d\n",
-			  file, header->ver);
-		break;
-	case 1:
-	case 2:
-		break;
-	default:
+	if (!dsp->ops->validate_version(dsp, header->ver)) {
 		adsp_err(dsp, "%s: unknown file format %d\n",
 			 file, header->ver);
 		goto out_fw;
@@ -1711,39 +1751,13 @@ static int wm_adsp_load(struct wm_adsp *dsp)
 		goto out_fw;
 	}
 
-	switch (dsp->type) {
-	case WMFW_ADSP1:
-		pos = sizeof(*header) + sizeof(*adsp1_sizes) + sizeof(*footer);
-		adsp1_sizes = (void *)&(header[1]);
-		footer = (void *)&(adsp1_sizes[1]);
-		sizes = sizeof(*adsp1_sizes);
+	pos = sizeof(*header);
+	pos = dsp->ops->parse_sizes(dsp, file, pos, firmware);
 
-		adsp_dbg(dsp, "%s: %d DM, %d PM, %d ZM\n",
-			 file, le32_to_cpu(adsp1_sizes->dm),
-			 le32_to_cpu(adsp1_sizes->pm),
-			 le32_to_cpu(adsp1_sizes->zm));
-		break;
-
-	case WMFW_ADSP2:
-		pos = sizeof(*header) + sizeof(*adsp2_sizes) + sizeof(*footer);
-		adsp2_sizes = (void *)&(header[1]);
-		footer = (void *)&(adsp2_sizes[1]);
-		sizes = sizeof(*adsp2_sizes);
-
-		adsp_dbg(dsp, "%s: %d XM, %d YM %d PM, %d ZM\n",
-			 file, le32_to_cpu(adsp2_sizes->xm),
-			 le32_to_cpu(adsp2_sizes->ym),
-			 le32_to_cpu(adsp2_sizes->pm),
-			 le32_to_cpu(adsp2_sizes->zm));
-		break;
+	footer = (void *)&firmware->data[pos];
+	pos += sizeof(*footer);
 
-	default:
-		WARN(1, "Unknown DSP type");
-		goto out_fw;
-	}
-
-	if (le32_to_cpu(header->len) != sizeof(*header) +
-	    sizes + sizeof(*footer)) {
+	if (le32_to_cpu(header->len) != pos) {
 		adsp_err(dsp, "%s: unexpected header length %d\n",
 			 file, le32_to_cpu(header->len));
 		goto out_fw;
@@ -2458,6 +2472,8 @@ static int wm_adsp_common_init(struct wm_adsp *dsp)
 
 int wm_adsp1_init(struct wm_adsp *dsp)
 {
+	dsp->ops = &wm_adsp1_ops;
+
 	return wm_adsp_common_init(dsp);
 }
 EXPORT_SYMBOL_GPL(wm_adsp1_init);
@@ -2577,23 +2593,11 @@ int wm_adsp1_event(struct snd_soc_dapm_widget *w,
 }
 EXPORT_SYMBOL_GPL(wm_adsp1_event);
 
-static int wm_adsp2_ena(struct wm_adsp *dsp)
+static int wm_adsp2v2_enable_core(struct wm_adsp *dsp)
 {
 	unsigned int val;
 	int ret, count;
 
-	switch (dsp->rev) {
-	case 0:
-		ret = regmap_update_bits_async(dsp->regmap,
-					       dsp->base + ADSP2_CONTROL,
-					       ADSP2_SYS_ENA, ADSP2_SYS_ENA);
-		if (ret != 0)
-			return ret;
-		break;
-	default:
-		break;
-	}
-
 	/* Wait for the RAM to start, should be near instantaneous */
 	for (count = 0; count < 10; ++count) {
 		ret = regmap_read(dsp->regmap, dsp->base + ADSP2_STATUS1, &val);
@@ -2616,6 +2620,18 @@ static int wm_adsp2_ena(struct wm_adsp *dsp)
 	return 0;
 }
 
+static int wm_adsp2_enable_core(struct wm_adsp *dsp)
+{
+	int ret;
+
+	ret = regmap_update_bits_async(dsp->regmap, dsp->base + ADSP2_CONTROL,
+				       ADSP2_SYS_ENA, ADSP2_SYS_ENA);
+	if (ret != 0)
+		return ret;
+
+	return wm_adsp2v2_enable_core(dsp);
+}
+
 static int wm_adsp2_lock(struct wm_adsp *dsp, unsigned int lock_regions)
 {
 	struct regmap *regmap = dsp->regmap;
@@ -2646,7 +2662,36 @@ static int wm_adsp2_lock(struct wm_adsp *dsp, unsigned int lock_regions)
 	return 0;
 }
 
-static void wm_adsp2_boot_work(struct work_struct *work)
+static int wm_adsp2_enable_memory(struct wm_adsp *dsp)
+{
+	return regmap_update_bits(dsp->regmap, dsp->base + ADSP2_CONTROL,
+				  ADSP2_MEM_ENA, ADSP2_MEM_ENA);
+}
+
+static void wm_adsp2_disable_memory(struct wm_adsp *dsp)
+{
+	regmap_update_bits(dsp->regmap, dsp->base + ADSP2_CONTROL,
+			   ADSP2_MEM_ENA, 0);
+}
+
+static void wm_adsp2_disable_core(struct wm_adsp *dsp)
+{
+	regmap_write(dsp->regmap, dsp->base + ADSP2_RDMA_CONFIG_1, 0);
+	regmap_write(dsp->regmap, dsp->base + ADSP2_WDMA_CONFIG_1, 0);
+	regmap_write(dsp->regmap, dsp->base + ADSP2_WDMA_CONFIG_2, 0);
+
+	regmap_update_bits(dsp->regmap, dsp->base + ADSP2_CONTROL,
+			   ADSP2_SYS_ENA, 0);
+}
+
+static void wm_adsp2v2_disable_core(struct wm_adsp *dsp)
+{
+	regmap_write(dsp->regmap, dsp->base + ADSP2_RDMA_CONFIG_1, 0);
+	regmap_write(dsp->regmap, dsp->base + ADSP2_WDMA_CONFIG_1, 0);
+	regmap_write(dsp->regmap, dsp->base + ADSP2V2_WDMA_CONFIG_2, 0);
+}
+
+static void wm_adsp_boot_work(struct work_struct *work)
 {
 	struct wm_adsp *dsp = container_of(work,
 					   struct wm_adsp,
@@ -2655,20 +2700,23 @@ static void wm_adsp2_boot_work(struct work_struct *work)
 
 	mutex_lock(&dsp->pwr_lock);
 
-	ret = regmap_update_bits(dsp->regmap, dsp->base + ADSP2_CONTROL,
-				 ADSP2_MEM_ENA, ADSP2_MEM_ENA);
-	if (ret != 0)
-		goto err_mutex;
+	if (dsp->ops->enable_memory) {
+		ret = dsp->ops->enable_memory(dsp);
+		if (ret != 0)
+			goto err_mutex;
+	}
 
-	ret = wm_adsp2_ena(dsp);
-	if (ret != 0)
-		goto err_mem;
+	if (dsp->ops->enable_core) {
+		ret = dsp->ops->enable_core(dsp);
+		if (ret != 0)
+			goto err_mem;
+	}
 
 	ret = wm_adsp_load(dsp);
 	if (ret != 0)
 		goto err_ena;
 
-	ret = wm_adsp2_setup_algs(dsp);
+	ret = dsp->ops->setup_algs(dsp);
 	if (ret != 0)
 		goto err_ena;
 
@@ -2681,17 +2729,8 @@ static void wm_adsp2_boot_work(struct work_struct *work)
 	if (ret != 0)
 		goto err_ena;
 
-	switch (dsp->rev) {
-	case 0:
-		/* Turn DSP back off until we are ready to run */
-		ret = regmap_update_bits(dsp->regmap, dsp->base + ADSP2_CONTROL,
-					 ADSP2_SYS_ENA, 0);
-		if (ret != 0)
-			goto err_ena;
-		break;
-	default:
-		break;
-	}
+	if (dsp->ops->disable_core)
+		dsp->ops->disable_core(dsp);
 
 	dsp->booted = true;
 
@@ -2700,11 +2739,11 @@ static void wm_adsp2_boot_work(struct work_struct *work)
 	return;
 
 err_ena:
-	regmap_update_bits(dsp->regmap, dsp->base + ADSP2_CONTROL,
-			   ADSP2_SYS_ENA | ADSP2_CORE_ENA | ADSP2_START, 0);
+	if (dsp->ops->disable_core)
+		dsp->ops->disable_core(dsp);
 err_mem:
-	regmap_update_bits(dsp->regmap, dsp->base + ADSP2_CONTROL,
-			   ADSP2_MEM_ENA, 0);
+	if (dsp->ops->disable_memory)
+		dsp->ops->disable_memory(dsp);
 err_mutex:
 	mutex_unlock(&dsp->pwr_lock);
 }
@@ -2771,18 +2810,12 @@ EXPORT_SYMBOL_GPL(wm_adsp2_preloader_put);
 
 static void wm_adsp_stop_watchdog(struct wm_adsp *dsp)
 {
-	switch (dsp->rev) {
-	case 0:
-	case 1:
-		return;
-	default:
-		regmap_update_bits(dsp->regmap, dsp->base + ADSP2_WATCHDOG,
-				   ADSP2_WDT_ENA_MASK, 0);
-	}
+	regmap_update_bits(dsp->regmap, dsp->base + ADSP2_WATCHDOG,
+			   ADSP2_WDT_ENA_MASK, 0);
 }
 
-int wm_adsp2_early_event(struct snd_soc_dapm_widget *w,
-			 struct snd_kcontrol *kcontrol, int event)
+int wm_adsp_early_event(struct snd_soc_dapm_widget *w,
+			struct snd_kcontrol *kcontrol, int event)
 {
 	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
 	struct wm_adsp *dsps = snd_soc_component_get_drvdata(component);
@@ -2803,8 +2836,8 @@ int wm_adsp2_early_event(struct snd_soc_dapm_widget *w,
 
 		dsp->booted = false;
 
-		regmap_update_bits(dsp->regmap, dsp->base + ADSP2_CONTROL,
-				   ADSP2_MEM_ENA, 0);
+		if (dsp->ops->disable_memory)
+			dsp->ops->disable_memory(dsp);
 
 		list_for_each_entry(ctl, &dsp->ctl_list, list)
 			ctl->enabled = 0;
@@ -2821,10 +2854,23 @@ int wm_adsp2_early_event(struct snd_soc_dapm_widget *w,
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(wm_adsp2_early_event);
+EXPORT_SYMBOL_GPL(wm_adsp_early_event);
 
-int wm_adsp2_event(struct snd_soc_dapm_widget *w,
-		   struct snd_kcontrol *kcontrol, int event)
+static int wm_adsp2_start_core(struct wm_adsp *dsp)
+{
+	return regmap_update_bits(dsp->regmap, dsp->base + ADSP2_CONTROL,
+				 ADSP2_CORE_ENA | ADSP2_START,
+				 ADSP2_CORE_ENA | ADSP2_START);
+}
+
+static void wm_adsp2_stop_core(struct wm_adsp *dsp)
+{
+	regmap_update_bits(dsp->regmap, dsp->base + ADSP2_CONTROL,
+			   ADSP2_CORE_ENA | ADSP2_START, 0);
+}
+
+int wm_adsp_event(struct snd_soc_dapm_widget *w,
+		  struct snd_kcontrol *kcontrol, int event)
 {
 	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
 	struct wm_adsp *dsps = snd_soc_component_get_drvdata(component);
@@ -2842,23 +2888,31 @@ int wm_adsp2_event(struct snd_soc_dapm_widget *w,
 			goto err;
 		}
 
-		ret = wm_adsp2_ena(dsp);
-		if (ret != 0)
-			goto err;
+		if (dsp->ops->enable_core) {
+			ret = dsp->ops->enable_core(dsp);
+			if (ret != 0)
+				goto err;
+		}
 
 		/* Sync set controls */
 		ret = wm_coeff_sync_controls(dsp);
 		if (ret != 0)
 			goto err;
 
-		wm_adsp2_lock(dsp, dsp->lock_regions);
+		if (dsp->ops->lock_memory) {
+			ret = dsp->ops->lock_memory(dsp, dsp->lock_regions);
+			if (ret != 0) {
+				adsp_err(dsp, "Error configuring MPU: %d\n",
+					 ret);
+				goto err;
+			}
+		}
 
-		ret = regmap_update_bits(dsp->regmap,
-					 dsp->base + ADSP2_CONTROL,
-					 ADSP2_CORE_ENA | ADSP2_START,
-					 ADSP2_CORE_ENA | ADSP2_START);
-		if (ret != 0)
-			goto err;
+		if (dsp->ops->start_core) {
+			ret = dsp->ops->start_core(dsp);
+			if (ret != 0)
+				goto err;
+		}
 
 		if (wm_adsp_fw[dsp->fw].num_caps != 0) {
 			ret = wm_adsp_buffer_init(dsp);
@@ -2869,56 +2923,27 @@ int wm_adsp2_event(struct snd_soc_dapm_widget *w,
 		dsp->running = true;
 
 		mutex_unlock(&dsp->pwr_lock);
-
 		break;
 
 	case SND_SOC_DAPM_PRE_PMD:
 		/* Tell the firmware to cleanup */
 		wm_adsp_signal_event_controls(dsp, WM_ADSP_FW_EVENT_SHUTDOWN);
 
-		wm_adsp_stop_watchdog(dsp);
+		if (dsp->ops->stop_watchdog)
+			dsp->ops->stop_watchdog(dsp);
 
 		/* Log firmware state, it can be useful for analysis */
-		switch (dsp->rev) {
-		case 0:
-			wm_adsp2_show_fw_status(dsp);
-			break;
-		default:
-			wm_adsp2v2_show_fw_status(dsp);
-			break;
-		}
+		if (dsp->ops->show_fw_status)
+			dsp->ops->show_fw_status(dsp);
 
 		mutex_lock(&dsp->pwr_lock);
 
 		dsp->running = false;
 
-		regmap_update_bits(dsp->regmap,
-				   dsp->base + ADSP2_CONTROL,
-				   ADSP2_CORE_ENA | ADSP2_START, 0);
-
-		/* Make sure DMAs are quiesced */
-		switch (dsp->rev) {
-		case 0:
-			regmap_write(dsp->regmap,
-				     dsp->base + ADSP2_RDMA_CONFIG_1, 0);
-			regmap_write(dsp->regmap,
-				     dsp->base + ADSP2_WDMA_CONFIG_1, 0);
-			regmap_write(dsp->regmap,
-				     dsp->base + ADSP2_WDMA_CONFIG_2, 0);
-
-			regmap_update_bits(dsp->regmap,
-					   dsp->base + ADSP2_CONTROL,
-					   ADSP2_SYS_ENA, 0);
-			break;
-		default:
-			regmap_write(dsp->regmap,
-				     dsp->base + ADSP2_RDMA_CONFIG_1, 0);
-			regmap_write(dsp->regmap,
-				     dsp->base + ADSP2_WDMA_CONFIG_1, 0);
-			regmap_write(dsp->regmap,
-				     dsp->base + ADSP2V2_WDMA_CONFIG_2, 0);
-			break;
-		}
+		if (dsp->ops->stop_core)
+			dsp->ops->stop_core(dsp);
+		if (dsp->ops->disable_core)
+			dsp->ops->disable_core(dsp);
 
 		if (wm_adsp_fw[dsp->fw].num_caps != 0)
 			wm_adsp_buffer_free(dsp);
@@ -2936,12 +2961,14 @@ int wm_adsp2_event(struct snd_soc_dapm_widget *w,
 
 	return 0;
 err:
-	regmap_update_bits(dsp->regmap, dsp->base + ADSP2_CONTROL,
-			   ADSP2_SYS_ENA | ADSP2_CORE_ENA | ADSP2_START, 0);
+	if (dsp->ops->stop_core)
+		dsp->ops->stop_core(dsp);
+	if (dsp->ops->disable_core)
+		dsp->ops->disable_core(dsp);
 	mutex_unlock(&dsp->pwr_lock);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(wm_adsp2_event);
+EXPORT_SYMBOL_GPL(wm_adsp_event);
 
 int wm_adsp2_component_probe(struct wm_adsp *dsp, struct snd_soc_component *component)
 {
@@ -2987,12 +3014,18 @@ int wm_adsp2_init(struct wm_adsp *dsp)
 				 "Failed to clear memory retention: %d\n", ret);
 			return ret;
 		}
+
+		dsp->ops = &wm_adsp2_ops[0];
+		break;
+	case 1:
+		dsp->ops = &wm_adsp2_ops[1];
 		break;
 	default:
+		dsp->ops = &wm_adsp2_ops[2];
 		break;
 	}
 
-	INIT_WORK(&dsp->boot_work, wm_adsp2_boot_work);
+	INIT_WORK(&dsp->boot_work, wm_adsp_boot_work);
 
 	return 0;
 }
@@ -3988,4 +4021,64 @@ irqreturn_t wm_adsp2_bus_error(struct wm_adsp *dsp)
 }
 EXPORT_SYMBOL_GPL(wm_adsp2_bus_error);
 
+struct wm_adsp_ops wm_adsp1_ops = {
+	.validate_version = wm_adsp_validate_version,
+	.parse_sizes = wm_adsp1_parse_sizes,
+};
+
+struct wm_adsp_ops wm_adsp2_ops[] = {
+	{
+		.parse_sizes = wm_adsp2_parse_sizes,
+		.validate_version = wm_adsp_validate_version,
+		.setup_algs = wm_adsp2_setup_algs,
+
+		.show_fw_status = wm_adsp2_show_fw_status,
+
+		.enable_memory = wm_adsp2_enable_memory,
+		.disable_memory = wm_adsp2_disable_memory,
+
+		.enable_core = wm_adsp2_enable_core,
+		.disable_core = wm_adsp2_disable_core,
+
+		.start_core = wm_adsp2_start_core,
+		.stop_core = wm_adsp2_stop_core,
+
+	},
+	{
+		.parse_sizes = wm_adsp2_parse_sizes,
+		.validate_version = wm_adsp_validate_version,
+		.setup_algs = wm_adsp2_setup_algs,
+
+		.show_fw_status = wm_adsp2v2_show_fw_status,
+
+		.enable_memory = wm_adsp2_enable_memory,
+		.disable_memory = wm_adsp2_disable_memory,
+		.lock_memory = wm_adsp2_lock,
+
+		.enable_core = wm_adsp2v2_enable_core,
+		.disable_core = wm_adsp2v2_disable_core,
+
+		.start_core = wm_adsp2_start_core,
+		.stop_core = wm_adsp2_stop_core,
+	},
+	{
+		.parse_sizes = wm_adsp2_parse_sizes,
+		.validate_version = wm_adsp_validate_version,
+		.setup_algs = wm_adsp2_setup_algs,
+
+		.show_fw_status = wm_adsp2v2_show_fw_status,
+		.stop_watchdog = wm_adsp_stop_watchdog,
+
+		.enable_memory = wm_adsp2_enable_memory,
+		.disable_memory = wm_adsp2_disable_memory,
+		.lock_memory = wm_adsp2_lock,
+
+		.enable_core = wm_adsp2v2_enable_core,
+		.disable_core = wm_adsp2v2_disable_core,
+
+		.start_core = wm_adsp2_start_core,
+		.stop_core = wm_adsp2_stop_core,
+	},
+};
+
 MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/codecs/wm_adsp.h b/sound/soc/codecs/wm_adsp.h
index ac1bec3b2248c..c75a671c19a1f 100644
--- a/sound/soc/codecs/wm_adsp.h
+++ b/sound/soc/codecs/wm_adsp.h
@@ -54,6 +54,7 @@ struct wm_adsp_alg_region {
 
 struct wm_adsp_compr;
 struct wm_adsp_compr_buf;
+struct wm_adsp_ops;
 
 struct wm_adsp {
 	const char *part;
@@ -66,6 +67,8 @@ struct wm_adsp {
 	struct regmap *regmap;
 	struct snd_soc_component *component;
 
+	struct wm_adsp_ops *ops;
+
 	unsigned int base;
 	unsigned int sysclk_reg;
 	unsigned int sysclk_mask;
@@ -106,6 +109,28 @@ struct wm_adsp {
 
 };
 
+struct wm_adsp_ops {
+	bool (*validate_version)(struct wm_adsp *dsp, unsigned int version);
+	unsigned int (*parse_sizes)(struct wm_adsp *dsp,
+				    const char * const file,
+				    unsigned int pos,
+				    const struct firmware *firmware);
+	int (*setup_algs)(struct wm_adsp *dsp);
+
+	void (*show_fw_status)(struct wm_adsp *dsp);
+	void (*stop_watchdog)(struct wm_adsp *dsp);
+
+	int (*enable_memory)(struct wm_adsp *dsp);
+	void (*disable_memory)(struct wm_adsp *dsp);
+	int (*lock_memory)(struct wm_adsp *dsp, unsigned int lock_regions);
+
+	int (*enable_core)(struct wm_adsp *dsp);
+	void (*disable_core)(struct wm_adsp *dsp);
+
+	int (*start_core)(struct wm_adsp *dsp);
+	void (*stop_core)(struct wm_adsp *dsp);
+};
+
 #define WM_ADSP1(wname, num) \
 	SND_SOC_DAPM_PGA_E(wname, SND_SOC_NOPM, num, 0, NULL, 0, \
 		wm_adsp1_event, SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD)
@@ -121,7 +146,7 @@ struct wm_adsp {
 	.event_flags = SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_PRE_PMD, \
 	.subseq = 100, /* Ensure we run after SYSCLK supply widget */ }, \
 {	.id = snd_soc_dapm_out_drv, .name = wname, \
-	.reg = SND_SOC_NOPM, .shift = num, .event = wm_adsp2_event, \
+	.reg = SND_SOC_NOPM, .shift = num, .event = wm_adsp_event, \
 	.event_flags = SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD }
 
 #define WM_ADSP_FW_CONTROL(dspname, num) \
@@ -138,13 +163,13 @@ int wm_adsp2_component_remove(struct wm_adsp *dsp, struct snd_soc_component *com
 int wm_adsp1_event(struct snd_soc_dapm_widget *w,
 		   struct snd_kcontrol *kcontrol, int event);
 
-int wm_adsp2_early_event(struct snd_soc_dapm_widget *w,
-			 struct snd_kcontrol *kcontrol, int event);
+int wm_adsp_early_event(struct snd_soc_dapm_widget *w,
+			struct snd_kcontrol *kcontrol, int event);
 
 irqreturn_t wm_adsp2_bus_error(struct wm_adsp *adsp);
 
-int wm_adsp2_event(struct snd_soc_dapm_widget *w,
-		   struct snd_kcontrol *kcontrol, int event);
+int wm_adsp_event(struct snd_soc_dapm_widget *w,
+		  struct snd_kcontrol *kcontrol, int event);
 
 int wm_adsp2_set_dspclk(struct snd_soc_dapm_widget *w, unsigned int freq);
 
-- 
2.11.0
