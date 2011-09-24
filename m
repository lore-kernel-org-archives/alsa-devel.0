From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: Drop exporting ad1980_dai
Date: Sat, 24 Sep 2011 18:43:43 +0800
Message-ID: <1316861023.11157.4.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Roy Huang <roy.huang@analog.com>, Cliff Cai <cliff.cai@analog.com>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

ad1980_dai is not used outside this driver,
thus drop exporting it.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/ad1980.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/ad1980.c b/sound/soc/codecs/ad1980.c
index 4c0fc30..e3931cc 100644
--- a/sound/soc/codecs/ad1980.c
+++ b/sound/soc/codecs/ad1980.c
@@ -148,7 +148,6 @@ static struct snd_soc_dai_driver ad1980_dai = {
 		.rates = SNDRV_PCM_RATE_48000,
 		.formats = SND_SOC_STD_AC97_FMTS, },
 };
-EXPORT_SYMBOL_GPL(ad1980_dai);
 
 static int ad1980_reset(struct snd_soc_codec *codec, int try_warm)
 {
-- 
1.7.4.1
