From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5682: Fix the boost volume at the
	begining of playback" to the asoc tree
Date: Tue, 18 Sep 2018 18:45:10 +0100 (BST)
Message-ID: <20180918174510.C3CDD440078@finisterre.ee.mobilebroadband>
References: <1537271498-5688-1-git-send-email-shumingf@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 9FB5C2678AA
 for <alsa-devel@alsa-project.org>; Tue, 18 Sep 2018 19:45:13 +0200 (CEST)
In-Reply-To: <1537271498-5688-1-git-send-email-shumingf@realtek.com>
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

   ASoC: rt5682: Fix the boost volume at the begining of playback

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

>From 28b20dde5e1c943ab899549a655ac4935cffccbb Mon Sep 17 00:00:00 2001
From: Shuming Fan <shumingf@realtek.com>
Date: Tue, 18 Sep 2018 19:51:38 +0800
Subject: [PATCH] ASoC: rt5682: Fix the boost volume at the begining of
 playback

This patch fixed the boost volume at the begining of playback
while DAC volume set to lower level.

Signed-off-by: Shuming Fan <shumingf@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5682.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/codecs/rt5682.c b/sound/soc/codecs/rt5682.c
index 2725eb72fb1b..18099668e960 100644
--- a/sound/soc/codecs/rt5682.c
+++ b/sound/soc/codecs/rt5682.c
@@ -68,6 +68,7 @@ struct rt5682_priv {
 
 static const struct reg_sequence patch_list[] = {
 	{0x01c1, 0x1000},
+	{RT5682_DAC_ADC_DIG_VOL1, 0xa020},
 };
 
 static const struct reg_default rt5682_reg[] = {
@@ -1468,6 +1469,8 @@ static int rt5682_hp_event(struct snd_soc_dapm_widget *w,
 			RT5682_HP_CTRL_2, 0x6000);
 		snd_soc_component_update_bits(component,
 			RT5682_DEPOP_1, 0x60, 0x60);
+		snd_soc_component_update_bits(component,
+			RT5682_DAC_ADC_DIG_VOL1, 0x00c0, 0x0080);
 		break;
 
 	case SND_SOC_DAPM_POST_PMD:
@@ -1475,6 +1478,8 @@ static int rt5682_hp_event(struct snd_soc_dapm_widget *w,
 			RT5682_DEPOP_1, 0x60, 0x0);
 		snd_soc_component_write(component,
 			RT5682_HP_CTRL_2, 0x0000);
+		snd_soc_component_update_bits(component,
+			RT5682_DAC_ADC_DIG_VOL1, 0x00c0, 0x0000);
 		break;
 
 	default:
-- 
2.19.0
