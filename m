From: <Codrin.Ciubotariu@microchip.com>
Subject: [PATCH 3/5] ASoC: codecs: ad193x: Fix frame polarity for DSP_A format
Date: Mon, 18 Feb 2019 16:10:32 +0000
Message-ID: <20190218160954.13929-4-codrin.ciubotariu@microchip.com>
References: <20190218160954.13929-1-codrin.ciubotariu@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190218160954.13929-1-codrin.ciubotariu@microchip.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: lars@metafoo.de, lgirdwood@gmail.com, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Codrin.Ciubotariu@microchip.com
List-Id: alsa-devel@alsa-project.org

From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>

By default, the codec starts to interpret the left (first) channel on
the falling edge (low polarity) of LRCLK. However, for DSP_A, the left
channel needs to start on the rising edge of LRCLK. This patch fixes
this channel swap by toggling the bit which selects the LRCLK polarity.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---
 sound/soc/codecs/ad193x.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/codecs/ad193x.c b/sound/soc/codecs/ad193x.c
index c16c9969d1a0..315ec9775118 100644
--- a/sound/soc/codecs/ad193x.c
+++ b/sound/soc/codecs/ad193x.c
@@ -228,6 +228,12 @@ static int ad193x_set_dai_fmt(struct snd_soc_dai *code=
c_dai,
 		return -EINVAL;
 	}
=20
+	/* For DSP_*, LRCLK's polarity must be inverted */
+	if (fmt & SND_SOC_DAIFMT_DSP_A) {
+		change_bit(ffs(AD193X_DAC_LEFT_HIGH) - 1,
+			   (unsigned long *)&dac_fmt);
+	}
+
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
 	case SND_SOC_DAIFMT_CBM_CFM: /* codec clk & frm master */
 		adc_fmt |=3D AD193X_ADC_LCR_MASTER;
--=20
2.17.1
