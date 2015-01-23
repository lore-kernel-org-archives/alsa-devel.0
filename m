From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 09/16] ALSA: line6: Use incremental loop
Date: Fri, 23 Jan 2015 18:13:16 +0100
Message-ID: <1422033203-23254-10-git-send-email-tiwai@suse.de>
References: <1422033203-23254-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A2076265529
 for <alsa-devel@alsa-project.org>; Fri, 23 Jan 2015 18:13:42 +0100 (CET)
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

Using a decremental loop without particular reasons worsens the
readability a lot.  Use incremental loops instead.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/line6/capture.c  |  4 ++--
 sound/usb/line6/pcm.c      |  6 +++---
 sound/usb/line6/playback.c | 12 ++++++------
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/sound/usb/line6/capture.c b/sound/usb/line6/capture.c
index 5a010ba163fa..97283e631e45 100644
--- a/sound/usb/line6/capture.c
+++ b/sound/usb/line6/capture.c
@@ -91,7 +91,7 @@ void line6_unlink_audio_in_urbs(struct snd_line6_pcm *line6pcm)
 {
 	unsigned int i;
 
-	for (i = LINE6_ISO_BUFFERS; i--;) {
+	for (i = 0; i < LINE6_ISO_BUFFERS; i++) {
 		if (test_bit(i, &line6pcm->active_urb_in)) {
 			if (!test_and_set_bit(i, &line6pcm->unlink_urb_in)) {
 				struct urb *u = line6pcm->urb_audio_in[i];
@@ -114,7 +114,7 @@ void line6_wait_clear_audio_in_urbs(struct snd_line6_pcm *line6pcm)
 
 	do {
 		alive = 0;
-		for (i = LINE6_ISO_BUFFERS; i--;) {
+		for (i = 0; i < LINE6_ISO_BUFFERS; i++) {
 			if (test_bit(i, &line6pcm->active_urb_in))
 				alive++;
 		}
diff --git a/sound/usb/line6/pcm.c b/sound/usb/line6/pcm.c
index adbcac46b785..43474c4ebb6b 100644
--- a/sound/usb/line6/pcm.c
+++ b/sound/usb/line6/pcm.c
@@ -273,7 +273,7 @@ static int snd_line6_control_playback_get(struct snd_kcontrol *kcontrol,
 	int i;
 	struct snd_line6_pcm *line6pcm = snd_kcontrol_chip(kcontrol);
 
-	for (i = 2; i--;)
+	for (i = 0; i < 2; i++)
 		ucontrol->value.integer.value[i] = line6pcm->volume_playback[i];
 
 	return 0;
@@ -286,7 +286,7 @@ static int snd_line6_control_playback_put(struct snd_kcontrol *kcontrol,
 	int i, changed = 0;
 	struct snd_line6_pcm *line6pcm = snd_kcontrol_chip(kcontrol);
 
-	for (i = 2; i--;)
+	for (i = 0; i < 2; i++)
 		if (line6pcm->volume_playback[i] !=
 		    ucontrol->value.integer.value[i]) {
 			line6pcm->volume_playback[i] =
@@ -330,7 +330,7 @@ static void line6_cleanup_pcm(struct snd_pcm *pcm)
 	int i;
 	struct snd_line6_pcm *line6pcm = snd_pcm_chip(pcm);
 
-	for (i = LINE6_ISO_BUFFERS; i--;) {
+	for (i = 0; i < LINE6_ISO_BUFFERS; i++) {
 		if (line6pcm->urb_audio_out[i]) {
 			usb_kill_urb(line6pcm->urb_audio_out[i]);
 			usb_free_urb(line6pcm->urb_audio_out[i]);
diff --git a/sound/usb/line6/playback.c b/sound/usb/line6/playback.c
index 1c9f95a370ff..ab9a83f0f864 100644
--- a/sound/usb/line6/playback.c
+++ b/sound/usb/line6/playback.c
@@ -297,7 +297,7 @@ void line6_unlink_audio_out_urbs(struct snd_line6_pcm *line6pcm)
 {
 	unsigned int i;
 
-	for (i = LINE6_ISO_BUFFERS; i--;) {
+	for (i = 0; i < LINE6_ISO_BUFFERS; i++) {
 		if (test_bit(i, &line6pcm->active_urb_out)) {
 			if (!test_and_set_bit(i, &line6pcm->unlink_urb_out)) {
 				struct urb *u = line6pcm->urb_audio_out[i];
@@ -320,7 +320,7 @@ void line6_wait_clear_audio_out_urbs(struct snd_line6_pcm *line6pcm)
 
 	do {
 		alive = 0;
-		for (i = LINE6_ISO_BUFFERS; i--;) {
+		for (i = 0; i < LINE6_ISO_BUFFERS; i++) {
 			if (test_bit(i, &line6pcm->active_urb_out))
 				alive++;
 		}
@@ -366,14 +366,14 @@ static void audio_out_callback(struct urb *urb)
 	line6pcm->last_frame_out = urb->start_frame;
 
 	/* find index of URB */
-	for (index = LINE6_ISO_BUFFERS; index--;)
+	for (index = 0; index < LINE6_ISO_BUFFERS; index++)
 		if (urb == line6pcm->urb_audio_out[index])
 			break;
 
-	if (index < 0)
+	if (index >= LINE6_ISO_BUFFERS)
 		return;		/* URB has been unlinked asynchronously */
 
-	for (i = LINE6_ISO_PACKETS; i--;)
+	for (i = 0; i < LINE6_ISO_PACKETS; i++)
 		length += urb->iso_frame_desc[i].length;
 
 	spin_lock_irqsave(&line6pcm->lock_audio_out, flags);
@@ -390,7 +390,7 @@ static void audio_out_callback(struct urb *urb)
 
 	clear_bit(index, &line6pcm->active_urb_out);
 
-	for (i = LINE6_ISO_PACKETS; i--;)
+	for (i = 0; i < LINE6_ISO_PACKETS; i++)
 		if (urb->iso_frame_desc[i].status == -EXDEV) {
 			shutdown = 1;
 			break;
-- 
2.2.2
