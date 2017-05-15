From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5514: fix gcc-7 warning" to the asoc tree
Date: Mon, 15 May 2017 17:03:50 +0900
Message-ID: <E1dAAys-0002Xg-E5@finisterre>
References: <20170511114512.2865725-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170511114512.2865725-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Douglas Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org, Bard Liao <bardliao@realtek.com>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5514: fix gcc-7 warning

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

>From 03ba791df98d15d07ea74075122af71e35c7611c Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 11 May 2017 13:44:38 +0200
Subject: [PATCH] ASoC: rt5514: fix gcc-7 warning

gcc-7 warns that there is a duplicate 'const' specifier in some
variables that are declared using the SOC_ENUM_SINGLE_DECL macro:

sound/soc/codecs/rt5514.c:398:14: error: duplicate 'const' declaration specifier [-Werror=duplicate-decl-specifier]
 static const SOC_ENUM_SINGLE_DECL(
sound/soc/codecs/rt5514.c:405:14: error: duplicate 'const' declaration specifier [-Werror=duplicate-decl-specifier]
 static const SOC_ENUM_SINGLE_DECL(

This removes one to fix the warning.

Fixes: 4a6180ea7399 ("ASoC: rt5514: add rt5514 codec driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5514.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt5514.c b/sound/soc/codecs/rt5514.c
index f91221b1ddf0..28ab9e2bb051 100644
--- a/sound/soc/codecs/rt5514.c
+++ b/sound/soc/codecs/rt5514.c
@@ -395,14 +395,14 @@ static const char * const rt5514_dmic_src[] = {
 	"DMIC1", "DMIC2"
 };
 
-static const SOC_ENUM_SINGLE_DECL(
+static SOC_ENUM_SINGLE_DECL(
 	rt5514_stereo1_dmic_enum, RT5514_DIG_SOURCE_CTRL,
 	RT5514_AD0_DMIC_INPUT_SEL_SFT, rt5514_dmic_src);
 
 static const struct snd_kcontrol_new rt5514_sto1_dmic_mux =
 	SOC_DAPM_ENUM("Stereo1 DMIC Source", rt5514_stereo1_dmic_enum);
 
-static const SOC_ENUM_SINGLE_DECL(
+static SOC_ENUM_SINGLE_DECL(
 	rt5514_stereo2_dmic_enum, RT5514_DIG_SOURCE_CTRL,
 	RT5514_AD1_DMIC_INPUT_SEL_SFT, rt5514_dmic_src);
 
-- 
2.11.0
