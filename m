From: Masanari Iida <standby24x7@gmail.com>
Subject: [PATCH] sound: core: Fix format string mismatch in seq_midi.c
Date: Tue, 22 Apr 2014 20:42:05 +0900
Message-ID: <1398166925-26412-1-git-send-email-standby24x7@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tiwai@suse.de, perex@perex.cz, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc: Masanari Iida <standby24x7@gmail.com>
List-Id: alsa-devel@alsa-project.org

Fix format string mismatch in snd_seq_midisynth_register_port().
Argument type of p is unsigned int.

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 sound/core/seq/seq_midi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/core/seq/seq_midi.c b/sound/core/seq/seq_midi.c
index 3e05c55..a1fd77a 100644
--- a/sound/core/seq/seq_midi.c
+++ b/sound/core/seq/seq_midi.c
@@ -362,13 +362,13 @@ snd_seq_midisynth_register_port(struct snd_seq_device *dev)
 		if (! port->name[0]) {
 			if (info->name[0]) {
 				if (ports > 1)
-					snprintf(port->name, sizeof(port->name), "%s-%d", info->name, p);
+					snprintf(port->name, sizeof(port->name), "%s-%u", info->name, p);
 				else
 					snprintf(port->name, sizeof(port->name), "%s", info->name);
 			} else {
 				/* last resort */
 				if (ports > 1)
-					sprintf(port->name, "MIDI %d-%d-%d", card->number, device, p);
+					sprintf(port->name, "MIDI %d-%d-%u", card->number, device, p);
 				else
 					sprintf(port->name, "MIDI %d-%d", card->number, device);
 			}
-- 
2.0.0.rc0.26.g779792a
