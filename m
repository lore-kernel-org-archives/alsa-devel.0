From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] pcm: dmix: Workaround for binary
	incompatibility
Date: Fri, 26 May 2017 14:39:16 +0200
Message-ID: <20170526123916.19015-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 6A5982674DB
 for <alsa-devel@alsa-project.org>; Fri, 26 May 2017 14:39:18 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id AE421ABF7
 for <alsa-devel@alsa-project.org>; Fri, 26 May 2017 12:39:18 +0000 (UTC)
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

The commit 1a9bd0f04481 ("pcm: direct: Fix for sync issue on xrun
recover") introduced a new field "recoveries" in
snd_pcm_direct_share_t.  Unfortunately this caused two issues:

- It changed the size of the struct which is used as the magic key
- The struct size differs between 32bit and 64bit due to alignment

The former brought the incompatibility with the older alsa-lib,
e.g. when you run an app with an older alsa-lib via LD_PRELOAD, it
doesn't work any longer.

The latter is more serious, it disallows running 32bit apps dmix with
64bit together.

As a workaround, put recoveries field to the unused field
"s.xfer_align", so that the struct is in an old form.

This is a one-time workaround, and we may need to reconsider more
about a breakage in future...

Reported-and-tested-by: Cheng Sun <chengsun9@gmail.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 src/pcm/pcm_direct.c | 8 ++++----
 src/pcm/pcm_direct.h | 3 +--
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/src/pcm/pcm_direct.c b/src/pcm/pcm_direct.c
index 89468d3537d0..43702601b0f2 100644
--- a/src/pcm/pcm_direct.c
+++ b/src/pcm/pcm_direct.c
@@ -615,7 +615,7 @@ int snd_pcm_direct_slave_recover(snd_pcm_direct_t *direct)
 		}
 		return ret;
 	}
-	direct->shmptr->recoveries++;
+	direct->shmptr->s.recoveries++;
 	semerr = snd_pcm_direct_semaphore_up(direct,
 						 DIRECT_IPC_SEM_CLIENT);
 	if (semerr < 0) {
@@ -631,11 +631,11 @@ int snd_pcm_direct_slave_recover(snd_pcm_direct_t *direct)
  */
 int snd_pcm_direct_client_chk_xrun(snd_pcm_direct_t *direct, snd_pcm_t *pcm)
 {
-	if (direct->shmptr->recoveries != direct->recoveries) {
+	if (direct->shmptr->s.recoveries != direct->recoveries) {
 		/* no matter how many xruns we missed -
 		 * so don't increment but just update to actual counter
 		 */
-		direct->recoveries = direct->shmptr->recoveries;
+		direct->recoveries = direct->shmptr->s.recoveries;
 		pcm->fast_ops->drop(pcm);
 		/* trigger_tstamp update is missing in drop callbacks */
 		gettimestamp(&direct->trigger_tstamp, pcm->tstamp_type);
@@ -1539,7 +1539,7 @@ int snd_pcm_direct_open_secondary_client(snd_pcm_t **spcmp, snd_pcm_direct_t *dm
 	dmix->slave_buffer_size = spcm->buffer_size;
 	dmix->slave_period_size = dmix->shmptr->s.period_size;
 	dmix->slave_boundary = spcm->boundary;
-	dmix->recoveries = dmix->shmptr->recoveries;
+	dmix->recoveries = dmix->shmptr->s.recoveries;
 
 	ret = snd_pcm_mmap(spcm);
 	if (ret < 0) {
diff --git a/src/pcm/pcm_direct.h b/src/pcm/pcm_direct.h
index 24e85f096310..582f055a5451 100644
--- a/src/pcm/pcm_direct.h
+++ b/src/pcm/pcm_direct.h
@@ -66,7 +66,6 @@ typedef struct {
 	char socket_name[256];			/* name of communication socket */
 	snd_pcm_type_t type;			/* PCM type (currently only hw) */
 	int use_server;
-	unsigned int recoveries;		/* no of executed recoveries on slave*/
 	struct {
 		unsigned int format;
 		snd_interval_t rate;
@@ -95,7 +94,7 @@ typedef struct {
 		unsigned int stop_threshold;	
 		unsigned int silence_threshold;
 		unsigned int silence_size;
-		unsigned int xfer_align; /* not used */
+		unsigned int recoveries;	/* no of executed recoveries on slave*/
 		unsigned long long boundary;
 		unsigned int info;
 		unsigned int msbits;
-- 
2.13.0
