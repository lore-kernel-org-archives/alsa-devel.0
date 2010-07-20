From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] wm8960: fix compile error
Date: Tue, 20 Jul 2010 17:49:22 +0800
Message-ID: <1279619362.11179.2.camel@mola>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Tejun Heo <tj@kernel.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This patch fixes compile error:
sound/soc/codecs/wm8960.c: In function 'wm8960_hw_params':
sound/soc/codecs/wm8960.c:511: error: 'codec' undeclared (first use in this function)
sound/soc/codecs/wm8960.c:511: error: (Each undeclared identifier is reported only once
sound/soc/codecs/wm8960.c:511: error: for each function it appears in.)
make[3]: *** [sound/soc/codecs/wm8960.o] Error 1
make[2]: *** [sound/soc/codecs] Error 2
make[1]: *** [sound/soc] Error 2
make: *** [sound] Error 2

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
This patch is against Liam's multi-component branch.

Axel

 sound/soc/codecs/wm8960.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index e6df6e3..599c559 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -508,8 +508,8 @@ static int wm8960_hw_params(struct snd_pcm_substream *substream,
 			    struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct wm8960_priv *wm8960 = snd_soc_codec_get_drvdata(codec);
 	struct snd_soc_codec *codec = rtd->codec;
+	struct wm8960_priv *wm8960 = snd_soc_codec_get_drvdata(codec);
 	u16 iface = snd_soc_read(codec, WM8960_IFACE1) & 0xfff3;
 	int i;
 
-- 
1.5.4.3
