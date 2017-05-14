From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH RFC 11/21] ALSA: pcm: localize
	snd_pcm_hw_params_choose()
Date: Sun, 14 May 2017 17:57:46 +0900
Message-ID: <20170514085756.22382-12-o-takashi@sakamocchi.jp>
References: <20170514085756.22382-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id C3138266B88
 for <alsa-devel@alsa-project.org>; Sun, 14 May 2017 10:58:04 +0200 (CEST)
In-Reply-To: <20170514085756.22382-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de, lars@metafoo.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

As of v4.12, snd_pcm_hw_params_choose() is just called in a process
context of ioctl(2) with SNDRV_PCM_IOCTL_HW_PARAMS. The function locates
in a different file, which has no tracepoints.

This commit moves the function to a file with the tracepoints for later
commit.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 include/sound/pcm.h     |  1 -
 sound/core/pcm_lib.c    | 40 ----------------------------------------
 sound/core/pcm_native.c | 40 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 40 insertions(+), 41 deletions(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index 361749e..d68b353 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -984,7 +984,6 @@ int snd_interval_ratnum(struct snd_interval *i,
 
 void _snd_pcm_hw_params_any(struct snd_pcm_hw_params *params);
 void _snd_pcm_hw_param_setempty(struct snd_pcm_hw_params *params, snd_pcm_hw_param_t var);
-int snd_pcm_hw_params_choose(struct snd_pcm_substream *substream, struct snd_pcm_hw_params *params);
 
 int snd_pcm_hw_refine(struct snd_pcm_substream *substream, struct snd_pcm_hw_params *params);
 
diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index 0ab6f86..a62f1f4 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -1718,46 +1718,6 @@ int snd_pcm_hw_param_last(struct snd_pcm_substream *pcm,
 
 EXPORT_SYMBOL(snd_pcm_hw_param_last);
 
-/**
- * snd_pcm_hw_param_choose - choose a configuration defined by @params
- * @pcm: PCM instance
- * @params: the hw_params instance
- *
- * Choose one configuration from configuration space defined by @params.
- * The configuration chosen is that obtained fixing in this order:
- * first access, first format, first subformat, min channels,
- * min rate, min period time, max buffer size, min tick time
- *
- * Return: Zero if successful, or a negative error code on failure.
- */
-int snd_pcm_hw_params_choose(struct snd_pcm_substream *pcm,
-			     struct snd_pcm_hw_params *params)
-{
-	static const int vars[] = {
-		SNDRV_PCM_HW_PARAM_ACCESS,
-		SNDRV_PCM_HW_PARAM_FORMAT,
-		SNDRV_PCM_HW_PARAM_SUBFORMAT,
-		SNDRV_PCM_HW_PARAM_CHANNELS,
-		SNDRV_PCM_HW_PARAM_RATE,
-		SNDRV_PCM_HW_PARAM_PERIOD_TIME,
-		SNDRV_PCM_HW_PARAM_BUFFER_SIZE,
-		SNDRV_PCM_HW_PARAM_TICK_TIME,
-		-1
-	};
-	const int *v;
-	int err;
-
-	for (v = vars; *v != -1; v++) {
-		if (*v != SNDRV_PCM_HW_PARAM_BUFFER_SIZE)
-			err = snd_pcm_hw_param_first(pcm, params, *v, NULL);
-		else
-			err = snd_pcm_hw_param_last(pcm, params, *v, NULL);
-		if (snd_BUG_ON(err < 0))
-			return err;
-	}
-	return 0;
-}
-
 static int snd_pcm_lib_ioctl_reset(struct snd_pcm_substream *substream,
 				   void *arg)
 {
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 7044ae5..2c5a4d9 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -526,6 +526,46 @@ int snd_pcm_hw_refine(struct snd_pcm_substream *substream,
 
 EXPORT_SYMBOL(snd_pcm_hw_refine);
 
+/**
+ * snd_pcm_hw_param_choose - choose a configuration defined by @params
+ * @pcm: PCM instance
+ * @params: the hw_params instance
+ *
+ * Choose one configuration from configuration space defined by @params.
+ * The configuration chosen is that obtained fixing in this order:
+ * first access, first format, first subformat, min channels,
+ * min rate, min period time, max buffer size, min tick time
+ *
+ * Return: Zero if successful, or a negative error code on failure.
+ */
+static int snd_pcm_hw_params_choose(struct snd_pcm_substream *pcm,
+				    struct snd_pcm_hw_params *params)
+{
+	static const int vars[] = {
+		SNDRV_PCM_HW_PARAM_ACCESS,
+		SNDRV_PCM_HW_PARAM_FORMAT,
+		SNDRV_PCM_HW_PARAM_SUBFORMAT,
+		SNDRV_PCM_HW_PARAM_CHANNELS,
+		SNDRV_PCM_HW_PARAM_RATE,
+		SNDRV_PCM_HW_PARAM_PERIOD_TIME,
+		SNDRV_PCM_HW_PARAM_BUFFER_SIZE,
+		SNDRV_PCM_HW_PARAM_TICK_TIME,
+		-1
+	};
+	const int *v;
+	int err;
+
+	for (v = vars; *v != -1; v++) {
+		if (*v != SNDRV_PCM_HW_PARAM_BUFFER_SIZE)
+			err = snd_pcm_hw_param_first(pcm, params, *v, NULL);
+		else
+			err = snd_pcm_hw_param_last(pcm, params, *v, NULL);
+		if (snd_BUG_ON(err < 0))
+			return err;
+	}
+	return 0;
+}
+
 static int snd_pcm_hw_refine_user(struct snd_pcm_substream *substream,
 				  struct snd_pcm_hw_params __user * _params)
 {
-- 
2.9.3
