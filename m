From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 1/2] ALSA: pcm: add local header file for
	snd-pcm module
Date: Fri, 26 May 2017 09:30:46 +0900
Message-ID: <20170526003047.17721-2-o-takashi@sakamocchi.jp>
References: <20170526003047.17721-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id 1B4742673E1
 for <alsa-devel@alsa-project.org>; Fri, 26 May 2017 02:30:52 +0200 (CEST)
In-Reply-To: <20170526003047.17721-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Several files are used to construct PCM core module, a.k.a snd-pcm.
Although available APIs are described in 'include/sound/pcm.h', some of
them are not exported as symbols in kernel space. Such APIs are just for
module local usage.

This commit adds module local header file and move some function prototypes
into it so that scopes of them are controlled properly and developers
get no confusion from unavailable symbols.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 include/sound/pcm.h     | 32 -------------------------------
 sound/core/pcm.c        |  2 ++
 sound/core/pcm_lib.c    |  2 ++
 sound/core/pcm_local.h  | 51 +++++++++++++++++++++++++++++++++++++++++++++++++
 sound/core/pcm_misc.c   |  3 +++
 sound/core/pcm_native.c |  2 ++
 6 files changed, 60 insertions(+), 32 deletions(-)
 create mode 100644 sound/core/pcm_local.h

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index c609b891c4c2..79fedf517070 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -969,12 +969,6 @@ static inline unsigned int params_buffer_bytes(const struct snd_pcm_hw_params *p
 }
 
 int snd_interval_refine(struct snd_interval *i, const struct snd_interval *v);
