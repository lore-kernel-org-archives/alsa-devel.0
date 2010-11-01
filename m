From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Push snd_soc_write() and snd_soc_read()
	into the source file
Date: Mon,  1 Nov 2010 15:44:31 -0400
Message-ID: <1288640671-13554-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A1428243B1
	for <alsa-devel@alsa-project.org>; Mon,  1 Nov 2010 20:44:26 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Facilitating adding trace type stuff. For a first pass add some dev_dbg()
statements into them.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc.h  |   14 +++-----------
 sound/soc/soc-core.c |   19 +++++++++++++++++++
 2 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 5c3bce8..aaf34d7 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -639,17 +639,9 @@ struct soc_enum {
 };
 
 /* codec IO */
-static inline unsigned int snd_soc_read(struct snd_soc_codec *codec,
-					unsigned int reg)
-{
-	return codec->driver->read(codec, reg);
-}
-
-static inline unsigned int snd_soc_write(struct snd_soc_codec *codec,
-					 unsigned int reg, unsigned int val)
-{
-	return codec->driver->write(codec, reg, val);
-}
+unsigned int snd_soc_read(struct snd_soc_codec *codec, unsigned int reg);
+unsigned int snd_soc_write(struct snd_soc_codec *codec,
+			   unsigned int reg, unsigned int val);
 
 /* device driver data */
 
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 805343f..6d93d44 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1876,6 +1876,25 @@ void snd_soc_free_ac97_codec(struct snd_soc_codec *codec)
 }
 EXPORT_SYMBOL_GPL(snd_soc_free_ac97_codec);
 
+unsigned int snd_soc_read(struct snd_soc_codec *codec, unsigned int reg)
+{
+	unsigned int ret;
+
+	ret = codec->driver->read(codec, reg);
+	dev_dbg(codec->dev, "read %x => %x\n", reg, ret);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(snd_soc_read);
+
+unsigned int snd_soc_write(struct snd_soc_codec *codec,
+			   unsigned int reg, unsigned int val)
+{
+	dev_dbg(codec->dev, "write %x = %x\n", reg, val);
+	return codec->driver->write(codec, reg, val);
+}
+EXPORT_SYMBOL_GPL(snd_soc_write);
+
 /**
  * snd_soc_update_bits - update codec register bits
  * @codec: audio codec
-- 
1.7.1
