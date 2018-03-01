From: <twischer@de.adit-jv.com>
Subject: [PATCH - THREAD_SAFE_API 1/1] pcm: Do not access
	lock_enabled if thread safe API
Date: Thu, 1 Mar 2018 17:34:44 +0100
Message-ID: <1519922084-6954-1-git-send-email-twischer@de.adit-jv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: Timo Wischer <twischer@de.adit-jv.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Timo Wischer <twischer@de.adit-jv.com>

is not enabled.
Without this commit compiling fails when THREAD_SAFE_API is not enabled

Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>

diff --git a/src/pcm/pcm.c b/src/pcm/pcm.c
index 1be3833..d53ed98 100644
--- a/src/pcm/pcm.c
+++ b/src/pcm/pcm.c
@@ -823,8 +823,11 @@ int snd_pcm_async(snd_pcm_t *pcm, int sig, pid_t pid)
 		sig = SIGIO;
 	if (pid == 0)
 		pid = getpid();
+
+#ifdef THREAD_SAFE_API
 	/* async handler may lead to a deadlock; suppose no multi thread */
 	pcm->lock_enabled = 0;
+#endif
 	return pcm->ops->async(pcm->op_arg, sig, pid);
 }
 #endif
-- 
2.7.4
