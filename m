From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/3] ASoC: wm8962: Mark register cache as dirty
	when regulators are disabled
Date: Wed, 25 Jan 2012 21:14:09 +0000
Message-ID: <1327526050-1182-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1327526050-1182-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EB13D24141
	for <alsa-devel@alsa-project.org>; Wed, 25 Jan 2012 22:14:16 +0100 (CET)
In-Reply-To: <1327526050-1182-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Otherwise we won't resync later.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8962.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index f1fd630..59518a9 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -96,7 +96,7 @@ static int wm8962_regulator_event_##n(struct notifier_block *nb, \
 	struct wm8962_priv *wm8962 = container_of(nb, struct wm8962_priv, \
 						  disable_nb[n]); \
 	if (event & REGULATOR_EVENT_DISABLE) { \
-		regcache_cache_only(wm8962->regmap, true);	\
+		regcache_mark_dirty(wm8962->regmap);	\
 	} \
 	return 0; \
 }
-- 
1.7.9.rc1
