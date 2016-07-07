From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH alsa-lib v2 3/3] pcm: Add LIBASOUND_THREAD_SAFE
	env variable check
Date: Thu,  7 Jul 2016 16:40:13 +0200
Message-ID: <20160707144013.23953-4-tiwai@suse.de>
References: <20160707144013.23953-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 9155826586A
 for <alsa-devel@alsa-project.org>; Thu,  7 Jul 2016 16:40:16 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 4CCF9AC80
 for <alsa-devel@alsa-project.org>; Thu,  7 Jul 2016 14:40:16 +0000 (UTC)
In-Reply-To: <20160707144013.23953-1-tiwai@suse.de>
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
List-Id: alsa-devel@alsa-project.org

For making the debugging with any deadlocks by the newly introduced
thread-safety feature, add a check with LIBASOUND_THREAD_SAFE
environment variable.  When this variable is set to "0", alsa-lib PCM
forcibly disables the whole thread-safe pthread mutex calls.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 src/pcm/pcm.c       | 16 ++++++++++++++++
 src/pcm/pcm_local.h |  6 ++++--
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/src/pcm/pcm.c b/src/pcm/pcm.c
index 1567a46146ad..1a9e9574ded8 100644
--- a/src/pcm/pcm.c
+++ b/src/pcm/pcm.c
@@ -494,6 +494,13 @@ aren't thread-safe, and application needs to call them carefully when they
 are called from multiple threads.  In general, all the functions that are
 often called during streaming are covered as thread-safe.
 
+This thread-safe behavior can be disabled also by passing 0 to the environment
+variable LIBASOUND_THREAD_SAFE, e.g.
+\code
+LIBASOUND_THREAD_SAFE=0 aplay foo.wav
+\endcode
+for making the debugging easier.
+
 \section pcm_dev_names PCM naming conventions
 
 The ALSA library uses a generic string representation for names of devices.
@@ -2541,6 +2548,15 @@ int snd_pcm_new(snd_pcm_t **pcmp, snd_pcm_type_t type, const char *name,
 	INIT_LIST_HEAD(&pcm->async_handlers);
 #ifdef THREAD_SAFE_API
 	pthread_mutex_init(&pcm->lock, NULL);
+	{
+		static int default_thread_safe = -1;
+		if (default_thread_safe < 0) {
+			char *p = getenv("LIBASOUND_THREAD_SAFE");
+			default_thread_safe = !p || *p != '0';
+		}
+		if (!default_thread_safe)
+			pcm->thread_safe = -1; /* force to disable */
+	}
 #endif
 	*pcmp = pcm;
 	return 0;
diff --git a/src/pcm/pcm_local.h b/src/pcm/pcm_local.h
index 5c7eeb4ee07d..bb7964d7833e 100644
--- a/src/pcm/pcm_local.h
+++ b/src/pcm/pcm_local.h
@@ -1087,11 +1087,13 @@ static inline void sw_set_period_event(snd_pcm_sw_params_t *params, int val)
 #ifdef THREAD_SAFE_API
 static inline void __snd_pcm_lock(snd_pcm_t *pcm)
 {
-	pthread_mutex_lock(&pcm->lock);
+	if (pcm->thread_safe >= 0)
+		pthread_mutex_lock(&pcm->lock);
 }
 static inline void __snd_pcm_unlock(snd_pcm_t *pcm)
 {
-	pthread_mutex_unlock(&pcm->lock);
+	if (pcm->thread_safe >= 0)
+		pthread_mutex_unlock(&pcm->lock);
 }
 static inline void snd_pcm_lock(snd_pcm_t *pcm)
 {
-- 
2.9.0
