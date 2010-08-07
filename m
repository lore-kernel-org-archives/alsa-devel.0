From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH] ASoC: register cache should be 1 byte aligned
	for 1 byte long register
Date: Sat,  7 Aug 2010 11:16:27 -0400
Message-ID: <1281194187-20914-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.gentoo.org (smtp.gentoo.org [140.211.166.183])
	by alsa0.perex.cz (Postfix) with ESMTP id 8D2CB1037FC
	for <alsa-devel@alsa-project.org>;
	Sat,  7 Aug 2010 17:16:24 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, Cliff Cai <cliff.cai@analog.com>
List-Id: alsa-devel@alsa-project.org

From: Cliff Cai <cliff.cai@analog.com>

Signed-off-by: Cliff Cai <cliff.cai@analog.com>
Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 sound/soc/soc-cache.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
index 472af38..adbc68c 100644
--- a/sound/soc/soc-cache.c
+++ b/sound/soc/soc-cache.c
@@ -340,7 +340,7 @@ static unsigned int snd_soc_16_8_read_i2c(struct snd_soc_codec *codec,
 static unsigned int snd_soc_16_8_read(struct snd_soc_codec *codec,
 				     unsigned int reg)
 {
-	u16 *cache = codec->reg_cache;
+	u8 *cache = codec->reg_cache;
 
 	reg &= 0xff;
 	if (reg >= codec->reg_cache_size)
@@ -351,7 +351,7 @@ static unsigned int snd_soc_16_8_read(struct snd_soc_codec *codec,
 static int snd_soc_16_8_write(struct snd_soc_codec *codec, unsigned int reg,
 			     unsigned int value)
 {
-	u16 *cache = codec->reg_cache;
+	u8 *cache = codec->reg_cache;
 	u8 data[3];
 	int ret;
 
-- 
1.7.2
