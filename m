From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] sb8: full duplex MIDI
Date: Fri, 16 May 2003 08:33:39 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0305160830380.4782-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


Added full duplex UART mode for DSP version 2.0 and later.


Index: alsa-kernel/include/sb.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/include/sb.h,v
retrieving revision 1.11
diff -u -r1.11 sb.h
--- alsa-kernel/include/sb.h	23 Apr 2003 10:01:33 -0000	1.11
+++ alsa-kernel/include/sb.h	16 May 2003 06:24:52 -0000
@@ -40,10 +40,11 @@
 	SB_HW_DT019X,		/* Diamond Tech. DT-019X / Avance Logic ALS-007 */
 };

-#define SB_OPEN_PCM		0x01
-#define SB_OPEN_MIDI_INPUT	0x02
-#define SB_OPEN_MIDI_OUTPUT	0x04
-#define SB_OPEN_MIDI_TRIGGER	0x08
+#define SB_OPEN_PCM			0x01
+#define SB_OPEN_MIDI_INPUT		0x02
+#define SB_OPEN_MIDI_OUTPUT		0x04
+#define SB_OPEN_MIDI_INPUT_TRIGGER	0x08
+#define SB_OPEN_MIDI_OUTPUT_TRIGGER	0x10

 #define SB_MODE_HALT		0x00
 #define SB_MODE_PLAYBACK_8	0x01
@@ -157,6 +158,7 @@
 #define SB_DSP_STEREO_16BIT	0xac

 #define SB_DSP_MIDI_INPUT_IRQ	0x31
+#define SB_DSP_MIDI_UART_IRQ	0x35
 #define SB_DSP_MIDI_OUTPUT	0x38

 #define SB_DSP4_OUT8_AI		0xc6
Index: alsa-kernel/isa/sb/sb8_midi.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/isa/sb/sb8_midi.c,v
retrieving revision 1.9
diff -u -r1.9 sb8_midi.c
--- alsa-kernel/isa/sb/sb8_midi.c	23 Apr 2003 10:01:42 -0000	1.9
+++ alsa-kernel/isa/sb/sb8_midi.c	16 May 2003 06:25:05 -0000
@@ -21,6 +21,9 @@
  * Sun May  9 22:54:38 BST 1999 George David Morrison <gdm@gedamo.demon.co.uk>
  *   Fixed typo in snd_sb8dsp_midi_new_device which prevented midi from
  *   working.
+ *
+ * Sun May 11 12:34:56 UTC 2003 Clemens Ladisch <clemens@ladisch.de>
+ *   Added full duplex UART mode for DSP version 2.0 and later.
  */

 #include <sound/driver.h>
