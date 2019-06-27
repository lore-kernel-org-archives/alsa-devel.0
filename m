From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Subject: [PATCH 2/2] ASoC: codecs: ad193x: Reset used registers at probe
Date: Thu, 27 Jun 2019 15:02:08 +0300
Message-ID: <20190627120208.4661-2-codrin.ciubotariu@microchip.com>
References: <20190627120208.4661-1-codrin.ciubotariu@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190627120208.4661-1-codrin.ciubotariu@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: lars@metafoo.de, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
List-Id: alsa-devel@alsa-project.org

Since the ad193x codecs have no software reset, we have to reinitialize the
registers after a hardware reset to assure no previous values are kept.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---
 sound/soc/codecs/ad193x.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/codecs/ad193x.c b/sound/soc/codecs/ad193x.c
index f944228f014e..80dab5df9633 100644
--- a/sound/soc/codecs/ad193x.c
+++ b/sound/soc/codecs/ad193x.c
@@ -425,12 +425,22 @@ static void ad193x_reg_default_init(struct ad193x_priv *ad193x)
 		{  0, 0x99 },	/* PLL_CLK_CTRL0: pll input: mclki/xi 12.288Mhz */
 		{  1, 0x04 },	/* PLL_CLK_CTRL1: no on-chip Vref */
 		{  2, 0x40 },	/* DAC_CTRL0: TDM mode */
+		{  3, 0x00 },	/* DAC_CTRL1: reset */
 		{  4, 0x1A },	/* DAC_CTRL2: 48kHz de-emphasis, unmute dac */
 		{  5, 0x00 },	/* DAC_CHNL_MUTE: unmute DAC channels */
+		{  6, 0x00 },	/* DAC_L1_VOL: no attenuation */
+		{  7, 0x00 },	/* DAC_R1_VOL: no attenuation */
+		{  8, 0x00 },	/* DAC_L2_VOL: no attenuation */
+		{  9, 0x00 },	/* DAC_R2_VOL: no attenuation */
+		{ 10, 0x00 },	/* DAC_L3_VOL: no attenuation */
+		{ 11, 0x00 },	/* DAC_R3_VOL: no attenuation */
+		{ 12, 0x00 },	/* DAC_L4_VOL: no attenuation */
+		{ 13, 0x00 },	/* DAC_R4_VOL: no attenuation */
 	};
 	const struct ad193x_reg_default reg_adc_init[] = {
 		{ 14, 0x03 },	/* ADC_CTRL0: high-pass filter enable */
 		{ 15, 0x43 },	/* ADC_CTRL1: sata delay=1, adc aux mode */
+		{ 16, 0x00 },	/* ADC_CTRL2: reset */
 	};
 	int i;
 
-- 
2.20.1
