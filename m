From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] ASoC: stm32: sai: remove set but not used variables 'mask, cr1'
Date: Mon, 18 Feb 2019 13:48:36 +0000
Message-ID: <20190218134836.107220-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Olivier Moysan <olivier.moysan@st.com>, Arnaud Pouliquen <arnaud.pouliquen@st.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: YueHaibing <yuehaibing@huawei.com>, alsa-devel@alsa-project.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Fixes gcc '-Wunused-but-set-variable' warning:

sound/soc/stm/stm32_sai_sub.c: In function 'stm32_sai_configure_clock':
sound/soc/stm/stm32_sai_sub.c:902:11: warning:
 variable 'mask' set but not used [-Wunused-but-set-variable]
sound/soc/stm/stm32_sai_sub.c:902:6: warning:
 variable 'cr1' set but not used [-Wunused-but-set-variable]

It's not used any more after 8307b2afd386 ("ASoC: stm32: sai: set sai as
mclk clock provider")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/soc/stm/stm32_sai_sub.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index d4825700b63f..a00640f1df06 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -898,7 +898,7 @@ static int stm32_sai_configure_clock(struct snd_soc_dai *cpu_dai,
 				     struct snd_pcm_hw_params *params)
 {
 	struct stm32_sai_sub_data *sai = snd_soc_dai_get_drvdata(cpu_dai);
-	int cr1, mask, div = 0;
+	int div = 0;
 	int sai_clk_rate, mclk_ratio, den;
 	unsigned int rate = params_rate(params);
 
@@ -944,8 +944,7 @@ static int stm32_sai_configure_clock(struct snd_soc_dai *cpu_dai,
 			if (sai->mclk_rate) {
 				mclk_ratio = sai->mclk_rate / rate;
 				if (mclk_ratio == 512) {
-					mask = SAI_XCR1_OSR;
-					cr1 = SAI_XCR1_OSR;
+					;
 				} else if (mclk_ratio != 256) {
 					dev_err(cpu_dai->dev,
 						"Wrong mclk ratio %d\n",
