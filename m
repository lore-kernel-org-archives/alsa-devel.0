From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 11/12] wm8978: fix a memory leak if another WM8978 is
	registered
Date: Thu, 15 Jul 2010 11:08:58 +0800
Message-ID: <1279163338.29294.30.camel@mola>
References: <1279162147.29294.2.camel@mola>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1279162147.29294.2.camel@mola>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Tejun Heo <tj@kernel.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

wm8978 is allocated in wm8978_i2c_probe() but is not freed if wm8978_register()
return -EINVAL (if another WM8978 is registered).

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/wm8978.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm8978.c b/sound/soc/codecs/wm8978.c
index 51d5f43..4e80323 100644
--- a/sound/soc/codecs/wm8978.c
+++ b/sound/soc/codecs/wm8978.c
@@ -1007,7 +1007,8 @@ static __devinit int wm8978_register(struct wm8978_priv *wm8978)
 
 	if (wm8978_codec) {
 		dev_err(codec->dev, "Another WM8978 is registered\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err;
 	}
 
 	/*
-- 
1.5.4.3
