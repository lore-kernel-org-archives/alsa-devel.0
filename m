From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: codecs: jz4725b: Remove unnecessary const qualifier" to the asoc tree
Date: Fri,  8 Feb 2019 13:11:11 +0000 (GMT)
Message-ID: <20190208131111.C0F0D1127F30@debutante.sirena.org.uk>
References: <20190208045918.16799-1-natechancellor@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190208045918.16799-1-natechancellor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nathan Chancellor <natechancellor@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Paul Cercueil <paul@crapouillou.net>, alsa-devel@alsa-project.org, Nick Desaulniers <ndesaulniers@google.com>, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: codecs: jz4725b: Remove unnecessary const qualifier

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

>From d9186330c881468722c005ee772ca745c81a29ef Mon Sep 17 00:00:00 2001
From: Nathan Chancellor <natechancellor@gmail.com>
Date: Thu, 7 Feb 2019 21:59:18 -0700
Subject: [PATCH] ASoC: codecs: jz4725b: Remove unnecessary const qualifier

Clang warns:

sound/soc/codecs/jz4725b.c:177:14: warning: duplicate 'const' declaration specifier [-Wduplicate-decl-specifier]
static const SOC_VALUE_ENUM_SINGLE_DECL(jz4725b_codec_adc_src_enum,
             ^
include/sound/soc.h:356:2: note: expanded from macro 'SOC_VALUE_ENUM_SINGLE_DECL'
        SOC_VALUE_ENUM_DOUBLE_DECL(name, xreg, xshift, xshift, xmask, xtexts, xvalues)
        ^
include/sound/soc.h:353:2: note: expanded from macro 'SOC_VALUE_ENUM_DOUBLE_DECL'
        const struct soc_enum name = SOC_VALUE_ENUM_DOUBLE(xreg, xshift_l, xshift_r, xmask, \
        ^

As it points out, SOC_VALUE_ENUM_DOUBLE_DECL has the const attribute in
its definition so remove it here.

Fixes: e9d97b05a80f ("ASoC: codecs: Add jz4725b-codec driver")
Link: https://github.com/ClangBuiltLinux/linux/issues/354
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/jz4725b.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/jz4725b.c b/sound/soc/codecs/jz4725b.c
index 103ccbc5d55c..766354c73076 100644
--- a/sound/soc/codecs/jz4725b.c
+++ b/sound/soc/codecs/jz4725b.c
@@ -173,12 +173,12 @@ static const char * const jz4725b_codec_adc_src_texts[] = {
 	"Mic 1", "Mic 2", "Line In", "Mixer",
 };
 static const unsigned int jz4725b_codec_adc_src_values[] = { 0, 1, 2, 3, };
-static const SOC_VALUE_ENUM_SINGLE_DECL(jz4725b_codec_adc_src_enum,
-					JZ4725B_CODEC_REG_CR3,
-					REG_CR3_INSEL_OFFSET,
-					REG_CR3_INSEL_MASK,
-					jz4725b_codec_adc_src_texts,
-					jz4725b_codec_adc_src_values);
+static SOC_VALUE_ENUM_SINGLE_DECL(jz4725b_codec_adc_src_enum,
+				  JZ4725B_CODEC_REG_CR3,
+				  REG_CR3_INSEL_OFFSET,
+				  REG_CR3_INSEL_MASK,
+				  jz4725b_codec_adc_src_texts,
+				  jz4725b_codec_adc_src_values);
 static const struct snd_kcontrol_new jz4725b_codec_adc_src_ctrl =
 			SOC_DAPM_ENUM("Route", jz4725b_codec_adc_src_enum);
 
-- 
2.20.1
