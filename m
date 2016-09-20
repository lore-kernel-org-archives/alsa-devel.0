From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 4/7] ASoC: wm_adsp: Move control cache sync out
	of preloader
Date: Tue, 20 Sep 2016 13:52:33 +0100
Message-ID: <1474375956-10443-5-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1474375956-10443-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 1F3DB266D04
 for <alsa-devel@alsa-project.org>; Tue, 20 Sep 2016 14:52:41 +0200 (CEST)
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

As part of the work to download firmware before the audio path is brought
up the DSP will be put into a low power state between downloading firmware
to the core and starting it running. This will mean that the firmware ALSA
controls are not accessible in the hardware during this period of time.

To prepare for this change we gate access to the hardware in the ALSA
control handlers on the DSP being running rather than simply booted and
move the synchronisation of the control caches out of the preloader delayed
work and into the main DAPM thread after the DSP will have been brought out
of its low power state.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_adsp.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index ae2f2b6..24485ec 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -792,7 +792,7 @@ static int wm_coeff_put(struct snd_kcontrol *kctl,
 	memcpy(ctl->cache, p, ctl->len);
 
 	ctl->set = 1;
-	if (ctl->enabled && ctl->dsp->booted)
+	if (ctl->enabled && ctl->dsp->running)
 		ret = wm_coeff_write_control(ctl, p, ctl->len);
 
 	mutex_unlock(&ctl->dsp->pwr_lock);
@@ -814,7 +814,7 @@ static int wm_coeff_tlv_put(struct snd_kcontrol *kctl,
 		ret = -EFAULT;
 	} else {
 		ctl->set = 1;
-		if (ctl->enabled && ctl->dsp->booted)
+		if (ctl->enabled && ctl->dsp->running)
 			ret = wm_coeff_write_control(ctl, ctl->cache, size);
 	}
 
@@ -874,12 +874,12 @@ static int wm_coeff_get(struct snd_kcontrol *kctl,
 	mutex_lock(&ctl->dsp->pwr_lock);
 
 	if (ctl->flags & WMFW_CTL_FLAG_VOLATILE) {
-		if (ctl->enabled && ctl->dsp->booted)
+		if (ctl->enabled && ctl->dsp->running)
 			ret = wm_coeff_read_control(ctl, p, ctl->len);
 		else
 			ret = -EPERM;
 	} else {
-		if (!ctl->flags && ctl->enabled && ctl->dsp->booted)
+		if (!ctl->flags && ctl->enabled && ctl->dsp->running)
 			ret = wm_coeff_read_control(ctl, ctl->cache, ctl->len);
 
 		memcpy(p, ctl->cache, ctl->len);
@@ -901,12 +901,12 @@ static int wm_coeff_tlv_get(struct snd_kcontrol *kctl,
 	mutex_lock(&ctl->dsp->pwr_lock);
 
 	if (ctl->flags & WMFW_CTL_FLAG_VOLATILE) {
-		if (ctl->enabled && ctl->dsp->booted)
+		if (ctl->enabled && ctl->dsp->running)
 			ret = wm_coeff_read_control(ctl, ctl->cache, size);
 		else
 			ret = -EPERM;
 	} else {
-		if (!ctl->flags && ctl->enabled && ctl->dsp->booted)
+		if (!ctl->flags && ctl->enabled && ctl->dsp->running)
 			ret = wm_coeff_read_control(ctl, ctl->cache, size);
 	}
 
@@ -2280,11 +2280,6 @@ static void wm_adsp2_boot_work(struct work_struct *work)
 	if (ret != 0)
 		goto err_ena;
 
-	/* Sync set controls */
-	ret = wm_coeff_sync_controls(dsp);
-	if (ret != 0)
-		goto err_ena;
-
 	dsp->booted = true;
 
 	mutex_unlock(&dsp->pwr_lock);
@@ -2349,6 +2344,11 @@ int wm_adsp2_event(struct snd_soc_dapm_widget *w,
 		if (!dsp->booted)
 			return -EIO;
 
+		/* Sync set controls */
+		ret = wm_coeff_sync_controls(dsp);
+		if (ret != 0)
+			goto err;
+
 		ret = regmap_update_bits(dsp->regmap,
 					 dsp->base + ADSP2_CONTROL,
 					 ADSP2_CORE_ENA | ADSP2_START,
-- 
2.1.4
