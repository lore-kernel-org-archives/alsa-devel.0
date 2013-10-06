From: Eldad Zack <eldad@fogrefinery.com>
Subject: [PATCH v4 03/15] ALSA: usb-audio: prevent NULL
	dereference on stop trigger
Date: Sun,  6 Oct 2013 22:31:08 +0200
Message-ID: <1381091480-23636-4-git-send-email-eldad@fogrefinery.com>
References: <1381091480-23636-1-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f45.google.com (mail-bk0-f45.google.com
 [209.85.214.45])
 by alsa0.perex.cz (Postfix) with ESMTP id A306F261A60
 for <alsa-devel@alsa-project.org>; Sun,  6 Oct 2013 22:31:29 +0200 (CEST)
Received: by mail-bk0-f45.google.com with SMTP id mx11so2349829bkb.32
 for <alsa-devel@alsa-project.org>; Sun, 06 Oct 2013 13:31:29 -0700 (PDT)
In-Reply-To: <1381091480-23636-1-git-send-email-eldad@fogrefinery.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>, Daniel Mack <zonque@gmail.com>, Nikolay Martynov <mar.kolya@gmail.com>
Cc: alsa-devel@alsa-project.org, Eldad Zack <eldad@fogrefinery.com>
List-Id: alsa-devel@alsa-project.org

If an endpoint uses another endpoint for synchronization, and the
other endpoint is stopped, an oops will occur on NULL dereference.
Clearing the prepare/retire callbacks solves this issue.

v2: Thanks to Daniel Mack, fixed (an ironic) NULL dereference when
the pcm substream is opened and closed immediately.

Signed-off-by: Eldad Zack <eldad@fogrefinery.com>
---
 sound/usb/pcm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index 1a9a018..525bc8c 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -1205,6 +1205,11 @@ static int snd_usb_pcm_close(struct snd_pcm_substream *substream, int direction)
 		subs->interface = -1;
 	}
 
+	if (subs->data_endpoint) {
+		subs->data_endpoint->prepare_data_urb = NULL;
+		subs->data_endpoint->retire_data_urb = NULL;
+	}
+
 	subs->pcm_substream = NULL;
 	snd_usb_autosuspend(subs->stream->chip);
 
@@ -1535,6 +1540,8 @@ static int snd_usb_substream_playback_trigger(struct snd_pcm_substream *substrea
 		subs->running = 1;
 		return 0;
 	case SNDRV_PCM_TRIGGER_STOP:
+		subs->data_endpoint->prepare_data_urb = NULL;
+		subs->data_endpoint->retire_data_urb = NULL;
 		stop_endpoints(subs, false);
 		subs->running = 0;
 		return 0;
@@ -1565,6 +1572,7 @@ static int snd_usb_substream_capture_trigger(struct snd_pcm_substream *substream
 		subs->running = 1;
 		return 0;
 	case SNDRV_PCM_TRIGGER_STOP:
+		subs->data_endpoint->retire_data_urb = NULL;
 		stop_endpoints(subs, false);
 		subs->running = 0;
 		return 0;
-- 
1.8.1.5
