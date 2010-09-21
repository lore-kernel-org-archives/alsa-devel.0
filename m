From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Return -1 instead of -EINVAL to ensure
	consistency
Date: Tue, 21 Sep 2010 17:04:07 +0100
Message-ID: <1285085047-31508-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DA33D1038B5
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Sep 2010 18:04:08 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

The code can't really cope with I/O errors, so it would be better
to be consistent throughout all cache functions and return -1 instead
of -EINVAL.

The return value of snd_soc_read(...) is mostly checked in the probe
function and nowhere else.
---
 sound/soc/soc-cache.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
index 28bf1ff..6702a3d 100644
--- a/sound/soc/soc-cache.c
+++ b/sound/soc/soc-cache.c
@@ -228,7 +228,7 @@ static unsigned int snd_soc_8_16_read(struct snd_soc_codec *codec,
 	if (reg >= codec->driver->reg_cache_size ||
 	    snd_soc_codec_volatile_register(codec, reg)) {
 		if (codec->cache_only)
-			return -EINVAL;
+			return -1;
 
 		return codec->hw_read(codec, reg);
 	} else {
@@ -455,7 +455,7 @@ static unsigned int snd_soc_16_16_read(struct snd_soc_codec *codec,
 	if (reg >= codec->driver->reg_cache_size ||
 	    snd_soc_codec_volatile_register(codec, reg)) {
 		if (codec->cache_only)
-			return -EINVAL;
+			return -1;
 
 		return codec->hw_read(codec, reg);
 	}
-- 
1.7.3
