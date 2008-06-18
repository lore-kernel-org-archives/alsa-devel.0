From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: [PATCH] alsa: add annotations to bitwise type
	snd_pcm_hw_param_t
Date: Wed, 18 Jun 2008 13:45:13 -0700
Message-ID: <1213821913.2125.21.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.241])
	by alsa0.perex.cz (Postfix) with ESMTP id 0850B103812
	for <alsa-devel@alsa-project.org>;
	Wed, 18 Jun 2008 22:45:15 +0200 (CEST)
Received: by rv-out-0708.google.com with SMTP id f25so5148823rvb.32
	for <alsa-devel@alsa-project.org>; Wed, 18 Jun 2008 13:45:14 -0700 (PDT)
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
Cc: Alexander Viro <viro@ftp.linux.org.uk>
List-Id: alsa-devel@alsa-project.org

Fully half of all alsa sparse warnings are from snd_pcm_hw_param_t degrading
to integer type, this goes a long way towards eliminating them.

Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
---
 include/sound/asound.h |   12 ++++++++----
 include/sound/pcm.h    |   32 ++++++++++++++++----------------
 2 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/include/sound/asound.h b/include/sound/asound.h
index 3eaf155..0309da2 100644
--- a/include/sound/asound.h
+++ b/include/sound/asound.h
@@ -302,6 +302,8 @@ typedef int __bitwise snd_pcm_hw_param_t;
 #define	SNDRV_PCM_HW_PARAM_SUBFORMAT	((__force snd_pcm_hw_param_t) 2) /* Subformat */
 #define	SNDRV_PCM_HW_PARAM_FIRST_MASK	SNDRV_PCM_HW_PARAM_ACCESS
 #define	SNDRV_PCM_HW_PARAM_LAST_MASK	SNDRV_PCM_HW_PARAM_SUBFORMAT
+#define SNDRV_PCM_HW_PARAM_MASK_INDEX(var)	\
+	((__force int)(var) - (__force int)SNDRV_PCM_HW_PARAM_FIRST_MASK)
 
 #define	SNDRV_PCM_HW_PARAM_SAMPLE_BITS	((__force snd_pcm_hw_param_t) 8) /* Bits per sample */
 #define	SNDRV_PCM_HW_PARAM_FRAME_BITS	((__force snd_pcm_hw_param_t) 9) /* Bits per frame */
@@ -317,6 +319,8 @@ typedef int __bitwise snd_pcm_hw_param_t;
 #define	SNDRV_PCM_HW_PARAM_TICK_TIME	((__force snd_pcm_hw_param_t) 19) /* Approx tick duration in us */
 #define	SNDRV_PCM_HW_PARAM_FIRST_INTERVAL	SNDRV_PCM_HW_PARAM_SAMPLE_BITS
 #define	SNDRV_PCM_HW_PARAM_LAST_INTERVAL	SNDRV_PCM_HW_PARAM_TICK_TIME
+#define SNDRV_PCM_HW_PARAM_INTERVAL_INDEX(var)	\
+	((__force int)(var) - (__force int)SNDRV_PCM_HW_PARAM_FIRST_INTERVAL)
 
 #define SNDRV_PCM_HW_PARAMS_NORESAMPLE		(1<<0)	/* avoid rate resampling */
 
