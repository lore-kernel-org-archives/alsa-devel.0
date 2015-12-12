From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm_adsp: Add power lock for firmware
	change control" to the asoc tree
Date: Sat, 12 Dec 2015 23:07:31 +0000
Message-ID: <E1a7tGF-0002ei-Ar@finisterre>
References: <1449590917-21170-4-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D02DE264F1D
 for <alsa-devel@alsa-project.org>; Sun, 13 Dec 2015 00:07:38 +0100 (CET)
In-Reply-To: <1449590917-21170-4-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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

   ASoC: wm_adsp: Add power lock for firmware change control

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

>From d27c5e155c69a4c45e9833fbf66aa580dcd01624 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Date: Tue, 8 Dec 2015 16:08:28 +0000
Subject: [PATCH] ASoC: wm_adsp: Add power lock for firmware change control

We should hold the DSP power lock whilst changing the firmware since we
need to check if it is running first.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm_adsp.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 19f0593..fd85a8c 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -451,6 +451,7 @@ static int wm_adsp_fw_put(struct snd_kcontrol *kcontrol,
 	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	struct wm_adsp *dsp = snd_soc_codec_get_drvdata(codec);
+	int ret = 0;
 
 	if (ucontrol->value.integer.value[0] == dsp[e->shift_l].fw)
 		return 0;
@@ -458,12 +459,16 @@ static int wm_adsp_fw_put(struct snd_kcontrol *kcontrol,
 	if (ucontrol->value.integer.value[0] >= WM_ADSP_NUM_FW)
 		return -EINVAL;
 
+	mutex_lock(&dsp[e->shift_l].pwr_lock);
+
 	if (dsp[e->shift_l].running)
-		return -EBUSY;
+		ret = -EBUSY;
+	else
+		dsp[e->shift_l].fw = ucontrol->value.integer.value[0];
 
-	dsp[e->shift_l].fw = ucontrol->value.integer.value[0];
+	mutex_unlock(&dsp[e->shift_l].pwr_lock);
 
-	return 0;
+	return ret;
 }
 
 static const struct soc_enum wm_adsp_fw_enum[] = {
-- 
2.6.4
