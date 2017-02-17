From: sutar.mounesh@gmail.com
Subject: [PATCH 2/6] pcm:direct: fix race on clearing timer
	events
Date: Fri, 17 Feb 2017 12:45:56 +0530
Message-ID: <1487315756-8991-1-git-send-email-sutar.mounesh@gmail.com>
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
Cc: Jiada Wang <jiada_wang@mentor.com>, Mounesh Sutar <sutar.mounesh@gmail.com>, alsa-devel@alsa-project.org, Andreas Pape <apape@de.adit-jv.com>, mounesh_sutar@mentor.com
List-Id: alsa-devel@alsa-project.org

From: Andreas Pape <apape@de.adit-jv.com>

snd_timer handling is racy: plugins clear timer queue if avail_min
is not reached to force a sleep on timer. The race can happen if
the expected event arrives in between the avail check and the
clearing of pending events. If this race happens, the user will
unnecessarily wait for one more timer event. On low latency/realtime
streams this can lead to xruns and must be avoided.

As a fix we recheck avail after having cleared poll events.

Signed-off-by: Andreas Pape <apape@de.adit-jv.com>
Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
Signed-off-by: Mounesh Sutar <sutar.mounesh@gmail.com>

diff --git a/src/pcm/pcm_direct.c b/src/pcm/pcm_direct.c
index 364191b..8a75c42 100644
--- a/src/pcm/pcm_direct.c
+++ b/src/pcm/pcm_direct.c
@@ -515,10 +515,12 @@ int snd_pcm_direct_async(snd_pcm_t *pcm, int sig, pid_t pid)
 }
 
 /* empty the timer read queue */
-void snd_pcm_direct_clear_timer_queue(snd_pcm_direct_t *dmix)
+int snd_pcm_direct_clear_timer_queue(snd_pcm_direct_t *dmix)
 {
+	int changed = 0;
 	if (dmix->timer_need_poll) {
 		while (poll(&dmix->timer_fd, 1, 0) > 0) {
+			changed++;
 			/* we don't need the value */
 			if (dmix->tread) {
 				snd_timer_tread_t rbuf[4];
@@ -533,15 +535,17 @@ void snd_pcm_direct_clear_timer_queue(snd_pcm_direct_t *dmix)
 			snd_timer_tread_t rbuf[4];
 			int len;
 			while ((len = snd_timer_read(dmix->timer, rbuf,
-						     sizeof(rbuf))) > 0 &&
+						     sizeof(rbuf))) > 0
+						     && (++changed) &&
 			       len != sizeof(rbuf[0]))
 				;
 		} else {
 			snd_timer_read_t rbuf;
 			while (snd_timer_read(dmix->timer, &rbuf, sizeof(rbuf)) > 0)
-				;
+				changed++;
 		}
 	}
+	return changed;
 }
 
 int snd_pcm_direct_timer_stop(snd_pcm_direct_t *dmix)
@@ -693,6 +697,8 @@ int snd_pcm_direct_poll_revents(snd_pcm_t *pcm, struct pollfd *pfds, unsigned in
 	int empty = 0;
 
 	assert(pfds && nfds == 1 && revents);
+
+timer_changed:
 	events = pfds[0].revents;
 	if (events & POLLIN) {
 		snd_pcm_uframes_t avail;
@@ -720,7 +726,16 @@ int snd_pcm_direct_poll_revents(snd_pcm_t *pcm, struct pollfd *pfds, unsigned in
 		break;
 	default:
 		if (empty) {
-			snd_pcm_direct_clear_timer_queue(dmix);
+			/* here we have a race condition:
+			 * if period event arrived after the avail_update call
+			 * above we might clear this event with the following
+			 * clear_timer_queue.
+			 * There is no way to do this in atomic manner, so we
+			 * need to recheck avail_update if we successfully
+			 * cleared a poll event.
+			 */
+			if (snd_pcm_direct_clear_timer_queue(dmix))
+				goto timer_changed;
 			events &= ~(POLLOUT|POLLIN);
 			/* additional check */
 			switch (__snd_pcm_state(pcm)) {
diff --git a/src/pcm/pcm_direct.h b/src/pcm/pcm_direct.h
index fba55fd..24e85f0 100644
--- a/src/pcm/pcm_direct.h
+++ b/src/pcm/pcm_direct.h
@@ -322,7 +322,7 @@ int snd_pcm_direct_munmap(snd_pcm_t *pcm);
 int snd_pcm_direct_prepare(snd_pcm_t *pcm);
 int snd_pcm_direct_resume(snd_pcm_t *pcm);
 int snd_pcm_direct_timer_stop(snd_pcm_direct_t *dmix);
-void snd_pcm_direct_clear_timer_queue(snd_pcm_direct_t *dmix);
+int snd_pcm_direct_clear_timer_queue(snd_pcm_direct_t *dmix);
 int snd_pcm_direct_set_timer_params(snd_pcm_direct_t *dmix);
 int snd_pcm_direct_open_secondary_client(snd_pcm_t **spcmp, snd_pcm_direct_t *dmix, const char *client_name);
 
-- 
2.7.4