@@ -336,11 +340,11 @@ struct snd_mask {
 
 struct snd_pcm_hw_params {
 	unsigned int flags;
-	struct snd_mask masks[SNDRV_PCM_HW_PARAM_LAST_MASK - 
-			       SNDRV_PCM_HW_PARAM_FIRST_MASK + 1];
+	struct snd_mask masks[
+		SNDRV_PCM_HW_PARAM_MASK_INDEX(SNDRV_PCM_HW_PARAM_LAST_MASK) + 1];
 	struct snd_mask mres[5];	/* reserved masks */
-	struct snd_interval intervals[SNDRV_PCM_HW_PARAM_LAST_INTERVAL -
-				        SNDRV_PCM_HW_PARAM_FIRST_INTERVAL + 1];
+	struct snd_interval intervals[
+		SNDRV_PCM_HW_PARAM_INTERVAL_INDEX(SNDRV_PCM_HW_PARAM_LAST_INTERVAL) + 1];
 	struct snd_interval ires[9];	/* reserved intervals */
 	unsigned int rmask;		/* W: requested masks */
 	unsigned int cmask;		/* R: changed masks */
diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index 51d58cc..5315b53 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -209,10 +209,10 @@ struct snd_pcm_hw_rule {
 };
 
 struct snd_pcm_hw_constraints {
-	struct snd_mask masks[SNDRV_PCM_HW_PARAM_LAST_MASK - 
-			 SNDRV_PCM_HW_PARAM_FIRST_MASK + 1];
-	struct snd_interval intervals[SNDRV_PCM_HW_PARAM_LAST_INTERVAL -
-			     SNDRV_PCM_HW_PARAM_FIRST_INTERVAL + 1];
+	struct snd_mask masks[
+		SNDRV_PCM_HW_PARAM_MASK_INDEX(SNDRV_PCM_HW_PARAM_LAST_MASK) + 1];
+	struct snd_interval intervals[
+		SNDRV_PCM_HW_PARAM_INTERVAL_INDEX(SNDRV_PCM_HW_PARAM_LAST_INTERVAL) + 1];
 	unsigned int rules_num;
 	unsigned int rules_all;
 	struct snd_pcm_hw_rule *rules;
@@ -221,13 +221,13 @@ struct snd_pcm_hw_constraints {
 static inline struct snd_mask *constrs_mask(struct snd_pcm_hw_constraints *constrs,
 					    snd_pcm_hw_param_t var)
 {
-	return &constrs->masks[var - SNDRV_PCM_HW_PARAM_FIRST_MASK];
+	return &constrs->masks[SNDRV_PCM_HW_PARAM_MASK_INDEX(var)];
 }
 
 static inline struct snd_interval *constrs_interval(struct snd_pcm_hw_constraints *constrs,
 						    snd_pcm_hw_param_t var)
 {
-	return &constrs->intervals[var - SNDRV_PCM_HW_PARAM_FIRST_INTERVAL];
+	return &constrs->intervals[SNDRV_PCM_HW_PARAM_INTERVAL_INDEX(var)];
 }
 
 struct snd_ratnum {
@@ -761,40 +761,40 @@ static inline void snd_pcm_trigger_done(struct snd_pcm_substream *substream,
 	substream->runtime->trigger_master = master;
 }
 
-static inline int hw_is_mask(int var)
+static inline int hw_is_mask(snd_pcm_hw_param_t var)
 {
-	return var >= SNDRV_PCM_HW_PARAM_FIRST_MASK &&
-		var <= SNDRV_PCM_HW_PARAM_LAST_MASK;
+	return (__force int)var >= (__force int)SNDRV_PCM_HW_PARAM_FIRST_MASK &&
+		(__force int)var <= (__force int)SNDRV_PCM_HW_PARAM_LAST_MASK;
 }
 
-static inline int hw_is_interval(int var)
+static inline int hw_is_interval(snd_pcm_hw_param_t var)
 {
-	return var >= SNDRV_PCM_HW_PARAM_FIRST_INTERVAL &&
-		var <= SNDRV_PCM_HW_PARAM_LAST_INTERVAL;
+	return (__force int)var >= (__force int)SNDRV_PCM_HW_PARAM_FIRST_INTERVAL &&
+		(__force int)var <= (__force int)SNDRV_PCM_HW_PARAM_LAST_INTERVAL;
 }
 
 static inline struct snd_mask *hw_param_mask(struct snd_pcm_hw_params *params,
 				     snd_pcm_hw_param_t var)
 {
-	return &params->masks[var - SNDRV_PCM_HW_PARAM_FIRST_MASK];
+	return &params->masks[SNDRV_PCM_HW_PARAM_MASK_INDEX(var)];
 }
 
 static inline struct snd_interval *hw_param_interval(struct snd_pcm_hw_params *params,
 					     snd_pcm_hw_param_t var)
 {
-	return &params->intervals[var - SNDRV_PCM_HW_PARAM_FIRST_INTERVAL];
+	return &params->intervals[SNDRV_PCM_HW_PARAM_INTERVAL_INDEX(var)];
 }
 
 static inline const struct snd_mask *hw_param_mask_c(const struct snd_pcm_hw_params *params,
 					     snd_pcm_hw_param_t var)
 {
-	return &params->masks[var - SNDRV_PCM_HW_PARAM_FIRST_MASK];
+	return &params->masks[SNDRV_PCM_HW_PARAM_MASK_INDEX(var)];
 }
 
 static inline const struct snd_interval *hw_param_interval_c(const struct snd_pcm_hw_params *params,
 						     snd_pcm_hw_param_t var)
 {
-	return &params->intervals[var - SNDRV_PCM_HW_PARAM_FIRST_INTERVAL];
+	return &params->intervals[SNDRV_PCM_HW_PARAM_INTERVAL_INDEX(var)];
 }
 
 #define params_access(p) snd_mask_min(hw_param_mask((p), SNDRV_PCM_HW_PARAM_ACCESS))
-- 
1.5.6.rc3.295.gdca2e
