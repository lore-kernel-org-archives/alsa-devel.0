From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [PATCH 6/8] emu10k1 multichannel support
Date: Tue, 15 Feb 2005 19:49:25 -0500
Message-ID: <1108514965.3772.37.camel@krustophenia.net>
References: <1108514291.3772.19.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-1Z8O4C41IccWSZQTNjk+"
In-Reply-To: <1108514291.3772.19.camel@krustophenia.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
Cc: Takashi Iwai <tiwai@suse.de>, James Courtier-Dutton <James@superbug.co.uk>
List-Id: alsa-devel@alsa-project.org


--=-1Z8O4C41IccWSZQTNjk+
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2005-02-15 at 19:38 -0500, Lee Revell wrote:
> This series of patches adds a 16 channel non interleaved PCM playback
> device, hw:x,3, to the emu10k1 driver.  It also adds support for the
> newly discovered per channel half loop interrupt.

Rewrite voice allocator for multichannel support.

Signed-Off-By: Lee Revell <rlrevell@joe-job.com>

--=-1Z8O4C41IccWSZQTNjk+
Content-Disposition: attachment; filename=voice.c.patch
Content-Type: text/x-patch; name=voice.c.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

Index: alsa-v009-test/alsa-kernel/pci/emu10k1/voice.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/voice.c,v
retrieving revision 1.5
diff -u -r1.5 voice.c
--- alsa-v009-test/alsa-kernel/pci/emu10k1/voice.c	12 Aug 2002 08:43:47 -0000	1.5
+++ alsa-v009-test/alsa-kernel/pci/emu10k1/voice.c	15 Feb 2005 23:51:24 -0000
@@ -1,8 +1,11 @@
 /*
  *  Copyright (c) by Jaroslav Kysela <perex@suse.cz>
  *                   Creative Labs, Inc.
+ *                   Lee Revell <rlrevell@joe-job.com>
  *  Routines for control of EMU10K1 chips - voice manager
  *
+ *  Rewrote voice allocator for multichannel support - rlrevell 12/2004
+ * 
  *  BUGS:
  *    --
  *
@@ -30,25 +33,70 @@
 #include <sound/core.h>
 #include <sound/emu10k1.h>
 
-static int voice_alloc(emu10k1_t *emu, emu10k1_voice_type_t type, int pair, emu10k1_voice_t **rvoice)
+/* Previously the voice allocator started at 0 every time.  The new voice 
+ * allocator uses a round robin scheme.  The next free voice is tracked in 
+ * the card record and each allocation begins where the last left off.  The 
+ * hardware requires stereo interleaved voices be aligned to an even/odd 
+ * boundary.  For multichannel voice allocation we ensure than the block of 
+ * voices does not cross the 32 voice boundary.  This simplifies the 
+ * multichannel support and ensures we can use a single write to the 
+ * (set|clear)_loop_stop registers.  Otherwise (for example) the voices would 
+ * get out of sync when pausing/resuming a stream.
+ *							--rlrevell
+ */
+
+static int voice_alloc(emu10k1_t *emu, emu10k1_voice_type_t type, int number, emu10k1_voice_t **rvoice)
 {
-	emu10k1_voice_t *voice, *voice2;
-	int idx;
+	emu10k1_voice_t *voice;
+	int i, j, k, first_voice, last_voice, skip;
 
 	*rvoice = NULL;
-	for (idx = 0; idx < 64; idx += pair ? 2 : 1) {
-		voice = &emu->voices[idx];
-		voice2 = pair ? &emu->voices[idx+1] : NULL;
-		if (voice->use || (voice2 && voice2->use))
+	first_voice = last_voice = 0;
+	for (i = emu->next_free_voice, j = 0; j < NUM_G ; i += number, j += number) {
+		// printk("i %d j %d next free %d!\n", i, j, emu->next_free_voice);
+		i %= NUM_G;
+
+		/* stereo voices must be even/odd */
+		if ((number == 2) && (i % 2)) {
+			i++;
 			continue;
+		}
+			
+		/* make sure the block of voices does not cross the 32 voice boundary */
+		//if (((i % 32) + number) > 32)
+		//	continue;
+
+		skip = 0;
+		for (k = 0; k < number; k++) {
+			voice = &emu->voices[(i+k) % NUM_G];
+			if (voice->use) {
+				printk("voice %d: use=1!\n", i+k);
+				skip = 1;
+			}
+		}
+		if (!skip) {
+			// printk("allocated voice %d\n", i);
+			first_voice = i;
+			last_voice = (i + number) % NUM_G;
+			emu->next_free_voice = last_voice;
+			break;
+		}
+	}
+	
+	if (first_voice == last_voice) {
+		printk("BUG (or not enough voices), number %d, next free %d!\n",
+				number,
+				emu->next_free_voice);
+		return -ENOMEM;
+	}	
+	
+	for (i=0; i < number; i++) {
+		voice = &emu->voices[(first_voice + i) % NUM_G];
+		// printk("voice alloc - %i, %i of %i\n", voice->number, idx-first_voice+1, number);
 		voice->use = 1;
-		if (voice2)
-			voice2->use = 1;
 		switch (type) {
 		case EMU10K1_PCM:
 			voice->pcm = 1;
-			if (voice2)
-				voice2->pcm = 1;
 			break;
 		case EMU10K1_SYNTH:
 			voice->synth = 1;
@@ -56,26 +104,27 @@
 		case EMU10K1_MIDI:
 			voice->midi = 1;
 			break;
+		case EMU10K1_EFX:
+			voice->efx = 1;
+			break;
 		}
-		// printk("voice alloc - %i, pair = %i\n", voice->number, pair);
-		*rvoice = voice;
-		return 0;
 	}
-	return -ENOMEM;
+	*rvoice = &emu->voices[first_voice];
+	return 0;
 }
 
-int snd_emu10k1_voice_alloc(emu10k1_t *emu, emu10k1_voice_type_t type, int pair, emu10k1_voice_t **rvoice)
+int snd_emu10k1_voice_alloc(emu10k1_t *emu, emu10k1_voice_type_t type, int number, emu10k1_voice_t **rvoice)
 {
 	unsigned long flags;
 	int result;
 
 	snd_assert(rvoice != NULL, return -EINVAL);
-	snd_assert(!pair || type == EMU10K1_PCM, return -EINVAL);
+	snd_assert(number, return -EINVAL);
 
 	spin_lock_irqsave(&emu->voice_lock, flags);
 	for (;;) {
-		result = voice_alloc(emu, type, pair, rvoice);
-		if (result == 0 || type != EMU10K1_PCM)
+		result = voice_alloc(emu, type, number, rvoice);
+		if (result == 0 || type == EMU10K1_SYNTH || type == EMU10K1_MIDI)
 			break;
 
 		/* free a voice from synth */
@@ -84,7 +133,7 @@
 			if (result >= 0) {
 				emu10k1_voice_t *pvoice = &emu->voices[result];
 				pvoice->interrupt = NULL;
-				pvoice->use = pvoice->pcm = pvoice->synth = pvoice->midi = 0;
+				pvoice->use = pvoice->pcm = pvoice->synth = pvoice->midi = pvoice->efx = 0;
 				pvoice->epcm = NULL;
 			}
 		}
@@ -103,7 +152,7 @@
 	snd_assert(pvoice != NULL, return -EINVAL);
 	spin_lock_irqsave(&emu->voice_lock, flags);
 	pvoice->interrupt = NULL;
-	pvoice->use = pvoice->pcm = pvoice->synth = pvoice->midi = 0;
+	pvoice->use = pvoice->pcm = pvoice->synth = pvoice->midi = pvoice->efx = 0;
 	pvoice->epcm = NULL;
 	snd_emu10k1_voice_init(emu, pvoice->number);
 	spin_unlock_irqrestore(&emu->voice_lock, flags);

--=-1Z8O4C41IccWSZQTNjk+--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
