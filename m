From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: [PATCH] kernel docs: fix sound/core/ kernel-doc
Date: Wed, 15 Oct 2008 14:38:40 -0700
Message-ID: <48F662E0.40904@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from agminet01.oracle.com (agminet01.oracle.com [141.146.126.228])
	by alsa0.perex.cz (Postfix) with ESMTP id 8AFFE244AA
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Oct 2008 23:39:07 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linux-doc@vger.kernel.org, alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, akpm <akpm@linux-foundation.org>
List-Id: alsa-devel@alsa-project.org

From: Randy Dunlap <randy.dunlap@oracle.com>

Add kernel-doc function short descriptions to sound/core functions that
are missing this short description.  Mostly this involves moving some of
the function description onto the @funcname line.

Also correct a few variable names and fix other kernel-doc notation.

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
cc: Jaroslav Kysela <perex@perex.cz>
cc: Takashi Iwai <tiwai@suse.de>
---
 sound/core/pcm_lib.c    |   48 ++++++++++++++++++++++++------------------------
 sound/core/pcm_native.c |   24 ++++++++----------------
 2 files changed, 32 insertions(+), 40 deletions(-)

--- lin2627-g5-kdoc.orig/sound/core/pcm_lib.c
+++ lin2627-g5-kdoc/sound/core/pcm_lib.c
@@ -908,12 +908,12 @@ int snd_pcm_hw_rule_add(struct snd_pcm_r
 EXPORT_SYMBOL(snd_pcm_hw_rule_add);
 
 /**
- * snd_pcm_hw_constraint_mask
+ * snd_pcm_hw_constraint_mask - apply the given bitmap mask constraint
  * @runtime: PCM runtime instance
  * @var: hw_params variable to apply the mask
  * @mask: the bitmap mask
  *
- * Apply the constraint of the given bitmap mask to a mask parameter.
+ * Apply the constraint of the given bitmap mask to a 32-bit mask parameter.
  */
 int snd_pcm_hw_constraint_mask(struct snd_pcm_runtime *runtime, snd_pcm_hw_param_t var,
 			       u_int32_t mask)
@@ -928,12 +928,12 @@ int snd_pcm_hw_constraint_mask(struct sn
 }
 
 /**
- * snd_pcm_hw_constraint_mask64
+ * snd_pcm_hw_constraint_mask64 - apply the given bitmap mask constraint
  * @runtime: PCM runtime instance
  * @var: hw_params variable to apply the mask
  * @mask: the 64bit bitmap mask
  *
- * Apply the constraint of the given bitmap mask to a mask parameter.
+ * Apply the constraint of the given bitmap mask to a 64-bit mask parameter.
  */
 int snd_pcm_hw_constraint_mask64(struct snd_pcm_runtime *runtime, snd_pcm_hw_param_t var,
 				 u_int64_t mask)
@@ -949,7 +949,7 @@ int snd_pcm_hw_constraint_mask64(struct 
 }
 
 /**
- * snd_pcm_hw_constraint_integer
+ * snd_pcm_hw_constraint_integer - apply an integer constraint to an interval
  * @runtime: PCM runtime instance
  * @var: hw_params variable to apply the integer constraint
  *
@@ -964,7 +964,7 @@ int snd_pcm_hw_constraint_integer(struct
 EXPORT_SYMBOL(snd_pcm_hw_constraint_integer);
 
 /**
- * snd_pcm_hw_constraint_minmax
+ * snd_pcm_hw_constraint_minmax - apply a min/max range constraint to an interval
  * @runtime: PCM runtime instance
  * @var: hw_params variable to apply the range
  * @min: the minimal value
@@ -995,7 +995,7 @@ static int snd_pcm_hw_rule_list(struct s
 
 
 /**
- * snd_pcm_hw_constraint_list
+ * snd_pcm_hw_constraint_list - apply a list of constraints to a parameter
  * @runtime: PCM runtime instance
  * @cond: condition bits
  * @var: hw_params variable to apply the list constraint
@@ -1031,7 +1031,7 @@ static int snd_pcm_hw_rule_ratnums(struc
 }
 
 /**
- * snd_pcm_hw_constraint_ratnums
+ * snd_pcm_hw_constraint_ratnums - apply ratnums constraint to a parameter
  * @runtime: PCM runtime instance
  * @cond: condition bits
  * @var: hw_params variable to apply the ratnums constraint
@@ -1064,7 +1064,7 @@ static int snd_pcm_hw_rule_ratdens(struc
 }
 
 /**
- * snd_pcm_hw_constraint_ratdens
+ * snd_pcm_hw_constraint_ratdens - apply ratdens constraint to a parameter
  * @runtime: PCM runtime instance
  * @cond: condition bits
  * @var: hw_params variable to apply the ratdens constraint
@@ -1095,7 +1095,7 @@ static int snd_pcm_hw_rule_msbits(struct
 }
 
 /**
- * snd_pcm_hw_constraint_msbits
+ * snd_pcm_hw_constraint_msbits - add a hw constraint msbits rule
  * @runtime: PCM runtime instance
  * @cond: condition bits
  * @width: sample bits width
@@ -1123,7 +1123,7 @@ static int snd_pcm_hw_rule_step(struct s
 }
 
 /**
- * snd_pcm_hw_constraint_step
+ * snd_pcm_hw_constraint_step - add a hw constraint step rule
  * @runtime: PCM runtime instance
  * @cond: condition bits
  * @var: hw_params variable to apply the step constraint
@@ -1154,7 +1154,7 @@ static int snd_pcm_hw_rule_pow2(struct s
 }		
 
 /**
- * snd_pcm_hw_constraint_pow2
+ * snd_pcm_hw_constraint_pow2 - add a hw constraint power-of-2 rule
  * @runtime: PCM runtime instance
  * @cond: condition bits
  * @var: hw_params variable to apply the power-of-2 constraint
@@ -1202,13 +1202,13 @@ void _snd_pcm_hw_params_any(struct snd_p
 EXPORT_SYMBOL(_snd_pcm_hw_params_any);
 
 /**
- * snd_pcm_hw_param_value
+ * snd_pcm_hw_param_value - return @params field @var value
  * @params: the hw_params instance
  * @var: parameter to retrieve
- * @dir: pointer to the direction (-1,0,1) or NULL
+ * @dir: pointer to the direction (-1,0,1) or %NULL
  *
- * Return the value for field PAR if it's fixed in configuration space 
- *  defined by PARAMS. Return -EINVAL otherwise
+ * Return the value for field @var if it's fixed in configuration space
+ * defined by @params. Return -%EINVAL otherwise.
  */
 int snd_pcm_hw_param_value(const struct snd_pcm_hw_params *params,
 			   snd_pcm_hw_param_t var, int *dir)
@@ -1271,13 +1271,13 @@ static int _snd_pcm_hw_param_first(struc
 
 
 /**
- * snd_pcm_hw_param_first
+ * snd_pcm_hw_param_first - refine config space and return minimum value
  * @pcm: PCM instance
  * @params: the hw_params instance
  * @var: parameter to retrieve
- * @dir: pointer to the direction (-1,0,1) or NULL
+ * @dir: pointer to the direction (-1,0,1) or %NULL
  *
- * Inside configuration space defined by PARAMS remove from PAR all 
+ * Inside configuration space defined by @params remove from @var all
  * values > minimum. Reduce configuration space accordingly.
  * Return the minimum.
  */
@@ -1317,13 +1317,13 @@ static int _snd_pcm_hw_param_last(struct
 
 
 /**
- * snd_pcm_hw_param_last
+ * snd_pcm_hw_param_last - refine config space and return maximum value
  * @pcm: PCM instance
  * @params: the hw_params instance
  * @var: parameter to retrieve
- * @dir: pointer to the direction (-1,0,1) or NULL
+ * @dir: pointer to the direction (-1,0,1) or %NULL
  *
- * Inside configuration space defined by PARAMS remove from PAR all 
+ * Inside configuration space defined by @params remove from @var all
  * values < maximum. Reduce configuration space accordingly.
  * Return the maximum.
  */
@@ -1345,11 +1345,11 @@ int snd_pcm_hw_param_last(struct snd_pcm
 EXPORT_SYMBOL(snd_pcm_hw_param_last);
 
 /**
- * snd_pcm_hw_param_choose
+ * snd_pcm_hw_param_choose - choose a configuration defined by @params
  * @pcm: PCM instance
  * @params: the hw_params instance
  *
- * Choose one configuration from configuration space defined by PARAMS
+ * Choose one configuration from configuration space defined by @params.
  * The configuration chosen is that obtained fixing in this order:
  * first access, first format, first subformat, min channels,
  * min rate, min period time, max buffer size, min tick time
--- lin2627-g5-kdoc.orig/sound/core/pcm_native.c
+++ lin2627-g5-kdoc/sound/core/pcm_native.c
@@ -875,10 +875,8 @@ static struct action_ops snd_pcm_action_
 };
 
 /**
- * snd_pcm_start
+ * snd_pcm_start - start all linked streams
  * @substream: the PCM substream instance
- *
- * Start all linked streams.
  */
 int snd_pcm_start(struct snd_pcm_substream *substream)
 {
@@ -926,12 +924,11 @@ static struct action_ops snd_pcm_action_
 };
 
 /**
- * snd_pcm_stop
+ * snd_pcm_stop - try to stop all running streams in the substream group
  * @substream: the PCM substream instance
  * @state: PCM state after stopping the stream
  *
- * Try to stop all running streams in the substream group.
- * The state of each stream is changed to the given value after that unconditionally.
+ * The state of each stream is then changed to the given state unconditionally.
  */
 int snd_pcm_stop(struct snd_pcm_substream *substream, int state)
 {
@@ -941,11 +938,10 @@ int snd_pcm_stop(struct snd_pcm_substrea
 EXPORT_SYMBOL(snd_pcm_stop);
 
 /**
- * snd_pcm_drain_done
+ * snd_pcm_drain_done - stop the DMA only when the given stream is playback
  * @substream: the PCM substream
  *
- * Stop the DMA only when the given stream is playback.
- * The state is changed to SETUP.
+ * After stopping, the state is changed to SETUP.
  * Unlike snd_pcm_stop(), this affects only the given stream.
  */
 int snd_pcm_drain_done(struct snd_pcm_substream *substream)
@@ -1065,10 +1061,9 @@ static struct action_ops snd_pcm_action_
 };
 
 /**
- * snd_pcm_suspend
+ * snd_pcm_suspend - trigger SUSPEND to all linked streams
  * @substream: the PCM substream
  *
- * Trigger SUSPEND to all linked streams.
  * After this call, all streams are changed to SUSPENDED state.
  */
 int snd_pcm_suspend(struct snd_pcm_substream *substream)
@@ -1088,10 +1083,9 @@ int snd_pcm_suspend(struct snd_pcm_subst
 EXPORT_SYMBOL(snd_pcm_suspend);
 
 /**
- * snd_pcm_suspend_all
+ * snd_pcm_suspend_all - trigger SUSPEND to all substreams in the given pcm
  * @pcm: the PCM instance
  *
- * Trigger SUSPEND to all substreams in the given pcm.
  * After this call, all streams are changed to SUSPENDED state.
  */
 int snd_pcm_suspend_all(struct snd_pcm *pcm)
@@ -1313,11 +1307,9 @@ static struct action_ops snd_pcm_action_
 };
 
 /**
- * snd_pcm_prepare
+ * snd_pcm_prepare - prepare the PCM substream to be triggerable
  * @substream: the PCM substream instance
  * @file: file to refer f_flags
- *
- * Prepare the PCM substream to be triggerable.
  */
 static int snd_pcm_prepare(struct snd_pcm_substream *substream,
 			   struct file *file)
