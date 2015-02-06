From: Tim Cussins <timcussins@eml.cc>
Subject: [PATCH v3 alsa-lib 2/3] START_AT ioctl and operations.
Date: Fri,  6 Feb 2015 16:16:00 +0000
Message-ID: <1423239361-17655-2-git-send-email-timcussins@eml.cc>
References: <1423239361-17655-1-git-send-email-timcussins@eml.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id D1C5A2651A4
 for <alsa-devel@alsa-project.org>; Fri,  6 Feb 2015 17:16:13 +0100 (CET)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
 by mailout.nyi.internal (Postfix) with ESMTP id 6E7BF20B50
 for <alsa-devel@alsa-project.org>; Fri,  6 Feb 2015 11:16:13 -0500 (EST)
In-Reply-To: <1423239361-17655-1-git-send-email-timcussins@eml.cc>
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
Cc: Tim Cussins <timcussins@eml.cc>
List-Id: alsa-devel@alsa-project.org

We introduce a new ioctl, START_AT, and 3 new snd_pcm_fast_ops_t members.

The ioctl takes a struct snd_start_at, which holds the required operation,
and corresponding arguments (which can be input and output).

The START_AT ioctol supports SET, CANCEL, and STATUS operations. STATUS
returns the current time.

struct snd_start_at packing, ioctl invocation, and unpacking is implemented
in pcm_hw.c.

Signed-off-by: Tim Cussins <timcussins@eml.cc>

