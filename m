From: Eldad Zack <eldad@fogrefinery.com>
Subject: [PATCH RFC 3/9] ALSA: usb-audio: prevent NULL
	dereference on stop trigger
Date: Sun, 18 Aug 2013 22:22:37 +0200
Message-ID: <1376857363-1116-4-git-send-email-eldad@fogrefinery.com>
References: <1376857363-1116-1-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f53.google.com (mail-bk0-f53.google.com
 [209.85.214.53])
 by alsa0.perex.cz (Postfix) with ESMTP id 8FFC0261616
 for <alsa-devel@alsa-project.org>; Sun, 18 Aug 2013 22:23:07 +0200 (CEST)
Received: by mail-bk0-f53.google.com with SMTP id d7so1217887bkh.12
 for <alsa-devel@alsa-project.org>; Sun, 18 Aug 2013 13:23:07 -0700 (PDT)
In-Reply-To: <1376857363-1116-1-git-send-email-eldad@fogrefinery.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, Daniel Mack <zonque@gmail.com>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Eldad Zack <eldad@fogrefinery.com>
List-Id: alsa-devel@alsa-project.org

If an endpoint uses another endpoint for synchronization, and the
other endpoint is stopped, an oops will occur on NULL dereference.
Clearing the prepare/retire callbacks solves this issue.

Signed-off-by: Eldad Zack <eldad@fogrefinery.com>

---
Note sure if the oops happens because of pcm_stream is NULLified, or
somewhere else. Needs a closer look.

I suspect this condition does not happen in practice since the call to
snd_usb_endpoint_deactivate() will unconditionally deactivate the URBs.
---
 sound/usb/pcm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index f612c4e..aa1e21f 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -1166,6 +1166,8 @@ static int snd_usb_pcm_close(struct snd_pcm_substream *substream, int direction)
 		subs->interface = -1;
 	}
 
+	subs->data_endpoint->prepare_data_urb = NULL;
+	subs->data_endpoint->retire_data_urb = NULL;
 	subs->pcm_substream = NULL;
 	snd_usb_autosuspend(subs->stream->chip);
 
@@ -1492,6 +1494,8 @@ static int snd_usb_substream_playback_trigger(struct snd_pcm_substream *substrea
 		subs->running = 1;
 		return 0;
 	case SNDRV_PCM_TRIGGER_STOP:
+		subs->data_endpoint->prepare_data_urb = NULL;
+		subs->data_endpoint->retire_data_urb = NULL;
 		stop_endpoints(subs, false);
 		subs->running = 0;
 		return 0;
@@ -1522,6 +1526,7 @@ static int snd_usb_substream_capture_trigger(struct snd_pcm_substream *substream
 		subs->running = 1;
 		return 0;
 	case SNDRV_PCM_TRIGGER_STOP:
+		subs->data_endpoint->retire_data_urb = NULL;
 		stop_endpoints(subs, false);
 		subs->running = 0;
 		return 0;
-- 
1.8.1.5
