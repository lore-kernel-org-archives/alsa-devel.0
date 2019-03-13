From: John Hsu <KCHSU0@nuvoton.com>
Subject: [PATCH] ASoC: nau8810: automatic selecting BCLK in I2S
	master mode
Date: Wed, 13 Mar 2019 16:52:01 +0800
Message-ID: <20190313085201.8605-1-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa1.perex.cz (Postfix) with ESMTP id 974C7F8961E
 for <alsa-devel@alsa-project.org>; Wed, 13 Mar 2019 09:52:08 +0100 (CET)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, WTLI@nuvoton.com, John Hsu <KCHSU0@nuvoton.com>, lgirdwood@gmail.com, YHCHuang@nuvoton.com, CTLIN0@nuvoton.com
List-Id: alsa-devel@alsa-project.org

The driver will select correct BCLK automatically according to
BCLK and FS information in I2S master mode.

Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
---
 sound/soc/codecs/nau8810.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/sound/soc/codecs/nau8810.c b/sound/soc/codecs/nau8810.c
index 832657720a5f..125e205e6687 100644
--- a/sound/soc/codecs/nau8810.c
+++ b/sound/soc/codecs/nau8810.c
@@ -667,6 +667,24 @@ static int nau8810_pcm_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_component *component = dai->component;
 	struct nau8810 *nau8810 = snd_soc_component_get_drvdata(component);
 	int val_len = 0, val_rate = 0, ret = 0;
+	unsigned int ctrl_val, bclk_fs, bclk_div;
+
+	/* Select BCLK configuration if the codec as master. */
+	regmap_read(nau8810->regmap, NAU8810_REG_CLOCK, &ctrl_val);
+	if (ctrl_val & NAU8810_CLKIO_MASTER) {
+		/* get the bclk and fs ratio */
+		bclk_fs = snd_soc_params_to_bclk(params) / params_rate(params);
+		if (bclk_fs <= 32)
+			bclk_div = NAU8810_BCLKDIV_8;
+		else if (bclk_fs <= 64)
+			bclk_div = NAU8810_BCLKDIV_4;
+		else if (bclk_fs <= 128)
+			bclk_div = NAU8810_BCLKDIV_2;
+		else
+			return -EINVAL;
+		regmap_update_bits(nau8810->regmap, NAU8810_REG_CLOCK,
+			NAU8810_BCLKSEL_MASK, bclk_div);
+	}
 
 	switch (params_width(params)) {
 	case 16:
-- 
2.18.0
