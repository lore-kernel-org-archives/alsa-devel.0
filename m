From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH alsa-lib] pcm: dmix: Handle slave PCM xrun and
	unexpected states properly
Date: Fri, 30 Oct 2015 17:18:56 +0100
Message-ID: <1446221936-8327-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id C159826051B
 for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2015 17:18:57 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id DB286ABE5
 for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2015 16:19:17 +0000 (UTC)
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

Currently, dmix & co plugins ignore the XRUN state of the slave PCM.
It's (supposedly) because dmix deals with the PCM in a free-wheel
mode, which is equivalent with XRUN.  But, this difference (whether
the correct freewheel or XRUN) should be done by the kernel, and we
may have an XRUN state indeed (e.g. via xrun injection).

This patch fixes this lack of behavior, to handle PCM xrun and does
prepare when the slave PCM is in such a state.

Also, the patch consolidates the prepare callback for all dmix, dsnoop
and dshare plugins, and fix/cleanup a bit for dshare/dsnoop codes to
align with dsnoop code.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 src/pcm/pcm_direct.c | 22 ++++++++++++++++++++++
 src/pcm/pcm_direct.h |  3 +++
 src/pcm/pcm_dmix.c   | 16 +++-------------
 src/pcm/pcm_dshare.c | 22 +++++++---------------
 src/pcm/pcm_dsnoop.c | 23 +++++++----------------
 5 files changed, 42 insertions(+), 44 deletions(-)

diff --git a/src/pcm/pcm_direct.c b/src/pcm/pcm_direct.c
index 195fddf06cda..fd3877c30d04 100644
--- a/src/pcm/pcm_direct.c
+++ b/src/pcm/pcm_direct.c
@@ -807,6 +807,28 @@ int snd_pcm_direct_set_chmap(snd_pcm_t *pcm, const snd_pcm_chmap_t *map)
 	return snd_pcm_set_chmap(dmix->spcm, map);
 }
 
