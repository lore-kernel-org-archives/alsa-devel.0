From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH v2 1/2] ALSA: pcm: Introduce protocol version
	field to sw_params
Date: Mon, 21 Jul 2014 13:51:36 +0200
Message-ID: <1405943497-3482-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id C9D56265314
 for <alsa-devel@alsa-project.org>; Mon, 21 Jul 2014 13:51:37 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 8DF82AD75
 for <alsa-devel@alsa-project.org>; Mon, 21 Jul 2014 11:51:37 +0000 (UTC)
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

For controlling the new fields more strictly, add sw_params.proto
field indicating the protocol version of the user-space.  User-space
should fill the SNDRV_PCM_VERSION value it's built with, then kernel
can know whether the new fields should be evaluated or not.

And now tstamp_type field is evaluated only when the valid value is
set there.  This avoids the wrong override of tstamp_type to zero,
which is SNDRV_PCM_TSTAMP_TYPE_GETTIMEOFDAY.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
v1->v2: rearrange the order of proto and tstamp_type fields

 include/uapi/sound/asound.h | 4 ++--
 sound/core/pcm_native.c     | 6 ++++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
index a7e062f91f39..32168f7ffce3 100644
--- a/include/uapi/sound/asound.h
+++ b/include/uapi/sound/asound.h
@@ -391,8 +391,8 @@ struct snd_pcm_sw_params {
 	snd_pcm_uframes_t silence_threshold;	/* min distance from noise for silence filling */
 	snd_pcm_uframes_t silence_size;		/* silence block size */
 	snd_pcm_uframes_t boundary;		/* pointers wrap point */
-	unsigned int tstamp_type;		/* timestamp type */
-	int pads;				/* alignment, reserved */
+	unsigned int proto;			/* protocol version */
+	unsigned int tstamp_type;		/* timestamp type (req. proto >= 2.0.12) */
 	unsigned char reserved[56];		/* reserved for future */
 };
 
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 81dedc381efd..8cd2f930ad0b 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -543,7 +543,8 @@ static int snd_pcm_sw_params(struct snd_pcm_substream *substream,
 
 	if (params->tstamp_mode > SNDRV_PCM_TSTAMP_LAST)
 		return -EINVAL;
-	if (params->tstamp_type > SNDRV_PCM_TSTAMP_TYPE_LAST)
+	if (params->proto >= SNDRV_PROTOCOL_VERSION(2, 0, 12) &&
+	    params->tstamp_type > SNDRV_PCM_TSTAMP_TYPE_LAST)
 		return -EINVAL;
 	if (params->avail_min == 0)
 		return -EINVAL;
@@ -559,7 +560,8 @@ static int snd_pcm_sw_params(struct snd_pcm_substream *substream,
 	err = 0;
 	snd_pcm_stream_lock_irq(substream);
 	runtime->tstamp_mode = params->tstamp_mode;
-	runtime->tstamp_type = params->tstamp_type;
+	if (params->proto >= SNDRV_PROTOCOL_VERSION(2, 0, 12))
+		runtime->tstamp_type = params->tstamp_type;
 	runtime->period_step = params->period_step;
 	runtime->control->avail_min = params->avail_min;
 	runtime->start_threshold = params->start_threshold;
-- 
2.0.1
