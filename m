From: Alexander Sverdlin <subaparts@yandex.ru>
Subject: [PATCH] ASoC: EDB93xx: Manage I2S rates according to
 datasheet for CS4271 CODEC.
Date: Sat, 05 Mar 2011 03:55:20 +0300
Message-ID: <1299286520.27359.103.camel@r60e>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from forward9.mail.yandex.net (forward9.mail.yandex.net
	[77.88.61.48]) by alsa0.perex.cz (Postfix) with ESMTP id D3A1C243B2
	for <alsa-devel@alsa-project.org>; Sat,  5 Mar 2011 01:55:22 +0100 (CET)
Received: from smtp6.mail.yandex.net (smtp6.mail.yandex.net [77.88.61.56])
	by forward9.mail.yandex.net (Yandex) with ESMTP id 33985CE051C
	for <alsa-devel@alsa-project.org>; Sat,  5 Mar 2011 03:55:22 +0300 (MSK)
Received: from [192.168.1.202] (ppp91-77-173-192.pppoe.mtu-net.ru
	[91.77.173.192])
	by smtp6.mail.yandex.net (Yandex) with ESMTPA id CF8F92A8052
	for <alsa-devel@alsa-project.org>; Sat,  5 Mar 2011 03:55:21 +0300 (MSK)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Alexander Sverdlin <subaparts@yandex.ru>

Manage I2S rates according to datasheet for CS4271 CODEC in EDB93xx
machine driver.

Signed-off-by: Alexander Sverdlin <subaparts@yandex.ru>
---
 sound/soc/ep93xx/edb93xx.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/ep93xx/edb93xx.c b/sound/soc/ep93xx/edb93xx.c
index b270085..d3aa151 100644
--- a/sound/soc/ep93xx/edb93xx.c
+++ b/sound/soc/ep93xx/edb93xx.c
@@ -41,17 +41,17 @@ static int edb93xx_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	int err;
+	unsigned int mclk_rate;
 	unsigned int rate = params_rate(params);
+
 	/*
-	 * We set LRCLK equal to `rate' and SCLK = LRCLK * 64,
-	 * because our sample size is 32 bit * 2 channels.
-	 * I2S standard permits us to transmit more bits than
-	 * the codec uses.
-	 * MCLK = SCLK * 4 is the best recommended value,
-	 * but we have to fall back to ratio 2 for higher
-	 * sample rates.
+	 * According to CS4271 datasheet we use MCLK/LRCK=256 for
+	 * rates below 50kHz and 128 for higher sample rates
 	 */
-	unsigned int mclk_rate = rate * 64 * ((rate <= 48000) ? 4 : 2);
+	if (rate < 50000)
+		mclk_rate = rate * 64 * 4;
+	else
+		mclk_rate = rate * 64 * 2;
 
 	err = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
 				  SND_SOC_DAIFMT_NB_IF |
