From: Eldad Zack <eldad@fogrefinery.com>
Subject: [PATCH v3 03/11] ALSA: usb-audio: prevent NULL
	dereference on stop trigger
Date: Sun, 25 Aug 2013 17:43:11 +0200
Message-ID: <1377445399-5678-4-git-send-email-eldad@fogrefinery.com>
References: <1377445399-5678-1-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f46.google.com (mail-bk0-f46.google.com
 [209.85.214.46])
 by alsa0.perex.cz (Postfix) with ESMTP id D91012619D5
 for <alsa-devel@alsa-project.org>; Sun, 25 Aug 2013 17:43:40 +0200 (CEST)
Received: by mail-bk0-f46.google.com with SMTP id 6so788336bkj.5
 for <alsa-devel@alsa-project.org>; Sun, 25 Aug 2013 08:43:40 -0700 (PDT)
In-Reply-To: <1377445399-5678-1-git-send-email-eldad@fogrefinery.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>, Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, Eldad Zack <eldad@fogrefinery.com>
List-Id: alsa-devel@alsa-project.org

If an endpoint uses another endpoint for synchronization, and the
other endpoint is stopped, an oops will occur on NULL dereference.
Clearing the prepare/retire callbacks solves this issue.

v2: Thanks to Daniel Mack, fixed (an irnoic) NULL dereference when
the pcm substream is opened and closed immediately.

Signed-off-by: Eldad Zack <eldad@fogrefinery.com>
---
 sound/usb/pcm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index 9ec401a..4227d34 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -1199,6 +1199,11 @@ static int snd_usb_pcm_close(struct snd_pcm_substream *substream, int direction)
 		subs->interface = -1;
 	}
 
+	if (subs->data_endpoint) {
+		subs->data_endpoint->prepare_data_urb = NULL;
+		subs->data_endpoint->retire_data_urb = NULL;
+	}
+
 	subs->pcm_substream = NULL;
 	snd_usb_autosuspend(subs->stream->chip);
 
@@ -1525,6 +1530,8 @@ static int snd_usb_substream_playback_trigger(struct snd_pcm_substream *substrea
 		subs->running = 1;
 		return 0;
 	case SNDRV_PCM_TRIGGER_STOP:
+		subs->data_endpoint->prepare_data_urb = NULL;
+		subs->data_endpoint->retire_data_urb = NULL;
 		stop_endpoints(subs, false);
 		subs->running = 0;
 		return 0;
@@ -1555,6 +1562,7 @@ static int snd_usb_substream_capture_trigger(struct snd_pcm_substream *substream
 		subs->running = 1;
 		return 0;
 	case SNDRV_PCM_TRIGGER_STOP:
+		subs->data_endpoint->retire_data_urb = NULL;
 		stop_endpoints(subs, false);
 		subs->running = 0;
 		return 0;
-- 
1.8.1.5
