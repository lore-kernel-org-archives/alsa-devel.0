From: Eldad Zack <eldad@fogrefinery.com>
Subject: [PATCH v4 13/15] ALSA: usb-audio: clear sync subs
	hw_params
Date: Sun,  6 Oct 2013 22:31:18 +0200
Message-ID: <1381091480-23636-14-git-send-email-eldad@fogrefinery.com>
References: <1381091480-23636-1-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f49.google.com (mail-bk0-f49.google.com
 [209.85.214.49])
 by alsa0.perex.cz (Postfix) with ESMTP id 56BF8261AA3
 for <alsa-devel@alsa-project.org>; Sun,  6 Oct 2013 22:31:43 +0200 (CEST)
Received: by mail-bk0-f49.google.com with SMTP id r7so2242098bkg.8
 for <alsa-devel@alsa-project.org>; Sun, 06 Oct 2013 13:31:42 -0700 (PDT)
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

If the snd_usb_substream associated with the sync endpoint is
not in use as a data endpoint, clear its hw_params.

For implicit feedback, this prevents a failure condition when the
capture substream is closed while the playback substream is open
(here the capture substream does not clear its parameters, since
use_count is 1), the playback is then closed and capture is opened
again. The code will then assume that the endpoint is already
running and will fail later.

Instead of just using the use_count of the endpoint, add a usage bit
to the struct to track if the substream is opened, to allow clearing
the parameters of the other substream if and only if it is not opened.

This flag must be set as soon as the substream is opened, since
the endpoint is started only later (at prepare).

Also group together the bit flags.

Signed-off-by: Eldad Zack <eldad@fogrefinery.com>
---
 sound/usb/card.h |  5 +++--
 sound/usb/pcm.c  | 27 ++++++++++++++++++++++-----
 2 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/sound/usb/card.h b/sound/usb/card.h
index eb38b0a..d9cb674 100644
--- a/sound/usb/card.h
+++ b/sound/usb/card.h
@@ -120,11 +120,12 @@ struct snd_usb_substream {
 	unsigned int period_bytes;	/* current period bytes (for hw_params callback) */
 	unsigned int period_frames;	/* current frames per period */
 	unsigned int buffer_periods;	/* current periods per buffer */
-	unsigned int txfr_quirk:1;	/* allow sub-frame alignment */
 	unsigned int fmt_type;		/* USB audio format type (1-3) */
 	unsigned int pkt_offset_adj;	/* Bytes to drop from beginning of packets (for non-compliant devices) */
 
-	unsigned int running: 1;	/* running status */
+	unsigned int txfr_quirk:1;	/* allow sub-frame alignment */
+	unsigned int running:1;		/* running status */
+	unsigned int used:1;		/* substream used */
 
 	unsigned int hwptr_done;	/* processed byte position in the buffer */
 	unsigned int transfer_done;		/* processed frames since last period update */
diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index 8854ee5..7ca9b47 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -786,6 +786,20 @@ static int snd_usb_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
+static void clear_substream(struct snd_usb_substream *subs)
+{
+	if (subs->used != 0)
+		return;
+
+	if (subs->data_endpoint && subs->data_endpoint->use_count != 0)
+		return;
+
+	subs->cur_audiofmt = NULL;
+	subs->cur_rate = 0;
+	subs->period_bytes = 0;
+	subs->channels = 0;
+}
+
 /*
  * hw_free callback
  *
@@ -795,11 +809,13 @@ static int snd_usb_hw_free(struct snd_pcm_substream *substream)
 {
 	struct snd_usb_substream *subs = substream->runtime->private_data;
 
-	if (!subs->data_endpoint || subs->data_endpoint->use_count == 0) {
-		subs->cur_audiofmt = NULL;
-		subs->cur_rate = 0;
-		subs->period_bytes = 0;
-		subs->channels = 0;
+	subs->used = 0;
+	clear_substream(subs);
+
+	if (subs->sync_endpoint) {
+		struct snd_usb_substream *sync_subs =
+			&subs->stream->substream[subs->direction ^ 1];
+		clear_substream(sync_subs);
 	}
 
 	down_read(&subs->stream->chip->shutdown_rwsem);
@@ -1264,6 +1280,7 @@ static int snd_usb_pcm_open(struct snd_pcm_substream *substream, int direction)
 	struct snd_usb_substream *subs = &as->substream[direction];
 
 	subs->interface = -1;
+	subs->used = 1;
 	runtime->hw = snd_usb_hardware;
 	runtime->private_data = subs;
 	subs->pcm_substream = substream;
-- 
1.8.1.5
