From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: es8316: remove unused constant variables" to the asoc tree
Date: Mon,  7 Jan 2019 18:58:29 +0000 (GMT)
Message-ID: <20190107185830.01EF01127491@debutante.sirena.org.uk>
References: <20190105020249.8639-4-pierre-louis.bossart@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190105020249.8639-4-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, tiwai@suse.de, open list <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, liam.r.girdwood@linux.intel.combroonie@kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: es8316: remove unused constant variables

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

>From 37b6f0350374e6c683bc2c2d8a54d4504bc04ec1 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Fri, 4 Jan 2019 20:02:31 -0600
Subject: [PATCH] ASoC: es8316: remove unused constant variables

Fix warnings with W=1

If these variables are useful this driver should be modified to expose
them.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/es8316.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/sound/soc/codecs/es8316.c b/sound/soc/codecs/es8316.c
index 98464ba1046c..6d4a323f786b 100644
--- a/sound/soc/codecs/es8316.c
+++ b/sound/soc/codecs/es8316.c
@@ -167,8 +167,6 @@ static const char * const es8316_hpmux_texts[] = {
 	"lin-rin with Boost and PGA"
 };
 
-static const unsigned int es8316_hpmux_values[] = { 0, 1, 2, 3 };
-
 static SOC_ENUM_SINGLE_DECL(es8316_left_hpmux_enum, ES8316_HPMIX_SEL,
 	4, es8316_hpmux_texts);
 
@@ -199,8 +197,6 @@ static const char * const es8316_dacsrc_texts[] = {
 	"RDATA TO LDAC, LDATA TO RDAC",
 };
 
-static const unsigned int es8316_dacsrc_values[] = { 0, 1, 2, 3 };
-
 static SOC_ENUM_SINGLE_DECL(es8316_dacsrc_mux_enum, ES8316_DAC_SET1,
 	6, es8316_dacsrc_texts);
 
-- 
2.20.1
