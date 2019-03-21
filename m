From: "Cormier, Jonathan" <jcormier@criticallink.com>
Subject: [PATCH v2 6/7] ASoC: tlv320aic26: hw_params was unintentionally clearing AIC26 master mode
Date: Thu, 21 Mar 2019 18:15:48 -0400
Message-ID: <20190321221549.13765-7-jcormier@criticallink.com>
References: <20190321221549.13765-1-jcormier@criticallink.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190321221549.13765-1-jcormier@criticallink.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, devicetree@vger.kernel.org
Cc: Bob Duke <bduke@criticallink.com>, Mike Williamson <michael.williamson@criticallink.com>, Greg Gluszek <greg.gluszek@criticallink.com>, Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@linaro.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jyri Sarha <jsarha@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Commit 5b0959d472c2 ("ASoC: tlv320aic26: Use snd_soc_update_bits()")
broke setting AIC26_REG_AUDIO_CTRL3 in master mode when fsref happens
to be 48000. The master mode bit was getting cleared.

Also fix setting AIC26_REG_DAC_GAIN and AIC26_REG_AUDIO_CTRL2 which
was broke by same commit.

Fixes 5b0959d472c2 ("ASoC: tlv320aic26: Use snd_soc_update_bits()")
Signed-off-by: Cormier, Jonathan <jcormier@criticallink.com>
---
 sound/soc/codecs/tlv320aic26.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic26.c b/sound/soc/codecs/tlv320aic26.c
index cd1bcb9cbfe1..c6ff4ca29d43 100644
--- a/sound/soc/codecs/tlv320aic26.c
+++ b/sound/soc/codecs/tlv320aic26.c
@@ -138,11 +138,12 @@ static int aic26_hw_params(struct snd_pcm_substream *substream,
 	snd_soc_component_write(component, AIC26_REG_PLL_PROG2, reg);
 
 	/* Audio Control 3 (master mode, fsref rate) */
+	reg = 0;
 	if (aic26->master)
-		reg = 0x0800;
+		reg |= 0x0800;
 	if (fsref == 48000)
-		reg = 0x2000;
-	snd_soc_component_update_bits(component, AIC26_REG_AUDIO_CTRL3, 0xf800, reg);
+		reg |= 0x2000;
+	snd_soc_component_update_bits(component, AIC26_REG_AUDIO_CTRL3, 0x2800, reg);
 
 	/* Audio Control 1 (FSref divisor) */
 	reg = wlen | aic26->datfm | (divisor << 3) | divisor;
@@ -167,7 +168,7 @@ static int aic26_mute(struct snd_soc_dai *dai, int mute)
 		reg = 0x8080;
 	else
 		reg = 0;
-	snd_soc_component_update_bits(component, AIC26_REG_DAC_GAIN, 0x8000, reg);
+	snd_soc_component_update_bits(component, AIC26_REG_DAC_GAIN, 0x8080, reg);
 
 	return 0;
 }
@@ -302,7 +303,7 @@ static ssize_t aic26_keyclick_set(struct device *dev,
 	struct aic26 *aic26 = dev_get_drvdata(dev);
 
 	snd_soc_component_update_bits(aic26->component, AIC26_REG_AUDIO_CTRL2,
-			    0x8000, 0x800);
+			    0x8000, 0x8000);
 
 	return count;
 }
-- 
2.21.0
