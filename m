From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Subject: [PATCH 2/2] ASoC: codecs: ad193x: Reset DAC Control 1 register at probe
Date: Wed, 26 Jun 2019 13:49:47 +0300
Message-ID: <20190626104947.26547-2-codrin.ciubotariu@microchip.com>
References: <20190626104947.26547-1-codrin.ciubotariu@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190626104947.26547-1-codrin.ciubotariu@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: lars@metafoo.de, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
List-Id: alsa-devel@alsa-project.org

Since the ad193x codecs have no software reset, we have to reinitialize the
registers after a hardware reset. For example, if we change the
device-tree between these resets, changing the audio format of the DAI link
from DSP_A with 8 TDM channels to I2S 2 channels, DAC Control 1 register
will remain configured for 8 channels. This patch resets this register at
probe to its default value.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---
 sound/soc/codecs/ad193x.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/ad193x.c b/sound/soc/codecs/ad193x.c
index 3ebc0524f4b2..cda435562a1d 100644
--- a/sound/soc/codecs/ad193x.c
+++ b/sound/soc/codecs/ad193x.c
@@ -427,6 +427,8 @@ static int ad193x_component_probe(struct snd_soc_component *component)
 	regmap_write(ad193x->regmap, AD193X_DAC_CTRL2, 0x1A);
 	/* dac in tdm mode */
 	regmap_write(ad193x->regmap, AD193X_DAC_CTRL0, 0x40);
+	/* reset DAC ctrl1 */
+	regmap_write(ad193x->regmap, AD193X_DAC_CTRL1, 0x00);
 
 	/* adc only */
 	if (ad193x_has_adc(ad193x)) {
-- 
2.20.1
