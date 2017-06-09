From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 1/3] ALSA: pcm: localize
	snd_pcm_hw_params_choose()
Date: Fri,  9 Jun 2017 21:46:48 +0900
Message-ID: <20170609124650.19989-2-o-takashi@sakamocchi.jp>
References: <20170609124650.19989-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 1E41E26763B
 for <alsa-devel@alsa-project.org>; Fri,  9 Jun 2017 14:47:00 +0200 (CEST)
In-Reply-To: <20170609124650.19989-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

As of v4.12, snd_pcm_hw_params_choose() is just called in a process
context of ioctl(2) with SNDRV_PCM_IOCTL_HW_PARAMS. The function locates
in a different file, which has no tracepoints.

This commit moves the function to a file with the tracepoints for later
commit.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/pcm_lib.c    | 40 ----------------------------------------
 sound/core/pcm_local.h  |  3 ---
 sound/core/pcm_native.c | 40 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 40 insertions(+), 43 deletions(-)

diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index 95b8ef15029f..9dc7bbfe8853 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -1700,46 +1700,6 @@ int snd_pcm_hw_param_last(struct snd_pcm_substream *pcm,
 
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
diff --git a/sound/core/pcm_local.h b/sound/core/pcm_local.h
index 34c66decaaf2..e4bf2af62b02 100644
--- a/sound/core/pcm_local.h
+++ b/sound/core/pcm_local.h
@@ -24,9 +24,6 @@ void snd_interval_mulkdiv(const struct snd_interval *a, unsigned int k,
 int snd_pcm_hw_constraints_init(struct snd_pcm_substream *substream);
 int snd_pcm_hw_constraints_complete(struct snd_pcm_substream *substream);
 
-int snd_pcm_hw_params_choose(struct snd_pcm_substream *substream,
-			     struct snd_pcm_hw_params *params);
-
 int snd_pcm_hw_constraint_mask(struct snd_pcm_runtime *runtime,
 			       snd_pcm_hw_param_t var, u_int32_t mask);
 
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 3293db0172db..8d9d181b1c03 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -571,6 +571,46 @@ static inline void snd_pcm_timer_notify(struct snd_pcm_substream *substream,
 #endif
 }
 
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
 static int snd_pcm_hw_params(struct snd_pcm_substream *substream,
 			     struct snd_pcm_hw_params *params)
 {
-- 
2.11.0
