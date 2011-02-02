From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: soc-core: Remove display_register()
	callback
Date: Wed,  2 Feb 2011 10:20:54 +0000
Message-ID: <1296642054-10485-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C10E8103832
	for <alsa-devel@alsa-project.org>; Wed,  2 Feb 2011 11:20:56 +0100 (CET)
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

Remove the display_register() callback as there are no users of it
in the upstream kernel and makes it difficult to unify the format
of the codec_reg file.

Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 include/sound/soc.h  |    2 --
 sound/soc/soc-core.c |   31 +++++++++++++------------------
 2 files changed, 13 insertions(+), 20 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 4b6c0a8..2e6463f 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -536,8 +536,6 @@ struct snd_soc_codec_driver {
 	/* codec IO */
 	unsigned int (*read)(struct snd_soc_codec *, unsigned int);
 	int (*write)(struct snd_soc_codec *, unsigned int, unsigned int);
-	int (*display_register)(struct snd_soc_codec *, char *,
-				size_t, unsigned int);
 	int (*volatile_register)(struct snd_soc_codec *, unsigned int);
 	int (*readable_register)(struct snd_soc_codec *, unsigned int);
 	short reg_cache_size;
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 205cbd7..4c061c3 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -110,24 +110,19 @@ static ssize_t soc_codec_reg_show(struct snd_soc_codec *codec, char *buf)
 		if (count >= PAGE_SIZE - 1)
 			break;
 
-		if (codec->driver->display_register) {
-			count += codec->driver->display_register(codec, buf + count,
-							 PAGE_SIZE - count, i);
-		} else {
-			/* If the read fails it's almost certainly due to
-			 * the register being volatile and the device being
-			 * powered off.
-			 */
-			ret = snd_soc_read(codec, i);
-			if (ret >= 0)
-				count += snprintf(buf + count,
-						  PAGE_SIZE - count,
-						  "%.*x", wordsize, ret);
-			else
-				count += snprintf(buf + count,
-						  PAGE_SIZE - count,
-						  "<no data: %d>", ret);
-		}
+		/* If the read fails it's almost certainly due to
+		 * the register being volatile and the device being
+		 * powered off.
+		 */
+		ret = snd_soc_read(codec, i);
+		if (ret >= 0)
+			count += snprintf(buf + count,
+					  PAGE_SIZE - count,
+					  "%.*x", wordsize, ret);
+		else
+			count += snprintf(buf + count,
+					  PAGE_SIZE - count,
+					  "<no data: %d>", ret);
 
 		if (count >= PAGE_SIZE - 1)
 			break;
-- 
1.7.3.5
