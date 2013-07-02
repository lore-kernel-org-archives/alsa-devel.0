From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 2/2] ALSA: hdspm - Add TCO support for RME
	AES(32)
Date: Tue,  2 Jul 2013 21:42:16 +0200
Message-ID: <1372794136-6591-3-git-send-email-adi@drcomp.erfurt.thur.de>
References: <1372794136-6591-1-git-send-email-adi@drcomp.erfurt.thur.de>
 <1372794136-6591-2-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1372794136-6591-2-git-send-email-adi@drcomp.erfurt.thur.de>
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

This patch adds support for the TCO extension module on RME AES(32)
cards.

Original patch by Martin Dausel <martin.dausel@iosono-sound.com>.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index 400d2f5..47542a0 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -432,11 +432,11 @@ MODULE_SUPPORTED_DEVICE("{{RME HDSPM-MADI}}");
 #define HDSPM_madiLock           (1<<3)	/* MADI Locked =1, no=0 */
 #define HDSPM_madiSync          (1<<18) /* MADI is in sync */
 
-#define HDSPM_tcoLock    0x00000020 /* Optional TCO locked status FOR HDSPe MADI! */
-#define HDSPM_tcoSync    0x10000000 /* Optional TCO sync status */
+#define HDSPM_tcoLockMadi    0x00000020 /* Optional TCO locked status for HDSPe MADI*/
+#define HDSPM_tcoSync    0x10000000 /* Optional TCO sync status for HDSPe MADI and AES32!*/
 
-#define HDSPM_syncInLock 0x00010000 /* Sync In lock status FOR HDSPe MADI! */
-#define HDSPM_syncInSync 0x00020000 /* Sync In sync status FOR HDSPe MADI! */
+#define HDSPM_syncInLock 0x00010000 /* Sync In lock status for HDSPe MADI! */
+#define HDSPM_syncInSync 0x00020000 /* Sync In sync status for HDSPe MADI! */
 
 #define HDSPM_BufferPositionMask 0x000FFC0 /* Bit 6..15 : h/w buffer pointer */
 			/* since 64byte accurate, last 6 bits are not used */
@@ -454,7 +454,7 @@ MODULE_SUPPORTED_DEVICE("{{RME HDSPM-MADI}}");
 					 * Interrupt
 					 */
 #define HDSPM_tco_detect         0x08000000
-#define HDSPM_tco_lock	         0x20000000
+#define HDSPM_tcoLockAes         0x20000000 /* Optional TCO locked status for HDSPe AES */
 
 #define HDSPM_s2_tco_detect      0x00000040
 #define HDSPM_s2_AEBO_D          0x00000080
@@ -552,7 +552,9 @@ MODULE_SUPPORTED_DEVICE("{{RME HDSPM-MADI}}");
 #define HDSPM_AES32_AUTOSYNC_FROM_AES6 6
 #define HDSPM_AES32_AUTOSYNC_FROM_AES7 7
 #define HDSPM_AES32_AUTOSYNC_FROM_AES8 8
-#define HDSPM_AES32_AUTOSYNC_FROM_NONE 9
+#define HDSPM_AES32_AUTOSYNC_FROM_TCO 9
+#define HDSPM_AES32_AUTOSYNC_FROM_SYNC_IN 10
+#define HDSPM_AES32_AUTOSYNC_FROM_NONE 11
 
 /*  status2 */
 /* HDSPM_LockAES_bit is given by HDSPM_LockAES >> (AES# - 1) */
@@ -565,6 +567,7 @@ MODULE_SUPPORTED_DEVICE("{{RME HDSPM-MADI}}");
 #define HDSPM_LockAES6  0x4
 #define HDSPM_LockAES7  0x2
 #define HDSPM_LockAES8  0x1
