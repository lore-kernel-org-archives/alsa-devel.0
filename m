From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 22/35] axfer: add support for non-blocking
	operation
Date: Tue, 13 Nov 2018 15:41:34 +0900
Message-ID: <20181113064147.13577-22-o-takashi@sakamocchi.jp>
References: <20181113062459.DD8F7267A5C@alsa0.perex.cz>
 <20181113064147.13577-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com
 [209.85.214.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 13278267AC2
 for <alsa-devel@alsa-project.org>; Tue, 13 Nov 2018 07:42:32 +0100 (CET)
Received: by mail-pl1-f196.google.com with SMTP id p6-v6so5520812pll.4
 for <alsa-devel@alsa-project.org>; Mon, 12 Nov 2018 22:42:32 -0800 (PST)
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

In alsa-lib PCM API, snd_pcm_read[i|n]() and snd_pcm_write[i|n] can be
used with non-blocking mode. This is available when SND_PCM_NONBLOCK is
used as 'mode' argument for a call of snd_pcm_open().

This commit adds support this type of operation. To reduce CPU usage, this
commit uses 'snd_pcm_wait()' to wait for event notification.

Below lines are examples to execute:
$ axfer transfer -N -P -d 2 -D hw:0,3 /dev/urandom -f dat -vvv
$ axfer transfer -N -C -d 2 -D hw:1,0 /dev/null -r 48000 -vvv

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 axfer/xfer-libasound-irq-rw.c | 102 ++++++++++++++++++++++++++++++++--
 axfer/xfer-libasound.c        |  16 +++++-
 axfer/xfer-libasound.h        |   1 +
 3 files changed, 113 insertions(+), 6 deletions(-)

diff --git a/axfer/xfer-libasound-irq-rw.c b/axfer/xfer-libasound-irq-rw.c
index 59634b4..f05ac4b 100644
--- a/axfer/xfer-libasound-irq-rw.c
+++ b/axfer/xfer-libasound-irq-rw.c
@@ -117,6 +117,51 @@ error:
 	return err;
 }
 
+static int r_process_frames_nonblocking(struct libasound_state *state,
+					snd_pcm_state_t status,
+					unsigned int *frame_count,
+					struct mapper_context *mapper,
+					struct container_context *cntrs)
+{
+	snd_pcm_sframes_t avail;
+	snd_pcm_uframes_t avail_count;
+	int err = 0;
+
+	if (status != SND_PCM_STATE_RUNNING) {
+		err = snd_pcm_start(state->handle);
+		if (err < 0)
+			goto error;
+	}
+
+	// Wait for hardware IRQ when no available space.
+	err = snd_pcm_wait(state->handle, -1);
+	if (err < 0)
+		goto error;
+
+	// Check available space on the buffer.
+	avail = snd_pcm_avail(state->handle);
+	if (avail < 0) {
+		err = avail;
+		goto error;
+	}
+	avail_count = (snd_pcm_uframes_t)avail;
+
+	if (avail_count == 0) {
+		// Let's go to a next iteration.
+		err = 0;
+		goto error;
+	}
+
+	err = read_frames(state, frame_count, avail_count, mapper, cntrs);
+	if (err < 0)
+		goto error;
+
+	return 0;
+error:
+	*frame_count = 0;
+	return err;
+}
+
 static int write_frames(struct libasound_state *state,
 			unsigned int *frame_count, unsigned int avail_count,
 			struct mapper_context *mapper,
@@ -231,6 +276,48 @@ error:
 	return err;
 }
 
