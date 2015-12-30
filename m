From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm5110: Use helper function to lock the
	DAPM mutex" to the asoc tree
Date: Wed, 30 Dec 2015 18:05:17 +0000
Message-ID: <E1aEL7d-0007Lq-R8@debutante>
References: <1451406314-13973-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9268E2659F8
 for <alsa-devel@alsa-project.org>; Wed, 30 Dec 2015 19:05:24 +0100 (CET)
In-Reply-To: <1451406314-13973-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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

   ASoC: wm5110: Use helper function to lock the DAPM mutex

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

>From e116615b80bb89484ad4d55c752a00dd6379f95c Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Date: Tue, 29 Dec 2015 16:25:14 +0000
Subject: [PATCH] ASoC: wm5110: Use helper function to lock the DAPM mutex

A couple of call sites were missed when the snd_soc_dapm_mutex_lock
function was added this patch fixes those up.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm5110.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index e93e5420943e..605daffebc9c 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -439,18 +439,17 @@ static int wm5110_in_pga_get(struct snd_kcontrol *kcontrol,
 {
 	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
-	struct snd_soc_card *card = dapm->card;
 	int ret;
 
 	/*
 	 * PGA Volume is also used as part of the enable sequence, so
 	 * usage of it should be avoided whilst that is running.
 	 */
-	mutex_lock_nested(&card->dapm_mutex, SND_SOC_DAPM_CLASS_RUNTIME);
+	snd_soc_dapm_mutex_lock(dapm);
 
 	ret = snd_soc_get_volsw_range(kcontrol, ucontrol);
 
-	mutex_unlock(&card->dapm_mutex);
+	snd_soc_dapm_mutex_unlock(dapm);
 
 	return ret;
 }
@@ -460,18 +459,17 @@ static int wm5110_in_pga_put(struct snd_kcontrol *kcontrol,
 {
 	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
-	struct snd_soc_card *card = dapm->card;
 	int ret;
 
 	/*
 	 * PGA Volume is also used as part of the enable sequence, so
 	 * usage of it should be avoided whilst that is running.
 	 */
-	mutex_lock_nested(&card->dapm_mutex, SND_SOC_DAPM_CLASS_RUNTIME);
+	snd_soc_dapm_mutex_lock(dapm);
 
 	ret = snd_soc_put_volsw_range(kcontrol, ucontrol);
 
-	mutex_unlock(&card->dapm_mutex);
+	snd_soc_dapm_mutex_unlock(dapm);
 
 	return ret;
 }
-- 
2.6.2
