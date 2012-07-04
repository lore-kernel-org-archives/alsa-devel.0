From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ALSA: pcm: Mostly constify constraints
Date: Wed,  4 Jul 2012 18:35:12 +0100
Message-ID: <1341423313-9561-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7766B244AE
	for <alsa-devel@alsa-project.org>;
	Wed,  4 Jul 2012 19:35:18 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

There is no need for the constraints to be modified while being applied so
they can be declared const, allowing drivers to declare constraint lists
const if they wish.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/pcm.h     |    6 +++---
 sound/core/pcm_lib.c    |   10 +++++-----
 sound/core/pcm_native.c |    4 ++--
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index e7afcc9..3b8f6ca 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -217,7 +217,7 @@ struct snd_pcm_hw_rule {
 	snd_pcm_hw_rule_func_t func;
 	int var;
 	int deps[4];
-	void *private;
+	const void *private;
 };
 
 struct snd_pcm_hw_constraints {
@@ -810,7 +810,7 @@ int snd_pcm_hw_constraint_integer(struct snd_pcm_runtime *runtime, snd_pcm_hw_pa
 int snd_pcm_hw_constraint_list(struct snd_pcm_runtime *runtime, 
 			       unsigned int cond,
 			       snd_pcm_hw_param_t var,
-			       struct snd_pcm_hw_constraint_list *l);
+			       const struct snd_pcm_hw_constraint_list *l);
 int snd_pcm_hw_constraint_ratnums(struct snd_pcm_runtime *runtime, 
 				  unsigned int cond,
 				  snd_pcm_hw_param_t var,
@@ -835,7 +835,7 @@ int snd_pcm_hw_rule_noresample(struct snd_pcm_runtime *runtime,
 int snd_pcm_hw_rule_add(struct snd_pcm_runtime *runtime,
 			unsigned int cond,
 			int var,
-			snd_pcm_hw_rule_func_t func, void *private,
+			snd_pcm_hw_rule_func_t func, const void *private,
 			int dep, ...);
 
 int snd_pcm_format_signed(snd_pcm_format_t format);
diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index 8f312fa6..4372de5 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -1104,7 +1104,7 @@ static int snd_interval_step(struct snd_interval *i, unsigned int min, unsigned
  */
 int snd_pcm_hw_rule_add(struct snd_pcm_runtime *runtime, unsigned int cond,
 			int var,
-			snd_pcm_hw_rule_func_t func, void *private,
+			snd_pcm_hw_rule_func_t func, const void *private,
 			int dep, ...)
 {
 	struct snd_pcm_hw_constraints *constrs = &runtime->hw_constraints;
@@ -1233,7 +1233,7 @@ EXPORT_SYMBOL(snd_pcm_hw_constraint_minmax);
 static int snd_pcm_hw_rule_list(struct snd_pcm_hw_params *params,
 				struct snd_pcm_hw_rule *rule)
 {
-	struct snd_pcm_hw_constraint_list *list = rule->private;
+	const struct snd_pcm_hw_constraint_list *list = rule->private;
 	return snd_interval_list(hw_param_interval(params, rule->var), list->count, list->list, list->mask);
 }		
 
@@ -1250,7 +1250,7 @@ static int snd_pcm_hw_rule_list(struct snd_pcm_hw_params *params,
 int snd_pcm_hw_constraint_list(struct snd_pcm_runtime *runtime,
 			       unsigned int cond,
 			       snd_pcm_hw_param_t var,
-			       struct snd_pcm_hw_constraint_list *l)
+			       const struct snd_pcm_hw_constraint_list *l)
 {
 	return snd_pcm_hw_rule_add(runtime, cond, var,
 				   snd_pcm_hw_rule_list, l,
@@ -1262,7 +1262,7 @@ EXPORT_SYMBOL(snd_pcm_hw_constraint_list);
 static int snd_pcm_hw_rule_ratnums(struct snd_pcm_hw_params *params,
 				   struct snd_pcm_hw_rule *rule)
 {
-	struct snd_pcm_hw_constraint_ratnums *r = rule->private;
+	const struct snd_pcm_hw_constraint_ratnums *r = rule->private;
 	unsigned int num = 0, den = 0;
 	int err;
 	err = snd_interval_ratnum(hw_param_interval(params, rule->var),
@@ -1296,7 +1296,7 @@ EXPORT_SYMBOL(snd_pcm_hw_constraint_ratnums);
 static int snd_pcm_hw_rule_ratdens(struct snd_pcm_hw_params *params,
 				   struct snd_pcm_hw_rule *rule)
 {
-	struct snd_pcm_hw_constraint_ratdens *r = rule->private;
+	const struct snd_pcm_hw_constraint_ratdens *r = rule->private;
 	unsigned int num = 0, den = 0;
 	int err = snd_interval_ratden(hw_param_interval(params, rule->var),
 				  r->nrats, r->rats, &num, &den);
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 53b5ada..5cc8c4f 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -1775,7 +1775,7 @@ const struct snd_pcm_hw_constraint_list snd_pcm_known_rates = {
 static int snd_pcm_hw_rule_rate(struct snd_pcm_hw_params *params,
 				struct snd_pcm_hw_rule *rule)
 {
-	struct snd_pcm_hardware *hw = rule->private;
+	const struct snd_pcm_hardware *hw = rule->private;
 	return snd_interval_list(hw_param_interval(params, rule->var),
 				 snd_pcm_known_rates.count,
 				 snd_pcm_known_rates.list, hw->rates);
@@ -1785,7 +1785,7 @@ static int snd_pcm_hw_rule_buffer_bytes_max(struct snd_pcm_hw_params *params,
 					    struct snd_pcm_hw_rule *rule)
 {
 	struct snd_interval t;
-	struct snd_pcm_substream *substream = rule->private;
+	const struct snd_pcm_substream *substream = rule->private;
 	t.min = 0;
 	t.max = substream->buffer_bytes_max;
 	t.openmin = 0;
-- 
1.7.10
