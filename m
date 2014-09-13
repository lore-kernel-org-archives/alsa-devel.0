From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: [PATCH 1/9] dmix: actually rewind when running or
	being drained
Date: Sun, 14 Sep 2014 00:30:13 +0600
Message-ID: <1410633021-20395-2-git-send-email-patrakov@gmail.com>
References: <1410633021-20395-1-git-send-email-patrakov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f48.google.com (mail-la0-f48.google.com
 [209.85.215.48])
 by alsa0.perex.cz (Postfix) with ESMTP id DD36A261ACA
 for <alsa-devel@alsa-project.org>; Sat, 13 Sep 2014 20:30:50 +0200 (CEST)
Received: by mail-la0-f48.google.com with SMTP id ty20so2715047lab.35
 for <alsa-devel@alsa-project.org>; Sat, 13 Sep 2014 11:30:50 -0700 (PDT)
In-Reply-To: <1410633021-20395-1-git-send-email-patrakov@gmail.com>
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
Cc: tiwai@suse.de, clemens@ladisch.de, "Alexander E. Patrakov" <patrakov@gmail.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Alexander E. Patrakov <patrakov@gmail.com>
---
 src/pcm/pcm_dmix.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/src/pcm/pcm_dmix.c b/src/pcm/pcm_dmix.c
index 7c53509..73cbe3f 100644
--- a/src/pcm/pcm_dmix.c
+++ b/src/pcm/pcm_dmix.c
@@ -669,11 +669,15 @@ static snd_pcm_sframes_t snd_pcm_dmix_rewind(snd_pcm_t *pcm, snd_pcm_uframes_t f
 	snd_pcm_direct_t *dmix = pcm->private_data;
 	snd_pcm_uframes_t slave_appl_ptr, slave_size;
 	snd_pcm_uframes_t appl_ptr, size, transfer, result;
+	int err;
 	const snd_pcm_channel_area_t *src_areas, *dst_areas;
 
 	if (dmix->state == SND_PCM_STATE_RUNNING ||
-	    dmix->state == SND_PCM_STATE_DRAINING)
-	    	return snd_pcm_dmix_hwsync(pcm);
+	    dmix->state == SND_PCM_STATE_DRAINING) {
+		err = snd_pcm_dmix_hwsync(pcm);
+		if (err < 0)
+			return err;
+	}
 
 	if (dmix->last_appl_ptr < dmix->appl_ptr)
 		size = dmix->appl_ptr - dmix->last_appl_ptr;
-- 
2.1.0
