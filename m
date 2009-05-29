From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 1/1] ASoC: TWL4030: Use reg_cache in
	twl4030_init_chip
Date: Fri, 29 May 2009 09:22:37 +0300
Message-ID: <1243578157-27690-2-git-send-email-peter.ujfalusi@nokia.com>
References: <1243578157-27690-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 0E9F12449E
	for <alsa-devel@alsa-project.org>;
	Fri, 29 May 2009 08:23:42 +0200 (CEST)
In-Reply-To: <1243578157-27690-1-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: sakoman@gmail.com, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Use the codec->reg_cache instead of the array directly
in twl4030_init_chip for setting the default values.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/twl4030.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 63ebd17..df474a5 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -145,7 +145,6 @@ struct twl4030_priv {
 static inline unsigned int twl4030_read_reg_cache(struct snd_soc_codec *codec,
 	unsigned int reg)
 {
-	u8 *cache = codec->reg_cache;
 
 	if (reg >= TWL4030_CACHEREGNUM)
 		return -EIO;
@@ -204,6 +203,7 @@ static void twl4030_codec_enable(struct snd_soc_codec *codec, int enable)
 
 static void twl4030_init_chip(struct snd_soc_codec *codec)
 {
+	u8 *cache = codec->reg_cache;
 	int i;
 
 	/* clear CODECPDZ prior to setting register defaults */
@@ -211,7 +211,7 @@ static void twl4030_init_chip(struct snd_soc_codec *codec)
 
 	/* set all audio section registers to reasonable defaults */
 	for (i = TWL4030_REG_OPTION; i <= TWL4030_REG_MISC_SET_2; i++)
-		twl4030_write(codec, i,	twl4030_reg[i]);
+		twl4030_write(codec, i,	cache[i]);
 
 }
 
-- 
1.6.3.1
