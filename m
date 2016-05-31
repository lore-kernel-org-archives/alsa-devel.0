From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ASoC: hdmi-codec: select CONFIG_HDMI
Date: Tue, 31 May 2016 23:12:00 +0200
Message-ID: <1464729159-587126-1-git-send-email-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Jyri Sarha <jsarha@ti.com>, Arnaud Pouliquen <arnaud.pouliquen@st.com>, PC Liao <pc.liao@mediatek.com>, Arnd Bergmann <arnd@arndb.de>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

SND_SOC_HDMI_CODEC can be enabled without HDMI support, leading
to a link error:

In function `hdmi_codec_hw_params':
sound/soc/codecs/hdmi-codec.c:188: undefined reference to `hdmi_audio_infoframe_init'
sound/built-in.o:(.debug_addr+0x1a5c0): undefined reference to `hdmi_audio_infoframe_init'

This changes the Kconfig file to select HDMI, as the other codec using
hdmi_audio_infoframe_init already does.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 09184118a8ab ("ASoC: hdmi-codec: Add hdmi-codec for external HDMI-encoders")
---
 sound/soc/codecs/Kconfig | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 4d82a58ff6b0..f3fb98f0a995 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -483,9 +483,10 @@ config SND_SOC_DMIC
 	tristate
 
 config SND_SOC_HDMI_CODEC
-       tristate
-       select SND_PCM_ELD
-       select SND_PCM_IEC958
+	tristate
+	select SND_PCM_ELD
+	select SND_PCM_IEC958
+	select HDMI
 
 config SND_SOC_ES8328
 	tristate "Everest Semi ES8328 CODEC"
-- 
2.7.0
