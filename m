From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/2] ALSA: pcm: Add cond_resched() in OSS
	read/write loop
Date: Fri,  6 Apr 2018 15:34:12 +0200
Message-ID: <20180406133412.10649-2-tiwai@suse.de>
References: <20180406133412.10649-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 36CAE2676C5
 for <alsa-devel@alsa-project.org>; Fri,  6 Apr 2018 15:34:15 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id D036CAE9E
 for <alsa-devel@alsa-project.org>; Fri,  6 Apr 2018 13:34:14 +0000 (UTC)
In-Reply-To: <20180406133412.10649-1-tiwai@suse.de>
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

The PCM OSS read/write loops may take too long occasionally when a
huge size of data is given.  Add cond_resched() to become more system-
friendlier.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/oss/pcm_oss.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/core/oss/pcm_oss.c b/sound/core/oss/pcm_oss.c
index 5e009a444d9d..54984119c0b3 100644
--- a/sound/core/oss/pcm_oss.c
+++ b/sound/core/oss/pcm_oss.c
@@ -1452,6 +1452,7 @@ static ssize_t snd_pcm_oss_write1(struct snd_pcm_substream *substream, const cha
 			break;
 		}
 		tmp = 0;
+		cond_resched();
 	}
 	atomic_dec(&runtime->oss.rw_ref);
 	return xfer > 0 ? (snd_pcm_sframes_t)xfer : tmp;
@@ -1547,6 +1548,7 @@ static ssize_t snd_pcm_oss_read1(struct snd_pcm_substream *substream, char __use
 			break;
 		}
 		tmp = 0;
+		cond_resched();
 	}
 	atomic_dec(&runtime->oss.rw_ref);
 	return xfer > 0 ? (snd_pcm_sframes_t)xfer : tmp;
-- 
2.16.3
