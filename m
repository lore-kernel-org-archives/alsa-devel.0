From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 12/21] ASoC: jive_wm8750: Use static DAI format
	setup
Date: Thu,  1 Jan 2015 17:16:21 +0100
Message-ID: <1420128990-6872-13-git-send-email-lars@metafoo.de>
References: <1420128990-6872-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-118.synserver.de (smtp-out-118.synserver.de
 [212.40.185.118])
 by alsa0.perex.cz (Postfix) with ESMTP id BD15E260556
 for <alsa-devel@alsa-project.org>; Thu,  1 Jan 2015 17:16:49 +0100 (CET)
In-Reply-To: <1420128990-6872-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Sangbeom Kim <sbkim73@samsung.com>, Denis Carikli <denis@eukrea.com>, Manuel Lauss <manuel.lauss@googlemail.com>, Bo Shen <voice.shen@atmel.com>, Shawn Guo <shawn.guo@linaro.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org

Set the dai_fmt field in the dai_link struct instead of manually calling
snd_soc_dai_fmt(). This makes the code cleaner and shorter.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/samsung/jive_wm8750.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/sound/soc/samsung/jive_wm8750.c b/sound/soc/samsung/jive_wm8750.c
index b5f6abd..6c3b359 100644
--- a/sound/soc/samsung/jive_wm8750.c
+++ b/sound/soc/samsung/jive_wm8750.c
@@ -61,20 +61,6 @@ static int jive_hw_params(struct snd_pcm_substream *substream,
 	s3c_i2sv2_iis_calc_rate(&div, NULL, params_rate(params),
 				s3c_i2sv2_get_clock(cpu_dai));
 
-	/* set codec DAI configuration */
-	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
-				  SND_SOC_DAIFMT_NB_NF |
-				  SND_SOC_DAIFMT_CBS_CFS);
-	if (ret < 0)
-		return ret;
-
-	/* set cpu DAI configuration */
-	ret = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S |
-				  SND_SOC_DAIFMT_NB_NF |
-				  SND_SOC_DAIFMT_CBS_CFS);
-	if (ret < 0)
-		return ret;
-
 	/* set the codec system clock for DAC and ADC */
 	ret = snd_soc_dai_set_sysclk(codec_dai, WM8750_SYSCLK, clk,
 				     SND_SOC_CLOCK_IN);
@@ -121,6 +107,8 @@ static struct snd_soc_dai_link jive_dai = {
 	.platform_name	= "s3c2412-i2s",
 	.codec_name	= "wm8750.0-001a",
 	.init		= jive_wm8750_init,
+	.dai_fmt	= SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
+			  SND_SOC_DAIFMT_CBS_CFS,
 	.ops		= &jive_ops,
 };
 
-- 
1.8.0
