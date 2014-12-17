From: Tim Cussins <timcussins@eml.cc>
Subject: [PATCH v2 2/3] snd_pcm_start_at: Add snd_pcm_ops so
	that driver can handle start_at requests.
Date: Wed, 17 Dec 2014 17:29:24 +0000
Message-ID: <1418837365-19398-2-git-send-email-timcussins@eml.cc>
References: <1418837365-19398-1-git-send-email-timcussins@eml.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 83DB72606B2
 for <alsa-devel@alsa-project.org>; Wed, 17 Dec 2014 18:29:56 +0100 (CET)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.nyi.internal (Postfix) with ESMTP id 1BA1720F59
 for <alsa-devel@alsa-project.org>; Wed, 17 Dec 2014 12:29:56 -0500 (EST)
In-Reply-To: <1418837365-19398-1-git-send-email-timcussins@eml.cc>
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

Provide members for starting and cancelling the timer.
Add state to snd_pcm_runtime that tracks current timer: This
allows us to cancel on state-change, or subsequent start_at call.

Signed-off-by: Tim Cussins <timcussins@eml.cc>

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index 1e7f74a..e7d5ded 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -73,6 +73,8 @@ struct snd_pcm_ops {
 	snd_pcm_uframes_t (*pointer)(struct snd_pcm_substream *substream);
 	int (*wall_clock)(struct snd_pcm_substream *substream,
 			  struct timespec *audio_ts);
+	int (*start_at)(struct snd_pcm_substream *substream, int audio_tstamp_type, const struct timespec *ts);
+	int (*start_at_cancel)(struct snd_pcm_substream *substream);
 	int (*copy)(struct snd_pcm_substream *substream, int channel,
 		    snd_pcm_uframes_t pos,
 		    void __user *buf, snd_pcm_uframes_t count);
@@ -364,6 +366,10 @@ struct snd_pcm_runtime {
 #ifdef CONFIG_SND_PCM_XRUN_DEBUG
 	struct snd_pcm_hwptr_log *hwptr_log;
 #endif
+
+	int start_at_timer_running;		/* 0 if no timer is running, 1 if running */
+	int start_at_timer_tstamp_class;	/* tstamp class of current timer */
+	void* start_at_timer_data;		/* data associated with current timer */
 };
 
 struct snd_pcm_group {		/* keep linked substreams */
-- 
2.1.0
