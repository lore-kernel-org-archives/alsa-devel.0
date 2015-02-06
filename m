From: Tim Cussins <timcussins@eml.cc>
Subject: [PATCH v3 kernel 1/3] snd_pcm_start_at and friends.
Date: Fri,  6 Feb 2015 16:16:26 +0000
Message-ID: <1423239388-17745-1-git-send-email-timcussins@eml.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 60BDB265314
 for <alsa-devel@alsa-project.org>; Fri,  6 Feb 2015 17:16:40 +0100 (CET)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.nyi.internal (Postfix) with ESMTP id B448B20B91
 for <alsa-devel@alsa-project.org>; Fri,  6 Feb 2015 11:16:39 -0500 (EST)
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

We introduce the kernel-side of the START_AT ioctl.

struct runtime is updated to hold information about the currently
active start_at timer, if any. This facilitates cancellation via
snd_pcm_start_at_abort(), and querying via snd_pcm_status().

struct snd_start_at holds a startat operation and its arguments.

Signed-off-by: Tim Cussins <timcussins@eml.cc>

diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
index 0e88e7a..2943e1a 100644
--- a/include/uapi/sound/asound.h
+++ b/include/uapi/sound/asound.h
@@ -421,7 +421,10 @@ struct snd_pcm_status {
 	snd_pcm_state_t suspended_state; /* suspended stream state */
 	__u32 reserved_alignment;	/* must be filled with zero */
 	struct timespec audio_tstamp;	/* from sample counter or wall clock */
-	unsigned char reserved[56-sizeof(struct timespec)]; /* must be filled with zero */
+	int startat_pending;		/* 1 if a start_at timer is pending, 0 otherwise */
+	int startat_clock_type;		/* start_at clock type, if pending */
+	struct timespec startat_start_time;	/* start_at start time, if pending */
+	unsigned char reserved[48-(2*sizeof(struct timespec))]; /* must be filled with zero */
 };
 
 struct snd_pcm_mmap_status {
@@ -473,6 +476,34 @@ enum {
 	SNDRV_PCM_TSTAMP_TYPE_LAST = SNDRV_PCM_TSTAMP_TYPE_MONOTONIC_RAW,
 };
 
+enum {
+	SNDRV_PCM_STARTAT_OP_SET = 0,
+	SNDRV_PCM_STARTAT_OP_CANCEL,
+	SNDRV_PCM_STARTAT_OP_STATUS,
+	SNDRV_PCM_STARTAT_OP_LAST = SNDRV_PCM_STARTAT_OP_STATUS,
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
+	int op;				/* startat operation to be performed */
+	union {				/* fields for setting a startat timer */
+		struct {
+			int clock_type;			/* clock type e.g. SNDRV_PCM_STARTAT_CLOCK_TYPE_GETTIMEOFDAY */
+			struct timespec start_time;	/* start time */
+		} set;
+		struct {
+			int clock_type;
+			struct timespec current_time;
+		} status;
+	} args;
+};
+
 /* channel positions */
 enum {
 	SNDRV_CHMAP_UNKNOWN = 0,
@@ -551,6 +582,8 @@ enum {
 #define SNDRV_PCM_IOCTL_READN_FRAMES	_IOR('A', 0x53, struct snd_xfern)
 #define SNDRV_PCM_IOCTL_LINK		_IOW('A', 0x60, int)
 #define SNDRV_PCM_IOCTL_UNLINK		_IO('A', 0x61)
+#define SNDRV_PCM_IOCTL_START_AT        _IOW('A', 0x62, struct snd_start_at)
+
 
 /*****************************************************************************
  *                                                                           *
-- 
1.9.1
