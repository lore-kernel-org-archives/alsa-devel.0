From: Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] ASoC: codecs: jz4725b: Remove unnecessary const qualifier
Date: Thu,  7 Feb 2019 21:59:18 -0700
Message-ID: <20190208045918.16799-1-natechancellor@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>, Nick Desaulniers <ndesaulniers@google.com>, Nathan Chancellor <natechancellor@gmail.com>
List-Id: alsa-devel@alsa-project.org

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
---
 sound/soc/codecs/jz4725b.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/jz4725b.c b/sound/soc/codecs/jz4725b.c
index e3dba92f30bd..5cc8c7ca24c6 100644
--- a/sound/soc/codecs/jz4725b.c
+++ b/sound/soc/codecs/jz4725b.c
@@ -174,12 +174,12 @@ static const char * const jz4725b_codec_adc_src_texts[] = {
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
