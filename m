From: Giuliano Pochini <pochini@shiny.it>
Subject: [PATCH] echoudio midi
Date: Tue, 22 Feb 2005 22:46:36 +0100
Message-ID: <20050222224636.206aeb57.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org



- write_midi() cleanup.

- Do not try to deliver new data to the DSP every 1ms when the output buffer
is full anymore. Instead, it waits until half of the queued data is send.

- Use mod_timer() in place of add_timer() because the .trigger() callback
may be called when the timer is already running.



Signed-off-by: Giuliano Pochini <pochini@shiny.it>

diff -du alsa-driver_orig/pci/echoaudio/echoaudio.h alsa-driver/pci/echoaudio/echoaudio.h
--- alsa-driver_orig/pci/echoaudio/echoaudio.h	Tue Feb 22 22:26:55 2005
+++ alsa-driver/pci/echoaudio/echoaudio.h	Thu Feb 17 23:38:08 2005
@@ -373,6 +373,7 @@
 #endif
 	struct timer_list timer;
 	char tinuse;				/* Timer in use */
+	char midi_full;				/* MIDI output buffer is full */
 	char can_set_rate;
 	char rate_set;
 
diff -du alsa-driver_orig/pci/echoaudio/midi.c alsa-driver/pci/echoaudio/midi.c
--- alsa-driver_orig/pci/echoaudio/midi.c	Tue Feb 22 22:26:55 2005
+++ alsa-driver/pci/echoaudio/midi.c	Sun Feb 20 22:19:05 2005
@@ -59,18 +59,14 @@
 */
 static int write_midi(echoaudio_t *chip, u8 *data, int bytes)
 {
-	if (bytes <= 0)
-		return 0;
+	snd_assert(bytes > 0 && bytes < MIDI_OUT_BUFFER_SIZE, return -EINVAL);
 
 	if (wait_handshake(chip))
 		return -EIO;
 
-	/* Return immediately if HF4 is clear - HF4 indicates that it is safe to write MIDI output data */
+	/* HF4 indicates that it is safe to write MIDI output data */
 	if ((get_dsp_register(chip, CHI32_STATUS_REG) & CHI32_STATUS_REG_HF4) == 0)
-		return 0;	//@@@ -EBUSY ?
-
-	/* The first byte contains the number of bytes to send */
-	snd_assert(bytes < MIDI_OUT_BUFFER_SIZE, return -EINVAL);
+		return 0;
 
 	chip->comm_page->midi_output[0] = bytes;
 	memcpy(&chip->comm_page->midi_output[1], data, bytes);
@@ -198,8 +194,8 @@
 {
 	echoaudio_t *chip = substream->rmidi->private_data;
 
-	init_timer(&chip->timer);
 	chip->tinuse = 0;
+	chip->midi_full = 0;
 	chip->midi_out = substream;
 	DE_MID(("rawmidi_oopen\n"));
 	return 0;
@@ -219,32 +215,36 @@
 	if the card's output buffer has room for new data. */
 	sent = bytes = 0;
 	spin_lock_irqsave(&chip->lock, flags);
+	chip->midi_full = 0;
 	if (chip->midi_out && !snd_rawmidi_transmit_empty(chip->midi_out)) {
 		bytes = snd_rawmidi_transmit_peek(chip->midi_out, buf, MIDI_OUT_BUFFER_SIZE - 1);
 		DE_MID(("Try to send %d bytes...\n", bytes));
-		if (bytes > 0) {	//@@ useless ?
-			sent = write_midi(chip, buf, bytes);
-			if (sent < 0) {
-				DE_MID(("write_midi() error %d\n", sent));
-				sent = 1000;	/* retry later */
-			} else {
-				DE_MID(("%d bytes sent\n", sent));
-				snd_rawmidi_transmit_ack(chip->midi_out, sent);
-			}
+		sent = write_midi(chip, buf, bytes);
+		if (sent < 0) {
+			snd_printk("write_midi() error %d\n", sent);
+			/* retry later */
+			sent = 9000;
+			chip->midi_full = 1;
+		} else if (sent > 0) {
+			DE_MID(("%d bytes sent\n", sent));
+			snd_rawmidi_transmit_ack(chip->midi_out, sent);
+		} else {
+			/* Buffer is full. DSP's internal buffer is 64 (128 ?)
+			bytes long. Let's wait until half of them are sent */
+			DE_MID(("Full\n"));
+			sent = 32;
+			chip->midi_full = 1;
 		}
 	}
-	spin_unlock_irqrestore(&chip->lock, flags);
 
 	/* We restart the timer only if there is some data left to send */
 	if (!snd_rawmidi_transmit_empty(chip->midi_out) && chip->tinuse) {
 		/* The timer will expire slightly after the data has been sent */
-		time = (sent << 10) / 3150 + 1;	/* ms */
-		chip->timer.expires = ((time * HZ + 999) / 1000) + jiffies;
-		add_timer(&chip->timer);
+		time = (sent << 3) / 25 + 1;	/* 8/25=0.32ms to send a byte */
+		mod_timer(&chip->timer, jiffies + (time * HZ + 999) / 1000);
 		DE_MID(("Timer armed(%d)\n", ((time * HZ + 999) / 1000)));
 	}
-
-	DE_MID(("snd_echo_midi_output_write done\n"));
+	spin_unlock_irqrestore(&chip->lock, flags);
 }
 
 
@@ -271,9 +271,8 @@
 	}
 	spin_unlock_irq(&chip->lock);
 
-	if (up)
+	if (up && !chip->midi_full)
 		snd_echo_midi_output_write((unsigned long)chip);
-	DE_MID(("rawmidi_otrigger\n"));
 }
 
 




--
Giuliano.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
