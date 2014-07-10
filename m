From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH alsa-lib 5/5] pcm: Implement timestamp type
	handling in all plugins
Date: Thu, 10 Jul 2014 15:09:17 +0200
Message-ID: <1404997757-15500-6-git-send-email-tiwai@suse.de>
References: <1404997757-15500-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 21F562610CE
 for <alsa-devel@alsa-project.org>; Thu, 10 Jul 2014 15:09:20 +0200 (CEST)
In-Reply-To: <1404997757-15500-1-git-send-email-tiwai@suse.de>
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
Cc: Daniel Thompson <daniel.thompson@linaro.org>, Mark Brown <broonie@kernel.org>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

Now all PCM plugins do support the proper timestamp type or pass it
over slaves.  The internal monotonic flag is dropped and replaced with
tstamp_type in all places.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 src/pcm/pcm_adpcm.c     |  2 +-
 src/pcm/pcm_alaw.c      |  2 +-
 src/pcm/pcm_copy.c      |  2 +-
 src/pcm/pcm_direct.c    |  4 ++--
 src/pcm/pcm_direct.h    |  2 +-
 src/pcm/pcm_dmix.c      |  8 ++++----
 src/pcm/pcm_dshare.c    |  8 ++++----
 src/pcm/pcm_dsnoop.c    |  4 ++--
 src/pcm/pcm_file.c      |  6 +++---
 src/pcm/pcm_generic.c   |  2 +-
 src/pcm/pcm_hooks.c     |  2 +-
 src/pcm/pcm_hw.c        |  1 -
 src/pcm/pcm_iec958.c    |  2 +-
 src/pcm/pcm_ioplug.c    |  9 ++++++---
 src/pcm/pcm_ladspa.c    |  2 +-
 src/pcm/pcm_lfloat.c    |  2 +-
 src/pcm/pcm_linear.c    |  2 +-
 src/pcm/pcm_local.h     | 45 +++++++++++++++++++++++++++++----------------
 src/pcm/pcm_meter.c     |  2 +-
 src/pcm/pcm_mmap_emul.c |  2 +-
 src/pcm/pcm_mulaw.c     |  2 +-
 src/pcm/pcm_multi.c     |  2 +-
 src/pcm/pcm_null.c      |  2 +-
 src/pcm/pcm_plug.c      |  2 +-
 src/pcm/pcm_rate.c      |  4 ++--
 src/pcm/pcm_route.c     |  2 +-
 src/pcm/pcm_share.c     |  6 +++---
 src/pcm/pcm_softvol.c   |  2 +-
 28 files changed, 73 insertions(+), 58 deletions(-)

