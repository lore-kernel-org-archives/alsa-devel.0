From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm_adsp: Fix enum ctl accesses in a wrong type" to the asoc tree
Date: Tue, 01 Mar 2016 12:19:44 +0900
Message-ID: <E1aaaqe-0007yv-7J@finisterre>
References: <1456765278-5435-10-git-send-email-tiwai@suse.de>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1456765278-5435-10-git-send-email-tiwai@suse.de>
Sender: stable-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>, stable@vger.kernel.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm_adsp: Fix enum ctl accesses in a wrong type

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

>From 15c665700bf6f4543f003ac0fbb1e9ec692e93f2 Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Mon, 29 Feb 2016 18:01:18 +0100
Subject: [PATCH] ASoC: wm_adsp: Fix enum ctl accesses in a wrong type

The firmware ctls like "DSP1 Firmware" in wm_adsp codec driver are
enum, while the current driver accesses wrongly via
value.integer.value[].  They have to be via value.enumerated.item[]
instead.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 sound/soc/codecs/wm_adsp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 33806d487b8a..b9195b9c2b05 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -586,7 +586,7 @@ static int wm_adsp_fw_get(struct snd_kcontrol *kcontrol,
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	struct wm_adsp *dsp = snd_soc_codec_get_drvdata(codec);
 
-	ucontrol->value.integer.value[0] = dsp[e->shift_l].fw;
+	ucontrol->value.enumerated.item[0] = dsp[e->shift_l].fw;
 
 	return 0;
 }
@@ -599,10 +599,10 @@ static int wm_adsp_fw_put(struct snd_kcontrol *kcontrol,
 	struct wm_adsp *dsp = snd_soc_codec_get_drvdata(codec);
 	int ret = 0;
 
-	if (ucontrol->value.integer.value[0] == dsp[e->shift_l].fw)
+	if (ucontrol->value.enumerated.item[0] == dsp[e->shift_l].fw)
 		return 0;
 
-	if (ucontrol->value.integer.value[0] >= WM_ADSP_NUM_FW)
+	if (ucontrol->value.enumerated.item[0] >= WM_ADSP_NUM_FW)
 		return -EINVAL;
 
 	mutex_lock(&dsp[e->shift_l].pwr_lock);
@@ -610,7 +610,7 @@ static int wm_adsp_fw_put(struct snd_kcontrol *kcontrol,
 	if (dsp[e->shift_l].running || dsp[e->shift_l].compr)
 		ret = -EBUSY;
 	else
-		dsp[e->shift_l].fw = ucontrol->value.integer.value[0];
+		dsp[e->shift_l].fw = ucontrol->value.enumerated.item[0];
 
 	mutex_unlock(&dsp[e->shift_l].pwr_lock);
 
-- 
2.7.0
