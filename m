From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH 12/16] ASoC: wm_adsp: add support for DSP
	region lock
Date: Wed, 5 Apr 2017 11:08:00 +0100
Message-ID: <1491386884-30689-13-git-send-email-rf@opensource.wolfsonmicro.com>
References: <1491386884-30689-1-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 5B50A26701D
 for <alsa-devel@alsa-project.org>; Wed,  5 Apr 2017 12:08:12 +0200 (CEST)
In-Reply-To: <1491386884-30689-1-git-send-email-rf@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linus.walleij@linaro.org, gnurou@gmail.com, robh+dt@kernel.org, tglx@linutronix.de, jason@lakedaemon.net, lee.jones@linaro.org, broonie@kernel.org
Cc: linux-gpio@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Mayuresh Kulkarni <mkulkarni@opensource.wolfsonmicro.com>

Newer ADSP2V2 codecs include a memory protection unit that can
be set to trap illegal accesses. When enabling an ADSPV2 core we
must configure the memory region traps so that the firmware can
access its own memory.

Signed-off-by: Mayuresh Kulkarni <mkulkarni@opensource.wolfsonmicro.com>
Signed-off-by: Nikesh Oswal <Nikesh.Oswal@wolfsonmicro.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_adsp.c | 137 +++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/wm_adsp.h |  23 ++++++++
 2 files changed, 160 insertions(+)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index a9acf22..20695b6 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -176,6 +176,37 @@
 #define ADSP2_RAM_RDY_SHIFT                    0
 #define ADSP2_RAM_RDY_WIDTH                    1
 
+/*
+ * ADSP2 Lock support
+ */
+#define ADSP2_LOCK_CODE_0                    0x5555
+#define ADSP2_LOCK_CODE_1                    0xAAAA
+
+#define ADSP2_WATCHDOG                       0x0A
+#define ADSP2_BUS_ERR_ADDR                   0x52
+#define ADSP2_REGION_LOCK_STATUS             0x64
+#define ADSP2_LOCK_REGION_1_LOCK_REGION_0    0x66
+#define ADSP2_LOCK_REGION_3_LOCK_REGION_2    0x68
+#define ADSP2_LOCK_REGION_5_LOCK_REGION_4    0x6A
+#define ADSP2_LOCK_REGION_7_LOCK_REGION_6    0x6C
+#define ADSP2_LOCK_REGION_9_LOCK_REGION_8    0x6E
+#define ADSP2_LOCK_REGION_CTRL               0x7A
+#define ADSP2_PMEM_ERR_ADDR_XMEM_ERR_ADDR    0x7C
+
+#define ADSP2_REGION_LOCK_ERR_MASK           0x8000
+#define ADSP2_SLAVE_ERR_MASK                 0x4000
+#define ADSP2_WDT_TIMEOUT_STS_MASK           0x2000
+#define ADSP2_CTRL_ERR_PAUSE_ENA             0x0002
+#define ADSP2_CTRL_ERR_EINT                  0x0001
+
+#define ADSP2_BUS_ERR_ADDR_MASK              0x00FFFFFF
+#define ADSP2_XMEM_ERR_ADDR_MASK             0x0000FFFF
+#define ADSP2_PMEM_ERR_ADDR_MASK             0x7FFF0000
+#define ADSP2_PMEM_ERR_ADDR_SHIFT            16
+#define ADSP2_WDT_ENA_MASK                   0xFFFFFFFD
+
+#define ADSP2_LOCK_REGION_SHIFT              16
+
 #define ADSP_MAX_STD_CTRL_SIZE               512
 
 #define WM_ADSP_ACKED_CTL_TIMEOUT_MS         100
@@ -2638,6 +2669,18 @@ int wm_adsp2_preloader_put(struct snd_kcontrol *kcontrol,
 }
 EXPORT_SYMBOL_GPL(wm_adsp2_preloader_put);
 
