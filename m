From: sutar.mounesh@gmail.com
Subject: [PATCH 3/4] alsa-lib:pcm: check state before enter
	poll on timer.
Date: Tue, 10 Jan 2017 12:03:54 +0530
Message-ID: <1484030034-11191-1-git-send-email-sutar.mounesh@gmail.com>
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
Cc: alsa-devel@alsa-project.org, Andreas Pape <apape@de.adit-jv.com>, mounesh_sutar@mentor.com
List-Id: alsa-devel@alsa-project.org

From: Andreas Pape <apape@de.adit-jv.com>

To avoid the chances of timeout, we need to check the enter poll
in state xrun.

Signed-off-by: Andreas Pape <apape@de.adit-jv.com>
Signed-off-by: Mounesh Sutar <mounesh_sutar@mentor.com>

diff --git a/src/pcm/pcm_direct.c b/src/pcm/pcm_direct.c
index 2bb2d4a..0642852 100644
--- a/src/pcm/pcm_direct.c
+++ b/src/pcm/pcm_direct.c
@@ -645,6 +645,46 @@ int snd_pcm_direct_client_chk_xrun(snd_pcm_direct_t *direct, snd_pcm_t *pcm)
 	return 0;
 }
 
+/*
+ * This is the only operation guaranteed to be called before entering poll().
+ * Direct plugins use fd of snd_timer to poll on, these timers do NOT check
+ * state of substream in kernel by intention.
+ * Only the enter to xrun might be notified once (SND_TIMER_EVENT_MSTOP).
+ * If xrun event was not correctly handled or was ignored it will never be
+ * evaluated again afterwards.
+ * This will result in snd_pcm_wait() always returning timeout.
+ * In contrast poll() on pcm hardware checks ALSA state and will immediately
+ * return POLLERR on XRUN.
+ *
+ * To prevent timeout and applications endlessly spinning without xrun
+ * detected we add a state check here which may trigger the xrun sequence.
+ *
+ * return count of filled descriptors or negative error code
+ */
+int snd_pcm_direct_poll_descriptors(snd_pcm_t *pcm, struct pollfd *pfds,
+				    unsigned int space)
+{
+	if (pcm->poll_fd < 0) {
+		SNDMSG("poll_fd < 0");
+		return -EIO;
+	}
+	if (space >= 1 && pfds) {
+		pfds->fd = pcm->poll_fd;
+		pfds->events = pcm->poll_events | POLLERR | POLLNVAL;
+	} else {
+		return 0;
+	}
+
+	/* this will also evaluate slave state and enter xrun if necessary */
+	switch (snd_pcm_state(pcm)) {
+	case SND_PCM_STATE_XRUN:
+		return -EPIPE;
+	default:
+		break;
+	}
+	return 1;
+}
+
 int snd_pcm_direct_poll_revents(snd_pcm_t *pcm, struct pollfd *pfds, unsigned int nfds, unsigned short *revents)
 {
 	snd_pcm_direct_t *dmix = pcm->private_data;
diff --git a/src/pcm/pcm_direct.h b/src/pcm/pcm_direct.h
index d48f6b4..66107ec 100644
--- a/src/pcm/pcm_direct.h
+++ b/src/pcm/pcm_direct.h
@@ -307,6 +307,8 @@ int snd_pcm_direct_parse_bindings(snd_pcm_direct_t *dmix,
 				  snd_config_t *cfg);
 int snd_pcm_direct_nonblock(snd_pcm_t *pcm, int nonblock);
 int snd_pcm_direct_async(snd_pcm_t *pcm, int sig, pid_t pid);
+int snd_pcm_direct_poll_descriptors(snd_pcm_t *pcm, struct pollfd *pfds,
+				    unsigned int space);
 int snd_pcm_direct_poll_revents(snd_pcm_t *pcm, struct pollfd *pfds, unsigned int nfds, unsigned short *revents);
 int snd_pcm_direct_info(snd_pcm_t *pcm, snd_pcm_info_t * info);
 int snd_pcm_direct_hw_refine(snd_pcm_t *pcm, snd_pcm_hw_params_t *params);
diff --git a/src/pcm/pcm_dmix.c b/src/pcm/pcm_dmix.c
index 258d4de..2e7d9d2 100644
--- a/src/pcm/pcm_dmix.c
+++ b/src/pcm/pcm_dmix.c
@@ -462,17 +462,22 @@ static int snd_pcm_dmix_sync_ptr(snd_pcm_t *pcm)
 static snd_pcm_state_t snd_pcm_dmix_state(snd_pcm_t *pcm)
 {
 	snd_pcm_direct_t *dmix = pcm->private_data;
+	int err;
 	snd_pcm_state_t state;
 	state = snd_pcm_state(dmix->spcm);
 	switch (state) {
-	case SND_PCM_STATE_XRUN:
 	case SND_PCM_STATE_SUSPENDED:
 	case SND_PCM_STATE_DISCONNECTED:
 		dmix->state = state;
 		return state;
+	case SND_PCM_STATE_XRUN:
+		if ((err = snd_pcm_direct_slave_recover(dmix)) < 0)
+			return err;
+		break;
 	default:
 		break;
 	}
+	snd_pcm_direct_client_chk_xrun(dmix, pcm);
 	if (dmix->state == STATE_RUN_PENDING)
 		return SNDRV_PCM_STATE_RUNNING;
 	return dmix->state;
@@ -968,7 +973,7 @@ static const snd_pcm_fast_ops_t snd_pcm_dmix_fast_ops = {
 	.avail_update = snd_pcm_dmix_avail_update,
 	.mmap_commit = snd_pcm_dmix_mmap_commit,
 	.htimestamp = snd_pcm_dmix_htimestamp,
-	.poll_descriptors = NULL,
+	.poll_descriptors = snd_pcm_direct_poll_descriptors,
 	.poll_descriptors_count = NULL,
 	.poll_revents = snd_pcm_dmix_poll_revents,
 };
diff --git a/src/pcm/pcm_dshare.c b/src/pcm/pcm_dshare.c
index 570f180..09d165d 100644
--- a/src/pcm/pcm_dshare.c
+++ b/src/pcm/pcm_dshare.c
@@ -255,17 +255,22 @@ static int snd_pcm_dshare_status(snd_pcm_t *pcm, snd_pcm_status_t * status)
 static snd_pcm_state_t snd_pcm_dshare_state(snd_pcm_t *pcm)
 {
 	snd_pcm_direct_t *dshare = pcm->private_data;
+	int err;
 	snd_pcm_state_t state;
 	state = snd_pcm_state(dshare->spcm);
 	switch (state) {
-	case SND_PCM_STATE_XRUN:
 	case SND_PCM_STATE_SUSPENDED:
 	case SND_PCM_STATE_DISCONNECTED:
 		dshare->state = state;
 		return state;
+	case SND_PCM_STATE_XRUN:
+		if ((err = snd_pcm_direct_slave_recover(dshare)) < 0)
+			return err;
+		break;
 	default:
 		break;
 	}
+	snd_pcm_direct_client_chk_xrun(dshare, pcm);
 	if (dshare->state == STATE_RUN_PENDING)
 		return SNDRV_PCM_STATE_RUNNING;
 	return dshare->state;
@@ -646,7 +651,7 @@ static const snd_pcm_fast_ops_t snd_pcm_dshare_fast_ops = {
 	.avail_update = snd_pcm_dshare_avail_update,
 	.mmap_commit = snd_pcm_dshare_mmap_commit,
 	.htimestamp = snd_pcm_dshare_htimestamp,
-	.poll_descriptors = NULL,
+	.poll_descriptors = snd_pcm_direct_poll_descriptors,
 	.poll_descriptors_count = NULL,
 	.poll_revents = snd_pcm_direct_poll_revents,
 };
diff --git a/src/pcm/pcm_dsnoop.c b/src/pcm/pcm_dsnoop.c
index 6b721ec..2b0df89 100644
--- a/src/pcm/pcm_dsnoop.c
+++ b/src/pcm/pcm_dsnoop.c
@@ -208,17 +208,22 @@ static int snd_pcm_dsnoop_status(snd_pcm_t *pcm, snd_pcm_status_t * status)
 static snd_pcm_state_t snd_pcm_dsnoop_state(snd_pcm_t *pcm)
 {
 	snd_pcm_direct_t *dsnoop = pcm->private_data;
+	int err;
 	snd_pcm_state_t state;
 	state = snd_pcm_state(dsnoop->spcm);
 	switch (state) {
-	case SND_PCM_STATE_XRUN:
 	case SND_PCM_STATE_SUSPENDED:
 	case SND_PCM_STATE_DISCONNECTED:
 		dsnoop->state = state;
 		return state;
+	case SND_PCM_STATE_XRUN:
+		if ((err = snd_pcm_direct_slave_recover(dsnoop)) < 0)
+			return err;
+		break;
 	default:
 		break;
 	}
+	snd_pcm_direct_client_chk_xrun(dsnoop, pcm);
 	return dsnoop->state;
 }
 
@@ -531,7 +536,7 @@ static const snd_pcm_fast_ops_t snd_pcm_dsnoop_fast_ops = {
 	.avail_update = snd_pcm_dsnoop_avail_update,
 	.mmap_commit = snd_pcm_dsnoop_mmap_commit,
 	.htimestamp = snd_pcm_dsnoop_htimestamp,
-	.poll_descriptors = NULL,
+	.poll_descriptors = snd_pcm_direct_poll_descriptors,
 	.poll_descriptors_count = NULL,
 	.poll_revents = snd_pcm_direct_poll_revents,
 };
-- 
2.7.4
