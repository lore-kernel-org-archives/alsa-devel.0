From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ASoC: ams-delta: remove duplicate 'const'
Date: Thu,  7 Mar 2019 11:10:49 +0100
Message-ID: <20190307101101.613881-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>, Arnd Bergmann <arnd@arndb.de>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Tony Lindgren <tony@atomide.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Janusz Krzysztofik <jmkrzyszt@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

clang points out that SOC_ENUM_SINGLE_EXT_DECL() contains a 'const'
modifier already, so adding another one does not make it more const:

sound/soc/ti/ams-delta.c:203:14: error: duplicate 'const' declaration specifier [-Werror,-Wduplicate-decl-specifier]
static const SOC_ENUM_SINGLE_EXT_DECL(ams_delta_audio_enum,
             ^
include/sound/soc.h:351:2: note: expanded from macro 'SOC_ENUM_SINGLE_EXT_DECL'
        const struct soc_enum name = SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(xtexts), xtexts)

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/ti/ams-delta.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/ti/ams-delta.c b/sound/soc/ti/ams-delta.c
index 4dce494dfbd3..b9611db14c86 100644
--- a/sound/soc/ti/ams-delta.c
+++ b/sound/soc/ti/ams-delta.c
@@ -200,7 +200,7 @@ static int ams_delta_get_audio_mode(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-static const SOC_ENUM_SINGLE_EXT_DECL(ams_delta_audio_enum,
+static SOC_ENUM_SINGLE_EXT_DECL(ams_delta_audio_enum,
 				      ams_delta_audio_mode);
 
 static const struct snd_kcontrol_new ams_delta_audio_controls[] = {
-- 
2.20.0
