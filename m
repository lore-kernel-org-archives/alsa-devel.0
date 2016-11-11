From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm_adsp: Signal firmware shutdown through event control" to the asoc tree
Date: Fri, 11 Nov 2016 16:01:08 +0000
Message-ID: <E1c5EGK-0003jd-P5@finisterre>
References: <1478711658-23696-4-git-send-email-rf@opensource.wolfsonmicro.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1478711658-23696-4-git-send-email-rf@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: Mark Brown <broonie@kernel.org>broonie@kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm_adsp: Signal firmware shutdown through event control

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

>From f4f0c4c60c3959a8f3650850b799049161732e91 Mon Sep 17 00:00:00 2001
From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Date: Wed, 9 Nov 2016 17:14:17 +0000
Subject: [PATCH] ASoC: wm_adsp: Signal firmware shutdown through event control

If the firmware has any system event signalling controls, signal
them during DSP PRE_PMD to tell the firmware it is about to be stopped.

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm_adsp.c | 114 +++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/wmfw.h    |   3 ++
 2 files changed, 117 insertions(+)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 7320fcacd86a..07cf7cb93301 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -162,6 +162,14 @@
 
 #define ADSP_MAX_STD_CTRL_SIZE               512
 
+#define WM_ADSP_ACKED_CTL_TIMEOUT_MS         100
+#define WM_ADSP_ACKED_CTL_N_QUICKPOLLS       10
+
+/*
+ * Event control messages
+ */
+#define WM_ADSP_FW_EVENT_SHUTDOWN            0x000001
+
 struct wm_adsp_buf {
 	struct list_head list;
 	void *buf;
@@ -739,6 +747,66 @@ static int wm_coeff_info(struct snd_kcontrol *kctl,
 	return 0;
 }
 
+static int wm_coeff_write_acked_control(struct wm_coeff_ctl *ctl,
+					unsigned int event_id)
+{
+	struct wm_adsp *dsp = ctl->dsp;
+	u32 val = cpu_to_be32(event_id);
+	unsigned int reg;
+	int i, ret;
+
+	ret = wm_coeff_base_reg(ctl, &reg);
+	if (ret)
+		return ret;
+
+	adsp_dbg(dsp, "Sending 0x%x to acked control alg 0x%x %s:0x%x\n",
+		 event_id, ctl->alg_region.alg,
+		 wm_adsp_mem_region_name(ctl->alg_region.type), ctl->offset);
+
+	ret = regmap_raw_write(dsp->regmap, reg, &val, sizeof(val));
+	if (ret) {
+		adsp_err(dsp, "Failed to write %x: %d\n", reg, ret);
+		return ret;
+	}
+
+	/*
+	 * Poll for ack, we initially poll at ~1ms intervals for firmwares
+	 * that respond quickly, then go to ~10ms polls. A firmware is unlikely
+	 * to ack instantly so we do the first 1ms delay before reading the
+	 * control to avoid a pointless bus transaction
+	 */
+	for (i = 0; i < WM_ADSP_ACKED_CTL_TIMEOUT_MS;) {
+		switch (i) {
+		case 0 ... WM_ADSP_ACKED_CTL_N_QUICKPOLLS - 1:
+			usleep_range(1000, 2000);
+			i++;
+			break;
+		default:
+			usleep_range(10000, 20000);
+			i += 10;
+			break;
+		}
+
+		ret = regmap_raw_read(dsp->regmap, reg, &val, sizeof(val));
+		if (ret) {
+			adsp_err(dsp, "Failed to read %x: %d\n", reg, ret);
+			return ret;
+		}
+
+		if (val == 0) {
+			adsp_dbg(dsp, "Acked control ACKED at poll %u\n", i);
+			return 0;
+		}
+	}
+
+	adsp_warn(dsp, "Acked control @0x%x alg:0x%x %s:0x%x timed out\n",
+		  reg, ctl->alg_region.alg,
+		  wm_adsp_mem_region_name(ctl->alg_region.type),
+		  ctl->offset);
+
+	return -ETIMEDOUT;
+}
+
 static int wm_coeff_write_control(struct wm_coeff_ctl *ctl,
 				  const void *buf, size_t len)
 {
@@ -1034,6 +1102,24 @@ static int wm_coeff_sync_controls(struct wm_adsp *dsp)
 	return 0;
 }
 
+static void wm_adsp_signal_event_controls(struct wm_adsp *dsp,
+					  unsigned int event)
+{
+	struct wm_coeff_ctl *ctl;
+	int ret;
+
+	list_for_each_entry(ctl, &dsp->ctl_list, list) {
+		if (ctl->type != WMFW_CTL_TYPE_HOSTEVENT)
+			continue;
+
+		ret = wm_coeff_write_acked_control(ctl, event);
+		if (ret)
+			adsp_warn(dsp,
+				  "Failed to send 0x%x event to alg 0x%x (%d)\n",
+				  event, ctl->alg_region.alg, ret);
+	}
+}
+
 static void wm_adsp_ctl_work(struct work_struct *work)
 {
 	struct wmfw_ctl_work *ctl_work = container_of(work,
@@ -1307,6 +1393,21 @@ static inline void wm_coeff_parse_coeff(struct wm_adsp *dsp, const u8 **data,
 	adsp_dbg(dsp, "\tALSA control len: %#x\n", blk->len);
 }
 
+static int wm_adsp_check_coeff_flags(struct wm_adsp *dsp,
+				const struct wm_coeff_parsed_coeff *coeff_blk,
+				unsigned int f_required,
+				unsigned int f_illegal)
+{
+	if ((coeff_blk->flags & f_illegal) ||
+	    ((coeff_blk->flags & f_required) != f_required)) {
+		adsp_err(dsp, "Illegal flags 0x%x for control type 0x%x\n",
+			 coeff_blk->flags, coeff_blk->ctl_type);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int wm_adsp_parse_coeff(struct wm_adsp *dsp,
 			       const struct wmfw_region *region)
 {
@@ -1323,6 +1424,16 @@ static int wm_adsp_parse_coeff(struct wm_adsp *dsp,
 		switch (coeff_blk.ctl_type) {
 		case SNDRV_CTL_ELEM_TYPE_BYTES:
 			break;
+		case WMFW_CTL_TYPE_HOSTEVENT:
+			ret = wm_adsp_check_coeff_flags(dsp, &coeff_blk,
+						WMFW_CTL_FLAG_SYS |
+						WMFW_CTL_FLAG_VOLATILE |
+						WMFW_CTL_FLAG_WRITEABLE |
+						WMFW_CTL_FLAG_READABLE,
+						0);
+			if (ret)
+				return -EINVAL;
+			break;
 		default:
 			adsp_err(dsp, "Unknown control type: %d\n",
 				 coeff_blk.ctl_type);
@@ -2400,6 +2511,9 @@ int wm_adsp2_event(struct snd_soc_dapm_widget *w,
 		break;
 
 	case SND_SOC_DAPM_PRE_PMD:
+		/* Tell the firmware to cleanup */
+		wm_adsp_signal_event_controls(dsp, WM_ADSP_FW_EVENT_SHUTDOWN);
+
 		/* Log firmware state, it can be useful for analysis */
 		wm_adsp2_show_fw_status(dsp);
 
diff --git a/sound/soc/codecs/wmfw.h b/sound/soc/codecs/wmfw.h
index 7613d60d62ea..892fc7490f3b 100644
--- a/sound/soc/codecs/wmfw.h
+++ b/sound/soc/codecs/wmfw.h
@@ -26,6 +26,9 @@
 #define WMFW_CTL_FLAG_WRITEABLE   0x0002
 #define WMFW_CTL_FLAG_READABLE    0x0001
 
+/* Non-ALSA coefficient types start at 0x1000 */
+#define WMFW_CTL_TYPE_HOSTEVENT   0x1001 /* event control */
+
 struct wmfw_header {
 	char magic[4];
 	__le32 len;
-- 
2.10.2
