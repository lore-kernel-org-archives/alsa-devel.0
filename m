From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 05/13] ASoC: Drop ASoC level caching from
	hw_write/hw_read
Date: Tue, 18 Mar 2014 09:02:08 +0100
Message-ID: <1395129736-11938-6-git-send-email-lars@metafoo.de>
References: <1395129736-11938-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-224.synserver.de (smtp-out-230.synserver.de
 [212.40.185.230])
 by alsa0.perex.cz (Postfix) with ESMTP id E1774261B0B
 for <alsa-devel@alsa-project.org>; Tue, 18 Mar 2014 09:01:44 +0100 (CET)
In-Reply-To: <1395129736-11938-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Brian Austin <brian.austin@cirrus.com>, Lars-Peter Clausen <lars@metafoo.de>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, Paul Handrigan <Paul.Handrigan@cirrus.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

All drivers using these functions now do regmap level caching. So this is dead
code and can be removed.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-io.c | 34 +++-------------------------------
 1 file changed, 3 insertions(+), 31 deletions(-)

diff --git a/sound/soc/soc-io.c b/sound/soc/soc-io.c
index de1e496..a66bc17 100644
--- a/sound/soc/soc-io.c
+++ b/sound/soc/soc-io.c
@@ -167,44 +167,16 @@ EXPORT_SYMBOL_GPL(snd_soc_platform_write);
 static int hw_write(struct snd_soc_codec *codec, unsigned int reg,
 		    unsigned int value)
 {
-	int ret;
-
-	if (!snd_soc_codec_volatile_register(codec, reg) &&
-	    reg < codec->driver->reg_cache_size &&
-	    !codec->cache_bypass) {
-		ret = snd_soc_cache_write(codec, reg, value);
-		if (ret < 0)
-			return -1;
-	}
-
-	if (codec->cache_only) {
-		codec->cache_sync = 1;
-		return 0;
-	}
-
 	return regmap_write(codec->control_data, reg, value);
 }
 
 static unsigned int hw_read(struct snd_soc_codec *codec, unsigned int reg)
 {
-	int ret;
 	unsigned int val;
+	int ret;
 
-	if (reg >= codec->driver->reg_cache_size ||
-	    snd_soc_codec_volatile_register(codec, reg) ||
-	    codec->cache_bypass) {
-		if (codec->cache_only)
-			return -1;
-
-		ret = regmap_read(codec->control_data, reg, &val);
-		if (ret == 0)
-			return val;
-		else
-			return -1;
-	}
-
-	ret = snd_soc_cache_read(codec, reg, &val);
-	if (ret < 0)
+	ret = regmap_read(codec->control_data, reg, &val);
+	if (ret != 0)
 		return -1;
 	return val;
 }
-- 
1.8.0
