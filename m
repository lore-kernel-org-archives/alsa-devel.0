From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH 3/3] ASoC: Automatically assign the default
	readable()/volatile() functions
Date: Thu, 13 Jan 2011 12:15:05 +0000
Message-ID: <1294920905-6560-3-git-send-email-dp@opensource.wolfsonmicro.com>
References: <1294920905-6560-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 67862103831
	for <alsa-devel@alsa-project.org>; Thu, 13 Jan 2011 13:15:14 +0100 (CET)
In-Reply-To: <1294920905-6560-1-git-send-email-dp@opensource.wolfsonmicro.com>
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
Cc: Peter Hsiang <Peter.Hsiang@maxim-ic.com>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

Ensure that all calls to readable_register()/volatile_register() go via
the snd_soc_codec function pointers.

If the default register access table has been given but no functions
for handling readable()/volatile() registers, use the default ones provided
by soc-cache.

Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 include/sound/soc.h  |    2 ++
 sound/soc/soc-core.c |   15 ++++++++++++---
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 97d1832..accb8a1 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -480,6 +480,8 @@ struct snd_soc_codec {
 	int num_dai;
 	enum snd_soc_compress_type compress_type;
 	size_t reg_size;	/* reg_cache_size * reg_word_size */
+	int (*volatile_register)(struct snd_soc_codec *, unsigned int);
+	int (*readable_register)(struct snd_soc_codec *, unsigned int);
 
 	/* runtime */
 	struct snd_ac97 *ac97;  /* for ad-hoc ac97 devices */
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index a20a1e9..fbdf39d 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -85,7 +85,7 @@ static ssize_t soc_codec_reg_show(struct snd_soc_codec *codec, char *buf)
 
 	count += sprintf(buf, "%s registers\n", codec->name);
 	for (i = 0; i < codec->driver->reg_cache_size; i += step) {
-		if (codec->driver->readable_register && !codec->driver->readable_register(codec, i))
+		if (codec->readable_register && !codec->readable_register(codec, i))
 			continue;
 
 		count += sprintf(buf + count, "%2x: ", i);
@@ -2030,8 +2030,8 @@ static int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
  */
 int snd_soc_codec_volatile_register(struct snd_soc_codec *codec, int reg)
 {
-	if (codec->driver->volatile_register)
-		return codec->driver->volatile_register(codec, reg);
+	if (codec->volatile_register)
+		return codec->volatile_register(codec, reg);
 	else
 		return 0;
 }
@@ -3490,6 +3490,8 @@ int snd_soc_register_codec(struct device *dev,
 
 	codec->write = codec_drv->write;
 	codec->read = codec_drv->read;
+	codec->volatile_register = codec_drv->volatile_register;
+	codec->readable_register = codec_drv->readable_register;
 	codec->dapm.bias_level = SND_SOC_BIAS_OFF;
 	codec->dapm.dev = dev;
 	codec->dapm.codec = codec;
@@ -3518,6 +3520,13 @@ int snd_soc_register_codec(struct device *dev,
 		}
 	}
 
+	if (codec_drv->reg_access_size && codec_drv->reg_access_default) {
+		if (!codec->volatile_register)
+			codec->volatile_register = snd_soc_default_volatile_register;
+		if (!codec->readable_register)
+			codec->readable_register = snd_soc_default_readable_register;
+	}
+
 	for (i = 0; i < num_dai; i++) {
 		fixup_codec_formats(&dai_drv[i].playback);
 		fixup_codec_formats(&dai_drv[i].capture);
-- 
1.7.3.5
