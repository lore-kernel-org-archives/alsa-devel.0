From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: hdmi-codec: select CONFIG_HDMI" to the asoc tree
Date: Thu, 02 Jun 2016 16:50:33 +0100
Message-ID: <E1b8UtF-0004wQ-3V@finisterre>
References: <1464729159-587126-1-git-send-email-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464729159-587126-1-git-send-email-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jyri Sarha <jsarha@ti.com>, Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Arnaud Pouliquen <arnaud.pouliquen@st.com>, Liam Girdwood <lgirdwood@gmail.com>Jyri Sarha <jsarha@ti.com>, linux-kernel@vger.kernel.org, PC Liao <pc.liao@mediatek.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: hdmi-codec: select CONFIG_HDMI

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

>From 6de7df8d1b1a45a07d6ecc6b4f94179e1e68f5ec Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 31 May 2016 23:12:00 +0200
Subject: [PATCH] ASoC: hdmi-codec: select CONFIG_HDMI

SND_SOC_HDMI_CODEC can be enabled without HDMI support, leading
to a link error:

In function `hdmi_codec_hw_params':
sound/soc/codecs/hdmi-codec.c:188: undefined reference to `hdmi_audio_infoframe_init'
sound/built-in.o:(.debug_addr+0x1a5c0): undefined reference to `hdmi_audio_infoframe_init'

This changes the Kconfig file to select HDMI, as the other codec using
hdmi_audio_infoframe_init already does.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Jyri Sarha <jsarha@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.8.1
