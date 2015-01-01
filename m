From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 05/21] ASoC: wm1133-ev1: Use static DAI format
	setup
Date: Thu,  1 Jan 2015 17:16:14 +0100
Message-ID: <1420128990-6872-6-git-send-email-lars@metafoo.de>
References: <1420128990-6872-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-118.synserver.de (smtp-out-118.synserver.de
 [212.40.185.118])
 by alsa0.perex.cz (Postfix) with ESMTP id C7C6F2604F7
 for <alsa-devel@alsa-project.org>; Thu,  1 Jan 2015 17:16:41 +0100 (CET)
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
 sound/soc/fsl/wm1133-ev1.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/sound/soc/fsl/wm1133-ev1.c b/sound/soc/fsl/wm1133-ev1.c
index 804749a..d072bd1 100644
--- a/sound/soc/fsl/wm1133-ev1.c
+++ b/sound/soc/fsl/wm1133-ev1.c
@@ -87,7 +87,6 @@ static int wm1133_ev1_hw_params(struct snd_pcm_substream *substream,
 	snd_pcm_format_t format = params_format(params);
 	unsigned int rate = params_rate(params);
 	unsigned int channels = params_channels(params);
-	u32 dai_format;
 
 	/* find the correct audio parameters */
 	for (i = 0; i < ARRAY_SIZE(wm8350_audio); i++) {
@@ -104,15 +103,6 @@ static int wm1133_ev1_hw_params(struct snd_pcm_substream *substream,
 	/* codec FLL input is 14.75 MHz from MCLK */
 	snd_soc_dai_set_pll(codec_dai, 0, 0, 14750000, wm8350_audio[i].sysclk);
 
-	dai_format = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
-		SND_SOC_DAIFMT_CBM_CFM;
-
-	/* set codec DAI configuration */
-	snd_soc_dai_set_fmt(codec_dai, dai_format);
-
-	/* set cpu DAI configuration */
-	snd_soc_dai_set_fmt(cpu_dai, dai_format);
-
 	/* TODO: The SSI driver should figure this out for us */
 	switch (channels) {
 	case 2:
@@ -244,6 +234,8 @@ static struct snd_soc_dai_link wm1133_ev1_dai = {
 	.init = wm1133_ev1_init,
 	.ops = &wm1133_ev1_ops,
 	.symmetric_rates = 1,
+	.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
+		   SND_SOC_DAIFMT_CBM_CFM,
 };
 
 static struct snd_soc_card wm1133_ev1 = {
-- 
1.8.0
