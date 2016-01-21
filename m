From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5645: fix the shift bit of IN1 boost" to the asoc tree
Date: Thu, 21 Jan 2016 16:56:06 +0000
Message-ID: <E1aMIWk-0008FK-Nz@debutante>
References: <1453353220-16155-1-git-send-email-bardliao@realtek.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1453353220-16155-1-git-send-email-bardliao@realtek.com>
Sender: stable-owner@vger.kernel.org
To: Bard Liao <bardliao@realtek.com>, Mark Brown <broonie@kernel.org>, stable@vger.kernel.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5645: fix the shift bit of IN1 boost

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

>From b28785fa9cede0d4f47310ca0dd2a4e1d50478b5 Mon Sep 17 00:00:00 2001
From: Bard Liao <bardliao@realtek.com>
Date: Thu, 21 Jan 2016 13:13:40 +0800
Subject: [PATCH] ASoC: rt5645: fix the shift bit of IN1 boost

The shift bit of IN1 boost gain control is 12.

Signed-off-by: Bard Liao <bardliao@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 sound/soc/codecs/rt5645.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 28132375e427..c916c3881259 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -600,7 +600,7 @@ static const struct snd_kcontrol_new rt5645_snd_controls[] = {
 
 	/* IN1/IN2 Control */
 	SOC_SINGLE_TLV("IN1 Boost", RT5645_IN1_CTRL1,
-		RT5645_BST_SFT1, 8, 0, bst_tlv),
+		RT5645_BST_SFT1, 12, 0, bst_tlv),
 	SOC_SINGLE_TLV("IN2 Boost", RT5645_IN2_CTRL,
 		RT5645_BST_SFT2, 8, 0, bst_tlv),
 
-- 
2.7.0.rc3
