From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 8/12] wm8955: fix resource reclaim in wm8955_register error
	path
Date: Thu, 15 Jul 2010 11:03:50 +0800
Message-ID: <1279163030.29294.23.camel@mola>
References: <1279162147.29294.2.camel@mola>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1279162147.29294.2.camel@mola>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Tejun Heo <tj@kernel.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This patch fixes the error path in wm8955_register to properly free resources.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/wm8955.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm8955.c b/sound/soc/codecs/wm8955.c
index fedb764..5f02559 100644
--- a/sound/soc/codecs/wm8955.c
+++ b/sound/soc/codecs/wm8955.c
@@ -964,7 +964,8 @@ static int wm8955_register(struct wm8955_priv *wm8955,
 
 	if (wm8955_codec) {
 		dev_err(codec->dev, "Another WM8955 is registered\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err;
 	}
 
 	mutex_init(&codec->mutex);
@@ -1047,18 +1048,19 @@ static int wm8955_register(struct wm8955_priv *wm8955,
 	ret = snd_soc_register_codec(codec);
 	if (ret != 0) {
 		dev_err(codec->dev, "Failed to register codec: %d\n", ret);
-		return ret;
+		goto err_enable;
 	}
 
 	ret = snd_soc_register_dai(&wm8955_dai);
 	if (ret != 0) {
 		dev_err(codec->dev, "Failed to register DAI: %d\n", ret);
-		snd_soc_unregister_codec(codec);
-		return ret;
+		goto err_codec;
 	}
 
 	return 0;
 
+err_codec:
+	snd_soc_unregister_codec(codec);
 err_enable:
 	regulator_bulk_disable(ARRAY_SIZE(wm8955->supplies), wm8955->supplies);
 err_get:
-- 
1.5.4.3
