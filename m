From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v4 01/10] ALSA: core: don't override timestamp
	unconditionally
Date: Fri, 30 Jan 2015 17:55:54 -0600
Message-ID: <1422662163-7391-2-git-send-email-pierre-louis.bossart@linux.intel.com>
References: <1422662163-7391-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id D43A526070A
 for <alsa-devel@alsa-project.org>; Sat, 31 Jan 2015 00:56:21 +0100 (CET)
In-Reply-To: <1422662163-7391-1-git-send-email-pierre-louis.bossart@linux.intel.com>
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

timestamp in RUNNING mode is already taken in update_hw_ptr routine,
getting a new timestamp introduces offset between hw_ptr, audio_tstamp
and system time

Add else condition to read timestamp as fallback and only when
enabled

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/core/pcm_native.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index ff3abc3..7bbc34d 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -720,8 +720,11 @@ int snd_pcm_status(struct snd_pcm_substream *substream,
 				runtime->status->audio_tstamp;
 			goto _tstamp_end;
 		}
+	} else {
+		/* get tstamp only in fallback mode and only if enabled */
+		if (runtime->tstamp_mode == SNDRV_PCM_TSTAMP_ENABLE)
+			snd_pcm_gettime(runtime, &status->tstamp);
 	}
-	snd_pcm_gettime(runtime, &status->tstamp);
  _tstamp_end:
 	status->appl_ptr = runtime->control->appl_ptr;
 	status->hw_ptr = runtime->status->hw_ptr;
-- 
1.9.1
