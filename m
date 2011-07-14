From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: wm8900: fix a memory leak if wm8900_set_fll fails
Date: Thu, 14 Jul 2011 18:14:46 +0800
Message-ID: <1310638486.5186.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/wm8900.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm8900.c b/sound/soc/codecs/wm8900.c
index 449ea09..082040e 100644
--- a/sound/soc/codecs/wm8900.c
+++ b/sound/soc/codecs/wm8900.c
@@ -1167,6 +1167,7 @@ static int wm8900_resume(struct snd_soc_codec *codec)
 		ret = wm8900_set_fll(codec, 0, fll_in, fll_out);
 		if (ret != 0) {
 			dev_err(codec->dev, "Failed to restart FLL\n");
+			kfree(cache);
 			return ret;
 		}
 	}
-- 
1.7.4.1
