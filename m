From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 12/12] wm9081: fix resource reclaim in wm9081_register
	error path
Date: Thu, 15 Jul 2010 11:11:08 +0800
Message-ID: <1279163468.29294.32.camel@mola>
References: <1279162147.29294.2.camel@mola>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1279162147.29294.2.camel@mola>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Daniel Ribeiro <drwyrm@gmail.com>, Tejun Heo <tj@kernel.org>, Jiri Kosina <jkosina@suse.cz>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This patch fixes the error path in wm9081_register to properly free resources.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/wm9081.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/wm9081.c b/sound/soc/codecs/wm9081.c
index 13186fb..76b37ff 100644
--- a/sound/soc/codecs/wm9081.c
+++ b/sound/soc/codecs/wm9081.c
@@ -1356,7 +1356,7 @@ static int wm9081_register(struct wm9081_priv *wm9081,
 	ret = snd_soc_codec_set_cache_io(codec, 8, 16, control);
 	if (ret != 0) {
 		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
-		return ret;
+		goto err;
 	}
 
 	reg = snd_soc_read(codec, WM9081_SOFTWARE_RESET);
@@ -1369,7 +1369,7 @@ static int wm9081_register(struct wm9081_priv *wm9081,
 	ret = wm9081_reset(codec);
 	if (ret < 0) {
 		dev_err(codec->dev, "Failed to issue reset\n");
-		return ret;
+		goto err;
 	}
 
 	wm9081_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
@@ -1388,18 +1388,19 @@ static int wm9081_register(struct wm9081_priv *wm9081,
 	ret = snd_soc_register_codec(codec);
 	if (ret != 0) {
 		dev_err(codec->dev, "Failed to register codec: %d\n", ret);
-		return ret;
+		goto err;
 	}
 
 	ret = snd_soc_register_dai(&wm9081_dai);
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
 	kfree(wm9081);
 	return ret;
-- 
1.5.4.3
