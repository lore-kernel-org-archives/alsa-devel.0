From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 16/16] ALSA: line6: Skip volume manipulation
	during silence copying
Date: Fri, 23 Jan 2015 18:13:23 +0100
Message-ID: <1422033203-23254-17-git-send-email-tiwai@suse.de>
References: <1422033203-23254-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 9EEE8265519
 for <alsa-devel@alsa-project.org>; Fri, 23 Jan 2015 18:13:41 +0100 (CET)
In-Reply-To: <1422033203-23254-1-git-send-email-tiwai@suse.de>
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Chris Rorvick <chris@rorvick.com>
List-Id: alsa-devel@alsa-project.org

A minor optimization; while pausing, the driver just copies the zero
that doesn't need any volume changes.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/line6/playback.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/usb/line6/playback.c b/sound/usb/line6/playback.c
index cbcd97f5d629..3762a98026aa 100644
--- a/sound/usb/line6/playback.c
+++ b/sound/usb/line6/playback.c
@@ -234,13 +234,14 @@ static int submit_audio_out_urb(struct snd_line6_pcm *line6pcm)
 		line6pcm->out.pos += urb_frames;
 		if (line6pcm->out.pos >= runtime->buffer_size)
 			line6pcm->out.pos -= runtime->buffer_size;
+
+		change_volume(urb_out, line6pcm->volume_playback,
+			      bytes_per_frame);
 	} else {
 		memset(urb_out->transfer_buffer, 0,
 		       urb_out->transfer_buffer_length);
 	}
 
-	change_volume(urb_out, line6pcm->volume_playback, bytes_per_frame);
-
 	if (line6pcm->prev_fbuf != NULL) {
 		if (line6pcm->flags & LINE6_BITS_PCM_IMPULSE) {
 			create_impulse_test_signal(line6pcm, urb_out,
-- 
2.2.2
