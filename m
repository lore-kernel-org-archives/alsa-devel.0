From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5/5] ALSA: line6: Handle error from
	line6_pcm_acquire()
Date: Tue, 27 Jan 2015 17:13:17 +0100
Message-ID: <1422375197-17293-6-git-send-email-tiwai@suse.de>
References: <1422375197-17293-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 6C2B9260A5B
 for <alsa-devel@alsa-project.org>; Tue, 27 Jan 2015 17:13:19 +0100 (CET)
In-Reply-To: <1422375197-17293-1-git-send-email-tiwai@suse.de>
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

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/line6/pcm.c      | 13 ++++++++++---
 sound/usb/line6/toneport.c | 13 ++++++++++---
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/sound/usb/line6/pcm.c b/sound/usb/line6/pcm.c
index 73c87467d2e0..8461d6bf992f 100644
--- a/sound/usb/line6/pcm.c
+++ b/sound/usb/line6/pcm.c
@@ -45,15 +45,22 @@ static int snd_line6_impulse_volume_put(struct snd_kcontrol *kcontrol,
 {
 	struct snd_line6_pcm *line6pcm = snd_kcontrol_chip(kcontrol);
 	int value = ucontrol->value.integer.value[0];
+	int err;
 
 	if (line6pcm->impulse_volume == value)
 		return 0;
 
 	line6pcm->impulse_volume = value;
-	if (value > 0)
-		line6_pcm_acquire(line6pcm, LINE6_STREAM_IMPULSE);
-	else
+	if (value > 0) {
+		err = line6_pcm_acquire(line6pcm, LINE6_STREAM_IMPULSE);
+		if (err < 0) {
+			line6pcm->impulse_volume = 0;
+			line6_pcm_release(line6pcm, LINE6_STREAM_IMPULSE);
+			return err;
+		}
+	} else {
 		line6_pcm_release(line6pcm, LINE6_STREAM_IMPULSE);
+	}
 	return 1;
 }
 
diff --git a/sound/usb/line6/toneport.c b/sound/usb/line6/toneport.c
index 61fa6256d7b0..819e06b3f3db 100644
--- a/sound/usb/line6/toneport.c
+++ b/sound/usb/line6/toneport.c
@@ -182,16 +182,23 @@ static int snd_toneport_monitor_put(struct snd_kcontrol *kcontrol,
 				    struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_line6_pcm *line6pcm = snd_kcontrol_chip(kcontrol);
+	int err;
 
 	if (ucontrol->value.integer.value[0] == line6pcm->volume_monitor)
 		return 0;
 
 	line6pcm->volume_monitor = ucontrol->value.integer.value[0];
 
-	if (line6pcm->volume_monitor > 0)
-		line6_pcm_acquire(line6pcm, LINE6_STREAM_MONITOR);
-	else
+	if (line6pcm->volume_monitor > 0) {
+		err = line6_pcm_acquire(line6pcm, LINE6_STREAM_MONITOR);
+		if (err < 0) {
+			line6pcm->volume_monitor = 0;
+			line6_pcm_release(line6pcm, LINE6_STREAM_MONITOR);
+			return err;
+		}
+	} else {
 		line6_pcm_release(line6pcm, LINE6_STREAM_MONITOR);
+	}
 
 	return 1;
 }
-- 
2.2.2