+
 /*
    Timecode
    After windows driver sources, bits 4*i to 4*i+3 give the input frequency on
@@ -629,16 +632,16 @@ MODULE_SUPPORTED_DEVICE("{{RME HDSPM-MADI}}");
 static char *hdspm_speed_names[] = { "single", "double", "quad" };
 
 static char *texts_autosync_aes_tco[] = { "Word Clock",
-					  "AES1", "AES2", "AES3", "AES4",
-					  "AES5", "AES6", "AES7", "AES8",
-					  "TCO" };
+					"AES1", "AES2", "AES3", "AES4",
+					"AES5", "AES6", "AES7", "AES8",
+					"TCO", "Sync In" };
 static char *texts_autosync_aes[] = { "Word Clock",
-				      "AES1", "AES2", "AES3", "AES4",
-				      "AES5", "AES6", "AES7", "AES8" };
+					"AES1", "AES2", "AES3", "AES4",
+					"AES5", "AES6", "AES7", "AES8", "Sync In"};
 static char *texts_autosync_madi_tco[] = { "Word Clock",
-					   "MADI", "TCO", "Sync In" };
+					"MADI", "TCO", "Sync In" };
 static char *texts_autosync_madi[] = { "Word Clock",
-				       "MADI", "Sync In" };
+					"MADI", "Sync In" };
 
 static char *texts_autosync_raydat_tco[] = {
 	"Word Clock",
@@ -655,7 +658,7 @@ static char *texts_autosync_aio_tco[] = {
 	"ADAT", "AES", "SPDIF", "TCO", "Sync In"
 };
 static char *texts_autosync_aio[] = { "Word Clock",
-				      "ADAT", "AES", "SPDIF", "Sync In" };
+					"ADAT", "AES", "SPDIF", "Sync In" };
 
 static char *texts_freq[] = {
 	"No Lock",
@@ -1073,6 +1076,17 @@ static void hdspm_set_sgbuf(struct hdspm *hdspm,
 			    struct snd_pcm_substream *substream,
 			     unsigned int reg, int channels);
 
+static int hdspm_aes_sync_check(struct hdspm *hdspm, int idx);
+static int hdspm_wc_sync_check(struct hdspm *hdspm);
+static int hdspm_tco_sync_check(struct hdspm *hdspm);
+static int hdspm_sync_in_sync_check(struct hdspm *hdspm);
+
+static int hdspm_get_aes_sample_rate(struct hdspm *hdspm, int index);
+static int hdspm_get_tco_sample_rate(struct hdspm *hdspm);
+static int hdspm_get_wc_sample_rate(struct hdspm *hdspm);
+
+
+
 static inline int HDSPM_bit2freq(int n)
 {
 	static const int bit2freq_tab[] = {
@@ -1202,10 +1216,7 @@ static int hdspm_rate_multiplier(struct hdspm *hdspm, int rate)
 	return rate;
 }
 
-static int hdspm_tco_sync_check(struct hdspm *hdspm);
-static int hdspm_sync_in_sync_check(struct hdspm *hdspm);
-
-/* check for external sample rate */
+/* check for external sample rate, returns the sample rate in Hz*/
 static int hdspm_external_sample_rate(struct hdspm *hdspm)
 {
 	unsigned int status, status2, timecode;
@@ -1218,17 +1229,36 @@ static int hdspm_external_sample_rate(struct hdspm *hdspm)
 		timecode = hdspm_read(hdspm, HDSPM_timecodeRegister);
 
 		syncref = hdspm_autosync_ref(hdspm);
+		switch (syncref) {
+		case HDSPM_AES32_AUTOSYNC_FROM_WORD:
+		/* Check WC sync and get sample rate */
+			if (hdspm_wc_sync_check(hdspm))
+				return HDSPM_bit2freq(hdspm_get_wc_sample_rate(hdspm));
+			break;
 
-		if (syncref == HDSPM_AES32_AUTOSYNC_FROM_WORD &&
-				status & HDSPM_AES32_wcLock)
-			return HDSPM_bit2freq((status >> HDSPM_AES32_wcFreq_bit) & 0xF);
+		case HDSPM_AES32_AUTOSYNC_FROM_AES1:
+		case HDSPM_AES32_AUTOSYNC_FROM_AES2:
+		case HDSPM_AES32_AUTOSYNC_FROM_AES3:
+		case HDSPM_AES32_AUTOSYNC_FROM_AES4:
+		case HDSPM_AES32_AUTOSYNC_FROM_AES5:
+		case HDSPM_AES32_AUTOSYNC_FROM_AES6:
+		case HDSPM_AES32_AUTOSYNC_FROM_AES7:
+		case HDSPM_AES32_AUTOSYNC_FROM_AES8:
+		/* Check AES sync and get sample rate */
+			if (hdspm_aes_sync_check(hdspm, syncref - HDSPM_AES32_AUTOSYNC_FROM_AES1))
+				return HDSPM_bit2freq(hdspm_get_aes_sample_rate(hdspm,
+							syncref - HDSPM_AES32_AUTOSYNC_FROM_AES1));
+			break;
 
-		if (syncref >= HDSPM_AES32_AUTOSYNC_FROM_AES1 &&
-				syncref <= HDSPM_AES32_AUTOSYNC_FROM_AES8 &&
-				status2 & (HDSPM_LockAES >>
-				(syncref - HDSPM_AES32_AUTOSYNC_FROM_AES1)))
-			return HDSPM_bit2freq((timecode >> (4*(syncref-HDSPM_AES32_AUTOSYNC_FROM_AES1))) & 0xF);
-		return 0;
+
+		case HDSPM_AES32_AUTOSYNC_FROM_TCO:
+		/* Check TCO sync and get sample rate */
+			if (hdspm_tco_sync_check(hdspm))
+				return HDSPM_bit2freq(hdspm_get_tco_sample_rate(hdspm));
+			break;
+		default:
+			return 0;
+		} /* end switch(syncref) */
 		break;
 
 	case MADIface:
@@ -1276,7 +1306,6 @@ static int hdspm_external_sample_rate(struct hdspm *hdspm)
 
 			rate_bits = status2 & HDSPM_wcFreqMask;
 
-
 			switch (rate_bits) {
 			case HDSPM_wcFreq32:
 				rate = 32000;
@@ -2220,11 +2249,12 @@ static int hdspm_get_wc_sample_rate(struct hdspm *hdspm)
 		status = hdspm_read(hdspm, HDSPM_RD_STATUS_1);
 		return (status >> 16) & 0xF;
 		break;
+	case AES32:
+		status = hdspm_read(hdspm, HDSPM_statusRegister);
+		return (status >> HDSPM_AES32_wcFreq_bit) & 0xF;
 	default:
 		break;
 	}
-
-
 	return 0;
 }
 
