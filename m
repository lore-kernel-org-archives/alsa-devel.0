From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 9/12] wm8961: fix resource reclaim in wm8961_register error
	path
Date: Thu, 15 Jul 2010 11:06:40 +0800
Message-ID: <1279163200.29294.25.camel@mola>
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

This patch fixes the error path in wm8961_register to properly free resources.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/wm8961.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm8961.c b/sound/soc/codecs/wm8961.c
index 5b9a756..2549d3a 100644
--- a/sound/soc/codecs/wm8961.c
+++ b/sound/soc/codecs/wm8961.c
@@ -1102,7 +1102,7 @@ static int wm8961_register(struct wm8961_priv *wm8961)
 	ret = wm8961_reset(codec);
 	if (ret < 0) {
 		dev_err(codec->dev, "Failed to issue reset\n");
-		return ret;
+		goto err;
 	}
 
 	/* Enable class W */
@@ -1147,18 +1147,19 @@ static int wm8961_register(struct wm8961_priv *wm8961)
 	ret = snd_soc_register_codec(codec);
 	if (ret != 0) {
 		dev_err(codec->dev, "Failed to register codec: %d\n", ret);
-		return ret;
+		goto err;
 	}
 
 	ret = snd_soc_register_dai(&wm8961_dai);
 	if (ret != 0) {
 		dev_err(codec->dev, "Failed to register DAI: %d\n", ret);
-		snd_soc_unregister_codec(codec);
-		return ret;
+		goto err_codec;
 	}
 
 	return 0;
 
+err_codec:
+	snd_soc_unregister_codec(codec);
 err:
 	kfree(wm8961);
 	return ret;
-- 
1.5.4.3
