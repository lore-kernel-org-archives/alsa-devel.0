From: John Hsu <KCHSU0@nuvoton.com>
Subject: [PATCH 2/2] ASoC: nau8825: provide clock divide for
	codec mater mode
Date: Tue, 20 Dec 2016 16:47:07 +0800
Message-ID: <1482223627-23547-2-git-send-email-KCHSU0@nuvoton.com>
References: <1482223627-23547-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa0.perex.cz (Postfix) with ESMTP id EB892266B78
 for <alsa-devel@alsa-project.org>; Tue, 20 Dec 2016 09:48:24 +0100 (CET)
In-Reply-To: <1482223627-23547-1-git-send-email-KCHSU0@nuvoton.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, anatol.pomozov@gmail.com, YHCHuang@nuvoton.com, WTLI@nuvoton.com, John Hsu <KCHSU0@nuvoton.com>, lgirdwood@gmail.com, benzh@chromium.org, CTLIN0@nuvoton.com, mhkuo@nuvoton.com, yong.zhi@intel.com
List-Id: alsa-devel@alsa-project.org

Provide the LRC and BCLK divide. The clock divide needs configuration
properly when codec in master mode.

Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
---
 sound/soc/codecs/nau8825.c | 26 ++++++++++++++++++++++++++
 sound/soc/codecs/nau8825.h |  6 ++++++
 2 files changed, 32 insertions(+)

diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
index 9c98d35..3c7a801 100644
--- a/sound/soc/codecs/nau8825.c
+++ b/sound/soc/codecs/nau8825.c
@@ -1421,9 +1421,35 @@ static int nau8825_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 	return 0;
 }
 
+static int nau8825_set_clkdiv(struct snd_soc_dai *codec_dai,
+	int div_id, int div)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	struct nau8825 *nau8825 = snd_soc_codec_get_drvdata(codec);
+
+	switch (div_id) {
+	case NAU8825_BCLKDIV:
+		regmap_update_bits(nau8825->regmap, NAU8825_REG_I2S_PCM_CTRL2,
+			NAU8825_I2S_BLK_DIV_MASK, div);
+		break;
+
+	case NAU8825_FSDIV:
+		regmap_update_bits(nau8825->regmap, NAU8825_REG_I2S_PCM_CTRL2,
+			NAU8825_I2S_LRC_DIV_MASK,
+			div << NAU8825_I2S_LRC_DIV_SFT);
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static const struct snd_soc_dai_ops nau8825_dai_ops = {
 	.hw_params	= nau8825_hw_params,
 	.set_fmt	= nau8825_set_dai_fmt,
+	.set_clkdiv	= nau8825_set_clkdiv,
 };
 
 #define NAU8825_RATES	SNDRV_PCM_RATE_8000_192000
diff --git a/sound/soc/codecs/nau8825.h b/sound/soc/codecs/nau8825.h
index 4b390c4..58b8554 100644
--- a/sound/soc/codecs/nau8825.h
+++ b/sound/soc/codecs/nau8825.h
@@ -425,6 +425,12 @@
 #define NAU8825_CHANRGE_PUMP_EN	(1 << 5)
 
 
+/* Programmable divide */
+enum {
+	NAU8825_BCLKDIV,
+	NAU8825_FSDIV,
+};
+
 /* System Clock Source */
 enum {
 	NAU8825_CLK_DIS = 0,
-- 
2.6.4
