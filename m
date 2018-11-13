From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 24/35] axfer: add an option to suppress event
	waiting
Date: Tue, 13 Nov 2018 15:41:36 +0900
Message-ID: <20181113064147.13577-24-o-takashi@sakamocchi.jp>
References: <20181113062459.DD8F7267A5C@alsa0.perex.cz>
 <20181113064147.13577-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com
 [209.85.215.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 7CE93267B3F
 for <alsa-devel@alsa-project.org>; Tue, 13 Nov 2018 07:42:36 +0100 (CET)
Received: by mail-pg1-f196.google.com with SMTP id 32-v6so5232826pgu.2
 for <alsa-devel@alsa-project.org>; Mon, 12 Nov 2018 22:42:36 -0800 (PST)
In-Reply-To: <20181113064147.13577-1-o-takashi@sakamocchi.jp>
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

In aplay, '--test-nowait' is used to suppress calls of snd_pcm_wait()
when I/O operations return -EAGAIN or process truncated number of data
frames. This seems to be for debugging purpose. In this program, this
option is equivalent to suppress event waiting.

This commit adds support for this option.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 axfer/xfer-libasound-irq-mmap.c | 10 ++++++----
 axfer/xfer-libasound-irq-rw.c   | 20 ++++++++++++--------
 axfer/xfer-libasound.c          | 16 ++++++++++++++++
 axfer/xfer-libasound.h          |  3 +++
 4 files changed, 37 insertions(+), 12 deletions(-)

diff --git a/axfer/xfer-libasound-irq-mmap.c b/axfer/xfer-libasound-irq-mmap.c
index 87ef7e0..18f6dfe 100644
--- a/axfer/xfer-libasound-irq-mmap.c
+++ b/axfer/xfer-libasound-irq-mmap.c
@@ -81,10 +81,12 @@ static int irq_mmap_process_frames(struct libasound_state *state,
 	snd_pcm_sframes_t consumed_count;
 	int err;
 
-	// Wait for hardware IRQ when no avail space in buffer.
-	err = snd_pcm_wait(state->handle, -1);
-	if (err < 0)
-		return err;
+	if (state->use_waiter) {
+		// Wait for hardware IRQ when no avail space in buffer.
+		err = snd_pcm_wait(state->handle, -1);
+		if (err < 0)
+			return err;
+	}
 
 	// Sync cache in user space to data in kernel space to calculate avail
 	// frames according to the latest positions on PCM buffer.
diff --git a/axfer/xfer-libasound-irq-rw.c b/axfer/xfer-libasound-irq-rw.c
index f05ac4b..625c095 100644
--- a/axfer/xfer-libasound-irq-rw.c
+++ b/axfer/xfer-libasound-irq-rw.c
@@ -133,10 +133,12 @@ static int r_process_frames_nonblocking(struct libasound_state *state,
 			goto error;
 	}
 
-	// Wait for hardware IRQ when no available space.
-	err = snd_pcm_wait(state->handle, -1);
-	if (err < 0)
-		goto error;
+	if (state->use_waiter) {
+		// Wait for hardware IRQ when no available space.
+		err = snd_pcm_wait(state->handle, -1);
+		if (err < 0)
+			goto error;
+	}
 
 	// Check available space on the buffer.
 	avail = snd_pcm_avail(state->handle);
@@ -286,10 +288,12 @@ static int w_process_frames_nonblocking(struct libasound_state *state,
 	unsigned int avail_count;
 	int err;
 
-	// Wait for hardware IRQ when no left space.
-	err = snd_pcm_wait(state->handle, -1);
-	if (err < 0)
-		goto error;
+	if (state->use_waiter) {
+		// Wait for hardware IRQ when no left space.
+		err = snd_pcm_wait(state->handle, -1);
+		if (err < 0)
+			goto error;
+	}
 
 	// Check available space on the buffer.
 	avail = snd_pcm_avail(state->handle);
diff --git a/axfer/xfer-libasound.c b/axfer/xfer-libasound.c
index c2e1282..61ae115 100644
--- a/axfer/xfer-libasound.c
+++ b/axfer/xfer-libasound.c
@@ -12,6 +12,7 @@
 enum no_short_opts {
         // 200 or later belong to non us-ascii character set.
 	OPT_FATAL_ERRORS = 200,
+	OPT_TEST_NOWAIT,
 };
 
 #define S_OPTS	"D:NM"
@@ -21,6 +22,7 @@ static const struct option l_opts[] = {
 	{"mmap",		0, 0, 'M'},
 	// For debugging.
 	{"fatal-errors",	0, 0, OPT_FATAL_ERRORS},
+	{"test-nowait",		0, 0, OPT_TEST_NOWAIT},
 };
 
 static int xfer_libasound_init(struct xfer_context *xfer,
@@ -54,6 +56,8 @@ static int xfer_libasound_parse_opt(struct xfer_context *xfer, int key,
 		state->mmap = true;
 	else if (key == OPT_FATAL_ERRORS)
 		state->finish_at_xrun = true;
+	else if (key == OPT_TEST_NOWAIT)
+		state->test_nowait = true;
 	else
 		err = -ENXIO;
 
@@ -80,6 +84,15 @@ int xfer_libasound_validate_opts(struct xfer_context *xfer)
 		return -EINVAL;
 	}
 
+	if (state->test_nowait) {
+		if (!state->nonblock && !state->mmap) {
+			fprintf(stderr,
+				"An option for nowait test should be used with "
+				"nonblock or mmap options.\n");
+			return -EINVAL;
+		}
+	}
+
 	return err;
 }
 
@@ -124,6 +137,9 @@ static int open_handle(struct xfer_context *xfer)
 		return err;
 	}
 
+	if ((state->nonblock || state->mmap) && !state->test_nowait)
+		state->use_waiter = true;
+
 	err = snd_pcm_hw_params_any(state->handle, state->hw_params);
 	if (err < 0)
 		return err;
diff --git a/axfer/xfer-libasound.h b/axfer/xfer-libasound.h
index 550b1c2..f3ce73f 100644
--- a/axfer/xfer-libasound.h
+++ b/axfer/xfer-libasound.h
@@ -33,6 +33,9 @@ struct libasound_state {
 	bool finish_at_xrun:1;
 	bool nonblock:1;
 	bool mmap:1;
+	bool test_nowait:1;
+
+	bool use_waiter:1;
 };
 
 // For internal use in 'libasound' module.
-- 
2.19.1
