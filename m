From: Peter Rosin <peda@lysator.liu.se>
Subject: [PATCH v2 1/7] ALSA: pcm: Add snd_interval_ranges()
	and snd_pcm_hw_constraint_ranges()
Date: Wed, 28 Jan 2015 15:16:06 +0100
Message-ID: <1422454572-7847-2-git-send-email-peda@lysator.liu.se>
References: <1422454572-7847-1-git-send-email-peda@lysator.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.lysator.liu.se (mail.lysator.liu.se [130.236.254.3])
 by alsa0.perex.cz (Postfix) with ESMTP id B6CFE261A76
 for <alsa-devel@alsa-project.org>; Wed, 28 Jan 2015 15:16:40 +0100 (CET)
In-Reply-To: <1422454572-7847-1-git-send-email-peda@lysator.liu.se>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Clemens Ladisch <clemens@ladisch.de>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>, Peter Rosin <peda@axentia.se>
List-Id: alsa-devel@alsa-project.org

From: Peter Rosin <peda@axentia.se>

Add helper functions to allow drivers to specify several disjoint
ranges for a variable. In particular, there is a codec (PCM512x) that
has a hole in its supported range of rates, due to PLL and divider
restrictions.

This is like snd_pcm_hw_constraint_list(), but for ranges instead of
points.

Signed-off-by: Peter Rosin <peda@axentia.se>
Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/pcm.h  |   12 +++++++
 sound/core/pcm_lib.c |   85 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 97 insertions(+)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index 1e7f74acc2ec..04fc037e0555 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -275,6 +275,12 @@ struct snd_pcm_hw_constraint_list {
 	unsigned int mask;
 };
 
+struct snd_pcm_hw_constraint_ranges {
+	unsigned int count;
+	const struct snd_interval *ranges;
+	unsigned int mask;
+};
+
 struct snd_pcm_hwptr_log;
 
 struct snd_pcm_runtime {
@@ -910,6 +916,8 @@ void snd_interval_mulkdiv(const struct snd_interval *a, unsigned int k,
 			  const struct snd_interval *b, struct snd_interval *c);
 int snd_interval_list(struct snd_interval *i, unsigned int count,
 		      const unsigned int *list, unsigned int mask);
+int snd_interval_ranges(struct snd_interval *i, unsigned int count,
+			const struct snd_interval *list, unsigned int mask);
 int snd_interval_ratnum(struct snd_interval *i,
 			unsigned int rats_count, struct snd_ratnum *rats,
 			unsigned int *nump, unsigned int *denp);
@@ -934,6 +942,10 @@ int snd_pcm_hw_constraint_list(struct snd_pcm_runtime *runtime,
 			       unsigned int cond,
 			       snd_pcm_hw_param_t var,
 			       const struct snd_pcm_hw_constraint_list *l);
+int snd_pcm_hw_constraint_ranges(struct snd_pcm_runtime *runtime,
+				 unsigned int cond,
+				 snd_pcm_hw_param_t var,
+				 const struct snd_pcm_hw_constraint_ranges *r);
 int snd_pcm_hw_constraint_ratnums(struct snd_pcm_runtime *runtime, 
 				  unsigned int cond,
 				  snd_pcm_hw_param_t var,
diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index ec9e7866177f..446c00bd908b 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -1015,6 +1015,60 @@ int snd_interval_list(struct snd_interval *i, unsigned int count,
 
 EXPORT_SYMBOL(snd_interval_list);
 
+/**
+ * snd_interval_ranges - refine the interval value from the list of ranges
+ * @i: the interval value to refine
+ * @count: the number of elements in the list of ranges
+ * @ranges: the ranges list
+ * @mask: the bit-mask to evaluate
+ *
+ * Refines the interval value from the list of ranges.
+ * When mask is non-zero, only the elements corresponding to bit 1 are
+ * evaluated.
+ *
+ * Return: Positive if the value is changed, zero if it's not changed, or a
+ * negative error code.
+ */
+int snd_interval_ranges(struct snd_interval *i, unsigned int count,
+			const struct snd_interval *ranges, unsigned int mask)
+{
+	unsigned int k;
+	struct snd_interval range_union;
+	struct snd_interval range;
+
+	if (!count) {
+		snd_interval_none(i);
+		return -EINVAL;
+	}
+	snd_interval_any(&range_union);
+	range_union.min = UINT_MAX;
+	range_union.max = 0;
+	for (k = 0; k < count; k++) {
+		if (mask && !(mask & (1 << k)))
+			continue;
+		snd_interval_copy(&range, &ranges[k]);
+		if (snd_interval_refine(&range, i) < 0)
+			continue;
+		if (snd_interval_empty(&range))
+			continue;
+
+		if (range.min < range_union.min) {
+			range_union.min = range.min;
+			range_union.openmin = 1;
+		}
+		if (range.min == range_union.min && !range.openmin)
+			range_union.openmin = 0;
+		if (range.max > range_union.max) {
+			range_union.max = range.max;
+			range_union.openmax = 1;
+		}
+		if (range.max == range_union.max && !range.openmax)
+			range_union.openmax = 0;
+	}
+	return snd_interval_refine(i, &range_union);
+}
+EXPORT_SYMBOL(snd_interval_ranges);
+
 static int snd_interval_step(struct snd_interval *i, unsigned int step)
 {
 	unsigned int n;
@@ -1221,6 +1275,37 @@ int snd_pcm_hw_constraint_list(struct snd_pcm_runtime *runtime,
 
 EXPORT_SYMBOL(snd_pcm_hw_constraint_list);
 
+static int snd_pcm_hw_rule_ranges(struct snd_pcm_hw_params *params,
+				  struct snd_pcm_hw_rule *rule)
+{
+	struct snd_pcm_hw_constraint_ranges *r = rule->private;
+	return snd_interval_ranges(hw_param_interval(params, rule->var),
+				   r->count, r->ranges, r->mask);
+}
+
+
+/**
+ * snd_pcm_hw_constraint_ranges - apply list of range constraints to a parameter
+ * @runtime: PCM runtime instance
+ * @cond: condition bits
+ * @var: hw_params variable to apply the list of range constraints
+ * @r: ranges
+ *
+ * Apply the list of range constraints to an interval parameter.
+ *
+ * Return: Zero if successful, or a negative error code on failure.
+ */
+int snd_pcm_hw_constraint_ranges(struct snd_pcm_runtime *runtime,
+				 unsigned int cond,
+				 snd_pcm_hw_param_t var,
+				 const struct snd_pcm_hw_constraint_ranges *r)
+{
+	return snd_pcm_hw_rule_add(runtime, cond, var,
+				   snd_pcm_hw_rule_ranges, (void *)r,
+				   var, -1);
+}
+EXPORT_SYMBOL(snd_pcm_hw_constraint_ranges);
+
 static int snd_pcm_hw_rule_ratnums(struct snd_pcm_hw_params *params,
 				   struct snd_pcm_hw_rule *rule)
 {
-- 
1.7.10.4
