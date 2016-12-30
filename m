From: sutar.mounesh@gmail.com
Subject: [PATCH 2/6] alsa-lib: Fix for sync issue on xrun
	recover
Date: Fri, 30 Dec 2016 11:58:48 +0530
Message-ID: <1483079328-28879-1-git-send-email-sutar.mounesh@gmail.com>
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
Cc: alsa-devel@alsa-project.org, Joshua Frkuska <joshua_frkuska@mentor.com>, Andreas Pape <apape@de.adit-jv.com>, mounesh_sutar@mentor.com
List-Id: alsa-devel@alsa-project.org

From: Andreas Pape <apape@de.adit-jv.com>

If using very short periods, DSHARE/DSNOOP/DMIX may report underruns while in
status 'prepared'. This prohibits correct recovery. Now slave xrun conditions
for DSHARE/DSNOOP/DMIX are being handled properly.

Signed-off-by: Andreas Pape <apape@de.adit-jv.com>
Signed-off-by: Joshua Frkuska <joshua_frkuska@mentor.com>

diff --git a/src/pcm/pcm_direct.c b/src/pcm/pcm_direct.c
index 8f42b19..4234d66 100644
--- a/src/pcm/pcm_direct.c
+++ b/src/pcm/pcm_direct.c
@@ -572,6 +572,9 @@ int snd_pcm_direct_poll_revents(snd_pcm_t *pcm, struct pollfd *pfds, unsigned in
 	}
 	switch (snd_pcm_state(dmix->spcm)) {
 	case SND_PCM_STATE_XRUN:
+		/*recover slave and update client state to xrun before returning POLLERR*/
+		snd_pcm_direct_slave_recover(dmix);
+		snd_pcm_direct_client_chk_xrun(dmix, pcm);
 	case SND_PCM_STATE_SUSPENDED:
 	case SND_PCM_STATE_SETUP:
 		events |= POLLERR;
@@ -965,6 +968,83 @@ static void save_slave_setting(snd_pcm_direct_t *dmix, snd_pcm_t *spcm)
 
 #undef COPY_SLAVE
 
+#define direct_sem_down_chk_ret(d, id) {\
+	int semerr = snd_pcm_direct_semaphore_down(d, DIRECT_IPC_SEM_CLIENT); \
+	if (semerr) {\
+		SNDERR("SEMDOWN FAILED with err %d", semerr);\
+		return semerr;\
+	}\
+}
+
+#define direct_sem_up_chk_ret(d, id) {\
+	int semerr = snd_pcm_direct_semaphore_up(d, DIRECT_IPC_SEM_CLIENT); \
+	if (semerr) {\
+		SNDERR("SEMUP FAILED with err %d", semerr);\
+		return semerr;\
+	}\
+}
+
+/*
+ * Recover slave on XRUN.
+ * Even if direct plugins disable xrun detection, there might be an xrun raised directly by some drivers.
+ * The first client recovers slave pcm.
+ * Each client needs to execute sw xrun handling afterwards
+ */
+int snd_pcm_direct_slave_recover(snd_pcm_direct_t *direct)
+{
+	int ret = 0;
+
+	direct_sem_down_chk_ret(direct, DIRECT_IPC_SEM_CLIENT);
+	if (snd_pcm_state(direct->spcm) != SND_PCM_STATE_XRUN) {
+		/*ignore... someone else already did recovery*/
+		direct_sem_up_chk_ret(direct, DIRECT_IPC_SEM_CLIENT);
+		return ret;
+	}
+
+	ret = snd_pcm_prepare(direct->spcm);
+	if (ret < 0) {
+		SNDERR("recover: unable to prepare slave");
+		direct_sem_up_chk_ret(direct, DIRECT_IPC_SEM_CLIENT);
+		return ret;
+	}
+
+	if (direct->type == SND_PCM_TYPE_DSHARE) {
+		const snd_pcm_channel_area_t *dst_areas;
+		dst_areas = snd_pcm_mmap_areas(direct->spcm);
+		snd_pcm_areas_silence(dst_areas, 0, direct->spcm->channels, direct->spcm->buffer_size, direct->spcm->format);
+	}
+
+	ret = snd_pcm_start(direct->spcm);
+	if (ret < 0) {
+		SNDERR("recover: unable to start slave");
+		direct_sem_up_chk_ret(direct, DIRECT_IPC_SEM_CLIENT);
+		return ret;
+	}
+	direct->shmptr->recoveries++;
+	direct_sem_up_chk_ret(direct, DIRECT_IPC_SEM_CLIENT);
+	return 0;
+}
+
+/*
+ * enter xrun state, if slave xrun occured
+ * @return: 0 - no xrun >0: xrun happened
+ */
+int snd_pcm_direct_client_chk_xrun(snd_pcm_direct_t *direct, snd_pcm_t *pcm)
+{
+	if (direct->shmptr->recoveries != direct->recoveries) {
+		/* no matter how many xruns we missed - so don't increment but just update to actual counter*/
+		direct->recoveries = direct->shmptr->recoveries;
+		pcm->fast_ops->drop(pcm);
+		/*trigger_tstamp update is missing in drop callbacks*/
+		gettimestamp(&direct->trigger_tstamp, pcm->tstamp_type);
+		/*no timer clear: if slave already entered xrun again the event is lost...*/
+		/*snd_pcm_direct_clear_timer_queue(direct);*/
+		direct->state = SND_PCM_STATE_XRUN;
+		return 1;
+	}
+	return 0;
+}
+
 /*
  * this function initializes hardware and starts playback operation with
  * no stop threshold (it operates all time without xrun checking)
@@ -1380,6 +1460,7 @@ int snd_pcm_direct_open_secondary_client(snd_pcm_t **spcmp, snd_pcm_direct_t *dm
 	dmix->slave_buffer_size = spcm->buffer_size;
 	dmix->slave_period_size = dmix->shmptr->s.period_size;
 	dmix->slave_boundary = spcm->boundary;
+	dmix->recoveries = dmix->shmptr->recoveries;
 
 	ret = snd_pcm_mmap(spcm);
 	if (ret < 0) {
diff --git a/src/pcm/pcm_direct.h b/src/pcm/pcm_direct.h
index 91e816c..569d2be 100644
--- a/src/pcm/pcm_direct.h
+++ b/src/pcm/pcm_direct.h
@@ -66,6 +66,7 @@ typedef struct {
 	char socket_name[256];			/* name of communication socket */
 	snd_pcm_type_t type;			/* PCM type (currently only hw) */
 	int use_server;
