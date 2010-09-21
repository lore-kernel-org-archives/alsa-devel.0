From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Fix soc-cache buffer overflow bug
Date: Tue, 21 Sep 2010 14:12:35 +0100
Message-ID: <1285074755-8627-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 47DD8103894
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Sep 2010 15:12:37 +0200 (CEST)
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

Make sure we stay within the cache boundaries when updating the
register cache.

Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 sound/soc/soc-cache.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
index 1228111..28bf1ff 100644
--- a/sound/soc/soc-cache.c
+++ b/sound/soc/soc-cache.c
@@ -203,8 +203,9 @@ static int snd_soc_8_16_write(struct snd_soc_codec *codec, unsigned int reg,
 	data[1] = (value >> 8) & 0xff;
 	data[2] = value & 0xff;
 
-	if (!snd_soc_codec_volatile_register(codec, reg))
-		reg_cache[reg] = value;
+	if (!snd_soc_codec_volatile_register(codec, reg)
+		&& reg < codec->driver->reg_cache_size)
+			reg_cache[reg] = value;
 
 	if (codec->cache_only) {
 		codec->cache_sync = 1;
-- 
1.7.3
