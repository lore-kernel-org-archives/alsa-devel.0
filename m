From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFC][PATCH 16/23] aplay: add implementations to
	scheduling
Date: Thu, 17 Aug 2017 20:59:57 +0900
Message-ID: <20170817120004.15326-17-o-takashi@sakamocchi.jp>
References: <20170817120004.15326-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id EF5E6266812
 for <alsa-devel@alsa-project.org>; Thu, 17 Aug 2017 14:00:15 +0200 (CEST)
In-Reply-To: <20170817120004.15326-1-o-takashi@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

This commit is planned to add an implementation for scheduling model.
---
 aplay/Makefile.am             |  4 +++-
 aplay/xfer-alsa-sched-irq.c   | 18 ++++++++++++++++
 aplay/xfer-alsa-sched-timer.c | 49 +++++++++++++++++++++++++++++++++++++++++++
 aplay/xfer-alsa.c             |  1 +
 aplay/xfer-alsa.h             |  3 +++
 5 files changed, 74 insertions(+), 1 deletion(-)
 create mode 100644 aplay/xfer-alsa-sched-irq.c
 create mode 100644 aplay/xfer-alsa-sched-timer.c

diff --git a/aplay/Makefile.am b/aplay/Makefile.am
index 9d5e044..c55fac7 100644
--- a/aplay/Makefile.am
+++ b/aplay/Makefile.am
@@ -37,7 +37,9 @@ aplay_SOURCES = \
 	xfer-alsa.h \
 	xfer-alsa.c \
 	xfer-alsa-io-mmap.c \
-	xfer-alsa-io-rw.c
+	xfer-alsa-io-rw.c \
+	xfer-alsa-sched-irq.c \
+	xfer-alsa-sched-timer.c
 
 EXTRA_DIST = aplay.1 arecord.1
 EXTRA_CLEAN = arecord
diff --git a/aplay/xfer-alsa-sched-irq.c b/aplay/xfer-alsa-sched-irq.c
new file mode 100644
index 0000000..135819f
--- /dev/null
+++ b/aplay/xfer-alsa-sched-irq.c
@@ -0,0 +1,18 @@
+/*
+ * xfer-alsa-sched-irq.c - interrupt-based scheduling model of ALSA.
+ *
+ * Copyright (c) 2017 Takashi Sakamoto <o-takashi@sakamocchi.jp>
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#include "xfer-alsa.h"
+
+static int alsa_irq_pre_process(struct xfer_context *xfer)
+{
+	return 0;
+}
+
+const struct xfer_alsa_sched_ops xfer_alsa_sched_irq_ops =  {
+	.pre_process	= alsa_irq_pre_process,
+};
diff --git a/aplay/xfer-alsa-sched-timer.c b/aplay/xfer-alsa-sched-timer.c
new file mode 100644
index 0000000..72187cc
--- /dev/null
+++ b/aplay/xfer-alsa-sched-timer.c
@@ -0,0 +1,49 @@
+/*
+ * xfer-alsa-sched-timer.c - timer-based scheduling model of ALSA.
+ *
+ * Copyright (c) 2017 Takashi Sakamoto <o-takashi@sakamocchi.jp>
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#include "xfer-alsa.h"
+
+static int alsa_timer_pre_process(struct xfer_context *xfer)
+{
+	struct alsa_state *state = xfer->private_data;
+	snd_pcm_uframes_t boundary;
+	snd_pcm_uframes_t avail_min;
+	int err;
+
+	err = snd_pcm_sw_params_get_boundary(state->sw_params, &boundary);
+	if (err < 0)
+		return err;
+
+	err = snd_pcm_sw_params_set_stop_threshold(state->handle,
+						   state->sw_params, boundary);
+	if (err < 0)
+		return err;
+
+	err = snd_pcm_sw_params_set_start_threshold(state->handle,
+						    state->sw_params, -1);
+	if (err < 0)
+		return err;
+
+	/* TODO: calculate proper value fo ravail_min. */
+	err = snd_pcm_hw_params_get_period_size(state->hw_params, &avail_min,
+						NULL);
+	if (err < 0)
+		return err;
+
+	err = snd_pcm_sw_params_set_avail_min(state->handle, state->sw_params,
+					      avail_min);
+	if (err < 0)
+		return err;
+
+	return snd_pcm_sw_params_set_period_event(state->handle,
+						  state->sw_params, 1);
+}
+
+const struct xfer_alsa_sched_ops xfer_alsa_sched_timer_ops =  {
+	.pre_process	= alsa_timer_pre_process,
+};
diff --git a/aplay/xfer-alsa.c b/aplay/xfer-alsa.c
index 57be488..05e6e7e 100644
--- a/aplay/xfer-alsa.c
+++ b/aplay/xfer-alsa.c
@@ -415,6 +415,7 @@ static int xfer_alsa_pre_process(struct xfer_context *xfer,
 		return err;
 
 	/* Assign scheduling operation. */
+	state->sched_ops = &xfer_alsa_sched_irq_ops;
 	err = state->sched_ops->pre_process(xfer);
 	if (err < 0)
 		return err;
diff --git a/aplay/xfer-alsa.h b/aplay/xfer-alsa.h
index 1731f04..9cc079d 100644
--- a/aplay/xfer-alsa.h
+++ b/aplay/xfer-alsa.h
@@ -58,4 +58,7 @@ extern const struct xfer_alsa_io_ops xfer_alsa_mmap_ops;
 extern const struct xfer_alsa_io_ops xfer_alsa_r_ops;
 extern const struct xfer_alsa_io_ops xfer_alsa_w_ops;
 
+extern const struct xfer_alsa_sched_ops xfer_alsa_sched_irq_ops;
+extern const struct xfer_alsa_sched_ops xfer_alsa_sched_timer_ops;
+
 #endif
-- 
2.11.0
