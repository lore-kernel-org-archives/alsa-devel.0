From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 06/11] ASoC: Add a set_bias_level() callback to
	the DAPM context struct
Date: Sun, 18 May 2014 14:24:13 +0200
Message-ID: <1400415858-11025-7-git-send-email-lars@metafoo.de>
References: <1400415858-11025-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-145.synserver.de (smtp-out-151.synserver.de
 [212.40.185.151])
 by alsa0.perex.cz (Postfix) with ESMTP id A326F264F0D
 for <alsa-devel@alsa-project.org>; Sun, 18 May 2014 14:24:29 +0200 (CEST)
In-Reply-To: <1400415858-11025-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Currently the DAPM code directly looks at the CODEC driver struct to get a
handle to the set_bias_level() callback. This patch adds a new set_bias_level()
callback to the DAPM context struct. The DAPM code will use this new callback
instead of the CODEC callback. For CODECs the new callback is set up to call the
CODEC specific set_bias_level callback(). Not looking directly at the CODEC
driver struct will allow non CODEC DAPM contexts to implement a set_bias_level()
callback.

This is also similar to how the seq_notifier() and stream_event() callbacks are
currently handled.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc-dapm.h |  2 ++
 sound/soc/soc-core.c     |  9 +++++++++
 sound/soc/soc-dapm.c     | 11 +++--------
 3 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 8db627c..3a5c4f9 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -601,6 +601,8 @@ struct snd_soc_dapm_context {
 	struct list_head list;
 
 	int (*stream_event)(struct snd_soc_dapm_context *dapm, int event);
+	int (*set_bias_level)(struct snd_soc_dapm_context *dapm,
+			      enum snd_soc_bias_level level);
 
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *debugfs_dapm;
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index bca8a71..f42429c 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -4285,6 +4285,13 @@ static int snd_soc_codec_drv_read(struct snd_soc_component *component,
 	return 0;
 }
 
+static int snd_soc_codec_set_bias_level(struct snd_soc_dapm_context *dapm,
+	enum snd_soc_bias_level level)
+{
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(dapm);
+	return codec->driver->set_bias_level(codec, level);
+}
+
 /**
  * snd_soc_register_codec - Register a codec with the ASoC core
  *
@@ -4322,6 +4329,8 @@ int snd_soc_register_codec(struct device *dev,
 	codec->dapm.component = &codec->component;
 	codec->dapm.seq_notifier = codec_drv->seq_notifier;
 	codec->dapm.stream_event = codec_drv->stream_event;
+	if (codec_drv->set_bias_level)
+		codec->dapm.set_bias_level = snd_soc_codec_set_bias_level;
 	codec->dev = dev;
 	codec->driver = codec_drv;
 	codec->component.val_bytes = codec_drv->reg_word_size;
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 3ccbf9b..297b712 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -427,15 +427,10 @@ static int snd_soc_dapm_set_bias_level(struct snd_soc_dapm_context *dapm,
 	if (ret != 0)
 		goto out;
 
-	if (dapm->codec) {
-		if (dapm->codec->driver->set_bias_level)
-			ret = dapm->codec->driver->set_bias_level(dapm->codec,
-								  level);
-		else
-			dapm->bias_level = level;
-	} else if (!card || dapm != &card->dapm) {
+	if (dapm->set_bias_level)
+		ret = dapm->set_bias_level(dapm, level);
+	else if (!card || dapm != &card->dapm)
 		dapm->bias_level = level;
-	}
 
 	if (ret != 0)
 		goto out;
-- 
1.8.0
