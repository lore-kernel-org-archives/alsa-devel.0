From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH RFC 04/21] ALSA: pcm: tracepoints for refining
	PCM parameters
Date: Sun, 14 May 2017 17:57:39 +0900
Message-ID: <20170514085756.22382-5-o-takashi@sakamocchi.jp>
References: <20170514085756.22382-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 1ABB62668F0
 for <alsa-devel@alsa-project.org>; Sun, 14 May 2017 10:58:01 +0200 (CEST)
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

When working for devices which have complicated mode for its data
transmission or which consists of several components, developers are
likely to use rules of parameters of PCM substream. However, there's no
infrastructure to assist their work.

In old days, ALSA PCM core got a local 'RULES_DEBUG' macro to debug
refinement of parameters for PCM substream. Although this is merely a
makeshift, with some modifications, we get the infrastructure.

This commit is for the purpose. Refinement of mask/interval type of
PCM parameters is recorded as tracepoint events as 'hw_params_mask' and
'hw_params_interval' on existent 'snd_pcm' subsystem.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/Makefile           |   1 +
 sound/core/pcm_native.c       | 146 ++++++++++++++++--------------------------
 sound/core/pcm_params_trace.h | 142 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 199 insertions(+), 90 deletions(-)
 create mode 100644 sound/core/pcm_params_trace.h

diff --git a/sound/core/Makefile b/sound/core/Makefile
index e85d9dd..a8514b3 100644
--- a/sound/core/Makefile
+++ b/sound/core/Makefile
@@ -22,6 +22,7 @@ snd-pcm-$(CONFIG_SND_PCM_IEC958) += pcm_iec958.o
 
 # for trace-points
 CFLAGS_pcm_lib.o := -I$(src)
+CFLAGS_pcm_native.o := -I$(src)
 
 snd-pcm-dmaengine-objs := pcm_dmaengine.o
 
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 78afdf1..5a2703e 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -37,6 +37,9 @@
 #include <sound/minors.h>
 #include <linux/uio.h>
 
+#define CREATE_TRACE_POINTS
+#include "pcm_params_trace.h"
+
 /*
  *  Compatibility
  */
@@ -255,50 +258,31 @@ static bool hw_support_mmap(struct snd_pcm_substream *substream)
 	return true;
 }
 
