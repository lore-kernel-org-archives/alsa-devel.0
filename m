From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: Drop exporting sn95031_get_mic_bias
Date: Sat, 24 Sep 2011 18:16:15 +0800
Message-ID: <1316859375.11157.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Vinod Koul <vinod.koul@linux.intel.com>, Harsha Priya <priya.harsha@intel.com>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

sn95031_get_mic_bias() is not used outside this driver
and it is a static function now.
Thus drop exporting sn95031_get_mic_bias.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/sn95031.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/sn95031.c b/sound/soc/codecs/sn95031.c
index d1781d1..8f8ce5f 100644
--- a/sound/soc/codecs/sn95031.c
+++ b/sound/soc/codecs/sn95031.c
@@ -161,7 +161,6 @@ static unsigned int sn95031_get_mic_bias(struct snd_soc_codec *codec)
 	pr_debug("mic bias = %dmV\n", mic_bias);
 	return mic_bias;
 }
-EXPORT_SYMBOL_GPL(sn95031_get_mic_bias);
 /*end - adc helper functions */
 
 static inline unsigned int sn95031_read(struct snd_soc_codec *codec,
-- 
1.7.4.1