+int snd_pcm_direct_prepare(snd_pcm_t *pcm)
+{
+	snd_pcm_direct_t *dmix = pcm->private_data;
+	int err;
+
+	switch (snd_pcm_state(dmix->spcm)) {
+	case SND_PCM_STATE_XRUN:
+	case SND_PCM_STATE_SUSPENDED:
+	case SND_PCM_STATE_DISCONNECTED:
+		err = snd_pcm_prepare(dmix->spcm);
+		if (err < 0)
+			return err;
+		snd_pcm_start(dmix->spcm);
+		break;
+	}
+	snd_pcm_direct_check_interleave(dmix, pcm);
+	dmix->state = SND_PCM_STATE_PREPARED;
+	dmix->appl_ptr = dmix->last_appl_ptr = 0;
+	dmix->hw_ptr = 0;
+	return snd_pcm_direct_set_timer_params(dmix);
+}
+
 int snd_pcm_direct_resume(snd_pcm_t *pcm)
 {
 	snd_pcm_direct_t *dmix = pcm->private_data;
diff --git a/src/pcm/pcm_direct.h b/src/pcm/pcm_direct.h
index 9b1ddbcf424a..611ad29a4821 100644
--- a/src/pcm/pcm_direct.h
+++ b/src/pcm/pcm_direct.h
@@ -224,6 +224,8 @@ struct snd_pcm_direct {
 	snd1_pcm_direct_mmap
 #define snd_pcm_direct_munmap \
 	snd1_pcm_direct_munmap
+#define snd_pcm_direct_prepare \
+	snd1_pcm_direct_prepare
 #define snd_pcm_direct_resume \
 	snd1_pcm_direct_resume
 #define snd_pcm_direct_timer_stop \
@@ -304,6 +306,7 @@ int snd_pcm_direct_sw_params(snd_pcm_t *pcm, snd_pcm_sw_params_t * params);
 int snd_pcm_direct_channel_info(snd_pcm_t *pcm, snd_pcm_channel_info_t * info);
 int snd_pcm_direct_mmap(snd_pcm_t *pcm);
 int snd_pcm_direct_munmap(snd_pcm_t *pcm);
+int snd_pcm_direct_prepare(snd_pcm_t *pcm);
 int snd_pcm_direct_resume(snd_pcm_t *pcm);
 int snd_pcm_direct_timer_stop(snd_pcm_direct_t *dmix);
 void snd_pcm_direct_clear_timer_queue(snd_pcm_direct_t *dmix);
diff --git a/src/pcm/pcm_dmix.c b/src/pcm/pcm_dmix.c
index 58e4975d5225..b26a5c790e7e 100644
--- a/src/pcm/pcm_dmix.c
+++ b/src/pcm/pcm_dmix.c
@@ -450,9 +450,10 @@ static snd_pcm_state_t snd_pcm_dmix_state(snd_pcm_t *pcm)
 	snd_pcm_state_t state;
 	state = snd_pcm_state(dmix->spcm);
 	switch (state) {
+	case SND_PCM_STATE_XRUN:
 	case SND_PCM_STATE_SUSPENDED:
-		return state;
 	case SND_PCM_STATE_DISCONNECTED:
+		dmix->state = state;
 		return state;
 	default:
 		break;
@@ -533,17 +534,6 @@ static int snd_pcm_dmix_hwsync(snd_pcm_t *pcm)
 	}
 }
 
-static int snd_pcm_dmix_prepare(snd_pcm_t *pcm)
-{
-	snd_pcm_direct_t *dmix = pcm->private_data;
-
-	snd_pcm_direct_check_interleave(dmix, pcm);
-	dmix->state = SND_PCM_STATE_PREPARED;
-	dmix->appl_ptr = dmix->last_appl_ptr = 0;
-	dmix->hw_ptr = 0;
-	return snd_pcm_direct_set_timer_params(dmix);
-}
-
 static void reset_slave_ptr(snd_pcm_t *pcm, snd_pcm_direct_t *dmix)
 {
 	dmix->slave_appl_ptr = dmix->slave_hw_ptr = *dmix->spcm->hw.ptr;
@@ -920,7 +910,7 @@ static const snd_pcm_fast_ops_t snd_pcm_dmix_fast_ops = {
 	.state = snd_pcm_dmix_state,
 	.hwsync = snd_pcm_dmix_hwsync,
 	.delay = snd_pcm_dmix_delay,
-	.prepare = snd_pcm_dmix_prepare,
+	.prepare = snd_pcm_direct_prepare,
 	.reset = snd_pcm_dmix_reset,
 	.start = snd_pcm_dmix_start,
 	.drop = snd_pcm_dmix_drop,
diff --git a/src/pcm/pcm_dshare.c b/src/pcm/pcm_dshare.c
index 02370dc7082d..58e47bbeac67 100644
--- a/src/pcm/pcm_dshare.c
+++ b/src/pcm/pcm_dshare.c
@@ -237,11 +237,14 @@ static int snd_pcm_dshare_status(snd_pcm_t *pcm, snd_pcm_status_t * status)
 static snd_pcm_state_t snd_pcm_dshare_state(snd_pcm_t *pcm)
 {
 	snd_pcm_direct_t *dshare = pcm->private_data;
-	switch (snd_pcm_state(dshare->spcm)) {
+	snd_pcm_state_t state;
+	state = snd_pcm_state(dshare->spcm);
+	switch (state) {
+	case SND_PCM_STATE_XRUN:
 	case SND_PCM_STATE_SUSPENDED:
-		return SND_PCM_STATE_SUSPENDED;
 	case SND_PCM_STATE_DISCONNECTED:
-		return SND_PCM_STATE_DISCONNECTED;
+		dshare->state = state;
+		return state;
 	default:
 		break;
 	}
@@ -296,17 +299,6 @@ static int snd_pcm_dshare_hwsync(snd_pcm_t *pcm)
 	}
 }
 
-static int snd_pcm_dshare_prepare(snd_pcm_t *pcm)
-{
-	snd_pcm_direct_t *dshare = pcm->private_data;
-
-	snd_pcm_direct_check_interleave(dshare, pcm);
-	dshare->state = SND_PCM_STATE_PREPARED;
-	dshare->appl_ptr = dshare->last_appl_ptr = 0;
-	dshare->hw_ptr = 0;
-	return snd_pcm_direct_set_timer_params(dshare);
-}
-
 static int snd_pcm_dshare_reset(snd_pcm_t *pcm)
 {
 	snd_pcm_direct_t *dshare = pcm->private_data;
@@ -595,7 +587,7 @@ static const snd_pcm_fast_ops_t snd_pcm_dshare_fast_ops = {
 	.state = snd_pcm_dshare_state,
 	.hwsync = snd_pcm_dshare_hwsync,
 	.delay = snd_pcm_dshare_delay,
-	.prepare = snd_pcm_dshare_prepare,
+	.prepare = snd_pcm_direct_prepare,
 	.reset = snd_pcm_dshare_reset,
 	.start = snd_pcm_dshare_start,
 	.drop = snd_pcm_dshare_drop,
diff --git a/src/pcm/pcm_dsnoop.c b/src/pcm/pcm_dsnoop.c
index 8a2e87ad0ae1..576c35b111cd 100644
--- a/src/pcm/pcm_dsnoop.c
+++ b/src/pcm/pcm_dsnoop.c
@@ -201,12 +201,14 @@ static int snd_pcm_dsnoop_status(snd_pcm_t *pcm, snd_pcm_status_t * status)
 static snd_pcm_state_t snd_pcm_dsnoop_state(snd_pcm_t *pcm)
 {
 	snd_pcm_direct_t *dsnoop = pcm->private_data;
-	switch (snd_pcm_state(dsnoop->spcm)) {
+	snd_pcm_state_t state;
+	state = snd_pcm_state(dsnoop->spcm);
+	switch (state) {
+	case SND_PCM_STATE_XRUN:
 	case SND_PCM_STATE_SUSPENDED:
-		return SND_PCM_STATE_SUSPENDED;
 	case SND_PCM_STATE_DISCONNECTED:
-		dsnoop->state = SNDRV_PCM_STATE_DISCONNECTED;
-		return -ENODEV;
+		dsnoop->state = state;
+		return state;
 	default:
 		break;
 	}
@@ -258,17 +260,6 @@ static int snd_pcm_dsnoop_hwsync(snd_pcm_t *pcm)
 	}
 }
 
-static int snd_pcm_dsnoop_prepare(snd_pcm_t *pcm)
-{
-	snd_pcm_direct_t *dsnoop = pcm->private_data;
-
-	snd_pcm_direct_check_interleave(dsnoop, pcm);
-	dsnoop->state = SND_PCM_STATE_PREPARED;
-	dsnoop->appl_ptr = 0;
-	dsnoop->hw_ptr = 0;
-	return snd_pcm_direct_set_timer_params(dsnoop);
-}
-
 static int snd_pcm_dsnoop_reset(snd_pcm_t *pcm)
 {
 	snd_pcm_direct_t *dsnoop = pcm->private_data;
@@ -497,7 +488,7 @@ static const snd_pcm_fast_ops_t snd_pcm_dsnoop_fast_ops = {
 	.state = snd_pcm_dsnoop_state,
 	.hwsync = snd_pcm_dsnoop_hwsync,
 	.delay = snd_pcm_dsnoop_delay,
-	.prepare = snd_pcm_dsnoop_prepare,
+	.prepare = snd_pcm_direct_prepare,
 	.reset = snd_pcm_dsnoop_reset,
 	.start = snd_pcm_dsnoop_start,
 	.drop = snd_pcm_dsnoop_drop,
-- 
2.6.2