-#undef RULES_DEBUG
-
-#ifdef RULES_DEBUG
-#define HW_PARAM(v) [SNDRV_PCM_HW_PARAM_##v] = #v
-static const char * const snd_pcm_hw_param_names[] = {
-	HW_PARAM(ACCESS),
-	HW_PARAM(FORMAT),
-	HW_PARAM(SUBFORMAT),
-	HW_PARAM(SAMPLE_BITS),
-	HW_PARAM(FRAME_BITS),
-	HW_PARAM(CHANNELS),
-	HW_PARAM(RATE),
-	HW_PARAM(PERIOD_TIME),
-	HW_PARAM(PERIOD_SIZE),
-	HW_PARAM(PERIOD_BYTES),
-	HW_PARAM(PERIODS),
-	HW_PARAM(BUFFER_TIME),
-	HW_PARAM(BUFFER_SIZE),
-	HW_PARAM(BUFFER_BYTES),
-	HW_PARAM(TICK_TIME),
-};
-#endif
-
-static int constrain_mask_params(struct snd_pcm_hw_constraints *constrs,
+static int constrain_mask_params(struct snd_pcm_substream *substream,
+				 struct snd_pcm_hw_constraints *constrs,
 				 struct snd_pcm_hw_params *params)
 {
 	struct snd_mask *m;
 	unsigned int k;
 	int changed;
 
+	struct snd_mask __maybe_unused old_mask;
+
 	for (k = SNDRV_PCM_HW_PARAM_FIRST_MASK; k <= SNDRV_PCM_HW_PARAM_LAST_MASK; k++) {
 		m = hw_param_mask(params, k);
 		if (snd_mask_empty(m))
 			return -EINVAL;
 		if (!(params->rmask & (1 << k)))
 			continue;
-#ifdef RULES_DEBUG
-		pr_debug("%s = ", snd_pcm_hw_param_names[k]);
-		pr_cont("%04x%04x%04x%04x -> ", m->bits[3], m->bits[2], m->bits[1], m->bits[0]);
-#endif
+
+		/* Keep the parameter to trace. */
+		if (trace_hw_params_mask_enabled())
+			old_mask = *m;
+
 		changed = snd_mask_refine(m, constrs_mask(constrs, k));
-#ifdef RULES_DEBUG
-		pr_cont("%04x%04x%04x%04x\n", m->bits[3], m->bits[2], m->bits[1], m->bits[0]);
-#endif
+
+		trace_hw_params_mask(substream, k, -1, &old_mask, m);
+
 		if (changed)
 			params->cmask |= 1 << k;
 		if (changed < 0)
@@ -308,38 +292,31 @@ static int constrain_mask_params(struct snd_pcm_hw_constraints *constrs,
 	return 0;
 }
 
-static int constrain_interval_params(struct snd_pcm_hw_constraints *constrs,
+static int constrain_interval_params(struct snd_pcm_substream *substream,
+				     struct snd_pcm_hw_constraints *constrs,
 				     struct snd_pcm_hw_params *params)
 {
 	struct snd_interval *i;
 	unsigned int k;
 	int changed;
 
+	struct snd_interval __maybe_unused old_interval;
+
 	for (k = SNDRV_PCM_HW_PARAM_FIRST_INTERVAL; k <= SNDRV_PCM_HW_PARAM_LAST_INTERVAL; k++) {
 		i = hw_param_interval(params, k);
 		if (snd_interval_empty(i))
 			return -EINVAL;
 		if (!(params->rmask & (1 << k)))
 			continue;
-#ifdef RULES_DEBUG
-		pr_debug("%s = ", snd_pcm_hw_param_names[k]);
-		if (i->empty)
-			pr_cont("empty");
-		else
-			pr_cont("%c%u %u%c",
-			       i->openmin ? '(' : '[', i->min,
-			       i->max, i->openmax ? ')' : ']');
-		pr_cont(" -> ");
-#endif
+
+		/* Keep the parameter to trace. */
+		if (trace_hw_params_interval_enabled())
+			old_interval = *i;
+
 		changed = snd_interval_refine(i, constrs_interval(constrs, k));
-#ifdef RULES_DEBUG
-		if (i->empty)
-			pr_cont("empty\n");
-		else 
-			pr_cont("%c%u %u%c\n",
-			       i->openmin ? '(' : '[', i->min,
-			       i->max, i->openmax ? ')' : ']');
-#endif
+
+		trace_hw_params_interval(substream, k, -1, &old_interval, i);
+
 		if (changed)
 			params->cmask |= 1 << k;
 		if (changed < 0)
@@ -349,7 +326,8 @@ static int constrain_interval_params(struct snd_pcm_hw_constraints *constrs,
 	return 0;
 }
 
-static int constrain_params_by_rules(struct snd_pcm_hw_constraints *constrs,
+static int constrain_params_by_rules(struct snd_pcm_substream *substream,
+				     struct snd_pcm_hw_constraints *constrs,
 				     struct snd_pcm_hw_params *params)
 {
 	unsigned int k;
@@ -358,10 +336,8 @@ static int constrain_params_by_rules(struct snd_pcm_hw_constraints *constrs,
 	unsigned int stamp = 2;
 	int changed, again;
 
-#ifdef RULES_DEBUG
-	struct snd_mask *m = NULL;
-	struct snd_interval *i = NULL;
-#endif
+	struct snd_interval __maybe_unused old_interval;
+	struct snd_mask __maybe_unused old_mask;
 
 	for (k = 0; k < constrs->rules_num; k++)
 		rstamps[k] = 0;
@@ -383,41 +359,31 @@ static int constrain_params_by_rules(struct snd_pcm_hw_constraints *constrs,
 			}
 			if (!doit)
 				continue;
-#ifdef RULES_DEBUG
-			pr_debug("Rule %d [%p]: ", k, r->func);
-			if (r->var >= 0) {
-				pr_cont("%s = ", snd_pcm_hw_param_names[r->var]);
-				if (hw_is_mask(r->var)) {
-					m = hw_param_mask(params, r->var);
-					pr_cont("%x", *m->bits);
-				} else {
-					i = hw_param_interval(params, r->var);
-					if (i->empty)
-						pr_cont("empty");
-					else
-						pr_cont("%c%u %u%c",
-						       i->openmin ? '(' : '[', i->min,
-						       i->max, i->openmax ? ')' : ']');
-				}
+
+			/* Keep old parameter to trace. */
+			if (trace_hw_params_mask_enabled()) {
+				if (hw_is_mask(r->var))
+					old_mask = *hw_param_mask(params, r->var);
 			}
-#endif
+			if (trace_hw_params_interval_enabled()) {
+				if (hw_is_interval(r->var))
+					old_interval = *hw_param_interval(params, r->var);
+			}
+
 			changed = r->func(params, r);
-#ifdef RULES_DEBUG
-			if (r->var >= 0) {
-				pr_cont(" -> ");
-				if (hw_is_mask(r->var))
-					pr_cont("%x", *m->bits);
-				else {
-					if (i->empty)
-						pr_cont("empty");
-					else
-						pr_cont("%c%u %u%c",
-						       i->openmin ? '(' : '[', i->min,
-						       i->max, i->openmax ? ')' : ']');
-				}
+
+			/* Trace the parameter. */
+			if (hw_is_mask(r->var)) {
+				trace_hw_params_mask(substream, r->var, k,
+						&old_mask,
+						hw_param_mask(params, r->var));
 			}
-			pr_cont("\n");
-#endif
+			if (hw_is_interval(r->var)) {
+				trace_hw_params_interval(substream, r->var, k,
+						&old_interval,
+						hw_param_interval(params, r->var));
+			}
+
 			rstamps[k] = stamp;
 			if (changed && r->var >= 0) {
 				params->cmask |= (1 << r->var);
@@ -451,15 +417,15 @@ int snd_pcm_hw_refine(struct snd_pcm_substream *substream,
 		params->rate_den = 0;
 	}
 
-	changed = constrain_mask_params(constrs, params);
+	changed = constrain_mask_params(substream, constrs, params);
 	if (changed < 0)
 		return changed;
 
-	changed = constrain_interval_params(constrs, params);
+	changed = constrain_interval_params(substream, constrs, params);
 	if (changed < 0)
 		return changed;
 
-	changed = constrain_params_by_rules(constrs, params);
+	changed = constrain_params_by_rules(substream, constrs, params);
 	if (changed < 0)
 		return changed;
 
diff --git a/sound/core/pcm_params_trace.h b/sound/core/pcm_params_trace.h
new file mode 100644
index 0000000..53a2c0f
--- /dev/null
+++ b/sound/core/pcm_params_trace.h
@@ -0,0 +1,142 @@
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM snd_pcm
+
+#if !defined(_PCM_PARAMS_TRACE_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _PCM_PARAMS_TRACE_H
+
+#include <linux/tracepoint.h>
+
+#define HW_PARAM_ENTRY(param) {SNDRV_PCM_HW_PARAM_##param, #param}
+#define hw_param_labels			\
+	HW_PARAM_ENTRY(ACCESS),		\
+	HW_PARAM_ENTRY(FORMAT),		\
+	HW_PARAM_ENTRY(SUBFORMAT),	\
+	HW_PARAM_ENTRY(SAMPLE_BITS),	\
+	HW_PARAM_ENTRY(FRAME_BITS),	\
+	HW_PARAM_ENTRY(CHANNELS),	\
+	HW_PARAM_ENTRY(RATE),		\
+	HW_PARAM_ENTRY(PERIOD_TIME),	\
+	HW_PARAM_ENTRY(PERIOD_SIZE),	\
+	HW_PARAM_ENTRY(PERIOD_BYTES),	\
+	HW_PARAM_ENTRY(PERIODS),	\
+	HW_PARAM_ENTRY(BUFFER_TIME),	\
+	HW_PARAM_ENTRY(BUFFER_SIZE),	\
+	HW_PARAM_ENTRY(BUFFER_BYTES),	\
+	HW_PARAM_ENTRY(TICK_TIME)
+
+TRACE_EVENT(hw_params_mask,
+	TP_PROTO(struct snd_pcm_substream *substream, snd_pcm_hw_param_t type, int index, const struct snd_mask *prev, const struct snd_mask *curr),
+	TP_ARGS(substream, type, index, prev, curr),
+	TP_STRUCT__entry(
+		__field(int, card)
+		__field(int, device)
+		__field(int, subdevice)
+		__field(int, direction)
+		__field(snd_pcm_hw_param_t, type)
+		__field(int, index)
+		__field(int, total)
+		__array(__u32, prev_bits, 8)
+		__array(__u32, curr_bits, 8)
+	),
+	TP_fast_assign(
+		__entry->card = substream->pcm->card->number;
+		__entry->device = substream->pcm->device;
+		__entry->subdevice = substream->number;
+		__entry->direction = substream->stream;
+		__entry->type = type;
+		__entry->index = index;
+		__entry->total = substream->runtime->hw_constraints.rules_num;
+		memcpy(__entry->prev_bits, prev->bits, sizeof(__u32) * 8);
+		memcpy(__entry->curr_bits, curr->bits, sizeof(__u32) * 8);
+	),
+	TP_printk("%d,%d,%d,%d: %03d/%03d: %08x%08x%08x%08x: %08x%08x%08x%08x: %s",
+		  __entry->card,
+		  __entry->device,
+		  __entry->subdevice,
+		  __entry->direction,
+		  __entry->index,
+		  __entry->total,
+		  __entry->prev_bits[3], __entry->prev_bits[2],
+		  __entry->prev_bits[1], __entry->prev_bits[0],
+		  __entry->curr_bits[3], __entry->curr_bits[2],
+		  __entry->curr_bits[1], __entry->curr_bits[0],
+		  __print_symbolic(__entry->type, hw_param_labels)
+	)
+);
+
+TRACE_EVENT(hw_params_interval,
+	TP_PROTO(struct snd_pcm_substream *substream, snd_pcm_hw_param_t type, int index, const struct snd_interval *prev, const struct snd_interval *curr),
+	TP_ARGS(substream, type, index, prev, curr),
+	TP_STRUCT__entry(
+		__field(int, card)
+		__field(int, device)
+		__field(int, subdevice)
+		__field(int, direction)
+		__field(snd_pcm_hw_param_t, type)
+		__field(int, index)
+		__field(int, total)
+		__field(unsigned int, prev_min)
+		__field(unsigned int, prev_max)
+		__field(unsigned int, prev_openmin)
+		__field(unsigned int, prev_openmax)
+		__field(unsigned int, prev_integer)
+		__field(unsigned int, prev_empty)
+		__field(unsigned int, curr_min)
+		__field(unsigned int, curr_max)
+		__field(unsigned int, curr_openmin)
+		__field(unsigned int, curr_openmax)
+		__field(unsigned int, curr_integer)
+		__field(unsigned int, curr_empty)
+	),
+	TP_fast_assign(
+		__entry->card = substream->pcm->card->number;
+		__entry->device = substream->pcm->device;
+		__entry->subdevice = substream->number;
+		__entry->direction = substream->stream;
+		__entry->type = type;
+		__entry->index = index;
+		__entry->total = substream->runtime->hw_constraints.rules_num;
+		__entry->prev_min = prev->min;
+		__entry->prev_max = prev->max;
+		__entry->prev_openmin = prev->openmin;
+		__entry->prev_openmax = prev->openmax;
+		__entry->prev_integer = prev->integer;
+		__entry->prev_empty = prev->empty;
+		__entry->curr_min = curr->min;
+		__entry->curr_max = curr->max;
+		__entry->curr_openmin = curr->openmin;
+		__entry->curr_openmax = curr->openmax;
+		__entry->curr_integer = curr->integer;
+		__entry->curr_empty = curr->empty;
+	),
+	TP_printk("%d,%d,%d,%d: %03d/%03d: %d %s%u, %u%s %d: %d %s%u, %u%s %d: %s",
+		  __entry->card,
+		  __entry->device,
+		  __entry->subdevice,
+		  __entry->direction,
+		  __entry->index,
+		  __entry->total,
+		  __entry->prev_empty,
+		  __entry->prev_openmin ? "(" : "[",
+		  __entry->prev_min,
+		  __entry->prev_max,
+		  __entry->prev_openmax ? ")" : "]",
+		  __entry->prev_integer,
+		  __entry->curr_empty,
+		  __entry->curr_openmin ? "(" : "[",
+		  __entry->curr_min,
+		  __entry->curr_max,
+		  __entry->curr_openmax ? ")" : "]",
+		  __entry->curr_integer,
+		  __print_symbolic(__entry->type, hw_param_labels)
+	)
+);
+
+#endif /* _PCM_PARAMS_TRACE_H */
+
+/* This part must be outside protection */
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE pcm_params_trace
+#include <trace/define_trace.h>
-- 
2.9.3
