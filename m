From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH RFC 17/21] ALSA: pcm: check type of parameter
	in added rule
Date: Sun, 14 May 2017 17:57:52 +0900
Message-ID: <20170514085756.22382-18-o-takashi@sakamocchi.jp>
References: <20170514085756.22382-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 63A0A2668AC
 for <alsa-devel@alsa-project.org>; Sun, 14 May 2017 10:58:06 +0200 (CEST)
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

Drivers can register rule of PCM parameters by a call of
snd_pcm_hw_rule_add(). The rule includes a target parameter and dependent
parameters. Basically, these parameters are the ones classified as mask or
interval type. Although the helper function should check the variables, it
actually doesn't. This brings extra check in rule application.

This commit adds argument checker to the helper function. Unfortunately,
snd_pcm_hw_constraint_msbits() pass -1 as its parameter type. This is
because it's for non-mask/non-interval parameter. However, similar
helper functions, i.e. snd_pcm_hw_constraint_ratdens(), uses the same
value for target/dependent parameter. We can use
SNDRV_PCM_HW_PARAM_SAMPLE_BITS for the parameter.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/pcm_lib.c    | 13 +++++++++----
 sound/core/pcm_native.c |  2 +-
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index 9659fa6..f699245 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -1146,6 +1146,10 @@ int snd_pcm_hw_rule_add(struct snd_pcm_runtime *runtime, unsigned int cond,
 	struct snd_pcm_hw_rule *c;
 	unsigned int k;
 	va_list args;
+
+	if (!hw_is_mask(var) && !hw_is_interval(var))
+		return -EINVAL;
+
 	va_start(args, dep);
 	if (constrs->rules_num >= constrs->rules_all) {
 		struct snd_pcm_hw_rule *new;
@@ -1448,10 +1452,11 @@ int snd_pcm_hw_constraint_msbits(struct snd_pcm_runtime *runtime,
 				 unsigned int msbits)
 {
 	unsigned long l = (msbits << 16) | width;
-	return snd_pcm_hw_rule_add(runtime, cond, -1,
-				    snd_pcm_hw_rule_msbits,
-				    (void*) l,
-				    SNDRV_PCM_HW_PARAM_SAMPLE_BITS, -1);
+	return snd_pcm_hw_rule_add(runtime, cond,
+				   SNDRV_PCM_HW_PARAM_SAMPLE_BITS,
+				   snd_pcm_hw_rule_msbits,
+				   (void *) l,
+				   SNDRV_PCM_HW_PARAM_SAMPLE_BITS, -1);
 }
 
 EXPORT_SYMBOL(snd_pcm_hw_constraint_msbits);
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index ad71eb2..00d5aff 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -438,7 +438,7 @@ static int constrain_params_by_rules(struct snd_pcm_substream *substream,
 		 * in user space by returned bits, then preparing for next
 		 * iteration.
 		 */
-		if (changed && r->var >= 0) {
+		if (changed) {
 			params->cmask |= (1 << r->var);
 			vstamps[r->var] = stamp;
 			again = true;
-- 
2.9.3
