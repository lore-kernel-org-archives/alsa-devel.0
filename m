From: "Oskar Schirmer" <oskar@scara.com>
Subject: [PATCH] sound/sgtl5000: fix codec clock source transition to avoid clockless moment
Date: 5 Aug 2013 07:36:02 +0000
Message-ID: <1375688163-1935-1-git-send-email-oskar@scara.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, Zeng Zhaoming <zengzm.kernel@gmail.com>, Oskar Schirmer <oskar@scara.com>
List-Id: alsa-devel@alsa-project.org

Powering down PLL before switching to a mode that does not use it
is a bad idea. It would cause the SGTL5000 be without internal
clock supply, especially on the I2C interface, which would make
subsequent access to it fail.

Thus, in case of not using PLL any longer, first set the mode
control, then power down PLL.

Signed-off-by: Oskar Schirmer <oskar@scara.com>
---
 sound/soc/codecs/sgtl5000.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 6c8a9e7..8ecb201 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -644,16 +644,19 @@ static int sgtl5000_set_clock(struct snd_soc_codec *codec, int frame_rate)
 		snd_soc_update_bits(codec, SGTL5000_CHIP_ANA_POWER,
 			SGTL5000_PLL_POWERUP | SGTL5000_VCOAMP_POWERUP,
 			SGTL5000_PLL_POWERUP | SGTL5000_VCOAMP_POWERUP);
+
+		/* if using pll, clk_ctrl must be set after pll power up */
+		snd_soc_write(codec, SGTL5000_CHIP_CLK_CTRL, clk_ctl);
 	} else {
+		/* otherwise, clk_ctrl must be set before pll power down */
+		snd_soc_write(codec, SGTL5000_CHIP_CLK_CTRL, clk_ctl);
+
 		/* power down pll */
 		snd_soc_update_bits(codec, SGTL5000_CHIP_ANA_POWER,
 			SGTL5000_PLL_POWERUP | SGTL5000_VCOAMP_POWERUP,
 			0);
 	}
 
-	/* if using pll, clk_ctrl must be set after pll power up */
-	snd_soc_write(codec, SGTL5000_CHIP_CLK_CTRL, clk_ctl);
-
 	return 0;
 }
 
-- 
1.7.9.5