diff --git a/include/sound/asound.h b/include/sound/asound.h
index 1f23cd6..ab7c05b 100644
--- a/include/sound/asound.h
+++ b/include/sound/asound.h
@@ -420,7 +420,10 @@ struct snd_pcm_status {
 	snd_pcm_state_t suspended_state; /* suspended stream state */
 	__u32 reserved_alignment;	/* must be filled with zero */
 	struct timespec audio_tstamp;	/* from sample counter or wall clock */
-	unsigned char reserved[56-sizeof(struct timespec)]; /* must be filled with zero */
+	int start_at_pending;
+	int start_at_clock_type;
+	struct timespec start_at_start_time;
+	unsigned char reserved[48-2*(sizeof(struct timespec))]; /* must be filled with zero */
 };
 
 struct snd_pcm_mmap_status {
@@ -472,6 +475,34 @@ enum {
 	SNDRV_PCM_TSTAMP_TYPE_LAST = SNDRV_PCM_TSTAMP_TYPE_MONOTONIC_RAW,
 };
 
+enum {
+        SNDRV_PCM_STARTAT_OP_SET = 0,
+        SNDRV_PCM_STARTAT_OP_CANCEL,
+        SNDRV_PCM_STARTAT_OP_STATUS,
+        SNDRV_PCM_STARTAT_OP_LAST = SNDRV_PCM_STARTAT_OP_STATUS,
+};
+
+enum {
+        SNDRV_PCM_STARTAT_CLOCK_TYPE_GETTIMEOFDAY = 0,
+        SNDRV_PCM_STARTAT_CLOCK_TYPE_MONOTONIC,
+        SNDRV_PCM_STARTAT_CLOCK_TYPE_LINK,
+        SNDRV_PCM_STARTAT_CLOCK_TYPE_LAST = SNDRV_PCM_STARTAT_CLOCK_TYPE_LINK,
+};
+
+struct snd_start_at {
+        int op;                         /* startat operation to be performed */
+        union {                         /* fields for setting a startat timer */
+                struct {
+                        int clock_type;                 /* clock type e.g. SNDRV_PCM_STARTAT_CLOCK_TYPE_GETTIMEOFDAY */
+                        struct timespec start_time;     /* start time */
+                } set;
+                struct {
+                        int clock_type;                 /* clock type e.g. SNDRV_PCM_STARTAT_CLOCK_TYPE_GETTIMEOFDAY */
+                        struct timespec current_time;
+                } status;
+        } args;
+};
+
 /* channel positions */
 enum {
 	SNDRV_CHMAP_UNKNOWN = 0,
@@ -550,6 +581,8 @@ enum {
 #define SNDRV_PCM_IOCTL_READN_FRAMES	_IOR('A', 0x53, struct snd_xfern)
 #define SNDRV_PCM_IOCTL_LINK		_IOW('A', 0x60, int)
 #define SNDRV_PCM_IOCTL_UNLINK		_IO('A', 0x61)
+#define SNDRV_PCM_IOCTL_START_AT	_IOW('A', 0x62, struct snd_start_at)
+
 
 /*****************************************************************************
  *                                                                           *
diff --git a/src/pcm/pcm_hw.c b/src/pcm/pcm_hw.c
index c34b766..07c3a2e 100644
--- a/src/pcm/pcm_hw.c
+++ b/src/pcm/pcm_hw.c
@@ -620,6 +620,67 @@ static int snd_pcm_hw_start(snd_pcm_t *pcm)
 	return 0;
 }
 
+static int snd_pcm_hw_start_at(snd_pcm_t *pcm, snd_pcm_startat_clock_type_t clock_type, const snd_htimestamp_t *start_time)
+{
+	snd_pcm_hw_t *hw = pcm->private_data;
+	int err;
+
+	struct snd_start_at start_at = {
+		.op = SNDRV_PCM_STARTAT_OP_SET,
+		.args.set = {
+			.clock_type = clock_type,
+			.start_time = *start_time,
+		}
+	};
+
+	if (ioctl(hw->fd, SNDRV_PCM_IOCTL_START_AT, &start_at) < 0) {
+		err = -errno;
+		SYSMSG("SNDRV_PCM_IOCTL_START_AT failed (%i)", err);
+		return err;
+	}
+	return 0;
+}
+
+static int snd_pcm_hw_start_at_abort(snd_pcm_t *pcm)
+{
+	snd_pcm_hw_t *hw = pcm->private_data;
+	int err;
+
+	struct snd_start_at start_at = {
+		.op = SNDRV_PCM_STARTAT_OP_CANCEL,
+	};
+
+	if (ioctl(hw->fd, SNDRV_PCM_IOCTL_START_AT, &start_at) < 0) {
+		err = -errno;
+		SYSMSG("SNDRV_PCM_IOCTL_START_AT failed (%i)", err);
+		return err;
+	}
+	return 0;
+}
+
+static int snd_pcm_hw_start_at_gettime(snd_pcm_t *pcm, snd_pcm_startat_clock_type_t clock_type, snd_htimestamp_t *current_time)
+{
+	snd_pcm_hw_t *hw = pcm->private_data;
+	int err;
+
+	struct snd_start_at start_at = {
+		.op = SNDRV_PCM_STARTAT_OP_STATUS,
+		.args.status = {
+			.clock_type = clock_type,
+		}
+	};
+
+	if (ioctl(hw->fd, SNDRV_PCM_IOCTL_START_AT, &start_at) < 0) {
+		err = -errno;
+		SYSMSG("SNDRV_PCM_IOCTL_START_AT failed (%i)", err);
+		return err;
+	}
+
+	*current_time = start_at.args.status.current_time;
+
+	return 0;
+}
+
 static int snd_pcm_hw_drop(snd_pcm_t *pcm)
 {
 	snd_pcm_hw_t *hw = pcm->private_data;
@@ -1336,6 +1397,9 @@ static const snd_pcm_fast_ops_t snd_pcm_hw_fast_ops = {
 	.prepare = snd_pcm_hw_prepare,
 	.reset = snd_pcm_hw_reset,
 	.start = snd_pcm_hw_start,
+	.start_at = snd_pcm_hw_start_at,
+	.start_at_abort = snd_pcm_hw_start_at_abort,
+	.start_at_gettime = snd_pcm_hw_start_at_gettime,
 	.drop = snd_pcm_hw_drop,
 	.drain = snd_pcm_hw_drain,
 	.pause = snd_pcm_hw_pause,
diff --git a/src/pcm/pcm_local.h b/src/pcm/pcm_local.h
index 394505f..0ea6b61 100644
--- a/src/pcm/pcm_local.h
+++ b/src/pcm/pcm_local.h
@@ -154,6 +154,9 @@ typedef struct {
 	int (*prepare)(snd_pcm_t *pcm);
 	int (*reset)(snd_pcm_t *pcm);
 	int (*start)(snd_pcm_t *pcm);
+	int (*start_at)(snd_pcm_t *pcm, snd_pcm_startat_clock_type_t clock_type, const snd_htimestamp_t *start_time);
+	int (*start_at_abort)(snd_pcm_t *pcm);
+	int (*start_at_gettime)(snd_pcm_t *pcm, snd_pcm_startat_clock_type_t clock_type, snd_htimestamp_t *current_time);
 	int (*drop)(snd_pcm_t *pcm);
 	int (*drain)(snd_pcm_t *pcm);
 	int (*pause)(snd_pcm_t *pcm, int enable);
-- 
1.9.1
