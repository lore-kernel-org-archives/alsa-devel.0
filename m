From: Shengjiu Wang <shengjiu.wang@freescale.com>
Subject: [PATCH V2] PCM: snd_pcm_xxxx_drain() maybe blocked
	after suspend and resume
Date: Fri, 12 Jun 2015 16:15:08 +0800
Message-ID: <237099058d5e658610915f8f6a4724d782299a25.1434096300.git.shengjiu.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0124.outbound.protection.outlook.com [65.55.169.124])
 by alsa0.perex.cz (Postfix) with ESMTP id A5E412666D3
 for <alsa-devel@alsa-project.org>; Fri, 12 Jun 2015 10:15:38 +0200 (CEST)
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

After suspend and resume, the alsa driver is stopped. But if alsa-lib run
into snd_pcm_xxxx_drain(), it need to wait avail >= pcm->stop_threshold,
otherwise, it will not exit the loop, so finally it is blocked at poll() of
snd_pcm_wait_nocheck(pcm, -1).
This patch is to add state check after snd_pcm_wait_nocheck(pcm, -1), if
the state is SND_PCM_STATE_SUSPENDED, then return error.

Signed-off-by: Shengjiu Wang <shengjiu.wang@freescale.com>
---
changes in v2:
- Add state check in beginning of drain()
- Add fix for pcm_dshare()
- Mov the state check to the place that is after
snd_pcm_direct_clear_timer_queue(dmix). That the suspend may happen just before
calling snd_pcm_direct_clear_timer_queue(dmix), which will force the next poll
to wait. So move state check to new place may safty.


 src/pcm/pcm_dmix.c   |   14 ++++++++++++++
 src/pcm/pcm_dshare.c |   14 ++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/src/pcm/pcm_dmix.c b/src/pcm/pcm_dmix.c
index babde6a..91148b9 100644
--- a/src/pcm/pcm_dmix.c
+++ b/src/pcm/pcm_dmix.c
@@ -616,6 +616,13 @@ static int snd_pcm_dmix_drain(snd_pcm_t *pcm)
 	snd_pcm_uframes_t stop_threshold;
 	int err;
 
+	switch (snd_pcm_state(dmix->spcm)) {
+	case SND_PCM_STATE_SUSPENDED:
+		return -ESTRPIPE;
+	default:
+		break;
+	}
+
 	if (dmix->state == SND_PCM_STATE_OPEN)
 		return -EBADFD;
 	if (pcm->mode & SND_PCM_NONBLOCK)
@@ -648,6 +655,13 @@ static int snd_pcm_dmix_drain(snd_pcm_t *pcm)
 			snd_pcm_dmix_sync_area(pcm);
 			snd_pcm_wait_nocheck(pcm, -1);
 			snd_pcm_direct_clear_timer_queue(dmix); /* force poll to wait */
+
+			switch (snd_pcm_state(dmix->spcm)) {
+			case SND_PCM_STATE_SUSPENDED:
+				return -ESTRPIPE;
+			default:
+				break;
+			}
 		}
 	} while (dmix->state == SND_PCM_STATE_DRAINING);
 	pcm->stop_threshold = stop_threshold;
diff --git a/src/pcm/pcm_dshare.c b/src/pcm/pcm_dshare.c
index 020e6f7..24975d4 100644
--- a/src/pcm/pcm_dshare.c
+++ b/src/pcm/pcm_dshare.c
@@ -367,6 +367,13 @@ static int snd_pcm_dshare_drain(snd_pcm_t *pcm)
 	snd_pcm_uframes_t stop_threshold;
 	int err;
 
+	switch (snd_pcm_state(dshare->spcm)) {
+	case SND_PCM_STATE_SUSPENDED:
+		return -ESTRPIPE;
+	default:
+		break;
+	}
+
 	if (dshare->state == SND_PCM_STATE_OPEN)
 		return -EBADFD;
 	if (pcm->mode & SND_PCM_NONBLOCK)
@@ -399,6 +406,13 @@ static int snd_pcm_dshare_drain(snd_pcm_t *pcm)
 			snd_pcm_dshare_sync_area(pcm);
 			snd_pcm_wait_nocheck(pcm, -1);
 			snd_pcm_direct_clear_timer_queue(dshare); /* force poll to wait */
+
+			switch (snd_pcm_state(dshare->spcm)) {
+			case SND_PCM_STATE_SUSPENDED:
+				return -ESTRPIPE;
+			default:
+				break;
+			}
 		}
 	} while (dshare->state == SND_PCM_STATE_DRAINING);
 	pcm->stop_threshold = stop_threshold;
-- 
1.7.9.5
