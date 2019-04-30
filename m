From: <vanitha.channaiah@in.bosch.com>
Subject: [PATCH 2/5] pcm: dshare: Added "hw_ptr_alignment"
	option in configuration for alignment of slave pointers
Date: Tue, 30 Apr 2019 13:08:40 +0530
Message-ID: <1556609923-14093-2-git-send-email-vanitha.channaiah@in.bosch.com>
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
is not period aligned which is ahead of few frames.

These changes are adaptation of same fix as given for dmix
commit ("6b058fda9dce8f416774ae54975f5706f3f5a6da")
("pcm-dmix-Add-option-to-allow-alignment-of-slave-poin.patch")

Signed-off-by: Vanitha Channaiah <vanitha.channaiah@in.bosch.com>
---
 src/pcm/pcm_dshare.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/src/pcm/pcm_dshare.c b/src/pcm/pcm_dshare.c
index f135b5d..45e2597 100644
--- a/src/pcm/pcm_dshare.c
+++ b/src/pcm/pcm_dshare.c
@@ -333,16 +333,16 @@ static int snd_pcm_dshare_reset(snd_pcm_t *pcm)
 	snd_pcm_direct_t *dshare = pcm->private_data;
 	dshare->hw_ptr %= pcm->period_size;
 	dshare->appl_ptr = dshare->last_appl_ptr = dshare->hw_ptr;
-	dshare->slave_appl_ptr = dshare->slave_hw_ptr = *dshare->spcm->hw.ptr;
+	snd_pcm_direct_reset_slave_ptr(pcm, dshare);
 	return 0;
 }
 
-static int snd_pcm_dshare_start_timer(snd_pcm_direct_t *dshare)
+static int snd_pcm_dshare_start_timer(snd_pcm_t *pcm, snd_pcm_direct_t *dshare)
 {
 	int err;
 
 	snd_pcm_hwsync(dshare->spcm);
-	dshare->slave_appl_ptr = dshare->slave_hw_ptr = *dshare->spcm->hw.ptr;
+	snd_pcm_direct_reset_slave_ptr(pcm, dshare);
 	err = snd_timer_start(dshare->timer);
 	if (err < 0)
 		return err;
@@ -364,7 +364,8 @@ static int snd_pcm_dshare_start(snd_pcm_t *pcm)
 	else if (avail < 0)
 		return 0;
 	else {
-		if ((err = snd_pcm_dshare_start_timer(dshare)) < 0)
+		err = snd_pcm_dshare_start_timer(pcm, dshare);
+		if (err < 0)
 			return err;
 		snd_pcm_dshare_sync_area(pcm);
 	}
@@ -547,7 +548,8 @@ static snd_pcm_sframes_t snd_pcm_dshare_mmap_commit(snd_pcm_t *pcm,
 		return 0;
 	snd_pcm_mmap_appl_forward(pcm, size);
 	if (dshare->state == STATE_RUN_PENDING) {
-		if ((err = snd_pcm_dshare_start_timer(dshare)) < 0)
+		err = snd_pcm_dshare_start_timer(pcm, dshare);
+		if (err < 0)
 			return err;
 	} else if (dshare->state == SND_PCM_STATE_RUNNING ||
 		   dshare->state == SND_PCM_STATE_DRAINING) {
@@ -755,6 +757,7 @@ int snd_pcm_dshare_open(snd_pcm_t **pcmp, const char *name,
 	dshare->slowptr = opts->slowptr;
 	dshare->max_periods = opts->max_periods;
 	dshare->var_periodsize = opts->var_periodsize;
+	dshare->hw_ptr_alignment = opts->hw_ptr_alignment;
 	dshare->sync_ptr = snd_pcm_dshare_sync_ptr;
 
  retry:
-- 
2.7.4
