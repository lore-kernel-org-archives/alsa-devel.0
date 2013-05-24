From: Fabio Baltieri <fabio.baltieri@linaro.org>
Subject: [PATCH 2/6] ASoC: ab8500-codec: Move codec ops on a separate structure
Date: Fri, 24 May 2013 12:39:16 +0200
Message-ID: <1369391960-27320-3-git-send-email-fabio.baltieri@linaro.org>
References: <1369391960-27320-1-git-send-email-fabio.baltieri@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1369391960-27320-1-git-send-email-fabio.baltieri@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Lee Jones <lee.jones@linaro.org>, Ola Lilja <ola.o.lilja@stericsson.com>, Fabio Baltieri <fabio.baltieri@linaro.org>
List-Id: alsa-devel@alsa-project.org

Define ab8500 codec operations structure on its own rather than inline
with snd_soc_dai_drivers to clean up the code and make the style
coherent with other codec drivers.

Signed-off-by: Fabio Baltieri <fabio.baltieri@linaro.org>
---
 sound/soc/codecs/ab8500-codec.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/ab8500-codec.c b/sound/soc/codecs/ab8500-codec.c
index 4ca45b9..b8ba0ad 100644
--- a/sound/soc/codecs/ab8500-codec.c
+++ b/sound/soc/codecs/ab8500-codec.c
@@ -2380,6 +2380,11 @@ static int ab8500_codec_set_dai_tdm_slot(struct snd_soc_dai *dai,
 	return 0;
 }
 
+static const struct snd_soc_dai_ops ab8500_codec_ops = {
+	.set_fmt = ab8500_codec_set_dai_fmt,
+	.set_tdm_slot = ab8500_codec_set_dai_tdm_slot,
+};
+
 static struct snd_soc_dai_driver ab8500_codec_dai[] = {
 	{
 		.name = "ab8500-codec-dai.0",
@@ -2391,12 +2396,7 @@ static struct snd_soc_dai_driver ab8500_codec_dai[] = {
 			.rates = AB8500_SUPPORTED_RATE,
 			.formats = AB8500_SUPPORTED_FMT,
 		},
-		.ops = (struct snd_soc_dai_ops[]) {
-			{
-				.set_tdm_slot = ab8500_codec_set_dai_tdm_slot,
-				.set_fmt = ab8500_codec_set_dai_fmt,
-			}
-		},
+		.ops = &ab8500_codec_ops,
 		.symmetric_rates = 1
 	},
 	{
@@ -2409,12 +2409,7 @@ static struct snd_soc_dai_driver ab8500_codec_dai[] = {
 			.rates = AB8500_SUPPORTED_RATE,
 			.formats = AB8500_SUPPORTED_FMT,
 		},
-		.ops = (struct snd_soc_dai_ops[]) {
-			{
-				.set_tdm_slot = ab8500_codec_set_dai_tdm_slot,
-				.set_fmt = ab8500_codec_set_dai_fmt,
-			}
-		},
+		.ops = &ab8500_codec_ops,
 		.symmetric_rates = 1
 	}
 };
-- 
1.8.2
