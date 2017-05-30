From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] pcm: dshare: Call snd_pcm_dshare_state()
	directly
Date: Tue, 30 May 2017 17:34:45 +0200
Message-ID: <20170530153445.4578-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 15B99266D5D
 for <alsa-devel@alsa-project.org>; Tue, 30 May 2017 17:34:46 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id AE4F3AAB6
 for <alsa-devel@alsa-project.org>; Tue, 30 May 2017 15:34:46 +0000 (UTC)
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

... otherwise it may be a deadlock if recursive lock isn't available.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 src/pcm/pcm_dshare.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/pcm/pcm_dshare.c b/src/pcm/pcm_dshare.c
index 4c57fb4a3028..7cdfea2a1572 100644
--- a/src/pcm/pcm_dshare.c
+++ b/src/pcm/pcm_dshare.c
@@ -227,6 +227,8 @@ static int snd_pcm_dshare_sync_ptr(snd_pcm_t *pcm)
  *  plugin implementation
  */
 
+static snd_pcm_state_t snd_pcm_dshare_state(snd_pcm_t *pcm);
+
 static int snd_pcm_dshare_status(snd_pcm_t *pcm, snd_pcm_status_t * status)
 {
 	snd_pcm_direct_t *dshare = pcm->private_data;
@@ -244,7 +246,7 @@ static int snd_pcm_dshare_status(snd_pcm_t *pcm, snd_pcm_status_t * status)
 	default:
 		break;
 	}
-	status->state = snd_pcm_state(pcm);
+	status->state = snd_pcm_dshare_state(pcm);
 	status->trigger_tstamp = dshare->trigger_tstamp;
 	status->avail = snd_pcm_mmap_playback_avail(pcm);
 	status->avail_max = status->avail > dshare->avail_max ? status->avail : dshare->avail_max;
-- 
2.13.0
