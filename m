From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 10/12] wm8974: fix a memory leak if another WM8974 is
	registered
Date: Thu, 15 Jul 2010 11:07:50 +0800
Message-ID: <1279163270.29294.28.camel@mola>
References: <1279162147.29294.2.camel@mola>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1279162147.29294.2.camel@mola>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Javier Martin <javier.martin@vista-silicon.com>, Tejun Heo <tj@kernel.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

wm8974 is allocated in wm8974_i2c_probe() but is not freed if wm8974_register()
return -EINVAL (if another WM8974 is registered).

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/wm8974.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm8974.c b/sound/soc/codecs/wm8974.c
index a2c4b2f..1468fe1 100644
--- a/sound/soc/codecs/wm8974.c
+++ b/sound/soc/codecs/wm8974.c
@@ -670,7 +670,8 @@ static __devinit int wm8974_register(struct wm8974_priv *wm8974)
 
 	if (wm8974_codec) {
 		dev_err(codec->dev, "Another WM8974 is registered\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err;
 	}
 
 	mutex_init(&codec->mutex);
-- 
1.5.4.3
