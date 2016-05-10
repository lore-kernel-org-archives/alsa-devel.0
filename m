From: Shengjiu Wang <shengjiu.wang@freescale.com>
Subject: [PATCH] pcm: Don't store the state for
	SND_PCM_STATE_SUSPENDED
Date: Tue, 10 May 2016 15:45:46 +0800
Message-ID: <1462866346-11878-1-git-send-email-shengjiu.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0113.outbound.protection.outlook.com [157.56.111.113])
 by alsa0.perex.cz (Postfix) with ESMTP id ABF9D261600
 for <alsa-devel@alsa-project.org>; Tue, 10 May 2016 09:45:28 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: perex@perex.cz, tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The resume function don't update the dmix->state, if store SUSPENDED
state in snd_pcm_dmix_state, the write function after resume will
return error -ESTRPIPE, because the snd_pcm_write_areas() will check
the state of the pcm device.
This patch remove the store SND_PCM_STATE_SUSPENDED state operation
for dmix,dshare,dsnoop.

Signed-off-by: Shengjiu Wang <shengjiu.wang@freescale.com>
---
 src/pcm/pcm_dmix.c   | 2 +-
 src/pcm/pcm_dshare.c | 2 +-
 src/pcm/pcm_dsnoop.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/pcm/pcm_dmix.c b/src/pcm/pcm_dmix.c
index 007d356..66bb288 100644
--- a/src/pcm/pcm_dmix.c
+++ b/src/pcm/pcm_dmix.c
@@ -451,9 +451,9 @@ static snd_pcm_state_t snd_pcm_dmix_state(snd_pcm_t *pcm)
 	state = snd_pcm_state(dmix->spcm);
 	switch (state) {
 	case SND_PCM_STATE_XRUN:
-	case SND_PCM_STATE_SUSPENDED:
 	case SND_PCM_STATE_DISCONNECTED:
 		dmix->state = state;
+	case SND_PCM_STATE_SUSPENDED:
 		return state;
 	default:
 		break;
diff --git a/src/pcm/pcm_dshare.c b/src/pcm/pcm_dshare.c
index adb3587..a133c72 100644
--- a/src/pcm/pcm_dshare.c
+++ b/src/pcm/pcm_dshare.c
@@ -241,9 +241,9 @@ static snd_pcm_state_t snd_pcm_dshare_state(snd_pcm_t *pcm)
 	state = snd_pcm_state(dshare->spcm);
 	switch (state) {
 	case SND_PCM_STATE_XRUN:
-	case SND_PCM_STATE_SUSPENDED:
 	case SND_PCM_STATE_DISCONNECTED:
 		dshare->state = state;
+	case SND_PCM_STATE_SUSPENDED:
 		return state;
 	default:
 		break;
diff --git a/src/pcm/pcm_dsnoop.c b/src/pcm/pcm_dsnoop.c
index 8ff0ba5..d56dd97 100644
--- a/src/pcm/pcm_dsnoop.c
+++ b/src/pcm/pcm_dsnoop.c
@@ -205,9 +205,9 @@ static snd_pcm_state_t snd_pcm_dsnoop_state(snd_pcm_t *pcm)
 	state = snd_pcm_state(dsnoop->spcm);
 	switch (state) {
 	case SND_PCM_STATE_XRUN:
-	case SND_PCM_STATE_SUSPENDED:
 	case SND_PCM_STATE_DISCONNECTED:
 		dsnoop->state = state;
+	case SND_PCM_STATE_SUSPENDED:
 		return state;
 	default:
 		break;
-- 
1.9.1