+static void wm_adsp_stop_watchdog(struct wm_adsp *dsp)
+{
+	switch (dsp->rev) {
+	case 0:
+	case 1:
+		return;
+	default:
+		regmap_update_bits(dsp->regmap, dsp->base + ADSP2_WATCHDOG,
+				   ADSP2_WDT_ENA_MASK, 0);
+	}
+}
+
 int wm_adsp2_early_event(struct snd_soc_dapm_widget *w,
 			 struct snd_kcontrol *kcontrol, int event,
 			 unsigned int freq)
@@ -2710,6 +2753,8 @@ int wm_adsp2_event(struct snd_soc_dapm_widget *w,
 		if (ret != 0)
 			goto err;
 
+		wm_adsp2_lock(dsp, dsp->lock_regions);
+
 		ret = regmap_update_bits(dsp->regmap,
 					 dsp->base + ADSP2_CONTROL,
 					 ADSP2_CORE_ENA | ADSP2_START,
@@ -2733,6 +2778,8 @@ int wm_adsp2_event(struct snd_soc_dapm_widget *w,
 		/* Tell the firmware to cleanup */
 		wm_adsp_signal_event_controls(dsp, WM_ADSP_FW_EVENT_SHUTDOWN);
 
+		wm_adsp_stop_watchdog(dsp);
+
 		/* Log firmware state, it can be useful for analysis */
 		switch (dsp->rev) {
 		case 0:
@@ -3624,4 +3671,94 @@ int wm_adsp_compr_copy(struct snd_compr_stream *stream, char __user *buf,
 }
 EXPORT_SYMBOL_GPL(wm_adsp_compr_copy);
 
+int wm_adsp2_lock(struct wm_adsp *dsp, unsigned int lock_regions)
+{
+	struct regmap *regmap = dsp->regmap;
+	unsigned int code0, code1, lock_reg;
+
+	if (!(lock_regions & WM_ADSP2_REGION_ALL))
+		return 0;
+
+	lock_regions &= WM_ADSP2_REGION_ALL;
+	lock_reg = dsp->base + ADSP2_LOCK_REGION_1_LOCK_REGION_0;
+
+	while (lock_regions) {
+		code0 = code1 = 0;
+		if (lock_regions & BIT(0)) {
+			code0 = ADSP2_LOCK_CODE_0;
+			code1 = ADSP2_LOCK_CODE_1;
+		}
+		if (lock_regions & BIT(1)) {
+			code0 |= ADSP2_LOCK_CODE_0 << ADSP2_LOCK_REGION_SHIFT;
+			code1 |= ADSP2_LOCK_CODE_1 << ADSP2_LOCK_REGION_SHIFT;
+		}
+		regmap_write(regmap, lock_reg, code0);
+		regmap_write(regmap, lock_reg, code1);
+		lock_regions >>= 2;
+		lock_reg += 2;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(wm_adsp2_lock);
+
+irqreturn_t wm_adsp2_bus_error(struct wm_adsp *dsp)
+{
+	unsigned int val;
+	struct regmap *regmap = dsp->regmap;
+	int ret = 0;
+
+	ret = regmap_read(regmap, dsp->base + ADSP2_LOCK_REGION_CTRL, &val);
+	if (ret) {
+		adsp_err(dsp,
+			"Failed to read Region Lock Ctrl register: %d\n", ret);
+		return IRQ_HANDLED;
+	}
+
+	if (val & ADSP2_WDT_TIMEOUT_STS_MASK) {
+		adsp_err(dsp, "watchdog timeout error\n");
+		wm_adsp_stop_watchdog(dsp);
+	}
+
+	if (val & (ADSP2_SLAVE_ERR_MASK | ADSP2_REGION_LOCK_ERR_MASK)) {
+		if (val & ADSP2_SLAVE_ERR_MASK)
+			adsp_err(dsp, "bus error: slave error\n");
+		else
+			adsp_err(dsp, "bus error: region lock error\n");
+
+		ret = regmap_read(regmap, dsp->base + ADSP2_BUS_ERR_ADDR, &val);
+		if (ret) {
+			adsp_err(dsp,
+				 "Failed to read Bus Err Addr register: %d\n",
+				 ret);
+			return IRQ_HANDLED;
+		}
+
+		adsp_err(dsp, "bus error address = 0x%x\n",
+			 val & ADSP2_BUS_ERR_ADDR_MASK);
+
+		ret = regmap_read(regmap,
+				  dsp->base + ADSP2_PMEM_ERR_ADDR_XMEM_ERR_ADDR,
+				  &val);
+		if (ret) {
+			adsp_err(dsp,
+				 "Failed to read Pmem Xmem Err Addr register: %d\n",
+				 ret);
+			return IRQ_HANDLED;
+		}
+
+		adsp_err(dsp, "xmem error address = 0x%x\n",
+			 val & ADSP2_XMEM_ERR_ADDR_MASK);
+		adsp_err(dsp, "pmem error address = 0x%x\n",
+			 (val & ADSP2_PMEM_ERR_ADDR_MASK) >>
+			 ADSP2_PMEM_ERR_ADDR_SHIFT);
+	}
+
+	regmap_update_bits(regmap, dsp->base + ADSP2_LOCK_REGION_CTRL,
+			   ADSP2_CTRL_ERR_EINT, ADSP2_CTRL_ERR_EINT);
+
+	return IRQ_HANDLED;
+}
+EXPORT_SYMBOL_GPL(wm_adsp2_bus_error);
+
 MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/codecs/wm_adsp.h b/sound/soc/codecs/wm_adsp.h
index 997227f..41cc11c 100644
--- a/sound/soc/codecs/wm_adsp.h
+++ b/sound/soc/codecs/wm_adsp.h
@@ -23,6 +23,23 @@
 #define WM_ADSP_COMPR_OK                 0
 #define WM_ADSP_COMPR_VOICE_TRIGGER      1
 
+#define WM_ADSP2_REGION_0 BIT(0)
+#define WM_ADSP2_REGION_1 BIT(1)
+#define WM_ADSP2_REGION_2 BIT(2)
+#define WM_ADSP2_REGION_3 BIT(3)
+#define WM_ADSP2_REGION_4 BIT(4)
+#define WM_ADSP2_REGION_5 BIT(5)
+#define WM_ADSP2_REGION_6 BIT(6)
+#define WM_ADSP2_REGION_7 BIT(7)
+#define WM_ADSP2_REGION_8 BIT(8)
+#define WM_ADSP2_REGION_9 BIT(9)
+#define WM_ADSP2_REGION_1_9 (WM_ADSP2_REGION_1 | \
+		WM_ADSP2_REGION_2 | WM_ADSP2_REGION_3 | \
+		WM_ADSP2_REGION_4 | WM_ADSP2_REGION_5 | \
+		WM_ADSP2_REGION_6 | WM_ADSP2_REGION_7 | \
+		WM_ADSP2_REGION_8 | WM_ADSP2_REGION_9)
+#define WM_ADSP2_REGION_ALL (WM_ADSP2_REGION_0 | WM_ADSP2_REGION_1_9)
+
 struct wm_adsp_region {
 	int type;
 	unsigned int base;
@@ -76,6 +93,8 @@ struct wm_adsp {
 
 	struct mutex pwr_lock;
 
+	unsigned int lock_regions;
+
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *debugfs_root;
 	char *wmfw_file_name;
@@ -114,6 +133,10 @@ int wm_adsp1_event(struct snd_soc_dapm_widget *w,
 int wm_adsp2_early_event(struct snd_soc_dapm_widget *w,
 			 struct snd_kcontrol *kcontrol, int event,
 			 unsigned int freq);
+
+int wm_adsp2_lock(struct wm_adsp *adsp, unsigned int regions);
+irqreturn_t wm_adsp2_bus_error(struct wm_adsp *adsp);
+
 int wm_adsp2_event(struct snd_soc_dapm_widget *w,
 		   struct snd_kcontrol *kcontrol, int event);
 
-- 
1.9.1