+	unsigned int recoveries;		/* no of executed recoveries on slave*/
 	struct {
 		unsigned int format;
 		snd_interval_t rate;
@@ -157,6 +158,7 @@ struct snd_pcm_direct {
 	int var_periodsize;		/* allow variable period size if max_periods is != -1*/
 	unsigned int channels;		/* client's channels */
 	unsigned int *bindings;
+	unsigned int recoveries;	/* mirror of executed recoveries on slave */
 	union {
 		struct {
 			int shmid_sum;			/* IPC global sum ring buffer memory identification */
@@ -318,7 +320,8 @@ int snd_pcm_direct_open_secondary_client(snd_pcm_t **spcmp, snd_pcm_direct_t *dm
 snd_pcm_chmap_query_t **snd_pcm_direct_query_chmaps(snd_pcm_t *pcm);
 snd_pcm_chmap_t *snd_pcm_direct_get_chmap(snd_pcm_t *pcm);
 int snd_pcm_direct_set_chmap(snd_pcm_t *pcm, const snd_pcm_chmap_t *map);
-
+int snd_pcm_direct_slave_recover(snd_pcm_direct_t *direct);
+int snd_pcm_direct_client_chk_xrun(snd_pcm_direct_t *direct, snd_pcm_t *pcm);
 int snd_timer_async(snd_timer_t *timer, int sig, pid_t pid);
 struct timespec snd_pcm_hw_fast_tstamp(snd_pcm_t *pcm);
 
diff --git a/src/pcm/pcm_dmix.c b/src/pcm/pcm_dmix.c
index 0ab7323..5c3eb2d 100644
--- a/src/pcm/pcm_dmix.c
+++ b/src/pcm/pcm_dmix.c
@@ -396,6 +396,7 @@ static int snd_pcm_dmix_sync_ptr0(snd_pcm_t *pcm, snd_pcm_uframes_t slave_hw_ptr
 	snd_pcm_direct_t *dmix = pcm->private_data;
 	snd_pcm_uframes_t old_slave_hw_ptr, avail;
 	snd_pcm_sframes_t diff;
+	int err;
 	
 	old_slave_hw_ptr = dmix->slave_hw_ptr;
 	dmix->slave_hw_ptr = *dmix->spcm->hw.ptr;
@@ -434,15 +435,21 @@ static int snd_pcm_dmix_sync_ptr0(snd_pcm_t *pcm, snd_pcm_uframes_t slave_hw_ptr
 static int snd_pcm_dmix_sync_ptr(snd_pcm_t *pcm)
 {
 	snd_pcm_direct_t *dmix = pcm->private_data;
+	int err;
 
 	switch (snd_pcm_state(dmix->spcm)) {
 	case SND_PCM_STATE_DISCONNECTED:
 		dmix->state = SND_PCM_STATE_DISCONNECTED;
 		return -ENODEV;
+	case SND_PCM_STATE_XRUN:
+		if ((err = snd_pcm_direct_slave_recover(dmix)) <0)
+			return err;
+		break;
 	default:
 		break;
 	}
-
+	if (snd_pcm_direct_client_chk_xrun(dmix, pcm))
+		return -EPIPE;
 	if (dmix->slowptr)
 		snd_pcm_hwsync(dmix->spcm);
 
@@ -828,12 +835,16 @@ static snd_pcm_sframes_t snd_pcm_dmix_mmap_commit(snd_pcm_t *pcm,
 
 	switch (snd_pcm_state(dmix->spcm)) {
 	case SND_PCM_STATE_XRUN:
-		return -EPIPE;
+		if ((err = snd_pcm_direct_slave_recover(dmix)) < 0)
+			return err;
+		break;
 	case SND_PCM_STATE_SUSPENDED:
 		return -ESTRPIPE;
 	default:
 		break;
 	}
+	if (snd_pcm_direct_client_chk_xrun(dmix, pcm))
+		return -EPIPE;
 	if (! size)
 		return 0;
 	snd_pcm_mmap_appl_forward(pcm, size);
@@ -841,8 +852,10 @@ static snd_pcm_sframes_t snd_pcm_dmix_mmap_commit(snd_pcm_t *pcm,
 		if ((err = snd_pcm_dmix_start_timer(pcm, dmix)) < 0)
 			return err;
 	} else if (dmix->state == SND_PCM_STATE_RUNNING ||
-		   dmix->state == SND_PCM_STATE_DRAINING)
-		snd_pcm_dmix_sync_ptr(pcm);
+		   dmix->state == SND_PCM_STATE_DRAINING) {
+		if (( err = snd_pcm_dmix_sync_ptr(pcm)) < 0)
+			return err;
+	}
 	if (dmix->state == SND_PCM_STATE_RUNNING ||
 	    dmix->state == SND_PCM_STATE_DRAINING) {
 		/* ok, we commit the changes after the validation of area */
@@ -858,10 +871,13 @@ static snd_pcm_sframes_t snd_pcm_dmix_mmap_commit(snd_pcm_t *pcm,
 static snd_pcm_sframes_t snd_pcm_dmix_avail_update(snd_pcm_t *pcm)
 {
 	snd_pcm_direct_t *dmix = pcm->private_data;
+	int err;
 	
 	if (dmix->state == SND_PCM_STATE_RUNNING ||
-	    dmix->state == SND_PCM_STATE_DRAINING)
-		snd_pcm_dmix_sync_ptr(pcm);
+	    dmix->state == SND_PCM_STATE_DRAINING) {
+		if (( err = snd_pcm_dmix_sync_ptr(pcm)) < 0)
+			return err;
+	}
 	return snd_pcm_mmap_playback_avail(pcm);
 }
 
diff --git a/src/pcm/pcm_dshare.c b/src/pcm/pcm_dshare.c
index a1fed5d..707e2c2 100644
--- a/src/pcm/pcm_dshare.c
+++ b/src/pcm/pcm_dshare.c
@@ -202,15 +202,21 @@ static int snd_pcm_dshare_sync_ptr0(snd_pcm_t *pcm, snd_pcm_uframes_t slave_hw_p
 static int snd_pcm_dshare_sync_ptr(snd_pcm_t *pcm)
 {
 	snd_pcm_direct_t *dshare = pcm->private_data;
+	int err;
 
 	switch (snd_pcm_state(dshare->spcm)) {
 	case SND_PCM_STATE_DISCONNECTED:
 		dshare->state = SNDRV_PCM_STATE_DISCONNECTED;
 		return -ENODEV;
+	case SND_PCM_STATE_XRUN:
+		if ((err = snd_pcm_direct_slave_recover(dshare)) <0)
+			return err;
+		break;
 	default:
 		break;
 	}
-
+	if (snd_pcm_direct_client_chk_xrun(dshare, pcm))
+		return -EPIPE;
 	if (dshare->slowptr)
 		snd_pcm_hwsync(dshare->spcm);
 
@@ -516,12 +522,16 @@ static snd_pcm_sframes_t snd_pcm_dshare_mmap_commit(snd_pcm_t *pcm,
 
 	switch (snd_pcm_state(dshare->spcm)) {
 	case SND_PCM_STATE_XRUN:
-		return -EPIPE;
+		if ((err = snd_pcm_direct_slave_recover(dshare)) < 0)
+			return err;
+		break;
 	case SND_PCM_STATE_SUSPENDED:
 		return -ESTRPIPE;
 	default:
 		break;
 	}
+	if (snd_pcm_direct_client_chk_xrun(dshare, pcm))
+		return -EPIPE;
 	if (! size)
 		return 0;
 	snd_pcm_mmap_appl_forward(pcm, size);
@@ -529,8 +539,10 @@ static snd_pcm_sframes_t snd_pcm_dshare_mmap_commit(snd_pcm_t *pcm,
 		if ((err = snd_pcm_dshare_start_timer(dshare)) < 0)
 			return err;
 	} else if (dshare->state == SND_PCM_STATE_RUNNING ||
-		   dshare->state == SND_PCM_STATE_DRAINING)
-		snd_pcm_dshare_sync_ptr(pcm);
+		   dshare->state == SND_PCM_STATE_DRAINING) {
+		if ((err = snd_pcm_dshare_sync_ptr(pcm)) < 0)
+			return err;
+	}
 	if (dshare->state == SND_PCM_STATE_RUNNING ||
 	    dshare->state == SND_PCM_STATE_DRAINING) {
 		/* ok, we commit the changes after the validation of area */
@@ -546,10 +558,13 @@ static snd_pcm_sframes_t snd_pcm_dshare_mmap_commit(snd_pcm_t *pcm,
 static snd_pcm_sframes_t snd_pcm_dshare_avail_update(snd_pcm_t *pcm)
 {
 	snd_pcm_direct_t *dshare = pcm->private_data;
+	int err;
 	
 	if (dshare->state == SND_PCM_STATE_RUNNING ||
-	    dshare->state == SND_PCM_STATE_DRAINING)
-		snd_pcm_dshare_sync_ptr(pcm);
+	    dshare->state == SND_PCM_STATE_DRAINING) {
+		if ((err = snd_pcm_dshare_sync_ptr(pcm)) < 0)
+			return err;
+	}
 	return snd_pcm_mmap_playback_avail(pcm);
 }
 
diff --git a/src/pcm/pcm_dsnoop.c b/src/pcm/pcm_dsnoop.c
index 85f0ff4..512e957 100644
--- a/src/pcm/pcm_dsnoop.c
+++ b/src/pcm/pcm_dsnoop.c
@@ -132,14 +132,21 @@ static int snd_pcm_dsnoop_sync_ptr(snd_pcm_t *pcm)
 	snd_pcm_direct_t *dsnoop = pcm->private_data;
 	snd_pcm_uframes_t slave_hw_ptr, old_slave_hw_ptr, avail;
 	snd_pcm_sframes_t diff;
+	int err;
 	
 	switch (snd_pcm_state(dsnoop->spcm)) {
 	case SND_PCM_STATE_DISCONNECTED:
 		dsnoop->state = SNDRV_PCM_STATE_DISCONNECTED;
 		return -ENODEV;
+	case SND_PCM_STATE_XRUN:
+		if ((err = snd_pcm_direct_slave_recover(dsnoop)) <0)
+			return err;
+		break;
 	default:
 		break;
 	}
+	if (snd_pcm_direct_client_chk_xrun(dsnoop, pcm))
+		return -EPIPE;
 	if (dsnoop->slowptr)
 		snd_pcm_hwsync(dsnoop->spcm);
 	old_slave_hw_ptr = dsnoop->slave_hw_ptr;
@@ -410,12 +417,16 @@ static snd_pcm_sframes_t snd_pcm_dsnoop_mmap_commit(snd_pcm_t *pcm,
 
 	switch (snd_pcm_state(dsnoop->spcm)) {
 	case SND_PCM_STATE_XRUN:
-		return -EPIPE;
+		if ((err = snd_pcm_direct_slave_recover(dsnoop)) <0)
+			return err;
+		break;
 	case SND_PCM_STATE_SUSPENDED:
 		return -ESTRPIPE;
 	default:
 		break;
 	}
+	if (snd_pcm_direct_client_chk_xrun(dsnoop, pcm))
+		return -EPIPE;
 	if (dsnoop->state == SND_PCM_STATE_RUNNING) {
 		err = snd_pcm_dsnoop_sync_ptr(pcm);
 		if (err < 0)
-- 
1.7.9.5