+static int w_process_frames_nonblocking(struct libasound_state *state,
+					snd_pcm_state_t status,
+					unsigned int *frame_count,
+					struct mapper_context *mapper,
+					struct container_context *cntrs)
+{
+	snd_pcm_sframes_t avail;
+	unsigned int avail_count;
+	int err;
+
+	// Wait for hardware IRQ when no left space.
+	err = snd_pcm_wait(state->handle, -1);
+	if (err < 0)
+		goto error;
+
+	// Check available space on the buffer.
+	avail = snd_pcm_avail(state->handle);
+	if (avail < 0) {
+		err = avail;
+		goto error;
+	}
+	avail_count = (unsigned int)avail;
+
+	if (avail_count == 0) {
+		// Let's go to a next iteration.
+		err = 0;
+		goto error;
+	}
+
+	err = write_frames(state, frame_count, avail_count, mapper, cntrs);
+	if (err < 0)
+		goto error;
+
+	// NOTE: The substream starts automatically when the accumulated number
+	// of queued data frame exceeds start_threshold.
+
+	return 0;
+error:
+	*frame_count = 0;
+	return err;
+}
+
 static int irq_rw_pre_process(struct libasound_state *state)
 {
 	struct rw_closure *closure = state->private_data;
@@ -267,10 +354,17 @@ static int irq_rw_pre_process(struct libasound_state *state)
 	if (err < 0)
 		return err;
 
-	if (snd_pcm_stream(state->handle) == SND_PCM_STREAM_CAPTURE)
-		closure->process_frames = r_process_frames_blocking;
-	else
-		closure->process_frames = w_process_frames_blocking;
+	if (snd_pcm_stream(state->handle) == SND_PCM_STREAM_CAPTURE) {
+		if (state->nonblock)
+			closure->process_frames = r_process_frames_nonblocking;
+		else
+			closure->process_frames = r_process_frames_blocking;
+	} else {
+		if (state->nonblock)
+			closure->process_frames = w_process_frames_nonblocking;
+		else
+			closure->process_frames = w_process_frames_blocking;
+	}
 
 	return 0;
 }
diff --git a/axfer/xfer-libasound.c b/axfer/xfer-libasound.c
index 77c142e..cb26b69 100644
--- a/axfer/xfer-libasound.c
+++ b/axfer/xfer-libasound.c
@@ -14,9 +14,10 @@ enum no_short_opts {
 	OPT_FATAL_ERRORS = 200,
 };
 
-#define S_OPTS	"D:"
+#define S_OPTS	"D:N"
 static const struct option l_opts[] = {
 	{"device",		1, 0, 'D'},
+	{"nonblock",		0, 0, 'N'},
 	// For debugging.
 	{"fatal-errors",	0, 0, OPT_FATAL_ERRORS},
 };
@@ -46,6 +47,8 @@ static int xfer_libasound_parse_opt(struct xfer_context *xfer, int key,
 
 	if (key == 'D')
 		state->node_literal = arg_duplicate_string(optarg, &err);
+	else if (key == 'N')
+		state->nonblock = true;
 	else if (key == OPT_FATAL_ERRORS)
 		state->finish_at_xrun = true;
 	else
@@ -91,10 +94,14 @@ static int set_access_hw_param(struct libasound_state *state)
 static int open_handle(struct xfer_context *xfer)
 {
 	struct libasound_state *state = xfer->private_data;
+	int mode = 0;
 	int err;
 
+	if (state->nonblock)
+		mode |= SND_PCM_NONBLOCK;
+
 	err = snd_pcm_open(&state->handle, state->node_literal, xfer->direction,
-			   0);
+			   mode);
 	if (err < 0) {
 		logging(state, "Fail to open libasound PCM node for %s: %s\n",
 			snd_pcm_stream_name(xfer->direction),
@@ -378,7 +385,12 @@ static void xfer_libasound_post_process(struct xfer_context *xfer)
 				logging(state, "snd_pcm_drop(): %s\n",
 				       snd_strerror(err));
 		} else {
+			// TODO: this is a bug in kernel land.
+			if (state->nonblock)
+				snd_pcm_nonblock(state->handle, 0);
 			err = snd_pcm_drain(state->handle);
+			if (state->nonblock)
+				snd_pcm_nonblock(state->handle, 1);
 			if (err < 0)
 				logging(state, "snd_pcm_drain(): %s\n",
 				       snd_strerror(err));
diff --git a/axfer/xfer-libasound.h b/axfer/xfer-libasound.h
index 270288d..6656aeb 100644
--- a/axfer/xfer-libasound.h
+++ b/axfer/xfer-libasound.h
@@ -31,6 +31,7 @@ struct libasound_state {
 	char *node_literal;
 
 	bool finish_at_xrun:1;
+	bool nonblock:1;
 };
 
 // For internal use in 'libasound' module.
-- 
2.19.1
