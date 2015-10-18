From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 01/18] ALSA: Add helper function to add single
	value constraint
Date: Sun, 18 Oct 2015 15:39:16 +0200
Message-ID: <1445175573-11784-2-git-send-email-lars@metafoo.de>
References: <1445175573-11784-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-200.synserver.de (smtp-out-225.synserver.de
 [212.40.185.225])
 by alsa0.perex.cz (Postfix) with ESMTP id 3FBBE2616EF
 for <alsa-devel@alsa-project.org>; Sun, 18 Oct 2015 15:39:41 +0200 (CEST)
In-Reply-To: <1445175573-11784-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vinod.koul@intel.com>, Mengdong Lin <mengdong.lin@intel.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Yang A Fang <yang.a.fang@intel.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

The recommended and most efficient way to constraint a configuration
parameter to a single value is to set the minimum and maximum allowed
values to the same value, i.e. calling snd_pcm_hw_constraint_minmax() with
the same value for min and max.

It is not necessarily obvious though that this is the approach that should
be taken and some drivers have come up with other ways of solving this
problem, e.g. installing a list constraint with a single item. List
constraints are dynamic constraints though and hence less efficient than
the static min-max constraint.

This patch introduces a new helper function called
snd_pcm_hw_constraint_single() which only takes a single value has the same
effect as calling snd_pcm_hw_constraint_minmax() with the same values for
min and max. But it is hopefully semantically more expressive, making it
clear that this is the preferred way of setting a single value constraint.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/pcm.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index 2882ddd..b767666 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -1028,6 +1028,22 @@ int snd_pcm_hw_rule_add(struct snd_pcm_runtime *runtime,
 			snd_pcm_hw_rule_func_t func, void *private,
 			int dep, ...);
 
+/**
+ * snd_pcm_hw_constraint_single() - Constrain parameter to a single value
+ * @runtime: PCM runtime instance
+ * @var: The hw_params variable to constrain
+ * @val: The value to constrain to
+ *
+ * Return: Positive if the value is changed, zero if it's not changed, or a
+ * negative error code.
+ */
+static inline int snd_pcm_hw_constraint_single(
+	struct snd_pcm_runtime *runtime, snd_pcm_hw_param_t var,
+	unsigned int val)
+{
+	return snd_pcm_hw_constraint_minmax(runtime, var, val, val);
+}
+
 int snd_pcm_format_signed(snd_pcm_format_t format);
 int snd_pcm_format_unsigned(snd_pcm_format_t format);
 int snd_pcm_format_linear(snd_pcm_format_t format);
-- 
2.1.4
