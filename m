From: Shengjiu Wang <shengjiu.wang@freescale.com>
Subject: [PATCH] PCM: snd_pcm_dmix_drain() maybe blocked after
	suspend and resume
Date: Mon, 8 Jun 2015 17:38:11 +0800
Message-ID: <1433756291-22999-1-git-send-email-shengjiu.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0111.outbound.protection.outlook.com [65.55.169.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 4B4312604E1
 for <alsa-devel@alsa-project.org>; Mon,  8 Jun 2015 11:38:28 +0200 (CEST)
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
into snd_pcm_dmix_drain(), it need to wait avail >= pcm->stop_threshold,
otherwise, it will not exit the loop, so finally it is blocked at poll() of
snd_pcm_wait_nocheck(pcm, -1).
This patch is to add state check after snd_pcm_wait_nocheck(pcm, -1), if
the state is SND_PCM_STATE_SUSPENDED, then return error.

Signed-off-by: Shengjiu Wang <shengjiu.wang@freescale.com>
---
 src/pcm/pcm_dmix.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/pcm/pcm_dmix.c b/src/pcm/pcm_dmix.c
index babde6a..0cc318e 100644
--- a/src/pcm/pcm_dmix.c
+++ b/src/pcm/pcm_dmix.c
@@ -647,6 +647,12 @@ static int snd_pcm_dmix_drain(snd_pcm_t *pcm)
 		if (dmix->state == SND_PCM_STATE_DRAINING) {
 			snd_pcm_dmix_sync_area(pcm);
 			snd_pcm_wait_nocheck(pcm, -1);
+			switch (snd_pcm_state(pcm)) {
+			case SND_PCM_STATE_SUSPENDED:
+				return -ESTRPIPE;
+			default:
+				break;
+			}
 			snd_pcm_direct_clear_timer_queue(dmix); /* force poll to wait */
 		}
 	} while (dmix->state == SND_PCM_STATE_DRAINING);
-- 
1.7.9.5
