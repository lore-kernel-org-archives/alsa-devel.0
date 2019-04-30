From: <vanitha.channaiah@in.bosch.com>
Subject: [PATCH 3/5] pcm: dsnoop: Added "hw_ptr_alignment"
	option in configuration for slave pointer alignment
Date: Tue, 30 Apr 2019 13:08:41 +0530
Message-ID: <1556609923-14093-3-git-send-email-vanitha.channaiah@in.bosch.com>
References: <1556609923-14093-1-git-send-email-vanitha.channaiah@in.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1556609923-14093-1-git-send-email-vanitha.channaiah@in.bosch.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: patch@alsa-project.org
Cc: twischer@de.adit-jv.com, alsa-devel@alsa-project.org, Vanitha Channaiah <vanitha.channaiah@in.bosch.com>
List-Id: alsa-devel@alsa-project.org

From: Vanitha Channaiah <vanitha.channaiah@in.bosch.com>

snd_pcm_wait() is waiting for longer time more than two periodic size as
avail is less than avail_min by few frames.
This is because the hw_ptr read from the kernel during snd_pcm_start()
is not period aligned which is ahead of few (Nperiod + 1)frames.

Signed-off-by: Vanitha Channaiah <vanitha.channaiah@in.bosch.com>
---
 src/pcm/pcm_direct.c | 7 ++++---
 src/pcm/pcm_dmix.c   | 2 ++
 src/pcm/pcm_dshare.c | 2 ++
 src/pcm/pcm_dsnoop.c | 5 ++++-
 4 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/src/pcm/pcm_direct.c b/src/pcm/pcm_direct.c
index 411a035..b56da85 100644
--- a/src/pcm/pcm_direct.c
+++ b/src/pcm/pcm_direct.c
@@ -2043,11 +2043,12 @@ int snd_pcm_direct_parse_open_conf(snd_config_t *root, snd_config_t *conf,
 
 void snd_pcm_direct_reset_slave_ptr(snd_pcm_t *pcm, snd_pcm_direct_t *dmix)
 {
-	dmix->slave_appl_ptr = dmix->slave_hw_ptr = *dmix->spcm->hw.ptr;
-
+	/* For buffer size less than two period size, the start position
+	 * of slave app ptr is rounded up in order to avoid xruns
+	 */
 	if (dmix->hw_ptr_alignment == SND_PCM_HW_PTR_ALIGNMENT_ROUNDUP ||
 		(dmix->hw_ptr_alignment == SND_PCM_HW_PTR_ALIGNMENT_AUTO &&
-		pcm->buffer_size <= pcm->period_size * 2))
+		pcm->buffer_size < pcm->period_size * 2))
 		dmix->slave_appl_ptr =
 			((dmix->slave_appl_ptr + dmix->slave_period_size - 1) /
 			dmix->slave_period_size) * dmix->slave_period_size;
diff --git a/src/pcm/pcm_dmix.c b/src/pcm/pcm_dmix.c
index dcde40d..274726e 100644
--- a/src/pcm/pcm_dmix.c
+++ b/src/pcm/pcm_dmix.c
@@ -562,6 +562,7 @@ static int snd_pcm_dmix_reset(snd_pcm_t *pcm)
 	snd_pcm_direct_t *dmix = pcm->private_data;
 	dmix->hw_ptr %= pcm->period_size;
 	dmix->appl_ptr = dmix->last_appl_ptr = dmix->hw_ptr;
+	dmix->slave_appl_ptr = dmix->slave_hw_ptr = *dmix->spcm->hw.ptr;
 	snd_pcm_direct_reset_slave_ptr(pcm, dmix);
 	return 0;
 }
@@ -571,6 +572,7 @@ static int snd_pcm_dmix_start_timer(snd_pcm_t *pcm, snd_pcm_direct_t *dmix)
 	int err;
 
 	snd_pcm_hwsync(dmix->spcm);
+	dmix->slave_appl_ptr = dmix->slave_hw_ptr = *dmix->spcm->hw.ptr;
 	snd_pcm_direct_reset_slave_ptr(pcm, dmix);
 	err = snd_timer_start(dmix->timer);
 	if (err < 0)
diff --git a/src/pcm/pcm_dshare.c b/src/pcm/pcm_dshare.c
index 45e2597..3847645 100644
--- a/src/pcm/pcm_dshare.c
+++ b/src/pcm/pcm_dshare.c
@@ -333,6 +333,7 @@ static int snd_pcm_dshare_reset(snd_pcm_t *pcm)
 	snd_pcm_direct_t *dshare = pcm->private_data;
 	dshare->hw_ptr %= pcm->period_size;
 	dshare->appl_ptr = dshare->last_appl_ptr = dshare->hw_ptr;
+	dshare->slave_appl_ptr = dshare->slave_hw_ptr = *dshare->spcm->hw.ptr;
 	snd_pcm_direct_reset_slave_ptr(pcm, dshare);
 	return 0;
 }
@@ -342,6 +343,7 @@ static int snd_pcm_dshare_start_timer(snd_pcm_t *pcm, snd_pcm_direct_t *dshare)
 	int err;
 
 	snd_pcm_hwsync(dshare->spcm);
+	dshare->slave_appl_ptr = dshare->slave_hw_ptr = *dshare->spcm->hw.ptr;
 	snd_pcm_direct_reset_slave_ptr(pcm, dshare);
 	err = snd_timer_start(dshare->timer);
 	if (err < 0)
diff --git a/src/pcm/pcm_dsnoop.c b/src/pcm/pcm_dsnoop.c
index d08b624..2bbbc2d 100644
--- a/src/pcm/pcm_dsnoop.c
+++ b/src/pcm/pcm_dsnoop.c
@@ -278,6 +278,7 @@ static int snd_pcm_dsnoop_reset(snd_pcm_t *pcm)
 	dsnoop->hw_ptr %= pcm->period_size;
 	dsnoop->appl_ptr = dsnoop->hw_ptr;
 	dsnoop->slave_appl_ptr = dsnoop->slave_hw_ptr;
+	snd_pcm_direct_reset_slave_ptr(pcm, dsnoop);
 	return 0;
 }
 
@@ -285,12 +286,13 @@ static int snd_pcm_dsnoop_start(snd_pcm_t *pcm)
 {
 	snd_pcm_direct_t *dsnoop = pcm->private_data;
 	int err;
-	
+
 	if (dsnoop->state != SND_PCM_STATE_PREPARED)
 		return -EBADFD;
 	snd_pcm_hwsync(dsnoop->spcm);
 	snoop_timestamp(pcm);
 	dsnoop->slave_appl_ptr = dsnoop->slave_hw_ptr;
+	snd_pcm_direct_reset_slave_ptr(pcm, dsnoop);
 	err = snd_timer_start(dsnoop->timer);
 	if (err < 0)
 		return err;
@@ -627,6 +629,7 @@ int snd_pcm_dsnoop_open(snd_pcm_t **pcmp, const char *name,
 	dsnoop->max_periods = opts->max_periods;
 	dsnoop->var_periodsize = opts->var_periodsize;
 	dsnoop->sync_ptr = snd_pcm_dsnoop_sync_ptr;
+	dsnoop->hw_ptr_alignment = opts->hw_ptr_alignment;
 
  retry:
 	if (first_instance) {
-- 
2.7.4