@@ -2243,11 +2273,13 @@ static int hdspm_get_tco_sample_rate(struct hdspm *hdspm)
 			status = hdspm_read(hdspm, HDSPM_RD_STATUS_1);
 			return (status >> 20) & 0xF;
 			break;
+		case AES32:
+			status = hdspm_read(hdspm, HDSPM_statusRegister);
+			return (status >> 1) & 0xF;
 		default:
 			break;
 		}
 	}
-
 	return 0;
 }
 
@@ -2274,6 +2306,23 @@ static int hdspm_get_sync_in_sample_rate(struct hdspm *hdspm)
 	return 0;
 }
 
+/**
+ * Returns the AES sample rate class for the given card.
+ **/
+static int hdspm_get_aes_sample_rate(struct hdspm *hdspm, int index)
+{
+	int timecode;
+
+	switch (hdspm->io_type) {
+	case AES32:
+		timecode = hdspm_read(hdspm, HDSPM_timecodeRegister);
+		return (timecode >> (4*index)) & 0xF;
+		break;
+	default:
+		break;
+	}
+	return 0;
+}
 
 /**
  * Returns the sample rate class for input source <idx> for
@@ -2282,7 +2331,6 @@ static int hdspm_get_sync_in_sample_rate(struct hdspm *hdspm)
 static int hdspm_get_s1_sample_rate(struct hdspm *hdspm, unsigned int idx)
 {
 	int status = hdspm_read(hdspm, HDSPM_RD_STATUS_2);
-
 	return (status >> (idx*4)) & 0xF;
 }
 
@@ -2380,10 +2428,22 @@ static int snd_hdspm_get_autosync_sample_rate(struct snd_kcontrol *kcontrol,
 			ucontrol->value.enumerated.item[0] =
 				hdspm_get_sync_in_sample_rate(hdspm);
 			break;
+		case 11: /* External Rate */
+			{
+			int rate = hdspm_external_sample_rate(hdspm);
+			int i, selected_rate = 0;
+			for (i = 1; i < 10; i++)
+				if (HDSPM_bit2freq(i) == rate) {
+					selected_rate = i;
+					break;
+				}
+			ucontrol->value.enumerated.item[0] = selected_rate;
+			}
+			break;
 		default: /* AES1 to AES8 */
 			ucontrol->value.enumerated.item[0] =
