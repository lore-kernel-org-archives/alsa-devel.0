From: Tim Cussins <timcussins@eml.cc>
Subject: [PATCH v2 1/3] snd_pcm_start_at: Add enum for
	timestamp class, and helper struct for start_at ioctl.
Date: Wed, 17 Dec 2014 17:29:23 +0000
Message-ID: <1418837365-19398-1-git-send-email-timcussins@eml.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id EB516260699
 for <alsa-devel@alsa-project.org>; Wed, 17 Dec 2014 18:29:53 +0100 (CET)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id 1F50C21257
 for <alsa-devel@alsa-project.org>; Wed, 17 Dec 2014 12:29:53 -0500 (EST)
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
Cc: tiwai@suse.de, nstoughton@aether.com, Tim Cussins <timcussins@eml.cc>, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

As per Pierre's suggestion, timestamp types are of two types:
System, and Audio.

Signed-off-by: Tim Cussins <timcussins@eml.cc>

diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
index 1f23cd6..bd1e9be 100644
--- a/include/uapi/sound/asound.h
+++ b/include/uapi/sound/asound.h
@@ -466,12 +466,30 @@ struct snd_xfern {
 };
 
 enum {
+        SNDRV_PCM_TSTAMP_CLASS_SYSTEM = 0,
+        SNDRV_PCM_TSTAMP_CLASS_AUDIO,
+        SNDRV_PCM_TSTAMP_CLASS_LAST = SNDRV_PCM_TSTAMP_CLASS_AUDIO,
+};
+
+enum {
 	SNDRV_PCM_TSTAMP_TYPE_GETTIMEOFDAY = 0,	/* gettimeofday equivalent */
 	SNDRV_PCM_TSTAMP_TYPE_MONOTONIC,	/* posix_clock_monotonic equivalent */
 	SNDRV_PCM_TSTAMP_TYPE_MONOTONIC_RAW,    /* monotonic_raw (no NTP) */
 	SNDRV_PCM_TSTAMP_TYPE_LAST = SNDRV_PCM_TSTAMP_TYPE_MONOTONIC_RAW,
 };
 
+enum {
+        SNDRV_PCM_AUDIO_TSTAMP_TYPE_DEFAULT = 0,
+        SNDRV_PCM_AUDIO_TSTAMP_TYPE_LINK,
+        SNDRV_PCM_AUDIO_TSTAMP_TYPE_LAST = SNDRV_PCM_AUDIO_TSTAMP_TYPE_LINK,
+};
+
+struct snd_start_at {
+        int tstamp_class;
+        int tstamp_type;
+        struct timespec start_time;
+};
+
 /* channel positions */
 enum {
 	SNDRV_CHMAP_UNKNOWN = 0,
@@ -550,6 +568,8 @@ enum {
 #define SNDRV_PCM_IOCTL_READN_FRAMES	_IOR('A', 0x53, struct snd_xfern)
 #define SNDRV_PCM_IOCTL_LINK		_IOW('A', 0x60, int)
 #define SNDRV_PCM_IOCTL_UNLINK		_IO('A', 0x61)
+#define SNDRV_PCM_IOCTL_START_AT        _IOW('A', 0x62, struct snd_start_at)
+
 
 /*****************************************************************************
  *                                                                           *
-- 
2.1.0
