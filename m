From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5663: Remove the boost volume in the
	beginning of playback" to the asoc tree
Date: Thu, 20 Sep 2018 18:35:13 +0100 (BST)
Message-ID: <20180920173513.4F373440078@finisterre.ee.mobilebroadband>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id CF4972677BB
 for <alsa-devel@alsa-project.org>; Thu, 20 Sep 2018 19:35:16 +0200 (CEST)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oder Chiou <oder_chiou@realtek.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5663: Remove the boost volume in the beginning of playback

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

>From fc795bf7224efda8c35e505966c2757856064247 Mon Sep 17 00:00:00 2001
From: Oder Chiou <oder_chiou@realtek.com>
Date: Wed, 19 Sep 2018 09:56:47 +0800
Subject: [PATCH] ASoC: rt5663: Remove the boost volume in the beginning of
 playback

The patch removes the boost volume in the beginning of playback while the
DAC volume set to lower.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5663.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5663.c b/sound/soc/codecs/rt5663.c
index 9bd24ad42240..2444fad7c2df 100644
--- a/sound/soc/codecs/rt5663.c
+++ b/sound/soc/codecs/rt5663.c
@@ -72,6 +72,7 @@ struct rt5663_priv {
 static const struct reg_sequence rt5663_patch_list[] = {
 	{ 0x002a, 0x8020 },
 	{ 0x0086, 0x0028 },
+	{ 0x0100, 0xa020 },
 	{ 0x0117, 0x0f28 },
 	{ 0x02fb, 0x8089 },
 };
@@ -580,7 +581,7 @@ static const struct reg_default rt5663_reg[] = {
 	{ 0x00fd, 0x0001 },
 	{ 0x00fe, 0x10ec },
 	{ 0x00ff, 0x6406 },
-	{ 0x0100, 0xa0a0 },
+	{ 0x0100, 0xa020 },
 	{ 0x0108, 0x4444 },
 	{ 0x0109, 0x4444 },
 	{ 0x010a, 0xaaaa },
@@ -2337,6 +2338,8 @@ static int rt5663_hp_event(struct snd_soc_dapm_widget *w,
 				0x8000);
 			snd_soc_component_update_bits(component, RT5663_DEPOP_1, 0x3000,
 				0x3000);
+			snd_soc_component_update_bits(component,
+				RT5663_DIG_VOL_ZCD, 0x00c0, 0x0080);
 		}
 		break;
 
@@ -2351,6 +2354,8 @@ static int rt5663_hp_event(struct snd_soc_dapm_widget *w,
 				RT5663_OVCD_HP_MASK, RT5663_OVCD_HP_EN);
 			snd_soc_component_update_bits(component,
 				RT5663_DACREF_LDO, 0x3e0e, 0);
+			snd_soc_component_update_bits(component,
+				RT5663_DIG_VOL_ZCD, 0x00c0, 0);
 		}
 		break;
 
-- 
2.19.0
