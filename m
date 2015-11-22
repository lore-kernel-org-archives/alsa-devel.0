From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH] [ALSA] midi: constify snd_rawmidi_global_ops structures
Date: Sun, 22 Nov 2015 08:55:07 +0100
Message-ID: <1448178907-18682-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.com>
Cc: kernel-janitors@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

The snd_rawmidi_global_ops structures are never modified, so declare them
as const.

Done with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 include/sound/rawmidi.h      |    2 +-
 sound/core/seq/seq_virmidi.c |    2 +-
 sound/usb/midi.c             |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/sound/rawmidi.h b/include/sound/rawmidi.h
index f6cbef7..fdabbb4 100644
--- a/include/sound/rawmidi.h
+++ b/include/sound/rawmidi.h
@@ -130,7 +130,7 @@ struct snd_rawmidi {
 	int ossreg;
 #endif
 
-	struct snd_rawmidi_global_ops *ops;
+	const struct snd_rawmidi_global_ops *ops;
 
 	struct snd_rawmidi_str streams[2];
 
diff --git a/sound/core/seq/seq_virmidi.c b/sound/core/seq/seq_virmidi.c
index 56e0f4cd..3da2d48 100644
--- a/sound/core/seq/seq_virmidi.c
+++ b/sound/core/seq/seq_virmidi.c
@@ -468,7 +468,7 @@ static int snd_virmidi_dev_unregister(struct snd_rawmidi *rmidi)
 /*
  *
  */
-static struct snd_rawmidi_global_ops snd_virmidi_global_ops = {
+static const struct snd_rawmidi_global_ops snd_virmidi_global_ops = {
 	.dev_register = snd_virmidi_dev_register,
 	.dev_unregister = snd_virmidi_dev_unregister,
 };
diff --git a/sound/usb/midi.c b/sound/usb/midi.c
index 5b4c58c..ee212e7 100644
--- a/sound/usb/midi.c
+++ b/sound/usb/midi.c
@@ -2206,7 +2206,7 @@ static int snd_usbmidi_create_endpoints_midiman(struct snd_usb_midi *umidi,
 	return 0;
 }
 
-static struct snd_rawmidi_global_ops snd_usbmidi_ops = {
+static const struct snd_rawmidi_global_ops snd_usbmidi_ops = {
 	.get_port_info = snd_usbmidi_get_port_info,
 };
 
