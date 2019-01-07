From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: max98090: remove unused constant variables" to the asoc tree
Date: Mon,  7 Jan 2019 18:58:31 +0000 (GMT)
Message-ID: <20190107185831.D68081127491@debutante.sirena.org.uk>
References: <20190105020249.8639-3-pierre-louis.bossart@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190105020249.8639-3-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, tiwai@suse.de, open list <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, liam.r.girdwood@linux.intel.combroonie@kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: max98090: remove unused constant variables

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

>From 97d8f6b71f56865e52d472247fe728700ef7128d Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Fri, 4 Jan 2019 20:02:30 -0600
Subject: [PATCH] ASoC: max98090: remove unused constant variables

Fix warnings with W=1

If these variables are useful then this driver should be modified to
expose them.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max98090.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
index c97f21836c66..30c242c38d99 100644
--- a/sound/soc/codecs/max98090.c
+++ b/sound/soc/codecs/max98090.c
@@ -314,9 +314,6 @@ static const DECLARE_TLV_DB_SCALE(max98090_av_tlv, -1200, 100, 0);
 static const DECLARE_TLV_DB_SCALE(max98090_dvg_tlv, 0, 600, 0);
 static const DECLARE_TLV_DB_SCALE(max98090_dv_tlv, -1500, 100, 0);
 
-static const DECLARE_TLV_DB_SCALE(max98090_sidetone_tlv, -6050, 200, 0);
-
-static const DECLARE_TLV_DB_SCALE(max98090_alc_tlv, -1500, 100, 0);
 static const DECLARE_TLV_DB_SCALE(max98090_alcmakeup_tlv, 0, 100, 0);
 static const DECLARE_TLV_DB_SCALE(max98090_alccomp_tlv, -3100, 100, 0);
 static const DECLARE_TLV_DB_SCALE(max98090_drcexp_tlv, -6600, 100, 0);
@@ -817,18 +814,6 @@ static SOC_ENUM_SINGLE_VIRT_DECL(dmic_mux_enum, dmic_mux_text);
 static const struct snd_kcontrol_new max98090_dmic_mux =
 	SOC_DAPM_ENUM("DMIC Mux", dmic_mux_enum);
 
-static const char *max98090_micpre_text[] = { "Off", "On" };
-
-static SOC_ENUM_SINGLE_DECL(max98090_pa1en_enum,
-			    M98090_REG_MIC1_INPUT_LEVEL,
-			    M98090_MIC_PA1EN_SHIFT,
-			    max98090_micpre_text);
-
-static SOC_ENUM_SINGLE_DECL(max98090_pa2en_enum,
-			    M98090_REG_MIC2_INPUT_LEVEL,
-			    M98090_MIC_PA2EN_SHIFT,
-			    max98090_micpre_text);
-
 /* LINEA mixer switch */
 static const struct snd_kcontrol_new max98090_linea_mixer_controls[] = {
 	SOC_DAPM_SINGLE("IN1 Switch", M98090_REG_LINE_INPUT_CONFIG,
-- 
2.20.1
