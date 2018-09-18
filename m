From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5682: Remove HP volume control" to
	the asoc tree
Date: Tue, 18 Sep 2018 18:45:26 +0100 (BST)
Message-ID: <20180918174526.DA6D5440078@finisterre.ee.mobilebroadband>
References: <1537271484-5638-1-git-send-email-shumingf@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id E063C2678AD
 for <alsa-devel@alsa-project.org>; Tue, 18 Sep 2018 19:45:29 +0200 (CEST)
In-Reply-To: <1537271484-5638-1-git-send-email-shumingf@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shuming Fan <shumingf@realtek.com>
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, albertchen@realtek.com, broonie@kernel.org, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5682: Remove HP volume control

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 3f24f37adbc9a1059420a9c8f857e3490a4bce5e Mon Sep 17 00:00:00 2001
From: Shuming Fan <shumingf@realtek.com>
Date: Tue, 18 Sep 2018 19:51:24 +0800
Subject: [PATCH] ASoC: rt5682: Remove HP volume control

This patch removed Headphone Playback Volume control.
Due to codec settings, we don't want the user to change HP analog gain.
The user could use DAC1 Playback Volume control to
change playback volume.

Signed-off-by: Shuming Fan <shumingf@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5682.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/sound/soc/codecs/rt5682.c b/sound/soc/codecs/rt5682.c
index afe7d5b19313..fad0bed82d79 100644
--- a/sound/soc/codecs/rt5682.c
+++ b/sound/soc/codecs/rt5682.c
@@ -749,7 +749,6 @@ static bool rt5682_readable_register(struct device *dev, unsigned int reg)
 	}
 }
 
-static const DECLARE_TLV_DB_SCALE(hp_vol_tlv, -2250, 150, 0);
 static const DECLARE_TLV_DB_SCALE(dac_vol_tlv, -6525, 75, 0);
 static const DECLARE_TLV_DB_SCALE(adc_vol_tlv, -1725, 75, 0);
 static const DECLARE_TLV_DB_SCALE(adc_bst_tlv, 0, 1200, 0);
@@ -1108,10 +1107,6 @@ static void rt5682_jack_detect_handler(struct work_struct *work)
 }
 
 static const struct snd_kcontrol_new rt5682_snd_controls[] = {
-	/* Headphone Output Volume */
-	SOC_DOUBLE_R_TLV("Headphone Playback Volume", RT5682_HPL_GAIN,
-		RT5682_HPR_GAIN, RT5682_G_HP_SFT, 15, 1, hp_vol_tlv),
-
 	/* DAC Digital Volume */
 	SOC_DOUBLE_TLV("DAC1 Playback Volume", RT5682_DAC1_DIG_VOL,
 		RT5682_L_VOL_SFT + 1, RT5682_R_VOL_SFT + 1, 86, 0, dac_vol_tlv),
-- 
2.19.0
