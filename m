From: Andrea Gelmini <andrea.gelmini@gelma.net>
Subject: [PATCH 48/66] sound/usb/caiaq/midi.h: Checkpatch cleanup
Date: Sat, 27 Feb 2010 17:51:29 +0100
Message-ID: <1267289508-31031-49-git-send-email-andrea.gelmini@gelma.net>
References: <1267289508-31031-1-git-send-email-andrea.gelmini@gelma.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1267289508-31031-1-git-send-email-andrea.gelmini@gelma.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Andrea Gelmini <andrea.gelmini@gelma.net>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Daniel Mack <daniel@caiaq.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

sound/usb/caiaq/midi.h:6: ERROR: "foo* bar" should be "foo *bar"

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 sound/usb/caiaq/midi.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/usb/caiaq/midi.h b/sound/usb/caiaq/midi.h
index 9d16db0..380f984 100644
--- a/sound/usb/caiaq/midi.h
+++ b/sound/usb/caiaq/midi.h
@@ -3,6 +3,6 @@
 
 int snd_usb_caiaq_midi_init(struct snd_usb_caiaqdev *dev);
 void snd_usb_caiaq_midi_handle_input(struct snd_usb_caiaqdev *dev, int port, const char *buf, int len);
-void snd_usb_caiaq_midi_output_done(struct urb* urb);
+void snd_usb_caiaq_midi_output_done(struct urb *urb);
 
 #endif /* CAIAQ_MIDI_H */
-- 
1.7.0.90.g251a4
