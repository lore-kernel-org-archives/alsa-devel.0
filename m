From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm_adsp: Add locking to DSP firmware
	controls" to the asoc tree
Date: Sat, 12 Dec 2015 23:07:27 +0000
Message-ID: <E1a7tGB-0002dm-Q0@finisterre>
References: <1449590917-21170-3-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4AB322606E5
 for <alsa-devel@alsa-project.org>; Sun, 13 Dec 2015 00:07:37 +0100 (CET)
In-Reply-To: <1449590917-21170-3-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm_adsp: Add locking to DSP firmware controls

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

>From 168d10e74c4efd945a37adeb134f096505e62b49 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Date: Tue, 8 Dec 2015 16:08:27 +0000
Subject: [PATCH] ASoC: wm_adsp: Add locking to DSP firmware controls

Locking is currently missing from the DSP firmware controls, which can
lead to some race conditions if the controls are accessed as the DSP
powers up or down. This patch adds them to the new power lock.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm_adsp.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 3a314f2..b083642 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -597,14 +597,19 @@ static int wm_coeff_put(struct snd_kcontrol *kctl,
 {
 	struct wm_coeff_ctl *ctl = (struct wm_coeff_ctl *)kctl->private_value;
 	char *p = ucontrol->value.bytes.data;
+	int ret = 0;
+
+	mutex_lock(&ctl->dsp->pwr_lock);
 
 	memcpy(ctl->cache, p, ctl->len);
 
 	ctl->set = 1;
-	if (!ctl->enabled)
-		return 0;
+	if (ctl->enabled)
+		ret = wm_coeff_write_control(ctl, p, ctl->len);
 
-	return wm_coeff_write_control(ctl, p, ctl->len);
+	mutex_unlock(&ctl->dsp->pwr_lock);
+
+	return ret;
 }
 
 static int wm_coeff_read_control(struct wm_coeff_ctl *ctl,
@@ -651,17 +656,22 @@ static int wm_coeff_get(struct snd_kcontrol *kctl,
 {
 	struct wm_coeff_ctl *ctl = (struct wm_coeff_ctl *)kctl->private_value;
 	char *p = ucontrol->value.bytes.data;
+	int ret = 0;
+
+	mutex_lock(&ctl->dsp->pwr_lock);
 
 	if (ctl->flags & WMFW_CTL_FLAG_VOLATILE) {
 		if (ctl->enabled)
-			return wm_coeff_read_control(ctl, p, ctl->len);
+			ret = wm_coeff_read_control(ctl, p, ctl->len);
 		else
-			return -EPERM;
+			ret = -EPERM;
+	} else {
+		memcpy(p, ctl->cache, ctl->len);
 	}
 
-	memcpy(p, ctl->cache, ctl->len);
+	mutex_unlock(&ctl->dsp->pwr_lock);
 
-	return 0;
+	return ret;
 }
 
 struct wmfw_ctl_work {
-- 
2.6.4
