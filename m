From: Damien Riegel <damien.riegel@savoirfairelinux.com>
Subject: [PATCH v1 3/3] ASoC: qcom: apq8016-sbc: enable jack
	detection
Date: Tue, 25 Jul 2017 13:51:26 -0400
Message-ID: <20170725175126.26578-4-damien.riegel@savoirfairelinux.com>
References: <20170725175126.26578-1-damien.riegel@savoirfairelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com
 [208.88.110.44])
 by alsa0.perex.cz (Postfix) with ESMTP id C5DC02672AC
 for <alsa-devel@alsa-project.org>; Tue, 25 Jul 2017 19:53:11 +0200 (CEST)
In-Reply-To: <20170725175126.26578-1-damien.riegel@savoirfairelinux.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Damien Riegel <damien.riegel@savoirfairelinux.com>, linux-kernel@vger.kernel.org, Patrick Lai <plai@codeaurora.org>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, kernel@savoirfairelinux.com
List-Id: alsa-devel@alsa-project.org

Now that the pm8916 audio codec has support for jack detection, let the
sound card driver use it.

Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
---
 sound/soc/qcom/apq8016_sbc.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/sound/soc/qcom/apq8016_sbc.c b/sound/soc/qcom/apq8016_sbc.c
index d084d7468299..5f03f6249397 100644
--- a/sound/soc/qcom/apq8016_sbc.c
+++ b/sound/soc/qcom/apq8016_sbc.c
@@ -19,11 +19,14 @@
 #include <linux/of.h>
 #include <linux/clk.h>
 #include <linux/platform_device.h>
+#include <sound/jack.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 #include <dt-bindings/sound/apq8016-lpass.h>
 
+#include "../codecs/msm8916-wcd-analog.h"
+
 struct apq8016_sbc_data {
 	void __iomem *mic_iomux;
 	void __iomem *spkr_iomux;
@@ -35,13 +38,26 @@ struct apq8016_sbc_data {
 #define MIC_CTRL_TLMM_SCLK_EN		BIT(1)
 #define	SPKR_CTL_PRI_WS_SLAVE_SEL_11	(BIT(17) | BIT(16))
 
+static struct snd_soc_jack apq8016_jack;
+
 static int apq8016_sbc_dai_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	struct snd_soc_card *card = rtd->card;
+	struct snd_soc_codec *codec = rtd->codec;
 	struct apq8016_sbc_data *pdata = snd_soc_card_get_drvdata(card);
 	int rval = 0;
 
+	if (!apq8016_jack.jack) {
+		rval = snd_soc_card_jack_new(card, "headset",
+					     SND_JACK_MECHANICAL,
+					     &apq8016_jack, NULL, 0);
+		if (rval)
+			return rval;
+
+		pm8916_wcd_analog_jack_detect(codec, &apq8016_jack);
+	}
+
 	switch (cpu_dai->id) {
 	case MI2S_PRIMARY:
 		writel(readl(pdata->spkr_iomux) | SPKR_CTL_PRI_WS_SLAVE_SEL_11,
-- 
2.13.3
