From: srinivas.kandagatla@linaro.org
Subject: [PATCH v1 2/6] ASoC: codecs: msm8916-analog: fix DIG_CLK_CTL_RXD3_CLK_EN define
Date: Wed, 26 Jul 2017 02:35:08 +0200
Message-ID: <20170726003512.18965-3-srinivas.kandagatla@linaro.org>
References: <20170726003512.18965-1-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170726003512.18965-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Banajit Goswami <bgoswami@codeaurora.org>, alsa-devel@alsa-project.org
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Patrick Lai <plai@codeaurora.org>, linux-kernel@vger.kernel.org, Damien Riegel <damien.riegel@savoirfairelinux.com>
List-Id: alsa-devel@alsa-project.org

From: Damien Riegel <damien.riegel@savoirfairelinux.com>

The wrong bit is assigned to DIG_CLK_CTL_RXD3_CLK_EN, change it for the
correct one.

Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/msm8916-wcd-analog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/msm8916-wcd-analog.c b/sound/soc/codecs/msm8916-wcd-analog.c
index a788029..5710fd4 100644
--- a/sound/soc/codecs/msm8916-wcd-analog.c
+++ b/sound/soc/codecs/msm8916-wcd-analog.c
@@ -36,7 +36,7 @@
 #define CDC_D_CDC_DIG_CLK_CTL		(0xf04A)
 #define DIG_CLK_CTL_RXD1_CLK_EN		BIT(0)
 #define DIG_CLK_CTL_RXD2_CLK_EN		BIT(1)
-#define DIG_CLK_CTL_RXD3_CLK_EN		BIT(3)
+#define DIG_CLK_CTL_RXD3_CLK_EN		BIT(2)
 #define DIG_CLK_CTL_TXD_CLK_EN		BIT(4)
 #define DIG_CLK_CTL_NCP_CLK_EN_MASK	BIT(6)
 #define DIG_CLK_CTL_NCP_CLK_EN		BIT(6)
-- 
2.9.3