@@ -40,15 +43,19 @@
 	char byte;

 	if (chip == NULL || (rmidi = chip->rmidi) == NULL) {
-		inb(SBP(chip, READ));	/* ack interrupt */
+		inb(SBP(chip, DATA_AVAIL));	/* ack interrupt */
 		return IRQ_NONE;
 	}
 	while (max-- > 0) {
 		spin_lock(&chip->midi_input_lock);
 		if (inb(SBP(chip, DATA_AVAIL)) & 0x80) {
 			byte = inb(SBP(chip, READ));
-			spin_unlock(&chip->midi_input_lock);
-			snd_rawmidi_receive(chip->midi_substream_input, &byte, 1);
+			if (chip->open & SB_OPEN_MIDI_INPUT_TRIGGER) {
+				spin_unlock(&chip->midi_input_lock);
+				snd_rawmidi_receive(chip->midi_substream_input, &byte, 1);
+			} else {
+				spin_unlock(&chip->midi_input_lock);
+			}
 		} else {
 			spin_unlock(&chip->midi_input_lock);
 		}
@@ -64,10 +71,13 @@
 {
 	unsigned long flags;
 	sb_t *chip;
+	unsigned int valid_open_flags;

 	chip = snd_magic_cast(sb_t, substream->rmidi->private_data, return -ENXIO);
+	valid_open_flags = chip->hardware >= SB_HW_20
+		? SB_OPEN_MIDI_OUTPUT | SB_OPEN_MIDI_OUTPUT_TRIGGER : 0;
 	spin_lock_irqsave(&chip->open_lock, flags);
-	if (chip->open) {
+	if (chip->open & ~valid_open_flags) {
 		spin_unlock_irqrestore(&chip->open_lock, flags);
 		return -EAGAIN;
 	}
@@ -76,6 +86,8 @@
 	if (!(chip->open & SB_OPEN_MIDI_OUTPUT)) {
 		spin_unlock_irqrestore(&chip->open_lock, flags);
 		snd_sbdsp_reset(chip);		/* reset DSP */
+		if (chip->hardware >= SB_HW_20)
+			snd_sbdsp_command(chip, SB_DSP_MIDI_UART_IRQ);
 	} else {
 		spin_unlock_irqrestore(&chip->open_lock, flags);
 	}
@@ -86,10 +98,13 @@
 {
 	unsigned long flags;
 	sb_t *chip;
+	unsigned int valid_open_flags;

 	chip = snd_magic_cast(sb_t, substream->rmidi->private_data, return -ENXIO);
+	valid_open_flags = chip->hardware >= SB_HW_20
+		? SB_OPEN_MIDI_INPUT | SB_OPEN_MIDI_INPUT_TRIGGER : 0;
 	spin_lock_irqsave(&chip->open_lock, flags);
-	if (chip->open) {
+	if (chip->open & ~valid_open_flags) {
 		spin_unlock_irqrestore(&chip->open_lock, flags);
 		return -EAGAIN;
 	}
@@ -98,6 +113,8 @@
 	if (!(chip->open & SB_OPEN_MIDI_INPUT)) {
 		spin_unlock_irqrestore(&chip->open_lock, flags);
 		snd_sbdsp_reset(chip);		/* reset DSP */
+		if (chip->hardware >= SB_HW_20)
+			snd_sbdsp_command(chip, SB_DSP_MIDI_UART_IRQ);
 	} else {
 		spin_unlock_irqrestore(&chip->open_lock, flags);
 	}
@@ -111,7 +128,7 @@

 	chip = snd_magic_cast(sb_t, substream->rmidi->private_data, return -ENXIO);
 	spin_lock_irqsave(&chip->open_lock, flags);
-	chip->open &= ~(SB_OPEN_MIDI_INPUT | SB_OPEN_MIDI_TRIGGER);
+	chip->open &= ~(SB_OPEN_MIDI_INPUT | SB_OPEN_MIDI_INPUT_TRIGGER);
 	chip->midi_substream_input = NULL;
 	if (!(chip->open & SB_OPEN_MIDI_OUTPUT)) {
 		spin_unlock_irqrestore(&chip->open_lock, flags);
@@ -129,7 +146,7 @@

 	chip = snd_magic_cast(sb_t, substream->rmidi->private_data, return -ENXIO);
 	spin_lock_irqsave(&chip->open_lock, flags);
-	chip->open &= ~SB_OPEN_MIDI_OUTPUT;
+	chip->open &= ~(SB_OPEN_MIDI_OUTPUT | SB_OPEN_MIDI_OUTPUT_TRIGGER);
 	chip->midi_substream_output = NULL;
 	if (!(chip->open & SB_OPEN_MIDI_INPUT)) {
 		spin_unlock_irqrestore(&chip->open_lock, flags);
@@ -148,14 +165,16 @@
 	chip = snd_magic_cast(sb_t, substream->rmidi->private_data, return);
 	spin_lock_irqsave(&chip->open_lock, flags);
 	if (up) {
-		if (!(chip->open & SB_OPEN_MIDI_TRIGGER)) {
-			snd_sbdsp_command(chip, SB_DSP_MIDI_INPUT_IRQ);
-			chip->open |= SB_OPEN_MIDI_TRIGGER;
+		if (!(chip->open & SB_OPEN_MIDI_INPUT_TRIGGER)) {
+			if (chip->hardware < SB_HW_20)
+				snd_sbdsp_command(chip, SB_DSP_MIDI_INPUT_IRQ);
+			chip->open |= SB_OPEN_MIDI_INPUT_TRIGGER;
 		}
 	} else {
-		if (chip->open & SB_OPEN_MIDI_TRIGGER) {
-			snd_sbdsp_command(chip, SB_DSP_MIDI_INPUT_IRQ);
-			chip->open &= ~SB_OPEN_MIDI_TRIGGER;
+		if (chip->open & SB_OPEN_MIDI_INPUT_TRIGGER) {
+			if (chip->hardware < SB_HW_20)
+				snd_sbdsp_command(chip, SB_DSP_MIDI_INPUT_IRQ);
+			chip->open &= ~SB_OPEN_MIDI_INPUT_TRIGGER;
 		}
 	}
 	spin_unlock_irqrestore(&chip->open_lock, flags);
@@ -172,14 +191,27 @@
 	chip = snd_magic_cast(sb_t, substream->rmidi->private_data, return);
 	while (max-- > 0) {
 		spin_lock_irqsave(&chip->open_lock, flags);
-		if (snd_rawmidi_transmit(substream, &byte, 1) != 1) {
-			chip->open &= ~SB_OPEN_MIDI_TRIGGER;
+		if (snd_rawmidi_transmit_peek(substream, &byte, 1) != 1) {
+			chip->open &= ~SB_OPEN_MIDI_OUTPUT_TRIGGER;
 			del_timer(&chip->midi_timer);
 			spin_unlock_irqrestore(&chip->open_lock, flags);
-			return;
+			break;
+		}
+		if (chip->hardware >= SB_HW_20) {
+			int timeout = 8;
+			while ((inb(SBP(chip, STATUS)) & 0x80) != 0 && --timeout > 0)
+				;
+			if (timeout == 0) {
+				/* Tx FIFO full - try again later */
+				spin_unlock_irqrestore(&chip->open_lock, flags);
+				break;
+			}
+			outb(byte, SBP(chip, WRITE));
+		} else {
+			snd_sbdsp_command(chip, SB_DSP_MIDI_OUTPUT);
+			snd_sbdsp_command(chip, byte);
 		}
-		snd_sbdsp_command(chip, SB_DSP_MIDI_OUTPUT);
-		snd_sbdsp_command(chip, byte);
+		snd_rawmidi_transmit_ack(substream, 1);
 		spin_unlock_irqrestore(&chip->open_lock, flags);
 	}
 }
@@ -193,7 +225,7 @@
 	spin_lock_irqsave(&chip->open_lock, flags);
 	chip->midi_timer.expires = 1 + jiffies;
 	add_timer(&chip->midi_timer);
-	spin_unlock_irqrestore(&chip->open_lock, flags);
+	spin_unlock_irqrestore(&chip->open_lock, flags);
 	snd_sb8dsp_midi_output_write(substream);
 }

@@ -205,17 +237,17 @@
 	chip = snd_magic_cast(sb_t, substream->rmidi->private_data, return);
 	spin_lock_irqsave(&chip->open_lock, flags);
 	if (up) {
-		if (!(chip->open & SB_OPEN_MIDI_TRIGGER)) {
+		if (!(chip->open & SB_OPEN_MIDI_OUTPUT_TRIGGER)) {
 			init_timer(&chip->midi_timer);
 			chip->midi_timer.function = snd_sb8dsp_midi_output_timer;
 			chip->midi_timer.data = (unsigned long) substream;
 			chip->midi_timer.expires = 1 + jiffies;
 			add_timer(&chip->midi_timer);
-			chip->open |= SB_OPEN_MIDI_TRIGGER;
+			chip->open |= SB_OPEN_MIDI_OUTPUT_TRIGGER;
 		}
 	} else {
-		if (chip->open & SB_OPEN_MIDI_TRIGGER) {
-			chip->open &= ~SB_OPEN_MIDI_TRIGGER;
+		if (chip->open & SB_OPEN_MIDI_OUTPUT_TRIGGER) {
+			chip->open &= ~SB_OPEN_MIDI_OUTPUT_TRIGGER;
 		}
 	}
 	spin_unlock_irqrestore(&chip->open_lock, flags);
@@ -254,7 +286,9 @@
 	strcpy(rmidi->name, "SB8 MIDI");
 	snd_rawmidi_set_ops(rmidi, SNDRV_RAWMIDI_STREAM_OUTPUT, &snd_sb8dsp_midi_output);
 	snd_rawmidi_set_ops(rmidi, SNDRV_RAWMIDI_STREAM_INPUT, &snd_sb8dsp_midi_input);
-	rmidi->info_flags |= SNDRV_RAWMIDI_INFO_OUTPUT | SNDRV_RAWMIDI_INFO_INPUT | SNDRV_RAWMIDI_INFO_DUPLEX;
+	rmidi->info_flags |= SNDRV_RAWMIDI_INFO_OUTPUT | SNDRV_RAWMIDI_INFO_INPUT;
+	if (chip->hardware >= SB_HW_20)
+		rmidi->info_flags |= SNDRV_RAWMIDI_INFO_DUPLEX;
 	rmidi->private_data = chip;
 	chip->rmidi = rmidi;
 	if (rrawmidi)




-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
