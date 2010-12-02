From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH 1/3] ASoC: Add compress_type as a member to
	snd_soc_codec
Date: Thu,  2 Dec 2010 14:53:01 +0000
Message-ID: <1291301583-15491-2-git-send-email-dp@opensource.wolfsonmicro.com>
References: <1291301583-15491-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8C393103843
	for <alsa-devel@alsa-project.org>; Thu,  2 Dec 2010 15:53:11 +0100 (CET)
In-Reply-To: <1291301583-15491-1-git-send-email-dp@opensource.wolfsonmicro.com>
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

We need to keep a copy of the compress_type supplied by the codec driver
so that we can override it if necessary with whatever the machine driver
has provided us with.  The reason for not modifying the codec->driver
struct directly is that ideally we'd like to keep it const.

Adjust the code in soc-cache and soc-core to make use of the compress_type
member in the snd_soc_codec struct.

Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 include/sound/soc.h   |    1 +
 sound/soc/soc-cache.c |    4 ++--
 sound/soc/soc-core.c  |    5 +++++
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 4a9195c5..838ad36 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -460,6 +460,7 @@ struct snd_soc_codec {
 	struct list_head list;
 	struct list_head card_list;
 	int num_dai;
+	enum snd_soc_compress_type compress_type;
 
 	/* runtime */
 	struct snd_ac97 *ac97;  /* for ad-hoc ac97 devices */
diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
index 5143984..081221d 100644
--- a/sound/soc/soc-cache.c
+++ b/sound/soc/soc-cache.c
@@ -1550,11 +1550,11 @@ int snd_soc_cache_init(struct snd_soc_codec *codec)
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(cache_types); ++i)
-		if (cache_types[i].id == codec->driver->compress_type)
+		if (cache_types[i].id == codec->compress_type)
 			break;
 	if (i == ARRAY_SIZE(cache_types)) {
 		dev_err(codec->dev, "Could not match compress type: %d\n",
-			codec->driver->compress_type);
+			codec->compress_type);
 		return -EINVAL;
 	}
 
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index eb950f7..1f142ae 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3446,6 +3446,11 @@ int snd_soc_register_codec(struct device *dev,
 		return -ENOMEM;
 	}
 
+	if (codec_drv->compress_type)
+		codec->compress_type = codec_drv->compress_type;
+	else
+		codec->compress_type = SND_SOC_FLAT_COMPRESSION;
+
 	INIT_LIST_HEAD(&codec->dapm.widgets);
 	INIT_LIST_HEAD(&codec->dapm.paths);
 	codec->dapm.bias_level = SND_SOC_BIAS_OFF;
-- 
1.7.3.2
