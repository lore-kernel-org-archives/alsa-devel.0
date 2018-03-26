From: Robert Rosengren <robert.rosengren@axis.com>
Subject: [PATCH] ALSA: aloop: Mark paused device as inactive
Date: Mon, 26 Mar 2018 07:24:49 +0200
Message-ID: <20180326052449.3618-1-robertr@axis.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, Robert Rosengren <robertr@axis.com>
List-Id: alsa-devel@alsa-project.org

Show paused ALSA aloop device as inactive, i.e. the control
"PCM Slave Active" set as false. Notification sent upon state change.

This makes it possible for client capturing from aloop device to know if
data is expected. Without it the client expects data even if playback
is paused.

Signed-off-by: Robert Rosengren <robertr@axis.com>
---
 sound/drivers/aloop.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/sound/drivers/aloop.c b/sound/drivers/aloop.c
index 0333143a1fa7..5404ab11132d 100644
--- a/sound/drivers/aloop.c
+++ b/sound/drivers/aloop.c
@@ -291,6 +291,8 @@ static int loopback_trigger(struct snd_pcm_substream *substream, int cmd)
 		cable->pause |= stream;
 		loopback_timer_stop(dpcm);
 		spin_unlock(&cable->lock);
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+			loopback_active_notify(dpcm);
 		break;
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 	case SNDRV_PCM_TRIGGER_RESUME:
@@ -299,6 +301,8 @@ static int loopback_trigger(struct snd_pcm_substream *substream, int cmd)
 		cable->pause &= ~stream;
 		loopback_timer_start(dpcm);
 		spin_unlock(&cable->lock);
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+			loopback_active_notify(dpcm);
 		break;
 	default:
 		return -EINVAL;
@@ -879,9 +883,11 @@ static int loopback_active_get(struct snd_kcontrol *kcontrol,
 			[kcontrol->id.subdevice][kcontrol->id.device ^ 1];
 	unsigned int val = 0;
 
-	if (cable != NULL)
-		val = (cable->running & (1 << SNDRV_PCM_STREAM_PLAYBACK)) ?
-									1 : 0;
+	if (cable != NULL) {
+		unsigned int running = cable->running ^ cable->pause;
+
+		val = (running & (1 << SNDRV_PCM_STREAM_PLAYBACK)) ? 1 : 0;
+	}
 	ucontrol->value.integer.value[0] = val;
 	return 0;
 }
-- 
2.11.0
