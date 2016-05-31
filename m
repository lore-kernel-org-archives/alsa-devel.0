From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: [PATCH 2/2] ASoC: cs53l30: Check return value of regcache_sync()
Date: Tue, 31 May 2016 16:06:39 -0700
Message-ID: <1464735999-10384-2-git-send-email-nicoleotsuka@gmail.com>
References: <1464735999-10384-1-git-send-email-nicoleotsuka@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464735999-10384-1-git-send-email-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: lgirdwood@gmail.com, brian.austin@cirrus.com, Paul.Handrigan@cirrus.com, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Regcache_sync() might fail. So this patch adds a return value Check for it.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 sound/soc/codecs/cs53l30.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs53l30.c b/sound/soc/codecs/cs53l30.c
index 9aff449..ac90dd7 100644
--- a/sound/soc/codecs/cs53l30.c
+++ b/sound/soc/codecs/cs53l30.c
@@ -1055,7 +1055,11 @@ static int cs53l30_runtime_resume(struct device *dev)
 		gpiod_set_value_cansleep(cs53l30->reset_gpio, 1);
 
 	regcache_cache_only(cs53l30->regmap, false);
-	regcache_sync(cs53l30->regmap);
+	ret = regcache_sync(cs53l30->regmap);
+	if (ret) {
+		dev_err(dev, "failed to synchronize regcache: %d\n", ret);
+		return ret;
+	}
 
 	return 0;
 }
-- 
2.1.4
