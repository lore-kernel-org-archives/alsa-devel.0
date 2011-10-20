From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: rt5631: Remove unused codec field from struct
 rt5631_priv
Date: Thu, 20 Oct 2011 11:00:06 +0800
Message-ID: <1319079606.5380.6.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: flove <flove@realtek.com>, Johnny Hsu <johnnyhsu@realtek.com>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/rt5631.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt5631.c b/sound/soc/codecs/rt5631.c
index 86e69f4..27a078c 100644
--- a/sound/soc/codecs/rt5631.c
+++ b/sound/soc/codecs/rt5631.c
@@ -31,7 +31,6 @@
 #include "rt5631.h"
 
 struct rt5631_priv {
-	struct snd_soc_codec *codec;
 	int codec_version;
 	int master;
 	int sysclk;
@@ -1632,7 +1631,6 @@ static int rt5631_probe(struct snd_soc_codec *codec)
 	}
 
 	codec->dapm.bias_level = SND_SOC_BIAS_STANDBY;
-	rt5631->codec = codec;
 
 	return 0;
 }
-- 
1.7.5.4
