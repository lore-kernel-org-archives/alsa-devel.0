From: Ben Gardiner <bengardiner@nanometrics.ca>
Subject: [PATCH] sound, core,
	pcm_lib: xrun_log: log also in_interrupt
Date: Wed, 18 May 2011 10:03:34 -0400
Message-ID: <1305727414-17623-1-git-send-email-bengardiner@nanometrics.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog113.obsmtp.com (na3sys009aog113.obsmtp.com
	[74.125.149.209])
	by alsa0.perex.cz (Postfix) with ESMTP id 59D1B24432
	for <alsa-devel@alsa-project.org>;
	Wed, 18 May 2011 16:03:48 +0200 (CEST)
Received: by mail-vx0-f176.google.com with SMTP id 37so1731614vxa.35
	for <alsa-devel@alsa-project.org>; Wed, 18 May 2011 07:03:40 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
Cc: Ben Gardiner <bengardiner@nanometrics.ca>, Clemens Ladisch <clemens@ladisch.de>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

When debugging pcm drivers I found the "period" or "hw" prefix printed
by either XRUN_DEBUG_PERIODUPDATE or XRUN_DEBUG_PERIODUPDATE events, 
respectively to be very useful is observing the interplay between
interrupt-context updates and syscall-context updates.

Similarly, when debugging overruns with XRUN_DEBUG_LOG it is useful to
see the context of the last 10 positions.

Add an in_interrupt member to hwptr_log_entry which stores the value of
the in_interrupt parameter of snd_pcm_update_hw_ptr0 when the log entry
is created. Print a "[Q]" prefix when dumping the log entries if
in_interrupt was true.

Signed-off-by: Ben Gardiner <bengardiner@nanometrics.ca>
---
 sound/core/pcm_lib.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index 64449cb..c8c8091 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -189,6 +189,7 @@ static void xrun(struct snd_pcm_substream *substream)
 #define XRUN_LOG_CNT	10
 
 struct hwptr_log_entry {
+	unsigned int in_interrupt;
 	unsigned long jiffies;
 	snd_pcm_uframes_t pos;
 	snd_pcm_uframes_t period_size;
@@ -204,7 +205,7 @@ struct snd_pcm_hwptr_log {
 };
 
 static void xrun_log(struct snd_pcm_substream *substream,
-		     snd_pcm_uframes_t pos)
+		     snd_pcm_uframes_t pos, int in_interrupt)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_pcm_hwptr_log *log = runtime->hwptr_log;
@@ -220,6 +221,7 @@ static void xrun_log(struct snd_pcm_substream *substream,
 			return;
 	}
 	entry = &log->entries[log->idx];
+	entry->in_interrupt = in_interrupt;
 	entry->jiffies = jiffies;
 	entry->pos = pos;
 	entry->period_size = runtime->period_size;
@@ -246,9 +248,11 @@ static void xrun_log_show(struct snd_pcm_substream *substream)
 		entry = &log->entries[idx];
 		if (entry->period_size == 0)
 			break;
-		snd_printd("hwptr log: %s: j=%lu, pos=%ld/%ld/%ld, "
+		snd_printd("hwptr log: %s: %sj=%lu, pos=%ld/%ld/%ld, "
 			   "hwptr=%ld/%ld\n",
-			   name, entry->jiffies, (unsigned long)entry->pos,
+			   name, entry->in_interrupt ? "[Q] " : "",
+			   entry->jiffies,
+			   (unsigned long)entry->pos,
 			   (unsigned long)entry->period_size,
 			   (unsigned long)entry->buffer_size,
 			   (unsigned long)entry->old_hw_ptr,
@@ -326,7 +330,7 @@ static int snd_pcm_update_hw_ptr0(struct snd_pcm_substream *substream,
 	}
 	pos -= pos % runtime->min_align;
 	if (xrun_debug(substream, XRUN_DEBUG_LOG))
-		xrun_log(substream, pos);
+		xrun_log(substream, pos, in_interrupt);
 	hw_base = runtime->hw_ptr_base;
 	new_hw_ptr = hw_base + pos;
 	if (in_interrupt) {
-- 
1.7.4.1
