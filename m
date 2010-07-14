From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] wm8988: remove a redundant snd_soc_unregister_codec call
 in wm8988_register
Date: Wed, 14 Jul 2010 19:06:07 +0800
Message-ID: <1279105567.2290.8.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Tejun Heo <tj@kernel.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

snd_soc_unregister_codec is called twice if snd_soc_register_dai fail.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/wm8988.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm8988.c b/sound/soc/codecs/wm8988.c
index 0417dae..19ad590 100644
--- a/sound/soc/codecs/wm8988.c
+++ b/sound/soc/codecs/wm8988.c
@@ -885,7 +885,6 @@ static int wm8988_register(struct wm8988_priv *wm8988,
 	ret = snd_soc_register_dai(&wm8988_dai);
 	if (ret != 0) {
 		dev_err(codec->dev, "Failed to register DAI: %d\n", ret);
-		snd_soc_unregister_codec(codec);
 		goto err_codec;
 	}
 
-- 
1.7.0.4
