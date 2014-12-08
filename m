From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH RFC 7/9] ALSA: core: pass audio tstamp config
	from userspace in compat mode
Date: Mon,  8 Dec 2014 16:23:44 -0600
Message-ID: <1418077426-8309-8-git-send-email-pierre-louis.bossart@linux.intel.com>
References: <1418077426-8309-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 819312605BA
 for <alsa-devel@alsa-project.org>; Mon,  8 Dec 2014 23:24:42 +0100 (CET)
In-Reply-To: <1418077426-8309-1-git-send-email-pierre-louis.bossart@linux.intel.com>
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
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Let userspace select audio timestamp config, ignore and zero all
other fields
Use audio_tstamp_data to retrieve config and pass report back to
user space

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/core/pcm_compat.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/core/pcm_compat.c b/sound/core/pcm_compat.c
index 2d957ba..d71b5b3 100644
--- a/sound/core/pcm_compat.c
+++ b/sound/core/pcm_compat.c
@@ -194,7 +194,7 @@ struct snd_pcm_status32 {
 	u32 avail_max;
 	u32 overrange;
 	s32 suspended_state;
-	u32 reserved_alignment;
+	u32 audio_tstamp_data;
 	struct compat_timespec audio_tstamp;
 	unsigned char reserved[56-sizeof(struct compat_timespec)];
 } __attribute__((packed));
@@ -206,6 +206,10 @@ static int snd_pcm_status_user_compat(struct snd_pcm_substream *substream,
 	struct snd_pcm_status status;
 	int err;
 
+	/* fetch audio_stamp_config from user-space */
+	if (get_user(status.audio_tstamp_data, &src->audio_tstamp_data))
+		return -EFAULT;
+
 	err = snd_pcm_status(substream, &status);
 	if (err < 0)
 		return err;
@@ -222,6 +226,7 @@ static int snd_pcm_status_user_compat(struct snd_pcm_substream *substream,
 	    put_user(status.avail_max, &src->avail_max) ||
 	    put_user(status.overrange, &src->overrange) ||
 	    put_user(status.suspended_state, &src->suspended_state) ||
+	    put_user(status.audio_tstamp_data, &src->audio_tstamp_data) ||
 	    compat_put_timespec(&status.audio_tstamp, &src->audio_tstamp))
 		return -EFAULT;
 
-- 
2.1.0
