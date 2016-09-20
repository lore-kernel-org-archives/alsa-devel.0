From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 3/7] ASoC: wm_adsp: Separate concept of booted
	and running
Date: Tue, 20 Sep 2016 13:52:32 +0100
Message-ID: <1474375956-10443-4-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1474375956-10443-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 45025266CF7
 for <alsa-devel@alsa-project.org>; Tue, 20 Sep 2016 14:52:37 +0200 (CEST)
In-Reply-To: <1474375956-10443-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Currently the wm_adsp driver has a flag that indicates the DSP is
"running", this flag is used to gate access to the hardware.  However this
flag is actually set in the firmware download thread after the firmware has
been downloaded, but this is before the core is actually started running,
so really it currently indicates that the core has been booted and is
perhaps running.

This patch clearly separates out the concepts of booted (firmware is
downloaded) and running (code is executing on the DSP) within the wm_adsp
driver.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_adsp.c | 36 +++++++++++++++++++++++++-----------
 sound/soc/codecs/wm_adsp.h |  2 ++
 2 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 21fbe7d..ae2f2b6 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -480,7 +480,7 @@ static ssize_t wm_adsp_debugfs_wmfw_read(struct file *file,
 
 	mutex_lock(&dsp->pwr_lock);
 
-	if (!dsp->wmfw_file_name || !dsp->running)
+	if (!dsp->wmfw_file_name || !dsp->booted)
 		ret = 0;
 	else
 		ret = simple_read_from_buffer(user_buf, count, ppos,
@@ -500,7 +500,7 @@ static ssize_t wm_adsp_debugfs_bin_read(struct file *file,
 
 	mutex_lock(&dsp->pwr_lock);
 
-	if (!dsp->bin_file_name || !dsp->running)
+	if (!dsp->bin_file_name || !dsp->booted)
 		ret = 0;
 	else
 		ret = simple_read_from_buffer(user_buf, count, ppos,
@@ -554,6 +554,9 @@ static void wm_adsp2_init_debugfs(struct wm_adsp *dsp,
 	if (!root)
 		goto err;
 
+	if (!debugfs_create_bool("booted", S_IRUGO, root, &dsp->booted))
+		goto err;
+
 	if (!debugfs_create_bool("running", S_IRUGO, root, &dsp->running))
 		goto err;
 
@@ -637,7 +640,7 @@ static int wm_adsp_fw_put(struct snd_kcontrol *kcontrol,
 
 	mutex_lock(&dsp[e->shift_l].pwr_lock);
 
-	if (dsp[e->shift_l].running || dsp[e->shift_l].compr)
+	if (dsp[e->shift_l].booted || dsp[e->shift_l].compr)
 		ret = -EBUSY;
 	else
 		dsp[e->shift_l].fw = ucontrol->value.enumerated.item[0];
@@ -789,7 +792,7 @@ static int wm_coeff_put(struct snd_kcontrol *kctl,
 	memcpy(ctl->cache, p, ctl->len);
 
 	ctl->set = 1;
-	if (ctl->enabled)
+	if (ctl->enabled && ctl->dsp->booted)
 		ret = wm_coeff_write_control(ctl, p, ctl->len);
 
 	mutex_unlock(&ctl->dsp->pwr_lock);
@@ -811,7 +814,7 @@ static int wm_coeff_tlv_put(struct snd_kcontrol *kctl,
 		ret = -EFAULT;
 	} else {
 		ctl->set = 1;
-		if (ctl->enabled)
+		if (ctl->enabled && ctl->dsp->booted)
 			ret = wm_coeff_write_control(ctl, ctl->cache, size);
 	}
 
@@ -871,12 +874,12 @@ static int wm_coeff_get(struct snd_kcontrol *kctl,
 	mutex_lock(&ctl->dsp->pwr_lock);
 
 	if (ctl->flags & WMFW_CTL_FLAG_VOLATILE) {
-		if (ctl->enabled)
+		if (ctl->enabled && ctl->dsp->booted)
 			ret = wm_coeff_read_control(ctl, p, ctl->len);
 		else
 			ret = -EPERM;
 	} else {
-		if (!ctl->flags && ctl->enabled)
+		if (!ctl->flags && ctl->enabled && ctl->dsp->booted)
 			ret = wm_coeff_read_control(ctl, ctl->cache, ctl->len);
 
 		memcpy(p, ctl->cache, ctl->len);
@@ -898,12 +901,12 @@ static int wm_coeff_tlv_get(struct snd_kcontrol *kctl,
 	mutex_lock(&ctl->dsp->pwr_lock);
 
 	if (ctl->flags & WMFW_CTL_FLAG_VOLATILE) {
-		if (ctl->enabled)
+		if (ctl->enabled && ctl->dsp->booted)
 			ret = wm_coeff_read_control(ctl, ctl->cache, size);
 		else
 			ret = -EPERM;
 	} else {
-		if (!ctl->flags && ctl->enabled)
+		if (!ctl->flags && ctl->enabled && ctl->dsp->booted)
 			ret = wm_coeff_read_control(ctl, ctl->cache, size);
 	}
 
@@ -2166,13 +2169,20 @@ int wm_adsp1_event(struct snd_soc_dapm_widget *w,
 		if (ret != 0)
 			goto err_ena;
 
+		dsp->booted = true;
+
 		/* Start the core running */
 		regmap_update_bits(dsp->regmap, dsp->base + ADSP1_CONTROL_30,
 				   ADSP1_CORE_ENA | ADSP1_START,
 				   ADSP1_CORE_ENA | ADSP1_START);
+
+		dsp->running = true;
 		break;
 
 	case SND_SOC_DAPM_PRE_PMD:
+		dsp->running = false;
+		dsp->booted = false;
+
 		/* Halt the core */
 		regmap_update_bits(dsp->regmap, dsp->base + ADSP1_CONTROL_30,
 				   ADSP1_CORE_ENA | ADSP1_START, 0);
@@ -2275,7 +2285,7 @@ static void wm_adsp2_boot_work(struct work_struct *work)
 	if (ret != 0)
 		goto err_ena;
 
-	dsp->running = true;
+	dsp->booted = true;
 
 	mutex_unlock(&dsp->pwr_lock);
 
@@ -2336,7 +2346,7 @@ int wm_adsp2_event(struct snd_soc_dapm_widget *w,
 	case SND_SOC_DAPM_POST_PMU:
 		flush_work(&dsp->boot_work);
 
-		if (!dsp->running)
+		if (!dsp->booted)
 			return -EIO;
 
 		ret = regmap_update_bits(dsp->regmap,
@@ -2346,6 +2356,8 @@ int wm_adsp2_event(struct snd_soc_dapm_widget *w,
 		if (ret != 0)
 			goto err;
 
+		dsp->running = true;
+
 		mutex_lock(&dsp->pwr_lock);
 
 		if (wm_adsp_fw[dsp->fw].num_caps != 0)
@@ -2365,7 +2377,9 @@ int wm_adsp2_event(struct snd_soc_dapm_widget *w,
 
 		dsp->fw_id = 0;
 		dsp->fw_id_version = 0;
+
 		dsp->running = false;
+		dsp->booted = false;
 
 		regmap_update_bits(dsp->regmap, dsp->base + ADSP2_CONTROL,
 				   ADSP2_CORE_ENA | ADSP2_START, 0);
diff --git a/sound/soc/codecs/wm_adsp.h b/sound/soc/codecs/wm_adsp.h
index a3b1b7e..228b1f9 100644
--- a/sound/soc/codecs/wm_adsp.h
+++ b/sound/soc/codecs/wm_adsp.h
@@ -61,6 +61,8 @@ struct wm_adsp {
 
 	int fw;
 	int fw_ver;
+
+	bool booted;
 	bool running;
 
 	struct list_head ctl_list;
-- 
2.1.4
