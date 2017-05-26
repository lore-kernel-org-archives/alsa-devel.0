From: Cheng Sun <chengsun9@gmail.com>
Subject: [PATCH] dmix: fix inconsistent status
Date: Fri, 26 May 2017 10:45:53 +0100
Message-ID: <CAG6t6sN1HiGd0CrzuzqSYU3sgn-f_DWdtCLen_g8g4OPzgxMrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-it0-f44.google.com (mail-it0-f44.google.com
 [209.85.214.44])
 by alsa0.perex.cz (Postfix) with ESMTP id F3858266B88
 for <alsa-devel@alsa-project.org>; Fri, 26 May 2017 11:46:14 +0200 (CEST)
Received: by mail-it0-f44.google.com with SMTP id o5so70802741ith.1
 for <alsa-devel@alsa-project.org>; Fri, 26 May 2017 02:46:14 -0700 (PDT)
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

Hi all,

Following on from my previous email with subject "1.1.3 bug report:
dmix reports inconsistent status", this is a preliminary patch which
fixes the issue.

Comments are welcome. In particular note that I'm not very familiar
with this code, and in particular I still don't quite understand what
the original commit which introduced this bug (38a2d2e) is meant to be
doing.

Note also that if this patch is committable, based on the commit
comment for 38a2d2e I think there might be an analogous change to be
made to faf53c1.

Cheers,
Cheng


---
diff --git a/src/pcm/pcm_dmix.c b/src/pcm/pcm_dmix.c
--- a/src/pcm/pcm_dmix.c
+++ b/src/pcm/pcm_dmix.c
@@ -459,12 +459,9 @@ static int snd_pcm_dmix_sync_ptr(snd_pcm_t *pcm)
  *  plugin implementation
  */

-static snd_pcm_state_t snd_pcm_dmix_state(snd_pcm_t *pcm)
+static snd_pcm_state_t
snd_pcm_dmix_state_from_slave_state(snd_pcm_direct_t *dmix, snd_pcm_t
*pcm, snd_pcm_state_t state)
 {
-    snd_pcm_direct_t *dmix = pcm->private_data;
     int err;
-    snd_pcm_state_t state;
-    state = snd_pcm_state(dmix->spcm);
     switch (state) {
     case SND_PCM_STATE_SUSPENDED:
     case SND_PCM_STATE_DISCONNECTED:
@@ -483,6 +480,13 @@ static snd_pcm_state_t snd_pcm_dmix_state(snd_pcm_t *pcm)
     return dmix->state;
 }

+static snd_pcm_state_t snd_pcm_dmix_state(snd_pcm_t *pcm)
+{
+    snd_pcm_direct_t *dmix = pcm->private_data;
+    snd_pcm_state_t slave_state = snd_pcm_state(dmix->spcm);
+    return snd_pcm_dmix_state_from_slave_state(dmix, pcm, slave_state);
+}
+
 static int snd_pcm_dmix_status(snd_pcm_t *pcm, snd_pcm_status_t * status)
 {
     snd_pcm_direct_t *dmix = pcm->private_data;
@@ -490,6 +494,8 @@ static int snd_pcm_dmix_status(snd_pcm_t *pcm,
snd_pcm_status_t * status)
     memset(status, 0, sizeof(*status));
     snd_pcm_status(dmix->spcm, status);

+    status->state = snd_pcm_dmix_state_from_slave_state(dmix, pcm,
status->state);
+
     switch (dmix->state) {
     case SNDRV_PCM_STATE_DRAINING:
     case SNDRV_PCM_STATE_RUNNING:
