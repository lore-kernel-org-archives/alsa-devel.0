From: Andrea Gelmini <andrea.gelmini@gelma.net>
Subject: [PATCH 22/66] sound/oss/v_midi.h: Checkpatch cleanup
Date: Sat, 27 Feb 2010 17:51:03 +0100
Message-ID: <1267289508-31031-23-git-send-email-andrea.gelmini@gelma.net>
References: <1267289508-31031-1-git-send-email-andrea.gelmini@gelma.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1267289508-31031-1-git-send-email-andrea.gelmini@gelma.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Andrea Gelmini <andrea.gelmini@gelma.net>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

sound/oss/v_midi.h:5: ERROR: code indent should use tabs where possible
sound/oss/v_midi.h:7: ERROR: trailing whitespace

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 sound/oss/v_midi.h |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/oss/v_midi.h b/sound/oss/v_midi.h
index 1b86cb4..08e2185 100644
--- a/sound/oss/v_midi.h
+++ b/sound/oss/v_midi.h
@@ -2,9 +2,9 @@ typedef struct vmidi_devc {
 	   int dev;
 
 	/* State variables */
- 	   int opened;
+	   int opened;
 	   spinlock_t lock;
-	
+
 	/* MIDI fields */
 	   int my_mididev;
 	   int pair_mididev;
@@ -12,4 +12,3 @@ typedef struct vmidi_devc {
 	   int intr_active;
 	   void (*midi_input_intr) (int dev, unsigned char data);
 	} vmidi_devc;
-
-- 
1.7.0.90.g251a4
