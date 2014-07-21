From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH alsa-lib v2] pcm: Fill sw_params proto field
Date: Mon, 21 Jul 2014 13:52:53 +0200
Message-ID: <1405943573-3547-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 2FF32265470
 for <alsa-devel@alsa-project.org>; Mon, 21 Jul 2014 13:52:54 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id EEF11AD71
 for <alsa-devel@alsa-project.org>; Mon, 21 Jul 2014 11:52:53 +0000 (UTC)
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

Fill the new proto field introduced to sw_params with the current PCM
protocol version.  This makes tstamp_type evaluated properly in the
kernel.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
v1->v2: rearrange proto and tstamp_type fields

 include/sound/asound.h | 4 ++--
 src/pcm/pcm.c          | 1 +
 src/pcm/pcm_params.c   | 1 +
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/sound/asound.h b/include/sound/asound.h
index 552f41bd1ca9..c819df421434 100644
--- a/include/sound/asound.h
+++ b/include/sound/asound.h
@@ -386,8 +386,8 @@ struct snd_pcm_sw_params {
 	snd_pcm_uframes_t silence_threshold;	/* min distance from noise for silence filling */
 	snd_pcm_uframes_t silence_size;		/* silence block size */
 	snd_pcm_uframes_t boundary;		/* pointers wrap point */
-	unsigned int tstamp_type;		/* timestamp type */
-	int pads;				/* alignment, reserved */
+	unsigned int proto;			/* protocol version */
+	unsigned int tstamp_type;		/* timestamp type (req. proto >= 2.0.12) */
 	unsigned char reserved[56];		/* reserved for future */
 };
 
diff --git a/src/pcm/pcm.c b/src/pcm/pcm.c
index 89844430bf35..1399a5b2e671 100644
--- a/src/pcm/pcm.c
+++ b/src/pcm/pcm.c
@@ -5610,6 +5610,7 @@ int snd_pcm_sw_params_current(snd_pcm_t *pcm, snd_pcm_sw_params_t *params)
 		SNDMSG("PCM not set up");
 		return -EIO;
 	}
+	params->proto = SNDRV_PCM_VERSION;
 	params->tstamp_mode = pcm->tstamp_mode;
 	params->tstamp_type = pcm->tstamp_type;
 	params->period_step = pcm->period_step;
diff --git a/src/pcm/pcm_params.c b/src/pcm/pcm_params.c
index 4adbefae0530..6e57904e445b 100644
--- a/src/pcm/pcm_params.c
+++ b/src/pcm/pcm_params.c
@@ -2257,6 +2257,7 @@ static int snd_pcm_sw_params_default(snd_pcm_t *pcm, snd_pcm_sw_params_t *params
 {
 	assert(pcm && params);
 	assert(pcm->setup);
+	params->proto = SNDRV_PCM_VERSION;
 	params->tstamp_mode = SND_PCM_TSTAMP_NONE;
 	params->tstamp_type = pcm->tstamp_type;
 	params->period_step = 1;
-- 
2.0.1
