From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/6] ALSA: pcm: Use common error handling code
 in _snd_pcm_new()
Date: Wed, 23 Aug 2017 10:23:23 +0200
Message-ID: <60478d72-9d5a-9eff-9372-0fb4dbb2dbc4@users.sourceforge.net>
References: <b8c9e41b-a47e-1d99-3d1a-5d39772e4b54@users.sourceforge.net>
 <s5h378isw2d.wl-tiwai@suse.de>
 <800d7aa6-d8f2-cbf5-caaa-7e4006976e68@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by alsa0.perex.cz (Postfix) with ESMTP id A49E92665D5
 for <alsa-devel@alsa-project.org>; Wed, 23 Aug 2017 10:23:30 +0200 (CEST)
In-Reply-To: <800d7aa6-d8f2-cbf5-caaa-7e4006976e68@users.sourceforge.net>
Content-Language: en-GB
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>, Arvind Yadav <arvind.yadav.cs@gmail.com>, Dan Carpenter <dan.carpenter@oracle.com>, Ingo Molnar <mingo@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Vegard Nossum <vegard.nossum@oracle.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 23 Aug 2017 08:40:37 +0200

Add a jump target so that a bit of exception handling can be better reused
at the end of this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/core/pcm.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/sound/core/pcm.c b/sound/core/pcm.c
index 89c7485519cb..048df9658f50 100644
--- a/sound/core/pcm.c
+++ b/sound/core/pcm.c
@@ -783,21 +783,27 @@ static int _snd_pcm_new(struct snd_card *card, const char *id, int device,
 	INIT_LIST_HEAD(&pcm->list);
 	if (id)
 		strlcpy(pcm->id, id, sizeof(pcm->id));
-	if ((err = snd_pcm_new_stream(pcm, SNDRV_PCM_STREAM_PLAYBACK, playback_count)) < 0) {
-		snd_pcm_free(pcm);
-		return err;
-	}
-	if ((err = snd_pcm_new_stream(pcm, SNDRV_PCM_STREAM_CAPTURE, capture_count)) < 0) {
-		snd_pcm_free(pcm);
-		return err;
-	}
-	if ((err = snd_device_new(card, SNDRV_DEV_PCM, pcm, &ops)) < 0) {
-		snd_pcm_free(pcm);
-		return err;
-	}
+
+	err = snd_pcm_new_stream(pcm, SNDRV_PCM_STREAM_PLAYBACK,
+				 playback_count);
+	if (err < 0)
+		goto free_pcm;
+
+	err = snd_pcm_new_stream(pcm, SNDRV_PCM_STREAM_CAPTURE, capture_count);
+	if (err < 0)
+		goto free_pcm;
+
+	err = snd_device_new(card, SNDRV_DEV_PCM, pcm, &ops);
+	if (err < 0)
+		goto free_pcm;
+
 	if (rpcm)
 		*rpcm = pcm;
 	return 0;
+
+free_pcm:
+	snd_pcm_free(pcm);
+	return err;
 }
 
 /**
-- 
2.14.0
