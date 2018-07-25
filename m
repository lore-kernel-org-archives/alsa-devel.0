From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 07/12] ALSA: opl3: Declare common variables
	properly
Date: Wed, 25 Jul 2018 23:00:52 +0200
Message-ID: <20180725210057.18017-8-tiwai@suse.de>
References: <20180725210057.18017-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id B0BDE267786
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 23:01:05 +0200 (CEST)
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id AC03EB0A5
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 21:01:03 +0000 (UTC)
In-Reply-To: <20180725210057.18017-1-tiwai@suse.de>
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
List-Id: alsa-devel@alsa-project.org

Move the declarations of common variables into opl3_voice.h instead of
declaring at each file multiple times, which was error-prone.

This fixes sparse warnings like:
  sound/drivers/opl3/opl3_synth.c:51:6: warning: symbol 'snd_opl3_regmap' was not declared. Should it be static?

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/drivers/opl3/opl3_drums.c | 2 --
 sound/drivers/opl3/opl3_lib.c   | 3 +--
 sound/drivers/opl3/opl3_midi.c  | 4 ----
 sound/drivers/opl3/opl3_oss.c   | 2 --
 sound/drivers/opl3/opl3_synth.c | 1 +
 sound/drivers/opl3/opl3_voice.h | 4 ++++
 6 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/sound/drivers/opl3/opl3_drums.c b/sound/drivers/opl3/opl3_drums.c
index 73694380734a..14929822956c 100644
--- a/sound/drivers/opl3/opl3_drums.c
+++ b/sound/drivers/opl3/opl3_drums.c
@@ -21,8 +21,6 @@
 
 #include "opl3_voice.h"
 
-extern char snd_opl3_regmap[MAX_OPL2_VOICES][4];
-
 static char snd_opl3_drum_table[47] =
 {
 	OPL3_BASSDRUM_ON,  OPL3_BASSDRUM_ON,  OPL3_HIHAT_ON,	/* 35 - 37 */
diff --git a/sound/drivers/opl3/opl3_lib.c b/sound/drivers/opl3/opl3_lib.c
index 588963d6be28..1a5355b747ec 100644
--- a/sound/drivers/opl3/opl3_lib.c
+++ b/sound/drivers/opl3/opl3_lib.c
@@ -31,13 +31,12 @@
 #include <linux/slab.h>
 #include <linux/ioport.h>
 #include <sound/minors.h>
+#include "opl3_voice.h"
 
 MODULE_AUTHOR("Jaroslav Kysela <perex@perex.cz>, Hannu Savolainen 1993-1996, Rob Hooft");
 MODULE_DESCRIPTION("Routines for control of AdLib FM cards (OPL2/OPL3/OPL4 chips)");
 MODULE_LICENSE("GPL");
 
-extern char snd_opl3_regmap[MAX_OPL2_VOICES][4];
-
 static void snd_opl2_command(struct snd_opl3 * opl3, unsigned short cmd, unsigned char val)
 {
 	unsigned long flags;
diff --git a/sound/drivers/opl3/opl3_midi.c b/sound/drivers/opl3/opl3_midi.c
index 71cd5a2fbe82..471916ca0b6b 100644
--- a/sound/drivers/opl3/opl3_midi.c
+++ b/sound/drivers/opl3/opl3_midi.c
@@ -25,10 +25,6 @@
 #include "opl3_voice.h"
 #include <sound/asoundef.h>
 
-extern char snd_opl3_regmap[MAX_OPL2_VOICES][4];
-
-extern bool use_internal_drums;
-
 static void snd_opl3_note_off_unsafe(void *p, int note, int vel,
 				     struct snd_midi_channel *chan);
 /*
diff --git a/sound/drivers/opl3/opl3_oss.c b/sound/drivers/opl3/opl3_oss.c
index 8a0ce3f43f42..869220ced4ed 100644
--- a/sound/drivers/opl3/opl3_oss.c
+++ b/sound/drivers/opl3/opl3_oss.c
@@ -29,8 +29,6 @@ static int snd_opl3_reset_seq_oss(struct snd_seq_oss_arg *arg);
 
 /* operators */
 
-extern struct snd_midi_op opl3_ops;
-
 static struct snd_seq_oss_callback oss_callback = {
 	.owner = 	THIS_MODULE,
 	.open =		snd_opl3_open_seq_oss,
diff --git a/sound/drivers/opl3/opl3_synth.c b/sound/drivers/opl3/opl3_synth.c
index 42920a243328..d522925fc5c0 100644
--- a/sound/drivers/opl3/opl3_synth.c
+++ b/sound/drivers/opl3/opl3_synth.c
@@ -24,6 +24,7 @@
 #include <linux/nospec.h>
 #include <sound/opl3.h>
 #include <sound/asound_fm.h>
+#include "opl3_voice.h"
 
 #if IS_ENABLED(CONFIG_SND_SEQUENCER)
 #define OPL3_SUPPORT_SYNTH
diff --git a/sound/drivers/opl3/opl3_voice.h b/sound/drivers/opl3/opl3_voice.h
index a2445163008e..5b02bd49fde4 100644
--- a/sound/drivers/opl3/opl3_voice.h
+++ b/sound/drivers/opl3/opl3_voice.h
@@ -52,4 +52,8 @@ void snd_opl3_free_seq_oss(struct snd_opl3 *opl3);
 #define snd_opl3_free_seq_oss(opl3) /* NOP */
 #endif
 
+extern char snd_opl3_regmap[MAX_OPL2_VOICES][4];
+extern bool use_internal_drums;
+extern struct snd_midi_op opl3_ops;
+
 #endif
-- 
2.18.0
