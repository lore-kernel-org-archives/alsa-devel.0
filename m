From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH] ALSA: snd-usb: fix stream info output in /proc
Date: Mon, 21 May 2012 12:47:36 +0200
Message-ID: <1337597256-23860-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bugwerft.de (unknown [212.112.241.193])
	by alsa0.perex.cz (Postfix) with ESMTP id C3D50243C8
	for <alsa-devel@alsa-project.org>;
	Mon, 21 May 2012 12:46:52 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, clemens@ladisch.de, linuxaudio@showlabor.de, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Set some substream struct members to make the proc interface code work
again.

Signed-off-by: Daniel Mack <zonque@gmail.com>
Reported-by: Felix Homann <linuxaudio@showlabor.de>
---
 sound/usb/pcm.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index 2d3a04d..24839d9 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -474,6 +474,11 @@ unlock:
 		mutex_unlock(&subs->stream->chip->shutdown_mutex);
 	}
 
+	if (ret == 0) {
+		subs->interface = fmt->iface;
+		subs->altset_idx = fmt->altset_idx;
+	}
+
 	return ret;
 }
 
@@ -1123,13 +1128,16 @@ static int snd_usb_substream_playback_trigger(struct snd_pcm_substream *substrea
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 		subs->data_endpoint->prepare_data_urb = prepare_playback_urb;
 		subs->data_endpoint->retire_data_urb = retire_playback_urb;
+		subs->running = 1;
 		return 0;
 	case SNDRV_PCM_TRIGGER_STOP:
 		stop_endpoints(subs, 0, 0, 0);
+		subs->running = 0;
 		return 0;
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 		subs->data_endpoint->prepare_data_urb = NULL;
 		subs->data_endpoint->retire_data_urb = NULL;
+		subs->running = 0;
 		return 0;
 	}
 
@@ -1148,15 +1156,19 @@ int snd_usb_substream_capture_trigger(struct snd_pcm_substream *substream, int c
 			return err;
 
 		subs->data_endpoint->retire_data_urb = retire_capture_urb;
+		subs->running = 1;
 		return 0;
 	case SNDRV_PCM_TRIGGER_STOP:
 		stop_endpoints(subs, 0, 0, 0);
+		subs->running = 0;
 		return 0;
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 		subs->data_endpoint->retire_data_urb = NULL;
+		subs->running = 0;
 		return 0;
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 		subs->data_endpoint->retire_data_urb = retire_capture_urb;
+		subs->running = 1;
 		return 0;
 	}
 
-- 
1.7.5.4
