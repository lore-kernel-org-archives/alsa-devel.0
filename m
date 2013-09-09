From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Subject: [PATCH] codecs: mc13783: add spi errate fix
Date: Mon,  9 Sep 2013 16:12:36 +0200
Message-ID: <1378735956-17318-1-git-send-email-s.trumtrar@pengutronix.de>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, kernel@pengutronix.de, Steffen Trumtrar <s.trumtrar@pengutronix.de>, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The MC13783 Chip Errata, Rev. 4 says, that depending on SPI clock
and main audio clock speed, the Audio Codec or Stereo DAC do sometimes
not start when programmed to do so. This is due to an internal clock
timing issue related to the loading of the SPI bits into the audio block.

On an i.MX27 based system, this issue lead to switched audio channels under
certain circumstances: RTC + Touch + Audio are used and loaded at startup.

The mentioned workaround of writing registers 40 and 41 two times is implemented
here.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: stable@vger.kernel.org
---
 sound/soc/codecs/mc13783.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/codecs/mc13783.c b/sound/soc/codecs/mc13783.c
index 4d3c8fd..e78353d 100644
--- a/sound/soc/codecs/mc13783.c
+++ b/sound/soc/codecs/mc13783.c
@@ -125,6 +125,10 @@ static int mc13783_write(struct snd_soc_codec *codec,
 
 	ret = mc13xxx_reg_write(priv->mc13xxx, reg, value);
 
+	/* include errata fix for spi audio problems */
+	if (reg == PMIC_AUDIO_CODEC || reg == PMIC_AUDIO_DAC)
+		ret = mc13xxx_reg_write(priv->mc13xxx, reg, value);
+
 	mc13xxx_unlock(priv->mc13xxx);
 
 	return ret;
-- 
1.8.4.rc3
