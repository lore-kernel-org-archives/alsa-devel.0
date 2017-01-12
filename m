From: Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH] ASoC: rt5660: remove double const
Date: Thu, 12 Jan 2017 11:48:11 +0100
Message-ID: <1484218091-28684-1-git-send-email-hofrat@osadl.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Bard Liao <bardliao@realtek.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>
List-Id: alsa-devel@alsa-project.org

Drop the const qualifier as it is being added by SOC_ENUM_DOUBLE_DECL()
already which is called by SOC_ENUM_SINGLE_DECL() here.

Fixes: commit 2b26dd4c1fc5 ("ASoC: rt5660: add rt5660 codec driver")
Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---

sparse throws the warning:
sound/soc/codecs/rt5660.c:529:14: warning: duplicate const 
sound/soc/codecs/rt5660.c:532:14: warning: duplicate const 

this is due to:
static const SOC_ENUM_SINGLE_DECL(rt5660_if1_dac_enum,...

which via:
#define SOC_ENUM_SINGLE_DECL(name, xreg, xshift, xtexts) \
        SOC_ENUM_DOUBLE_DECL(name, xreg, xshift, xshift, xtexts)

expands to:
#define SOC_ENUM_DOUBLE_DECL(name, xreg, xshift_l, xshift_r, xtexts) \
        const struct soc_enum name = SOC_ENUM_DOUBLE(xreg, xshift_l, xshift_r, \
                                                ARRAY_SIZE(xtexts), xtexts)
and that already carries the const qualifier so that results in the
"duplicate const" from sparse. The fix is simply to drop the first
const.

Patch was compile tested with: x86_64_defconfig + CONFIG_COMPILE_TEST=y
SND_SOC=m + SND_SOC_ALL_CODECS=m (implies SND_SOC_RT5660=m)

Patch is aginast 4.10-rc3 (localversion-next is next-20170112)

 sound/soc/codecs/rt5660.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt5660.c b/sound/soc/codecs/rt5660.c
index 76cf76a..296b7b0 100644
--- a/sound/soc/codecs/rt5660.c
+++ b/sound/soc/codecs/rt5660.c
@@ -526,10 +526,10 @@ static const char * const rt5660_data_select[] = {
 	"L/R", "R/L", "L/L", "R/R"
 };
 
-static const SOC_ENUM_SINGLE_DECL(rt5660_if1_dac_enum,
+static SOC_ENUM_SINGLE_DECL(rt5660_if1_dac_enum,
 	RT5660_DIG_INF1_DATA, RT5660_IF1_DAC_IN_SFT, rt5660_data_select);
 
-static const SOC_ENUM_SINGLE_DECL(rt5660_if1_adc_enum,
+static SOC_ENUM_SINGLE_DECL(rt5660_if1_adc_enum,
 	RT5660_DIG_INF1_DATA, RT5660_IF1_ADC_IN_SFT, rt5660_data_select);
 
 static const struct snd_kcontrol_new rt5660_if1_dac_swap_mux =
-- 
2.1.4