-				hdspm_get_s1_sample_rate(hdspm,
-						kcontrol->private_value-1);
+				hdspm_get_aes_sample_rate(hdspm,
+						kcontrol->private_value - HDSPM_AES32_AUTOSYNC_FROM_AES1);
 			break;
 		}
 		break;
@@ -2740,6 +2800,7 @@ static int hdspm_pref_sync_ref(struct hdspm * hdspm)
 static int hdspm_set_pref_sync_ref(struct hdspm * hdspm, int pref)
 {
 	int p = 0;
+	snd_printk(KERN_INFO "Setting Preferred Sync Reference to %d ", pref);
 
 	switch (hdspm->io_type) {
 	case AES32:
@@ -2964,19 +3025,20 @@ static int snd_hdspm_put_pref_sync_ref(struct snd_kcontrol *kcontrol,
 
 static int hdspm_autosync_ref(struct hdspm *hdspm)
 {
+	/* This looks at the autosync selected sync reference */
 	if (AES32 == hdspm->io_type) {
+
 		unsigned int status = hdspm_read(hdspm, HDSPM_statusRegister);
-		unsigned int syncref =
-			(status >> HDSPM_AES32_syncref_bit) & 0xF;
-		if (syncref == 0)
-			return HDSPM_AES32_AUTOSYNC_FROM_WORD;
-		if (syncref <= 8)
+		unsigned int syncref = (status >> HDSPM_AES32_syncref_bit) & 0xF;
+		if ((syncref >= HDSPM_AES32_AUTOSYNC_FROM_WORD) &&
+				(syncref <= HDSPM_AES32_AUTOSYNC_FROM_SYNC_IN)) {
 			return syncref;
+		}
 		return HDSPM_AES32_AUTOSYNC_FROM_NONE;
+
 	} else if (MADI == hdspm->io_type) {
-		/* This looks at the autosync selected sync reference */
-		unsigned int status2 = hdspm_read(hdspm, HDSPM_statusRegister2);
 
+		unsigned int status2 = hdspm_read(hdspm, HDSPM_statusRegister2);
 		switch (status2 & HDSPM_SelSyncRefMask) {
 		case HDSPM_SelSyncRef_WORD:
 			return HDSPM_AUTOSYNC_FROM_WORD;
@@ -2989,7 +3051,7 @@ static int hdspm_autosync_ref(struct hdspm *hdspm)
 		case HDSPM_SelSyncRef_NVALID:
 			return HDSPM_AUTOSYNC_FROM_NONE;
 		default:
-			return 0;
+			return HDSPM_AUTOSYNC_FROM_NONE;
 		}
 
 	}
@@ -3004,11 +3066,11 @@ static int snd_hdspm_info_autosync_ref(struct snd_kcontrol *kcontrol,
 
 	if (AES32 == hdspm->io_type) {
 		static char *texts[] = { "WordClock", "AES1", "AES2", "AES3",
-			"AES4",	"AES5", "AES6", "AES7", "AES8", "None"};
+			"AES4",	"AES5", "AES6", "AES7", "AES8", "TCO", "Sync In", "None"};
 
 		uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
 		uinfo->count = 1;
-		uinfo->value.enumerated.items = 10;
+		uinfo->value.enumerated.items = ARRAY_SIZE(texts);
 		if (uinfo->value.enumerated.item >=
 		    uinfo->value.enumerated.items)
 			uinfo->value.enumerated.item =
@@ -3042,7 +3104,6 @@ static int snd_hdspm_get_autosync_ref(struct snd_kcontrol *kcontrol,
 }
 
 
-
 #define HDSPM_TCO_VIDEO_INPUT_FORMAT(xname, xindex) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
 	.name = xname, \
@@ -3836,16 +3897,24 @@ static int hdspm_tco_sync_check(struct hdspm *hdspm)
 	if (hdspm->tco) {
 		switch (hdspm->io_type) {
 		case MADI:
+			status = hdspm_read(hdspm, HDSPM_statusRegister);
+			if (status & HDSPM_tcoLockMadi) {
+				if (status & HDSPM_tcoSync)
+					return 2;
+				else
+					return 1;
+			}
+			return 0;
+			break;
 		case AES32:
 			status = hdspm_read(hdspm, HDSPM_statusRegister);
-			if (status & HDSPM_tcoLock) {
+			if (status & HDSPM_tcoLockAes) {
 				if (status & HDSPM_tcoSync)
 					return 2;
 				else
 					return 1;
 			}
 			return 0;
-
 			break;
 
 		case RayDAT:
@@ -4436,7 +4505,7 @@ static struct snd_kcontrol_new snd_hdspm_controls_aes32[] = {
 	HDSPM_PREF_SYNC_REF("Preferred Sync Reference", 0),
 	HDSPM_AUTOSYNC_REF("AutoSync Reference", 0),
 	HDSPM_SYSTEM_SAMPLE_RATE("System Sample Rate", 0),
-	HDSPM_AUTOSYNC_SAMPLE_RATE("External Rate", 0),
+	HDSPM_AUTOSYNC_SAMPLE_RATE("External Rate", 11),
 	HDSPM_SYNC_CHECK("WC Sync Check", 0),
 	HDSPM_SYNC_CHECK("AES1 Sync Check", 1),
 	HDSPM_SYNC_CHECK("AES2 Sync Check", 2),
@@ -4592,77 +4661,22 @@ static int snd_hdspm_create_controls(struct snd_card *card,
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
-
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
@@ -4696,7 +4710,7 @@ snd_hdspm_proc_read_madi(struct snd_info_entry * entry,
 		} else if (a & HDSPM_TCO1_Video_Input_Format_PAL) {
 			snd_iprintf(buffer, "  Video: PAL\n");
 		} else {
-			snd_iprintf(buffer, "  No video\n");
+			snd_iprintf(buffer, "  no video\n");
 		}
 		if (a & HDSPM_TCO1_TCO_lock) {
 			snd_iprintf(buffer, "  Sync: lock\n");
@@ -4756,6 +4770,75 @@ snd_hdspm_proc_read_madi(struct snd_info_entry * entry,
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
 
@@ -4859,6 +4942,9 @@ snd_hdspm_proc_read_madi(struct snd_info_entry * entry,
 		(status & HDSPM_RX_64ch) ? "64 channels" :
 		"56 channels");
 
+	/* call readout function for TCO specific status */
+	snd_hdspm_proc_read_tco(entry, buffer);
+
 	snd_iprintf(buffer, "\n");
 }
 
@@ -5000,11 +5086,18 @@ snd_hdspm_proc_read_aes32(struct snd_info_entry * entry,
 		autosync_ref = "AES7"; break;
 	case HDSPM_AES32_AUTOSYNC_FROM_AES8:
 		autosync_ref = "AES8"; break;
+	case HDSPM_AES32_AUTOSYNC_FROM_TCO:
+		autosync_ref = "TCO"; break;
+	case HDSPM_AES32_AUTOSYNC_FROM_SYNC_IN:
+		autosync_ref = "Sync In"; break;
 	default:
 		autosync_ref = "---"; break;
 	}
 	snd_iprintf(buffer, "AutoSync ref = %s\n", autosync_ref);
 
+	/* call readout function for TCO specific status */
+	snd_hdspm_proc_read_tco(entry, buffer);
+
 	snd_iprintf(buffer, "\n");
 }
 
@@ -5067,6 +5160,8 @@ snd_hdspm_proc_read_raydat(struct snd_info_entry *entry,
 
 }
 
+
+
 #ifdef CONFIG_SND_DEBUG
 static void
 snd_hdspm_proc_read_debug(struct snd_info_entry *entry,
@@ -5188,7 +5283,7 @@ static int snd_hdspm_set_defaults(struct hdspm * hdspm)
 
 	case AES32:
 		hdspm->control_register =
-			HDSPM_ClockModeMaster |	/* Master Cloack Mode on */
+			HDSPM_ClockModeMaster |	/* Master Clock Mode on */
 			hdspm_encode_latency(7) | /* latency max=8192samples */
 			HDSPM_SyncRef0 |	/* AES1 is syncclock */
 			HDSPM_LineOut |	/* Analog output in */
@@ -5196,6 +5291,7 @@ static int snd_hdspm_set_defaults(struct hdspm * hdspm)
 		break;
 	}
 
+	snd_printk(KERN_INFO "Setting defaults...");
 	hdspm_write(hdspm, HDSPM_controlRegister, hdspm->control_register);
 
 	if (AES32 == hdspm->io_type) {
@@ -5461,6 +5557,12 @@ static int snd_hdspm_hw_params(struct snd_pcm_substream *substream,
 	   params_buffer_size(params));
 	   */
 
+	/*  For AES cards, the float format bit is the same as a preferred sync reference
+		Since we don't want to spoil the sync settings, the format setting is ignored.
+		Not very nice, but the Mac driver does the same thing.*/
+	if (hdspm->io_type == AES32) {
+		return 0;
+	}
 
 	/* Switch to native float format if requested */
 	if (SNDRV_PCM_FORMAT_FLOAT_LE == params_format(params)) {
@@ -6649,6 +6751,7 @@ static int snd_hdspm_create(struct snd_card *card,
 		break;
 
 	case MADI:
+	case AES32:
 		if (hdspm_read(hdspm, HDSPM_statusRegister) & HDSPM_tco_detect) {
 			hdspm->midiPorts++;
 			hdspm->tco = kzalloc(sizeof(struct hdspm_tco),
@@ -6656,7 +6759,7 @@ static int snd_hdspm_create(struct snd_card *card,
 			if (NULL != hdspm->tco) {
 				hdspm_tco_write(hdspm);
 			}
-			snd_printk(KERN_INFO "HDSPM: MADI TCO module found\n");
+			snd_printk(KERN_INFO "HDSPM: MADI/AES TCO module found\n");
 		} else {
 			hdspm->tco = NULL;
 		}
@@ -6671,10 +6774,12 @@ static int snd_hdspm_create(struct snd_card *card,
 	case AES32:
 		if (hdspm->tco) {
 			hdspm->texts_autosync = texts_autosync_aes_tco;
-			hdspm->texts_autosync_items = 10;
+			hdspm->texts_autosync_items =
+				ARRAY_SIZE(texts_autosync_aes_tco);
 		} else {
 			hdspm->texts_autosync = texts_autosync_aes;
-			hdspm->texts_autosync_items = 9;
+			hdspm->texts_autosync_items =
+				ARRAY_SIZE(texts_autosync_aes);
 		}
 		break;
 
-- 
1.8.3.1
