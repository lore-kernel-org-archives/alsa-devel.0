From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: stm32: sai: remove set but not used variables 'mask,
 cr1'" to the asoc tree
Date: Mon, 18 Feb 2019 18:49:17 +0000 (GMT)
Message-ID: <20190218184917.CDEC21128008@debutante.sirena.org.uk>
References: <20190218145026.142805-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190218145026.142805-1-yuehaibing@huawei.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: YueHaibing <yuehaibing@huawei.com>
Cc: alsa-devel@alsa-project.org, Olivier Moysan <olivier.moysan@st.com>, kernel-janitors@vger.kernel.org, Arnaud Pouliquen <arnaud.pouliquen@st.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Jaroslav Kysela <perex@perex.cz>, linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: stm32: sai: remove set but not used variables 'mask, cr1'

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 70605450fd42060783b0072a61a30f42a74f2917 Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Mon, 18 Feb 2019 14:50:26 +0000
Subject: [PATCH] ASoC: stm32: sai: remove set but not used variables 'mask,
 cr1'

Fixes gcc '-Wunused-but-set-variable' warning:

sound/soc/stm/stm32_sai_sub.c: In function 'stm32_sai_configure_clock':
sound/soc/stm/stm32_sai_sub.c:902:11: warning:
 variable 'mask' set but not used [-Wunused-but-set-variable]
sound/soc/stm/stm32_sai_sub.c:902:6: warning:
 variable 'cr1' set but not used [-Wunused-but-set-variable]

It's not used any more after 8307b2afd386 ("ASoC: stm32: sai: set sai as
mclk clock provider")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/stm/stm32_sai_sub.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index d4825700b63f..f9297228c41c 100644
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
 
@@ -943,10 +943,8 @@ static int stm32_sai_configure_clock(struct snd_soc_dai *cpu_dai,
 		} else {
 			if (sai->mclk_rate) {
 				mclk_ratio = sai->mclk_rate / rate;
-				if (mclk_ratio == 512) {
-					mask = SAI_XCR1_OSR;
-					cr1 = SAI_XCR1_OSR;
-				} else if (mclk_ratio != 256) {
+				if ((mclk_ratio != 512) &&
+				    (mclk_ratio != 256)) {
 					dev_err(cpu_dai->dev,
 						"Wrong mclk ratio %d\n",
 						mclk_ratio);
-- 
2.20.1