-void snd_interval_mul(const struct snd_interval *a, const struct snd_interval *b, struct snd_interval *c);
-void snd_interval_div(const struct snd_interval *a, const struct snd_interval *b, struct snd_interval *c);
-void snd_interval_muldivk(const struct snd_interval *a, const struct snd_interval *b, 
-			  unsigned int k, struct snd_interval *c);
-void snd_interval_mulkdiv(const struct snd_interval *a, unsigned int k,
-			  const struct snd_interval *b, struct snd_interval *c);
 int snd_interval_list(struct snd_interval *i, unsigned int count,
 		      const unsigned int *list, unsigned int mask);
 int snd_interval_ranges(struct snd_interval *i, unsigned int count,
@@ -985,15 +979,9 @@ int snd_interval_ratnum(struct snd_interval *i,
 
 void _snd_pcm_hw_params_any(struct snd_pcm_hw_params *params);
 void _snd_pcm_hw_param_setempty(struct snd_pcm_hw_params *params, snd_pcm_hw_param_t var);
-int snd_pcm_hw_params_choose(struct snd_pcm_substream *substream, struct snd_pcm_hw_params *params);
 
 int snd_pcm_hw_refine(struct snd_pcm_substream *substream, struct snd_pcm_hw_params *params);
 
-int snd_pcm_hw_constraints_init(struct snd_pcm_substream *substream);
-int snd_pcm_hw_constraints_complete(struct snd_pcm_substream *substream);
-
-int snd_pcm_hw_constraint_mask(struct snd_pcm_runtime *runtime, snd_pcm_hw_param_t var,
-			       u_int32_t mask);
 int snd_pcm_hw_constraint_mask64(struct snd_pcm_runtime *runtime, snd_pcm_hw_param_t var,
 				 u_int64_t mask);
 int snd_pcm_hw_constraint_minmax(struct snd_pcm_runtime *runtime, snd_pcm_hw_param_t var,
@@ -1081,10 +1069,6 @@ void snd_pcm_set_ops(struct snd_pcm * pcm, int direction,
 void snd_pcm_set_sync(struct snd_pcm_substream *substream);
 int snd_pcm_lib_ioctl(struct snd_pcm_substream *substream,
 		      unsigned int cmd, void *arg);                      
-int snd_pcm_update_state(struct snd_pcm_substream *substream,
-			 struct snd_pcm_runtime *runtime);
-int snd_pcm_update_hw_ptr(struct snd_pcm_substream *substream);
-void snd_pcm_playback_silence(struct snd_pcm_substream *substream, snd_pcm_uframes_t new_hw_ptr);
 void snd_pcm_period_elapsed(struct snd_pcm_substream *substream);
 snd_pcm_sframes_t snd_pcm_lib_write(struct snd_pcm_substream *substream,
 				    const void __user *buf,
@@ -1096,8 +1080,6 @@ snd_pcm_sframes_t snd_pcm_lib_writev(struct snd_pcm_substream *substream,
 snd_pcm_sframes_t snd_pcm_lib_readv(struct snd_pcm_substream *substream,
 				    void __user **bufs, snd_pcm_uframes_t frames);
 
-extern const struct snd_pcm_hw_constraint_list snd_pcm_known_rates;
-
 int snd_pcm_limit_hw_rates(struct snd_pcm_runtime *runtime);
 unsigned int snd_pcm_rate_to_rate_bit(unsigned int rate);
 unsigned int snd_pcm_rate_bit_to_rate(unsigned int rate_bit);
@@ -1131,20 +1113,6 @@ static inline void snd_pcm_set_runtime_buffer(struct snd_pcm_substream *substrea
 	}
 }
 
-/*
- *  Timer interface
- */
-
-#ifdef CONFIG_SND_PCM_TIMER
-void snd_pcm_timer_resolution_change(struct snd_pcm_substream *substream);
-void snd_pcm_timer_init(struct snd_pcm_substream *substream);
-void snd_pcm_timer_done(struct snd_pcm_substream *substream);
-#else
-static inline void
-snd_pcm_timer_resolution_change(struct snd_pcm_substream *substream) {}
-static inline void snd_pcm_timer_init(struct snd_pcm_substream *substream) {}
-static inline void snd_pcm_timer_done(struct snd_pcm_substream *substream) {}
-#endif
 /**
  * snd_pcm_gettime - Fill the timespec depending on the timestamp mode
  * @runtime: PCM runtime instance
diff --git a/sound/core/pcm.c b/sound/core/pcm.c
index d30dba0ee688..4b3290447398 100644
--- a/sound/core/pcm.c
+++ b/sound/core/pcm.c
@@ -31,6 +31,8 @@
 #include <sound/control.h>
 #include <sound/info.h>
 
+#include "pcm_local.h"
+
 MODULE_AUTHOR("Jaroslav Kysela <perex@perex.cz>, Abramo Bagnara <abramo@alsa-project.org>");
 MODULE_DESCRIPTION("Midlevel PCM code for ALSA.");
 MODULE_LICENSE("GPL");
diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index ab4b1d1e44ee..e50548af4004 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -33,6 +33,8 @@
 #include <sound/pcm_params.h>
 #include <sound/timer.h>
 
+#include "pcm_local.h"
+
 #ifdef CONFIG_SND_PCM_XRUN_DEBUG
 #define CREATE_TRACE_POINTS
 #include "pcm_trace.h"
diff --git a/sound/core/pcm_local.h b/sound/core/pcm_local.h
new file mode 100644
index 000000000000..34c66decaaf2
--- /dev/null
+++ b/sound/core/pcm_local.h
@@ -0,0 +1,51 @@
+/*
+ * pcm_local.h - a local header file for snd-pcm module.
+ *
+ * Copyright (c) Takashi Sakamoto <o-takashi@sakamocchi.jp>
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#ifndef __SOUND_CORE_PCM_LOCAL_H
+#define __SOUND_CORE_PCM_LOCAL_H
+
+extern const struct snd_pcm_hw_constraint_list snd_pcm_known_rates;
+
+void snd_interval_mul(const struct snd_interval *a,
+		      const struct snd_interval *b, struct snd_interval *c);
+void snd_interval_div(const struct snd_interval *a,
+		      const struct snd_interval *b, struct snd_interval *c);
+void snd_interval_muldivk(const struct snd_interval *a,
+			  const struct snd_interval *b,
+			  unsigned int k, struct snd_interval *c);
+void snd_interval_mulkdiv(const struct snd_interval *a, unsigned int k,
+			  const struct snd_interval *b, struct snd_interval *c);
+
+int snd_pcm_hw_constraints_init(struct snd_pcm_substream *substream);
+int snd_pcm_hw_constraints_complete(struct snd_pcm_substream *substream);
+
+int snd_pcm_hw_params_choose(struct snd_pcm_substream *substream,
+			     struct snd_pcm_hw_params *params);
+
+int snd_pcm_hw_constraint_mask(struct snd_pcm_runtime *runtime,
+			       snd_pcm_hw_param_t var, u_int32_t mask);
+
+int snd_pcm_update_state(struct snd_pcm_substream *substream,
+			 struct snd_pcm_runtime *runtime);
+int snd_pcm_update_hw_ptr(struct snd_pcm_substream *substream);
+
+void snd_pcm_playback_silence(struct snd_pcm_substream *substream,
+			      snd_pcm_uframes_t new_hw_ptr);
+
+#ifdef CONFIG_SND_PCM_TIMER
+void snd_pcm_timer_resolution_change(struct snd_pcm_substream *substream);
+void snd_pcm_timer_init(struct snd_pcm_substream *substream);
+void snd_pcm_timer_done(struct snd_pcm_substream *substream);
+#else
+static inline void
+snd_pcm_timer_resolution_change(struct snd_pcm_substream *substream) {}
+static inline void snd_pcm_timer_init(struct snd_pcm_substream *substream) {}
+static inline void snd_pcm_timer_done(struct snd_pcm_substream *substream) {}
+#endif
+
+#endif	/* __SOUND_CORE_PCM_LOCAL_H */
diff --git a/sound/core/pcm_misc.c b/sound/core/pcm_misc.c
index 53dc37357bca..dd8383e29315 100644
--- a/sound/core/pcm_misc.c
+++ b/sound/core/pcm_misc.c
@@ -23,6 +23,9 @@
 #include <linux/export.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
+
+#include "pcm_local.h"
+
 #define SND_PCM_FORMAT_UNKNOWN (-1)
 
 /* NOTE: "signed" prefix must be given below since the default char is
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 5be549cf91e5..bf5d0f2acfb9 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -37,6 +37,8 @@
 #include <sound/minors.h>
 #include <linux/uio.h>
 
+#include "pcm_local.h"
+
 /*
  *  Compatibility
  */
-- 
2.11.0