diff --git a/src/pcm/pcm_adpcm.c b/src/pcm/pcm_adpcm.c
index 6f0e7c4cc631..1a83c5a0e21c 100644
--- a/src/pcm/pcm_adpcm.c
+++ b/src/pcm/pcm_adpcm.c
@@ -579,7 +579,7 @@ int snd_pcm_adpcm_open(snd_pcm_t **pcmp, const char *name, snd_pcm_format_t sfor
 	pcm->private_data = adpcm;
 	pcm->poll_fd = slave->poll_fd;
 	pcm->poll_events = slave->poll_events;
-	pcm->monotonic = slave->monotonic;
+	pcm->tstamp_type = slave->tstamp_type;
 	snd_pcm_set_hw_ptr(pcm, &adpcm->plug.hw_ptr, -1, 0);
 	snd_pcm_set_appl_ptr(pcm, &adpcm->plug.appl_ptr, -1, 0);
 	*pcmp = pcm;
diff --git a/src/pcm/pcm_alaw.c b/src/pcm/pcm_alaw.c
index 1b1bab83c944..db759e3effa4 100644
--- a/src/pcm/pcm_alaw.c
+++ b/src/pcm/pcm_alaw.c
@@ -453,7 +453,7 @@ int snd_pcm_alaw_open(snd_pcm_t **pcmp, const char *name, snd_pcm_format_t sform
 	pcm->private_data = alaw;
 	pcm->poll_fd = slave->poll_fd;
 	pcm->poll_events = slave->poll_events;
-	pcm->monotonic = slave->monotonic;
+	pcm->tstamp_type = slave->tstamp_type;
 	snd_pcm_set_hw_ptr(pcm, &alaw->plug.hw_ptr, -1, 0);
 	snd_pcm_set_appl_ptr(pcm, &alaw->plug.appl_ptr, -1, 0);
 	*pcmp = pcm;
diff --git a/src/pcm/pcm_copy.c b/src/pcm/pcm_copy.c
index 56a1f6bcc912..66d3a4719856 100644
--- a/src/pcm/pcm_copy.c
+++ b/src/pcm/pcm_copy.c
@@ -209,7 +209,7 @@ int snd_pcm_copy_open(snd_pcm_t **pcmp, const char *name, snd_pcm_t *slave, int
 	pcm->private_data = copy;
 	pcm->poll_fd = slave->poll_fd;
 	pcm->poll_events = slave->poll_events;
-	pcm->monotonic = slave->monotonic;
+	pcm->tstamp_type = slave->tstamp_type;
 	snd_pcm_set_hw_ptr(pcm, &copy->plug.hw_ptr, -1, 0);
 	snd_pcm_set_appl_ptr(pcm, &copy->plug.appl_ptr, -1, 0);
 	*pcmp = pcm;
diff --git a/src/pcm/pcm_direct.c b/src/pcm/pcm_direct.c
index 5416cf71674c..8e37bcba5e19 100644
--- a/src/pcm/pcm_direct.c
+++ b/src/pcm/pcm_direct.c
@@ -840,6 +840,7 @@ static void save_slave_setting(snd_pcm_direct_t *dmix, snd_pcm_t *spcm)
 	COPY_SLAVE(period_time);
 	COPY_SLAVE(periods);
 	COPY_SLAVE(tstamp_mode);
+	COPY_SLAVE(tstamp_type);
 	COPY_SLAVE(period_step);
 	COPY_SLAVE(avail_min);
 	COPY_SLAVE(start_threshold);
@@ -857,7 +858,6 @@ static void save_slave_setting(snd_pcm_direct_t *dmix, snd_pcm_t *spcm)
 	COPY_SLAVE(buffer_time);
 	COPY_SLAVE(sample_bits);
 	COPY_SLAVE(frame_bits);
-	COPY_SLAVE(monotonic);
 }
 
 #undef COPY_SLAVE
@@ -1204,6 +1204,7 @@ static void copy_slave_setting(snd_pcm_direct_t *dmix, snd_pcm_t *spcm)
 	COPY_SLAVE(period_time);
 	COPY_SLAVE(periods);
 	COPY_SLAVE(tstamp_mode);
+	COPY_SLAVE(tstamp_type);
 	COPY_SLAVE(period_step);
 	COPY_SLAVE(avail_min);
 	COPY_SLAVE(start_threshold);
@@ -1221,7 +1222,6 @@ static void copy_slave_setting(snd_pcm_direct_t *dmix, snd_pcm_t *spcm)
 	COPY_SLAVE(buffer_time);
 	COPY_SLAVE(sample_bits);
 	COPY_SLAVE(frame_bits);
-	COPY_SLAVE(monotonic);
 
 	spcm->info &= ~SND_PCM_INFO_PAUSE;
 	spcm->boundary = recalc_boundary_size(dmix->shmptr->s.boundary, spcm->buffer_size);
diff --git a/src/pcm/pcm_direct.h b/src/pcm/pcm_direct.h
index 5ae39c0e4237..9b1ddbcf424a 100644
--- a/src/pcm/pcm_direct.h
+++ b/src/pcm/pcm_direct.h
@@ -85,8 +85,8 @@ typedef struct {
 		unsigned int period_size;
 		unsigned int period_time;
 		snd_interval_t periods;
-		unsigned int monotonic;
 		snd_pcm_tstamp_t tstamp_mode;
+		snd_pcm_tstamp_type_t tstamp_type;
 		unsigned int period_step;
 		unsigned int sleep_min; /* not used */
 		unsigned int avail_min;
diff --git a/src/pcm/pcm_dmix.c b/src/pcm/pcm_dmix.c
index 4aa6d4eab4a2..7c535093ea0f 100644
--- a/src/pcm/pcm_dmix.c
+++ b/src/pcm/pcm_dmix.c
@@ -428,7 +428,7 @@ static int snd_pcm_dmix_sync_ptr(snd_pcm_t *pcm)
 		dmix->avail_max = avail;
 	if (avail >= pcm->stop_threshold) {
 		snd_timer_stop(dmix->timer);
-		gettimestamp(&dmix->trigger_tstamp, pcm->monotonic);
+		gettimestamp(&dmix->trigger_tstamp, pcm->tstamp_type);
 		if (dmix->state == SND_PCM_STATE_RUNNING) {
 			dmix->state = SND_PCM_STATE_XRUN;
 			return -EPIPE;
@@ -477,7 +477,7 @@ static int snd_pcm_dmix_status(snd_pcm_t *pcm, snd_pcm_status_t * status)
 	memset(status, 0, sizeof(*status));
 	status->state = snd_pcm_dmix_state(pcm);
 	status->trigger_tstamp = dmix->trigger_tstamp;
-	gettimestamp(&status->tstamp, pcm->monotonic);
+	gettimestamp(&status->tstamp, pcm->tstamp_type);
 	status->avail = snd_pcm_mmap_playback_avail(pcm);
 	status->avail_max = status->avail > dmix->avail_max ? status->avail : dmix->avail_max;
 	dmix->avail_max = 0;
@@ -596,7 +596,7 @@ static int snd_pcm_dmix_start(snd_pcm_t *pcm)
 			return err;
 		snd_pcm_dmix_sync_area(pcm);
 	}
-	gettimestamp(&dmix->trigger_tstamp, pcm->monotonic);
+	gettimestamp(&dmix->trigger_tstamp, pcm->tstamp_type);
 	return 0;
 }
 
@@ -1104,7 +1104,7 @@ int snd_pcm_dmix_open(snd_pcm_t **pcmp, const char *name,
 		
 	pcm->poll_fd = dmix->poll_fd;
 	pcm->poll_events = POLLIN;	/* it's different than other plugins */
-	pcm->monotonic = spcm->monotonic;
+	pcm->tstamp_type = spcm->tstamp_type;
 	pcm->mmap_rw = 1;
 	snd_pcm_set_hw_ptr(pcm, &dmix->hw_ptr, -1, 0);
 	snd_pcm_set_appl_ptr(pcm, &dmix->appl_ptr, -1, 0);
diff --git a/src/pcm/pcm_dshare.c b/src/pcm/pcm_dshare.c
index f2d1103a6bfb..b985172825e7 100644
--- a/src/pcm/pcm_dshare.c
+++ b/src/pcm/pcm_dshare.c
@@ -195,7 +195,7 @@ static int snd_pcm_dshare_sync_ptr(snd_pcm_t *pcm)
 		dshare->avail_max = avail;
 	if (avail >= pcm->stop_threshold) {
 		snd_timer_stop(dshare->timer);
-		gettimestamp(&dshare->trigger_tstamp, pcm->monotonic);
+		gettimestamp(&dshare->trigger_tstamp, pcm->tstamp_type);
 		if (dshare->state == SND_PCM_STATE_RUNNING) {
 			dshare->state = SND_PCM_STATE_XRUN;
 			return -EPIPE;
@@ -226,7 +226,7 @@ static int snd_pcm_dshare_status(snd_pcm_t *pcm, snd_pcm_status_t * status)
 	memset(status, 0, sizeof(*status));
 	status->state = snd_pcm_state(dshare->spcm);
 	status->trigger_tstamp = dshare->trigger_tstamp;
-	gettimestamp(&status->tstamp, pcm->monotonic);
+	gettimestamp(&status->tstamp, pcm->tstamp_type);
 	status->avail = snd_pcm_mmap_playback_avail(pcm);
 	status->avail_max = status->avail > dshare->avail_max ? status->avail : dshare->avail_max;
 	dshare->avail_max = 0;
@@ -346,7 +346,7 @@ static int snd_pcm_dshare_start(snd_pcm_t *pcm)
 			return err;
 		snd_pcm_dshare_sync_area(pcm);
 	}
-	gettimestamp(&dshare->trigger_tstamp, pcm->monotonic);
+	gettimestamp(&dshare->trigger_tstamp, pcm->tstamp_type);
 	return 0;
 }
 
@@ -792,7 +792,7 @@ int snd_pcm_dshare_open(snd_pcm_t **pcmp, const char *name,
 
 	pcm->poll_fd = dshare->poll_fd;
 	pcm->poll_events = POLLIN;	/* it's different than other plugins */
-	pcm->monotonic = spcm->monotonic;
+	pcm->tstamp_type = spcm->tstamp_type;
 	pcm->mmap_rw = 1;
 	snd_pcm_set_hw_ptr(pcm, &dshare->hw_ptr, -1, 0);
 	snd_pcm_set_appl_ptr(pcm, &dshare->appl_ptr, -1, 0);
diff --git a/src/pcm/pcm_dsnoop.c b/src/pcm/pcm_dsnoop.c
index 76379140c133..0f9c9df481bc 100644
--- a/src/pcm/pcm_dsnoop.c
+++ b/src/pcm/pcm_dsnoop.c
@@ -159,7 +159,7 @@ static int snd_pcm_dsnoop_sync_ptr(snd_pcm_t *pcm)
 	if (pcm->stop_threshold >= pcm->boundary)	/* don't care */
 		return 0;
 	if ((avail = snd_pcm_mmap_capture_hw_avail(pcm)) >= pcm->stop_threshold) {
-		gettimestamp(&dsnoop->trigger_tstamp, pcm->monotonic);
+		gettimestamp(&dsnoop->trigger_tstamp, pcm->tstamp_type);
 		dsnoop->state = SND_PCM_STATE_XRUN;
 		dsnoop->avail_max = avail;
 		return -EPIPE;
@@ -690,7 +690,7 @@ int snd_pcm_dsnoop_open(snd_pcm_t **pcmp, const char *name,
 
 	pcm->poll_fd = dsnoop->poll_fd;
 	pcm->poll_events = POLLIN;	/* it's different than other plugins */
-	pcm->monotonic = spcm->monotonic;
+	pcm->tstamp_type = spcm->tstamp_type;
 	pcm->mmap_rw = 1;
 	snd_pcm_set_hw_ptr(pcm, &dsnoop->hw_ptr, -1, 0);
 	snd_pcm_set_appl_ptr(pcm, &dsnoop->appl_ptr, -1, 0);
diff --git a/src/pcm/pcm_file.c b/src/pcm/pcm_file.c
index b139f7f24dc3..a0b8bf41bf5b 100644
--- a/src/pcm/pcm_file.c
+++ b/src/pcm/pcm_file.c
@@ -781,10 +781,10 @@ int snd_pcm_file_open(snd_pcm_t **pcmp, const char *name,
 	pcm->poll_fd = slave->poll_fd;
 	pcm->poll_events = slave->poll_events;
 	pcm->mmap_shadow = 1;
+	pcm->tstamp_type = SND_PCM_TSTAMP_TYPE_GETTIMEOFDAY;
 #if defined(HAVE_CLOCK_GETTIME) && defined(CLOCK_MONOTONIC)
-	pcm->monotonic = clock_gettime(CLOCK_MONOTONIC, &timespec) == 0;
-#else
-	pcm->monotonic = 0;
+	if (clock_gettime(CLOCK_MONOTONIC, &timespec) == 0)
+		pcm->tstamp_type = SND_PCM_TSTAMP_TYPE_MONOTONIC;
 #endif
 	pcm->stream = stream;
 	snd_pcm_link_hw_ptr(pcm, slave);
diff --git a/src/pcm/pcm_generic.c b/src/pcm/pcm_generic.c
index f068ee2585bc..9b605911f868 100644
--- a/src/pcm/pcm_generic.c
+++ b/src/pcm/pcm_generic.c
@@ -294,7 +294,7 @@ int snd_pcm_generic_real_htimestamp(snd_pcm_t *pcm, snd_pcm_uframes_t *avail,
 		if (ok && (snd_pcm_uframes_t)avail1 == *avail)
 			break;
 		*avail = avail1;
-		gettimestamp(tstamp, pcm->monotonic);
+		gettimestamp(tstamp, pcm->tstamp_type);
 		ok = 1;
 	}
 	return 0;
diff --git a/src/pcm/pcm_hooks.c b/src/pcm/pcm_hooks.c
index f83728245ecd..0b93c641daaa 100644
--- a/src/pcm/pcm_hooks.c
+++ b/src/pcm/pcm_hooks.c
@@ -240,7 +240,7 @@ int snd_pcm_hooks_open(snd_pcm_t **pcmp, const char *name, snd_pcm_t *slave, int
 	pcm->poll_fd = slave->poll_fd;
 	pcm->poll_events = slave->poll_events;
 	pcm->mmap_shadow = 1;
-	pcm->monotonic = slave->monotonic;
+	pcm->tstamp_type = slave->tstamp_type;
 	snd_pcm_link_hw_ptr(pcm, slave);
 	snd_pcm_link_appl_ptr(pcm, slave);
 	*pcmp = pcm;
diff --git a/src/pcm/pcm_hw.c b/src/pcm/pcm_hw.c
index bafa8debeb0b..74cff672a0c1 100644
--- a/src/pcm/pcm_hw.c
+++ b/src/pcm/pcm_hw.c
@@ -1498,7 +1498,6 @@ int snd_pcm_hw_open_fd(snd_pcm_t **pcmp, const char *name,
 	pcm->poll_fd = fd;
 	pcm->poll_events = info.stream == SND_PCM_STREAM_PLAYBACK ? POLLOUT : POLLIN;
 	pcm->tstamp_type = tstamp_type;
-	pcm->monotonic = tstamp_type != SND_PCM_TSTAMP_TYPE_GETTIMEOFDAY;
 
 	ret = snd_pcm_hw_mmap_status(pcm);
 	if (ret < 0) {
diff --git a/src/pcm/pcm_iec958.c b/src/pcm/pcm_iec958.c
index 0c61fc17995b..38c4ce7e2421 100644
--- a/src/pcm/pcm_iec958.c
+++ b/src/pcm/pcm_iec958.c
@@ -534,7 +534,7 @@ int snd_pcm_iec958_open(snd_pcm_t **pcmp, const char *name, snd_pcm_format_t sfo
 	pcm->private_data = iec;
 	pcm->poll_fd = slave->poll_fd;
 	pcm->poll_events = slave->poll_events;
-	pcm->monotonic = slave->monotonic;
+	pcm->tstamp_type = slave->tstamp_type;
 	snd_pcm_set_hw_ptr(pcm, &iec->plug.hw_ptr, -1, 0);
 	snd_pcm_set_appl_ptr(pcm, &iec->plug.appl_ptr, -1, 0);
 	*pcmp = pcm;
diff --git a/src/pcm/pcm_ioplug.c b/src/pcm/pcm_ioplug.c
index c1c3a9835d47..85a88911eafc 100644
--- a/src/pcm/pcm_ioplug.c
+++ b/src/pcm/pcm_ioplug.c
@@ -448,7 +448,7 @@ static int snd_pcm_ioplug_start(snd_pcm_t *pcm)
 	if (err < 0)
 		return err;
 
-	gettimestamp(&io->trigger_tstamp, pcm->monotonic);
+	gettimestamp(&io->trigger_tstamp, pcm->tstamp_type);
 	io->data->state = SND_PCM_STATE_RUNNING;
 
 	return 0;
@@ -463,7 +463,7 @@ static int snd_pcm_ioplug_drop(snd_pcm_t *pcm)
 
 	io->data->callback->stop(io->data);
 
-	gettimestamp(&io->trigger_tstamp, pcm->monotonic);
+	gettimestamp(&io->trigger_tstamp, pcm->tstamp_type);
 	io->data->state = SND_PCM_STATE_SETUP;
 
 	return 0;
@@ -1069,7 +1069,10 @@ int snd_pcm_ioplug_reinit_status(snd_pcm_ioplug_t *ioplug)
 {
 	ioplug->pcm->poll_fd = ioplug->poll_fd;
 	ioplug->pcm->poll_events = ioplug->poll_events;
-	ioplug->pcm->monotonic = (ioplug->flags & SND_PCM_IOPLUG_FLAG_MONOTONIC) != 0;
+	if (ioplug->flags & SND_PCM_IOPLUG_FLAG_MONOTONIC)
+		ioplug->pcm->tstamp_type = SND_PCM_TSTAMP_TYPE_MONOTONIC;
+	else
+		ioplug->pcm->tstamp_type = SND_PCM_TSTAMP_TYPE_GETTIMEOFDAY;
 	ioplug->pcm->mmap_rw = ioplug->mmap_rw;
 	return 0;
 }
diff --git a/src/pcm/pcm_ladspa.c b/src/pcm/pcm_ladspa.c
index 7d1e3df878b0..631ee0f35b73 100644
--- a/src/pcm/pcm_ladspa.c
+++ b/src/pcm/pcm_ladspa.c
@@ -1641,7 +1641,7 @@ int snd_pcm_ladspa_open(snd_pcm_t **pcmp, const char *name,
 	pcm->private_data = ladspa;
 	pcm->poll_fd = slave->poll_fd;
 	pcm->poll_events = slave->poll_events;
-	pcm->monotonic = slave->monotonic;
+	pcm->tstamp_type = slave->tstamp_type;
 	snd_pcm_set_hw_ptr(pcm, &ladspa->plug.hw_ptr, -1, 0);
 	snd_pcm_set_appl_ptr(pcm, &ladspa->plug.appl_ptr, -1, 0);
 	*pcmp = pcm;
diff --git a/src/pcm/pcm_lfloat.c b/src/pcm/pcm_lfloat.c
index bbf72c274222..324282f0b7fc 100644
--- a/src/pcm/pcm_lfloat.c
+++ b/src/pcm/pcm_lfloat.c
@@ -412,7 +412,7 @@ int snd_pcm_lfloat_open(snd_pcm_t **pcmp, const char *name, snd_pcm_format_t sfo
 	pcm->private_data = lfloat;
 	pcm->poll_fd = slave->poll_fd;
 	pcm->poll_events = slave->poll_events;
-	pcm->monotonic = slave->monotonic;
+	pcm->tstamp_type = slave->tstamp_type;
 	snd_pcm_set_hw_ptr(pcm, &lfloat->plug.hw_ptr, -1, 0);
 	snd_pcm_set_appl_ptr(pcm, &lfloat->plug.appl_ptr, -1, 0);
 	*pcmp = pcm;
diff --git a/src/pcm/pcm_linear.c b/src/pcm/pcm_linear.c
index 7aa894185444..3d5bbb8a3688 100644
--- a/src/pcm/pcm_linear.c
+++ b/src/pcm/pcm_linear.c
@@ -484,7 +484,7 @@ int snd_pcm_linear_open(snd_pcm_t **pcmp, const char *name, snd_pcm_format_t sfo
 	pcm->private_data = linear;
 	pcm->poll_fd = slave->poll_fd;
 	pcm->poll_events = slave->poll_events;
-	pcm->monotonic = slave->monotonic;
+	pcm->tstamp_type = slave->tstamp_type;
 	snd_pcm_set_hw_ptr(pcm, &linear->plug.hw_ptr, -1, 0);
 	snd_pcm_set_appl_ptr(pcm, &linear->plug.appl_ptr, -1, 0);
 	*pcmp = pcm;
diff --git a/src/pcm/pcm_local.h b/src/pcm/pcm_local.h
index 3ed7e1a88792..2206afe2c4a9 100644
--- a/src/pcm/pcm_local.h
+++ b/src/pcm/pcm_local.h
@@ -191,7 +191,6 @@ struct _snd_pcm {
 	int poll_fd;
 	unsigned short poll_events;
 	int setup: 1,
-	    monotonic: 1,
 	    compat: 1;
 	snd_pcm_access_t access;	/* access mode */
 	snd_pcm_format_t format;	/* SND_PCM_FORMAT_* */
@@ -960,26 +959,40 @@ typedef union snd_tmp_double {
 } snd_tmp_double_t;
 
 /* get the current timestamp */
-static inline void gettimestamp(snd_htimestamp_t *tstamp, int monotonic)
+#ifdef HAVE_CLOCK_GETTIME
+static inline void gettimestamp(snd_htimestamp_t *tstamp,
+				snd_pcm_tstamp_type_t tstamp_type)
 {
-#if defined(HAVE_CLOCK_GETTIME)
-#if defined(CLOCK_MONOTONIC)
-	if (monotonic) {
-		clock_gettime(CLOCK_MONOTONIC, tstamp);
-	} else {
-#endif
-		clock_gettime(CLOCK_REALTIME, tstamp);
-#else
-		struct timeval tv;
+	clockid_t id;
 
-		gettimeofday(&tv, 0);
-		tstamp->tv_sec = tv.tv_sec;
-		tstamp->tv_nsec = tv.tv_usec * 1000L;
+	switch (tstamp_type) {
+#ifdef CLOCK_MONOTONIC_RAW
+	case SND_PCM_TSTAMP_TYPE_MONOTONIC_RAW:
+		id = CLOCK_MONOTONIC_RAW;
+		break;
 #endif
-#if defined(HAVE_CLOCK_GETTIME)
-	}
+#ifdef CLOCK_MONOTONIC
+	case SND_PCM_TSTAMP_TYPE_MONOTONIC:
+		id = CLOCK_MONOTONIC;
+		break;
 #endif
+	default:
+		id = CLOCK_REALTIME;
+		break;
+	}
+	clock_gettime(id, tstamp);
+}
+#else /* HAVE_CLOCK_GETTIME */
+static inline void gettimestamp(snd_htimestamp_t *tstamp,
+				snd_pcm_tstamp_type_t tstamp_type)
+{
+	struct timeval tv;
+
+	gettimeofday(&tv, 0);
+	tstamp->tv_sec = tv.tv_sec;
+	tstamp->tv_nsec = tv.tv_usec * 1000L;
 }
+#endif /* HAVE_CLOCK_GETTIME */
 
 snd_pcm_chmap_query_t **
 _snd_pcm_make_single_query_chmaps(const snd_pcm_chmap_t *src);
diff --git a/src/pcm/pcm_meter.c b/src/pcm/pcm_meter.c
index 676fbef89c30..034f582564a8 100644
--- a/src/pcm/pcm_meter.c
+++ b/src/pcm/pcm_meter.c
@@ -591,7 +591,7 @@ int snd_pcm_meter_open(snd_pcm_t **pcmp, const char *name, unsigned int frequenc
 	pcm->private_data = meter;
 	pcm->poll_fd = slave->poll_fd;
 	pcm->poll_events = slave->poll_events;
-	pcm->monotonic = slave->monotonic;
+	pcm->tstamp_type = slave->tstamp_type;
 	snd_pcm_link_hw_ptr(pcm, slave);
 	snd_pcm_link_appl_ptr(pcm, slave);
 	*pcmp = pcm;
diff --git a/src/pcm/pcm_mmap_emul.c b/src/pcm/pcm_mmap_emul.c
index 63789bc07c1b..b2b15efd07d9 100644
--- a/src/pcm/pcm_mmap_emul.c
+++ b/src/pcm/pcm_mmap_emul.c
@@ -428,7 +428,7 @@ int __snd_pcm_mmap_emul_open(snd_pcm_t **pcmp, const char *name,
 	pcm->private_data = map;
 	pcm->poll_fd = slave->poll_fd;
 	pcm->poll_events = slave->poll_events;
-	pcm->monotonic = slave->monotonic;
+	pcm->tstamp_type = slave->tstamp_type;
 	snd_pcm_set_hw_ptr(pcm, &map->hw_ptr, -1, 0);
 	snd_pcm_set_appl_ptr(pcm, &map->appl_ptr, -1, 0);
 	*pcmp = pcm;
diff --git a/src/pcm/pcm_mulaw.c b/src/pcm/pcm_mulaw.c
index 7adce38e9f48..011b2a516be0 100644
--- a/src/pcm/pcm_mulaw.c
+++ b/src/pcm/pcm_mulaw.c
@@ -467,7 +467,7 @@ int snd_pcm_mulaw_open(snd_pcm_t **pcmp, const char *name, snd_pcm_format_t sfor
 	pcm->private_data = mulaw;
 	pcm->poll_fd = slave->poll_fd;
 	pcm->poll_events = slave->poll_events;
-	pcm->monotonic = slave->monotonic;
+	pcm->tstamp_type = slave->tstamp_type;
 	snd_pcm_set_hw_ptr(pcm, &mulaw->plug.hw_ptr, -1, 0);
 	snd_pcm_set_appl_ptr(pcm, &mulaw->plug.appl_ptr, -1, 0);
 	*pcmp = pcm;
diff --git a/src/pcm/pcm_multi.c b/src/pcm/pcm_multi.c
index a84e0ce48c59..4b8299ed6bcd 100644
--- a/src/pcm/pcm_multi.c
+++ b/src/pcm/pcm_multi.c
@@ -1077,7 +1077,7 @@ int snd_pcm_multi_open(snd_pcm_t **pcmp, const char *name,
 	pcm->private_data = multi;
 	pcm->poll_fd = multi->slaves[master_slave].pcm->poll_fd;
 	pcm->poll_events = multi->slaves[master_slave].pcm->poll_events;
-	pcm->monotonic = multi->slaves[master_slave].pcm->monotonic;
+	pcm->tstamp_type = multi->slaves[master_slave].pcm->tstamp_type;
 	snd_pcm_link_hw_ptr(pcm, multi->slaves[master_slave].pcm);
 	snd_pcm_link_appl_ptr(pcm, multi->slaves[master_slave].pcm);
 	*pcmp = pcm;
diff --git a/src/pcm/pcm_null.c b/src/pcm/pcm_null.c
index 655261f74e1f..f11a1020f7e3 100644
--- a/src/pcm/pcm_null.c
+++ b/src/pcm/pcm_null.c
@@ -100,7 +100,7 @@ static int snd_pcm_null_status(snd_pcm_t *pcm, snd_pcm_status_t * status)
 	memset(status, 0, sizeof(*status));
 	status->state = null->state;
 	status->trigger_tstamp = null->trigger_tstamp;
-	gettimestamp(&status->tstamp, pcm->monotonic);
+	gettimestamp(&status->tstamp, pcm->tstamp_type);
 	status->avail = snd_pcm_null_avail_update(pcm);
 	status->avail_max = pcm->buffer_size;
 	return 0;
diff --git a/src/pcm/pcm_plug.c b/src/pcm/pcm_plug.c
index 7a6c2b99c639..5639b9ea8044 100644
--- a/src/pcm/pcm_plug.c
+++ b/src/pcm/pcm_plug.c
@@ -1127,7 +1127,7 @@ int snd_pcm_plug_open(snd_pcm_t **pcmp,
 	pcm->poll_fd = slave->poll_fd;
 	pcm->poll_events = slave->poll_events;
 	pcm->mmap_shadow = 1;
-	pcm->monotonic = slave->monotonic;
+	pcm->tstamp_type = slave->tstamp_type;
 	snd_pcm_link_hw_ptr(pcm, slave);
 	snd_pcm_link_appl_ptr(pcm, slave);
 	*pcmp = pcm;
diff --git a/src/pcm/pcm_rate.c b/src/pcm/pcm_rate.c
index 7f667d4c6a52..aea95e52d3dc 100644
--- a/src/pcm/pcm_rate.c
+++ b/src/pcm/pcm_rate.c
@@ -1067,7 +1067,7 @@ static int snd_pcm_rate_start(snd_pcm_t *pcm)
 	if (snd_pcm_state(rate->gen.slave) != SND_PCM_STATE_PREPARED)
 		return -EBADFD;
 
-	gettimestamp(&rate->trigger_tstamp, pcm->monotonic);
+	gettimestamp(&rate->trigger_tstamp, pcm->tstamp_type);
 
 	avail = snd_pcm_mmap_playback_hw_avail(rate->gen.slave);
 	if (avail == 0) {
@@ -1370,7 +1370,7 @@ int snd_pcm_rate_open(snd_pcm_t **pcmp, const char *name,
 	pcm->poll_fd = slave->poll_fd;
 	pcm->poll_events = slave->poll_events;
 	pcm->mmap_rw = 1;
-	pcm->monotonic = slave->monotonic;
+	pcm->tstamp_type = slave->tstamp_type;
 	snd_pcm_set_hw_ptr(pcm, &rate->hw_ptr, -1, 0);
 	snd_pcm_set_appl_ptr(pcm, &rate->appl_ptr, -1, 0);
 	*pcmp = pcm;
diff --git a/src/pcm/pcm_route.c b/src/pcm/pcm_route.c
index 751e36f28fdf..2f0be38b1906 100644
--- a/src/pcm/pcm_route.c
+++ b/src/pcm/pcm_route.c
@@ -1122,7 +1122,7 @@ int snd_pcm_route_open(snd_pcm_t **pcmp, const char *name,
 	pcm->private_data = route;
 	pcm->poll_fd = slave->poll_fd;
 	pcm->poll_events = slave->poll_events;
-	pcm->monotonic = slave->monotonic;
+	pcm->tstamp_type = slave->tstamp_type;
 	snd_pcm_set_hw_ptr(pcm, &route->plug.hw_ptr, -1, 0);
 	snd_pcm_set_appl_ptr(pcm, &route->plug.appl_ptr, -1, 0);
 	err = route_load_ttable(&route->params, pcm->stream, tt_ssize, ttable, tt_cused, tt_sused);
diff --git a/src/pcm/pcm_share.c b/src/pcm/pcm_share.c
index 118ab2617780..97705447dd6d 100644
--- a/src/pcm/pcm_share.c
+++ b/src/pcm/pcm_share.c
@@ -971,7 +971,7 @@ static int snd_pcm_share_start(snd_pcm_t *pcm)
 	}
 	slave->running_count++;
 	_snd_pcm_share_update(pcm);
-	gettimestamp(&share->trigger_tstamp, pcm->monotonic);
+	gettimestamp(&share->trigger_tstamp, pcm->tstamp_type);
  _end:
 	Pthread_mutex_unlock(&slave->mutex);
 	return err;
@@ -1126,7 +1126,7 @@ static void _snd_pcm_share_stop(snd_pcm_t *pcm, snd_pcm_state_t state)
 		return;
 	}
 #endif
-	gettimestamp(&share->trigger_tstamp, pcm->monotonic);
+	gettimestamp(&share->trigger_tstamp, pcm->tstamp_type);
 	if (pcm->stream == SND_PCM_STREAM_CAPTURE) {
 		snd_pcm_areas_copy(pcm->stopped_areas, 0,
 				   pcm->running_areas, 0,
@@ -1526,7 +1526,7 @@ int snd_pcm_share_open(snd_pcm_t **pcmp, const char *name, const char *sname,
 	pcm->private_data = share;
 	pcm->poll_fd = share->client_socket;
 	pcm->poll_events = stream == SND_PCM_STREAM_PLAYBACK ? POLLOUT : POLLIN;
-	pcm->monotonic = slave->pcm->monotonic;
+	pcm->tstamp_type = slave->pcm->tstamp_type;
 	snd_pcm_set_hw_ptr(pcm, &share->hw_ptr, -1, 0);
 	snd_pcm_set_appl_ptr(pcm, &share->appl_ptr, -1, 0);
 
diff --git a/src/pcm/pcm_softvol.c b/src/pcm/pcm_softvol.c
index 5da92049cc88..c6cfd8896b26 100644
--- a/src/pcm/pcm_softvol.c
+++ b/src/pcm/pcm_softvol.c
@@ -903,7 +903,7 @@ int snd_pcm_softvol_open(snd_pcm_t **pcmp, const char *name,
 	 * an extra buffer.
 	 */
 	pcm->mmap_shadow = 1;
-	pcm->monotonic = slave->monotonic;
+	pcm->tstamp_type = slave->tstamp_type;
 	snd_pcm_set_hw_ptr(pcm, &svol->plug.hw_ptr, -1, 0);
 	snd_pcm_set_appl_ptr(pcm, &svol->plug.appl_ptr, -1, 0);
 	*pcmp = pcm;
-- 
2.0.1
