From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCHv2 12/31] ALSA: hdspm - Create TCO readout
	function
Date: Fri,  5 Jul 2013 11:28:04 +0200
Message-ID: <1373016503-9474-13-git-send-email-adi@drcomp.erfurt.thur.de>
References: <1373016503-9474-1-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-2-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-3-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-4-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-5-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-6-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-7-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-8-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-9-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-10-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-11-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-12-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1373016503-9474-12-git-send-email-adi@drcomp.erfurt.thur.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: Adrian Knoth <adi@drcomp.erfurt.thur.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This patch separates the TCO bits from snd_hdspm_proc_read_madi(), so
the new function can later be shared between MADI and AES32 cards.

It's essentially only moving code around, no new functionality.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index 06e69de..58b2104 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -4636,77 +4636,22 @@ static int snd_hdspm_create_controls(struct snd_card *card,
  ------------------------------------------------------------*/
 
 static void
-snd_hdspm_proc_read_madi(struct snd_info_entry * entry,
-			 struct snd_info_buffer *buffer)
+snd_hdspm_proc_read_tco(struct snd_info_entry *entry,
+					struct snd_info_buffer *buffer)
 {
 	struct hdspm *hdspm = entry->private_data;
-	unsigned int status, status2, control, freq;
-
-	char *pref_sync_ref;
-	char *autosync_ref;
-	char *system_clock_mode;
-	char *insel;
-	int x, x2;
-
-	/* TCO stuff */
+	unsigned int status, control;
 	int a, ltc, frames, seconds, minutes, hours;
 	unsigned int period;
 	u64 freq_const = 0;
 	u32 rate;
 
+	snd_iprintf(buffer, "--- TCO ---\n");
+
 	status = hdspm_read(hdspm, HDSPM_statusRegister);
-	status2 = hdspm_read(hdspm, HDSPM_statusRegister2);
 	control = hdspm->control_register;
-	freq = hdspm_read(hdspm, HDSPM_timecodeRegister);
-
-	snd_iprintf(buffer, "%s (Card #%d) Rev.%x Status2first3bits: %x\n",
-			hdspm->card_name, hdspm->card->number + 1,
-			hdspm->firmware_rev,
-			(status2 & HDSPM_version0) |
-			(status2 & HDSPM_version1) | (status2 &
-				HDSPM_version2));
-
-	snd_iprintf(buffer, "HW Serial: 0x%06x%06x\n",
-			(hdspm_read(hdspm, HDSPM_midiStatusIn1)>>8) & 0xFFFFFF,
-			hdspm->serial);
-
-	snd_iprintf(buffer, "IRQ: %d Registers bus: 0x%lx VM: 0x%lx\n",
-			hdspm->irq, hdspm->port, (unsigned long)hdspm->iobase);
-
-	snd_iprintf(buffer, "--- System ---\n");
 
-	snd_iprintf(buffer,
-		"IRQ Pending: Audio=%d, MIDI0=%d, MIDI1=%d, IRQcount=%d\n",
-		status & HDSPM_audioIRQPending,
-		(status & HDSPM_midi0IRQPending) ? 1 : 0,
-		(status & HDSPM_midi1IRQPending) ? 1 : 0,
-		hdspm->irq_count);
-	snd_iprintf(buffer,
-		"HW pointer: id = %d, rawptr = %d (%d->%d) "
-		"estimated= %ld (bytes)\n",
-		((status & HDSPM_BufferID) ? 1 : 0),
-		(status & HDSPM_BufferPositionMask),
-		(status & HDSPM_BufferPositionMask) %
-		(2 * (int)hdspm->period_bytes),
-		((status & HDSPM_BufferPositionMask) - 64) %
-		(2 * (int)hdspm->period_bytes),
-		(long) hdspm_hw_pointer(hdspm) * 4);
 
-	snd_iprintf(buffer,
-		"MIDI FIFO: Out1=0x%x, Out2=0x%x, In1=0x%x, In2=0x%x \n",
-		hdspm_read(hdspm, HDSPM_midiStatusOut0) & 0xFF,
-		hdspm_read(hdspm, HDSPM_midiStatusOut1) & 0xFF,
-		hdspm_read(hdspm, HDSPM_midiStatusIn0) & 0xFF,
-		hdspm_read(hdspm, HDSPM_midiStatusIn1) & 0xFF);
-	snd_iprintf(buffer,
-		"MIDIoverMADI FIFO: In=0x%x, Out=0x%x \n",
-		hdspm_read(hdspm, HDSPM_midiStatusIn2) & 0xFF,
-		hdspm_read(hdspm, HDSPM_midiStatusOut2) & 0xFF);
-	snd_iprintf(buffer,
-		"Register: ctrl1=0x%x, ctrl2=0x%x, status1=0x%x, "
-		"status2=0x%x\n",
-		hdspm->control_register, hdspm->control2_register,
-		status, status2);
 	if (status & HDSPM_tco_detect) {
 		snd_iprintf(buffer, "TCO module detected.\n");
 		a = hdspm_read(hdspm, HDSPM_RD_TCO+4);
@@ -4800,6 +4745,75 @@ snd_hdspm_proc_read_madi(struct snd_info_entry * entry,
 	} else {
 		snd_iprintf(buffer, "No TCO module detected.\n");
 	}
+}
+
+static void
+snd_hdspm_proc_read_madi(struct snd_info_entry *entry,
+			 struct snd_info_buffer *buffer)
+{
+	struct hdspm *hdspm = entry->private_data;
+	unsigned int status, status2, control, freq;
+
+	char *pref_sync_ref;
+	char *autosync_ref;
+	char *system_clock_mode;
+	char *insel;
+	int x, x2;
+
+	status = hdspm_read(hdspm, HDSPM_statusRegister);
+	status2 = hdspm_read(hdspm, HDSPM_statusRegister2);
+	control = hdspm->control_register;
+	freq = hdspm_read(hdspm, HDSPM_timecodeRegister);
+
+	snd_iprintf(buffer, "%s (Card #%d) Rev.%x Status2first3bits: %x\n",
+			hdspm->card_name, hdspm->card->number + 1,
+			hdspm->firmware_rev,
+			(status2 & HDSPM_version0) |
+			(status2 & HDSPM_version1) | (status2 &
+				HDSPM_version2));
+
+	snd_iprintf(buffer, "HW Serial: 0x%06x%06x\n",
+			(hdspm_read(hdspm, HDSPM_midiStatusIn1)>>8) & 0xFFFFFF,
+			hdspm->serial);
+
+	snd_iprintf(buffer, "IRQ: %d Registers bus: 0x%lx VM: 0x%lx\n",
+			hdspm->irq, hdspm->port, (unsigned long)hdspm->iobase);
+
+	snd_iprintf(buffer, "--- System ---\n");
+
+	snd_iprintf(buffer,
+		"IRQ Pending: Audio=%d, MIDI0=%d, MIDI1=%d, IRQcount=%d\n",
+		status & HDSPM_audioIRQPending,
+		(status & HDSPM_midi0IRQPending) ? 1 : 0,
+		(status & HDSPM_midi1IRQPending) ? 1 : 0,
+		hdspm->irq_count);
+	snd_iprintf(buffer,
+		"HW pointer: id = %d, rawptr = %d (%d->%d) "
+		"estimated= %ld (bytes)\n",
+		((status & HDSPM_BufferID) ? 1 : 0),
+		(status & HDSPM_BufferPositionMask),
+		(status & HDSPM_BufferPositionMask) %
+		(2 * (int)hdspm->period_bytes),
+		((status & HDSPM_BufferPositionMask) - 64) %
+		(2 * (int)hdspm->period_bytes),
+		(long) hdspm_hw_pointer(hdspm) * 4);
+
+	snd_iprintf(buffer,
+		"MIDI FIFO: Out1=0x%x, Out2=0x%x, In1=0x%x, In2=0x%x \n",
+		hdspm_read(hdspm, HDSPM_midiStatusOut0) & 0xFF,
+		hdspm_read(hdspm, HDSPM_midiStatusOut1) & 0xFF,
+		hdspm_read(hdspm, HDSPM_midiStatusIn0) & 0xFF,
+		hdspm_read(hdspm, HDSPM_midiStatusIn1) & 0xFF);
+	snd_iprintf(buffer,
+		"MIDIoverMADI FIFO: In=0x%x, Out=0x%x \n",
+		hdspm_read(hdspm, HDSPM_midiStatusIn2) & 0xFF,
+		hdspm_read(hdspm, HDSPM_midiStatusOut2) & 0xFF);
+	snd_iprintf(buffer,
+		"Register: ctrl1=0x%x, ctrl2=0x%x, status1=0x%x, "
+		"status2=0x%x\n",
+		hdspm->control_register, hdspm->control2_register,
+		status, status2);
+
 
 	snd_iprintf(buffer, "--- Settings ---\n");
 
@@ -4903,6 +4917,9 @@ snd_hdspm_proc_read_madi(struct snd_info_entry * entry,
 		(status & HDSPM_RX_64ch) ? "64 channels" :
 		"56 channels");
 
+	/* call readout function for TCO specific status */
+	snd_hdspm_proc_read_tco(entry, buffer);
+
 	snd_iprintf(buffer, "\n");
 }
 
-- 
1.8.3.1
