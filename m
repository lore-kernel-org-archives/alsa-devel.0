From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 5/12] wm8711: fix a memory leak if another WM8711 is
	registered
Date: Thu, 15 Jul 2010 10:57:53 +0800
Message-ID: <1279162673.29294.14.camel@mola>
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

wm8711 is allocated in either wm8711_spi_probe() or wm8711_i2c_probe() but is
not freed if wm8711_register() return -EINVAL(if another ad1836 is registered).

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/wm8711.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm8711.c b/sound/soc/codecs/wm8711.c
index effb14e..e2dba07 100644
--- a/sound/soc/codecs/wm8711.c
+++ b/sound/soc/codecs/wm8711.c
@@ -439,7 +439,8 @@ static int wm8711_register(struct wm8711_priv *wm8711,
 
 	if (wm8711_codec) {
 		dev_err(codec->dev, "Another WM8711 is registered\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err;
 	}
 
 	mutex_init(&codec->mutex);
-- 
1.5.4.3
