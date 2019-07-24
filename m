From: Adam Miartus <amiartus@de.adit-jv.com>
Subject: [PATCH 2/2] alsa: dshare: allow missing bindings
Date: Wed, 24 Jul 2019 12:13:00 +0200
Message-ID: <1563963180-416-3-git-send-email-amiartus@de.adit-jv.com>
References: <1563963180-416-1-git-send-email-amiartus@de.adit-jv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1563963180-416-1-git-send-email-amiartus@de.adit-jv.com>
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
Cc: alsa-devel@alsa-project.org, Andreas Pape <apape@de.adit-jv.com>
List-Id: alsa-devel@alsa-project.org

allow opening the device and start the audio clock without blocking
any channel

this is required if the audio clock has to be available all the time,
even when application is not streaming audio data

Signed-off-by: Andreas Pape <apape@de.adit-jv.com>
Signed-off-by: Adam Miartus <amiartus@de.adit-jv.com>
---
 src/pcm/pcm_dshare.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/src/pcm/pcm_dshare.c b/src/pcm/pcm_dshare.c
index b75809c..1d29ffe 100644
--- a/src/pcm/pcm_dshare.c
+++ b/src/pcm/pcm_dshare.c
@@ -508,7 +508,8 @@ static int snd_pcm_dshare_close(snd_pcm_t *pcm)
 
 	if (dshare->timer)
 		snd_timer_close(dshare->timer);
-	do_silence(pcm);
+	if (dshare->bindings)
+		do_silence(pcm);
 	snd_pcm_direct_semaphore_down(dshare, DIRECT_IPC_SEM_CLIENT);
 	dshare->shmptr->u.dshare.chn_mask &= ~dshare->u.dshare.chn_mask;
 	snd_pcm_close(dshare->spcm);
@@ -621,6 +622,12 @@ static void snd_pcm_dshare_dump(snd_pcm_t *pcm, snd_output_t *out)
 		snd_pcm_dump(dshare->spcm, out);
 }
 
+static const snd_pcm_ops_t snd_pcm_dshare_dummy_ops = {
+	.close = snd_pcm_dshare_close,
+};
+
+static const snd_pcm_fast_ops_t snd_pcm_dshare_fast_dummy_ops;
+
 static const snd_pcm_ops_t snd_pcm_dshare_ops = {
 	.close = snd_pcm_dshare_close,
 	.info = snd_pcm_direct_info,
@@ -713,12 +720,7 @@ int snd_pcm_dshare_open(snd_pcm_t **pcmp, const char *name,
 	if (ret < 0)
 		goto _err_nosem;
 		
-	if (!dshare->bindings) {
-		SNDERR("dshare: specify bindings!!!");
-		ret = -EINVAL;
-		goto _err_nosem;
-	}
-	
+
 	dshare->ipc_key = opts->ipc_key;
 	dshare->ipc_perm = opts->ipc_perm;
 	dshare->ipc_gid = opts->ipc_gid;
@@ -751,9 +753,14 @@ int snd_pcm_dshare_open(snd_pcm_t **pcmp, const char *name,
 		SNDERR("unable to create IPC shm instance");
 		goto _err;
 	}
-		
-	pcm->ops = &snd_pcm_dshare_ops;
-	pcm->fast_ops = &snd_pcm_dshare_fast_ops;
+
+	if (!dshare->bindings) {
+		pcm->ops = &snd_pcm_dshare_dummy_ops;
+		pcm->fast_ops = &snd_pcm_dshare_fast_dummy_ops;
+	} else {
+		pcm->ops = &snd_pcm_dshare_ops;
+		pcm->fast_ops = &snd_pcm_dshare_fast_ops;
+	}
 	pcm->private_data = dshare;
 	dshare->state = SND_PCM_STATE_OPEN;
 	dshare->slowptr = opts->slowptr;
@@ -843,7 +850,7 @@ int snd_pcm_dshare_open(snd_pcm_t **pcmp, const char *name,
 		dshare->spcm = spcm;
 	}
 
-	for (chn = 0; chn < dshare->channels; chn++) {
+	for (chn = 0; dshare->bindings && (chn < dshare->channels); chn++) {
 		unsigned int dchn = dshare->bindings ? dshare->bindings[chn] : chn;
 		if (dchn != UINT_MAX)
 			dshare->u.dshare.chn_mask |= (1ULL << dchn);
-- 
2.7.4
