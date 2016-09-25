From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm_adsp: Move control cache sync out of
	preloader" to the asoc tree
Date: Sat, 24 Sep 2016 22:58:27 -0700
Message-ID: <E1bo2SJ-0002xI-3T@finisterre>
References: <1474375956-10443-5-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E08712665B6
 for <alsa-devel@alsa-project.org>; Sun, 25 Sep 2016 07:58:40 +0200 (CEST)
In-Reply-To: <1474375956-10443-5-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm_adsp: Move control cache sync out of preloader

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

>From cef45771c141fdccebe4cb7e0ce79f4687275494 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Date: Tue, 20 Sep 2016 13:52:33 +0100
Subject: [PATCH] ASoC: wm_adsp: Move control cache sync out of preloader

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
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm_adsp.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index ae2f2b6e82ed..24485ec5866f 100644
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
2.9.3
