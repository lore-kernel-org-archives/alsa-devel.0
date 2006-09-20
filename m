From: Remy Bruno <remy.bruno@trinnov.com>
Subject: AES32 Driver
Date: Wed, 20 Sep 2006 13:35:20 +0200
Message-ID: <20060920113520.GA26592@trinnov.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="huq684BweRXVnRxX"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--huq684BweRXVnRxX
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline

Hi,

I modified the hdspm driver in order to support the RME AES32 card.
As I'm not sure if it is possible to get the rights for modifying the hg
repository, I send the diff file attached (obtained with "diff -u -r", as
neither "hg bundle" nor "hg outgoing -p" worked). This diff is against the last
hg tree.

The modifications have been done on the basis of the RME Windows driver source
code that RME sent to me (but that I am not allowed to send back). The AES32
and MADI cards are differentiated by the firmware revision. I tested the
modified driver on an AES32 and (at least partly) validated it. Of course, the
MADI part should not be concerned by my modifications, except for one point:
the offset of HDSPM_statusRegister2. In the original hdspm file, it is set to
96, but when I look at the source code by RME, it is set to 48 (but increment
is 32 bits, so it corresponds to 192), for AES32 as well as for MADI. So I set
it to 192 for both cards. The new driver should thus be tested on the MADI to
check if I didn't break this.

I also changed the hdsp driver: by default, precise_ptr was set to 1, which
does not work on the cards I have (our company uses many hdsp cards, so I was
able to check that this feature does not work at least on some cards). So I
reset it to 0, which works on all the cards we have. Of course, it is still
possible to change it back to 1 by using the appropriate control, but I think
it is better to have default values that work for all cards (and furthermore, I
don't see the purpose of this feature, as it works well without it...).

Please let me know if my changes are integrated in the main tree.

Regards,

Remy Bruno


--huq684BweRXVnRxX
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: attachment; filename="alsa-aes32.diff"

diff -u -r alsa-kernel/pci/rme9652/hdsp.c alsa-kernel-aes32/pci/rme9652/hdsp.c
--- alsa-kernel/pci/rme9652/hdsp.c	2006-09-20 11:57:16.000000000 +0200
+++ alsa-kernel-aes32/pci/rme9652/hdsp.c	2006-09-20 11:25:17.000000000 +0200
@@ -4940,7 +4940,7 @@
 	}
 
 	hdsp->irq = pci->irq;
-	hdsp->precise_ptr = 1;
+	hdsp->precise_ptr = 0;
 	hdsp->use_midi_tasklet = 1;
 
 	if ((err = snd_hdsp_initialize_memory(hdsp)) < 0)
diff -u -r alsa-kernel/pci/rme9652/hdspm.c alsa-kernel-aes32/pci/rme9652/hdspm.c
--- alsa-kernel/pci/rme9652/hdspm.c	2006-09-20 11:57:16.000000000 +0200
+++ alsa-kernel-aes32/pci/rme9652/hdspm.c	2006-09-20 11:50:39.000000000 +0200
@@ -6,6 +6,8 @@
  *      code based on hdsp.c   Paul Davis
  *                             Marcus Andersson
  *                             Thomas Charbonnel
+ *      Modified 2006-06-01 for AES32 support by Remy Bruno
+ *                                               <remy.bruno@trinnov.com>
  *
  *   This program is free software; you can redistribute it and/or modify
  *   it under the terms of the GNU General Public License as published by
@@ -77,7 +79,8 @@
 
 MODULE_AUTHOR
       ("Winfried Ritsch <ritsch_AT_iem.at>, Paul Davis <paul@linuxaudiosystems.com>, "
-       "Marcus Andersson, Thomas Charbonnel <thomas@undata.org>");
+       "Marcus Andersson, Thomas Charbonnel <thomas@undata.org>, "
+       "Remy Bruno <remy.bruno@trinnov.com>");
 MODULE_DESCRIPTION("RME HDSPM");
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{RME HDSPM-MADI}}");
@@ -107,7 +110,11 @@
 /* --- Read registers. ---
    These are defined as byte-offsets from the iobase value */
 #define HDSPM_statusRegister    0
-#define HDSPM_statusRegister2  96
+//#define HDSPM_statusRegister2  96
+/* after RME Windows driver sources, status2 is 4-byte word # 48 = word at
+ * offset 192, for AES32 and MADI */
+#define HDSPM_statusRegister2  192
+#define HDSPM_timecodeRegister 128
 
 #define HDSPM_midiDataIn0     360
 #define HDSPM_midiDataIn1     364
@@ -140,37 +147,50 @@
 #define HDSPM_Frequency0  (1<<6)  /* 0=44.1kHz/88.2kHz 1=48kHz/96kHz */
 #define HDSPM_Frequency1  (1<<7)  /* 0=32kHz/64kHz */
 #define HDSPM_DoubleSpeed (1<<8)  /* 0=normal speed, 1=double speed */
-#define HDSPM_QuadSpeed   (1<<31) /* quad speed bit, not implemented now */
+#define HDSPM_QuadSpeed   (1<<31) /* quad speed bit */
 
+#define HDSPM_Professional (1<<9) /* Professional */ /* AES32 ONLY */
 #define HDSPM_TX_64ch     (1<<10) /* Output 64channel MODE=1,
-				     56channelMODE=0 */
+				     56channelMODE=0 */ /* MADI ONLY*/
+#define HDSPM_Emphasis    (1<<10) /* Emphasis */ /* AES32 ONLY */
 
 #define HDSPM_AutoInp     (1<<11) /* Auto Input (takeover) == Safe Mode, 
-                                     0=off, 1=on  */
+                                     0=off, 1=on  */ /* MADI ONLY */
+#define HDSPM_Dolby       (1<<11) /* Dolby = "NonAudio" ?? */ /* AES32 ONLY */
 
-#define HDSPM_InputSelect0 (1<<14) /* Input select 0= optical, 1=coax */
+#define HDSPM_InputSelect0 (1<<14) /* Input select 0= optical, 1=coax */ /* MADI ONLY*/
 #define HDSPM_InputSelect1 (1<<15) /* should be 0 */
 
 #define HDSPM_SyncRef0     (1<<16) /* 0=WOrd, 1=MADI */
-#define HDSPM_SyncRef1     (1<<17) /* should be 0 */
+#define HDSPM_SyncRef1     (1<<17) /* for AES32: SyncRefN codes the AES # */
+#define HDSPM_SyncRef2     (1<<13)
+#define HDSPM_SyncRef3     (1<<25)
 
+#define HDSPM_SMUX         (1<<18) /* Frame ??? */ /* MADI ONY */
 #define HDSPM_clr_tms      (1<<19) /* clear track marker, do not use 
                                       AES additional bits in
 				      lower 5 Audiodatabits ??? */
+#define HDSPM_taxi_reset   (1<<20) /* ??? */ /* MADI ONLY ? */
+#define HDSPM_WCK48        (1<<20) /* Frame ??? = HDSPM_SMUX */ /* AES32 ONLY */
 
 #define HDSPM_Midi0InterruptEnable (1<<22)
 #define HDSPM_Midi1InterruptEnable (1<<23)
 
 #define HDSPM_LineOut (1<<24) /* Analog Out on channel 63/64 on=1, mute=0 */
 
+#define HDSPM_DS_DoubleWire (1<<26) /* AES32 ONLY */
+#define HDSPM_QS_DoubleWire (1<<27) /* AES32 ONLY */
+#define HDSPM_QS_QuadWire   (1<<28) /* AES32 ONLY */
+
+#define HDSPM_wclk_sel (1<<30)
 
 /* --- bit helper defines */
 #define HDSPM_LatencyMask    (HDSPM_Latency0|HDSPM_Latency1|HDSPM_Latency2)
-#define HDSPM_FrequencyMask  (HDSPM_Frequency0|HDSPM_Frequency1)
+#define HDSPM_FrequencyMask  (HDSPM_Frequency0|HDSPM_Frequency1|HDSPM_DoubleSpeed|HDSPM_QuadSpeed)
 #define HDSPM_InputMask      (HDSPM_InputSelect0|HDSPM_InputSelect1)
 #define HDSPM_InputOptical   0
 #define HDSPM_InputCoaxial   (HDSPM_InputSelect0)
-#define HDSPM_SyncRefMask    (HDSPM_SyncRef0|HDSPM_SyncRef1)
+#define HDSPM_SyncRefMask    (HDSPM_SyncRef0|HDSPM_SyncRef1|HDSPM_SyncRef2|HDSPM_SyncRef3)
 #define HDSPM_SyncRef_Word   0
 #define HDSPM_SyncRef_MADI   (HDSPM_SyncRef0)
 
@@ -183,6 +203,9 @@
 #define HDSPM_Frequency64KHz   (HDSPM_DoubleSpeed|HDSPM_Frequency0)
 #define HDSPM_Frequency88_2KHz (HDSPM_DoubleSpeed|HDSPM_Frequency1)
 #define HDSPM_Frequency96KHz   (HDSPM_DoubleSpeed|HDSPM_Frequency1|HDSPM_Frequency0)
+#define HDSPM_Frequency128KHz   (HDSPM_QuadSpeed|HDSPM_Frequency0)
+#define HDSPM_Frequency176_4KHz   (HDSPM_QuadSpeed|HDSPM_Frequency1)
+#define HDSPM_Frequency192KHz   (HDSPM_QuadSpeed|HDSPM_Frequency1|HDSPM_Frequency0)
 
 /* --- for internal discrimination */
 #define HDSPM_CLOCK_SOURCE_AUTOSYNC          0	/* Sample Clock Sources */
@@ -229,7 +252,8 @@
 #define HDSPM_BIGENDIAN_MODE  (1<<9)
 #define HDSPM_RD_MULTIPLE     (1<<10)
 
-/* --- Status Register bits --- */
+/* --- Status Register bits --- */ /* MADI ONLY */ /* Bits defined here and
+     that do not conflict with specific bits for AES32 seem to be valid also for the AES32 */
 #define HDSPM_audioIRQPending    (1<<0)	/* IRQ is high and pending */
 #define HDSPM_RX_64ch            (1<<1)	/* Input 64chan. MODE=1, 56chn. MODE=0 */
 #define HDSPM_AB_int             (1<<2)	/* InputChannel Opt=0, Coax=1 (like inp0) */
@@ -263,7 +287,7 @@
 #define HDSPM_madiFreq176_4 (HDSPM_madiFreq3)
 #define HDSPM_madiFreq192   (HDSPM_madiFreq3|HDSPM_madiFreq0)
 
-/* Status2 Register bits */
+/* Status2 Register bits */ /* MADI ONLY */
 
 #define HDSPM_version0 (1<<0)	/* not realy defined but I guess */
 #define HDSPM_version1 (1<<1)	/* in former cards it was ??? */
@@ -297,6 +321,63 @@
 #define HDSPM_SelSyncRef_MADI      (HDSPM_SelSyncRef0)
 #define HDSPM_SelSyncRef_NVALID    (HDSPM_SelSyncRef0|HDSPM_SelSyncRef1|HDSPM_SelSyncRef2)
 
+/*
+   For AES32, bits for status, status2 and timecode are different
+*/
+// status
+#define HDSPM_AES32_wcLock	0x0200000
+#define HDSPM_AES32_wcFreq_bit  22
+// (status >> HDSPM_AES32_wcFreq_bit) & 0xF gives WC frequency
+#define HDSPM_bit2freq(n) (\
+    (n)==1?32000:\
+    (n)==2?44100:\
+    (n)==3?48000:\
+    (n)==4?64000:\
+    (n)==5?88200:\
+    (n)==6?96000:\
+    (n)==7?128000:\
+    (n)==8?176400:\
+    (n)==9?192000:0)
+// (status >> HDSPM_AES32_syncref_bit) & 0xF gives sync source
+#define HDSPM_AES32_syncref_bit  16
+
+#define HDSPM_AES32_AUTOSYNC_FROM_WORD 0
+#define HDSPM_AES32_AUTOSYNC_FROM_AES1 1
+#define HDSPM_AES32_AUTOSYNC_FROM_AES2 2
+#define HDSPM_AES32_AUTOSYNC_FROM_AES3 3
+#define HDSPM_AES32_AUTOSYNC_FROM_AES4 4
+#define HDSPM_AES32_AUTOSYNC_FROM_AES5 5
+#define HDSPM_AES32_AUTOSYNC_FROM_AES6 6
+#define HDSPM_AES32_AUTOSYNC_FROM_AES7 7
+#define HDSPM_AES32_AUTOSYNC_FROM_AES8 8
+#define HDSPM_AES32_AUTOSYNC_FROM_NONE -1
+
+// status2
+//#define HDSPM_LockAES_bit 
+// bit given by HDSPM_LockAES >> (AES# - 1)
+#define HDSPM_LockAES   0x80
+#define HDSPM_LockAES1  0x80
+#define HDSPM_LockAES2  0x40
+#define HDSPM_LockAES3  0x20
+#define HDSPM_LockAES4  0x10
+#define HDSPM_LockAES5  0x8
+#define HDSPM_LockAES6  0x4
+#define HDSPM_LockAES7  0x2
+#define HDSPM_LockAES8  0x1
+// timecode
+//   bits 4*i to 4*i+3 give the input frequency on AES i+1
+// bits 3210
+//      0001  32kHz
+//      0010  44.1kHz
+//      0011  48kHz
+//      0100  64kHz
+//      0101  88.2kHz
+//      0110  96kHz
+//      0111  128kHz
+//      1000  176.4kHz
+//      1001  192kHz
+//  NB: Timecode register doesn't seem to work on AES32 card revision 230
+
 /* Mixer Values */
 #define UNITY_GAIN          32768	/* = 65536/2 */
 #define MINUS_INFINITY_GAIN 0
@@ -314,10 +395,14 @@
    size is the same regardless of the number of channels, and
    also the latency to use. 
    for one direction !!!
+   => need to mupltiply by 2!!
 */
-#define HDSPM_DMA_AREA_BYTES (HDSPM_MAX_CHANNELS * HDSPM_CHANNEL_BUFFER_BYTES)
+#define HDSPM_DMA_AREA_BYTES (2 * HDSPM_MAX_CHANNELS * HDSPM_CHANNEL_BUFFER_BYTES)
 #define HDSPM_DMA_AREA_KILOBYTES (HDSPM_DMA_AREA_BYTES/1024)
 
+// revisions >= 230 indicate AES32 card
+#define HDSPM_AESREVISION 230
+
 struct hdspm_midi {
 	struct hdspm *hdspm;
 	int id;
@@ -336,7 +421,9 @@
         struct snd_pcm_substream *playback_substream; /* and/or capture stream */
 
 	char *card_name;	     /* for procinfo */
-	unsigned short firmware_rev; /* dont know if relevant */
+	unsigned short firmware_rev; /* dont know if relevant (yes if AES32)*/
+
+        unsigned char is_aes32;    // indicates if card is AES32
 
 	int precise_ptr;	/* use precise pointers, to be tested */
 	int monitor_outs;	/* set up monitoring outs init flag */
@@ -544,86 +631,107 @@
 /* check for external sample rate */
 static inline int hdspm_external_sample_rate(struct hdspm * hdspm)
 {
-	unsigned int status2 = hdspm_read(hdspm, HDSPM_statusRegister2);
-	unsigned int status = hdspm_read(hdspm, HDSPM_statusRegister);
-	unsigned int rate_bits;
-	int rate = 0;
-
-	/* if wordclock has synced freq and wordclock is valid */
-	if ((status2 & HDSPM_wcLock) != 0 &&
-	    (status & HDSPM_SelSyncRef0) == 0) {
-
-		rate_bits = status2 & HDSPM_wcFreqMask;
-
-		switch (rate_bits) {
-		case HDSPM_wcFreq32:
-			rate = 32000;
-			break;
-		case HDSPM_wcFreq44_1:
-			rate = 44100;
-			break;
-		case HDSPM_wcFreq48:
-			rate = 48000;
-			break;
-		case HDSPM_wcFreq64:
-			rate = 64000;
-			break;
-		case HDSPM_wcFreq88_2:
-			rate = 88200;
-			break;
-		case HDSPM_wcFreq96:
-			rate = 96000;
-			break;
-			/* Quadspeed Bit missing ???? */
-		default:
-			rate = 0;
-			break;
-		}
-	}
-
-	/* if rate detected and Syncref is Word than have it, word has priority to MADI */
-	if (rate != 0
-	    && (status2 & HDSPM_SelSyncRefMask) == HDSPM_SelSyncRef_WORD)
-		return rate;
-
-	/* maby a madi input (which is taken if sel sync is madi) */
-	if (status & HDSPM_madiLock) {
-		rate_bits = status & HDSPM_madiFreqMask;
-
-		switch (rate_bits) {
-		case HDSPM_madiFreq32:
-			rate = 32000;
-			break;
-		case HDSPM_madiFreq44_1:
-			rate = 44100;
-			break;
-		case HDSPM_madiFreq48:
-			rate = 48000;
-			break;
-		case HDSPM_madiFreq64:
-			rate = 64000;
-			break;
-		case HDSPM_madiFreq88_2:
-			rate = 88200;
-			break;
-		case HDSPM_madiFreq96:
-			rate = 96000;
-			break;
-		case HDSPM_madiFreq128:
-			rate = 128000;
-			break;
-		case HDSPM_madiFreq176_4:
-			rate = 176400;
-			break;
-		case HDSPM_madiFreq192:
-			rate = 192000;
-			break;
-		default:
-			rate = 0;
-			break;
-		}
-	}
-	return rate;
+  if (hdspm->is_aes32)
+  {
+    unsigned int status2 = hdspm_read(hdspm, HDSPM_statusRegister2);
+    unsigned int status = hdspm_read(hdspm, HDSPM_statusRegister);
+    unsigned int timecode = hdspm_read(hdspm, HDSPM_timecodeRegister);
+
+    int syncref = hdspm_autosync_ref(hdspm);
+
+    if (syncref == HDSPM_AES32_AUTOSYNC_FROM_WORD &&
+        status & HDSPM_AES32_wcLock)
+      return HDSPM_bit2freq((status >> HDSPM_AES32_wcFreq_bit) & 0xF);
+    if (syncref >= HDSPM_AES32_AUTOSYNC_FROM_AES1 &&
+        syncref <= HDSPM_AES32_AUTOSYNC_FROM_AES8 &&
+        status2 & (HDSPM_LockAES >> (syncref - HDSPM_AES32_AUTOSYNC_FROM_AES1)))
+      return HDSPM_bit2freq(
+          (timecode >> (4*(syncref-HDSPM_AES32_AUTOSYNC_FROM_AES1))) & 0xF);
+    return 0;
+  }
+  else
+  {
+    unsigned int status2 = hdspm_read(hdspm, HDSPM_statusRegister2);
+    unsigned int status = hdspm_read(hdspm, HDSPM_statusRegister);
+    unsigned int rate_bits;
+    int rate = 0;
+
+    /* if wordclock has synced freq and wordclock is valid */
+    if ((status2 & HDSPM_wcLock) != 0 &&
+        (status & HDSPM_SelSyncRef0) == 0) {
+
+      rate_bits = status2 & HDSPM_wcFreqMask;
+
+      switch (rate_bits) {
+        case HDSPM_wcFreq32:
+          rate = 32000;
+          break;
+        case HDSPM_wcFreq44_1:
+          rate = 44100;
+          break;
+        case HDSPM_wcFreq48:
+          rate = 48000;
+          break;
+        case HDSPM_wcFreq64:
+          rate = 64000;
+          break;
+        case HDSPM_wcFreq88_2:
+          rate = 88200;
+          break;
+        case HDSPM_wcFreq96:
+          rate = 96000;
+          break;
+          /* Quadspeed Bit missing ???? */
+        default:
+          rate = 0;
+          break;
+      }
+    }
+
+    /* if rate detected and Syncref is Word than have it, word has priority to MADI */
+    if (rate != 0
+        && (status2 & HDSPM_SelSyncRefMask) == HDSPM_SelSyncRef_WORD)
+      return rate;
+
+    /* maby a madi input (which is taken if sel sync is madi) */
+    if (status & HDSPM_madiLock) {
+      rate_bits = status & HDSPM_madiFreqMask;
+
+      switch (rate_bits) {
+        case HDSPM_madiFreq32:
+          rate = 32000;
+          break;
+        case HDSPM_madiFreq44_1:
+          rate = 44100;
+          break;
+        case HDSPM_madiFreq48:
+          rate = 48000;
+          break;
+        case HDSPM_madiFreq64:
+          rate = 64000;
+          break;
+        case HDSPM_madiFreq88_2:
+          rate = 88200;
+          break;
+        case HDSPM_madiFreq96:
+          rate = 96000;
+          break;
+        case HDSPM_madiFreq128:
+          rate = 128000;
+          break;
+        case HDSPM_madiFreq176_4:
+          rate = 176400;
+          break;
+        case HDSPM_madiFreq192:
+          rate = 192000;
+          break;
+        default:
+          rate = 0;
+          break;
+      }
+    }
+    return rate;
+  }
 }
 
 /* Latency function */
@@ -676,7 +784,9 @@
 	int n = hdspm->period_bytes;
 	void *buf = hdspm->playback_buffer;
 
-	snd_assert(buf != NULL, return);
+//	snd_assert(buf != NULL, return);
+        if (buf == NULL)
+          return;
 
 	for (i = 0; i < HDSPM_MAX_CHANNELS; i++) {
 		memset(buf, 0, n);
@@ -716,6 +826,7 @@
 	int current_rate;
 	int rate_bits;
 	int not_set = 0;
+        int is_single, is_double, is_quad;
 
 	/* ASSUMPTION: hdspm->lock is either set, or there is no need for
 	   it (e.g. during module initialization).
@@ -766,43 +877,65 @@
 	   changes in the read/write routines.  
 	 */
 
+        is_single = (current_rate <= 48000);
+        is_double = (current_rate > 48000 && current_rate <= 96000);
+        is_quad = (current_rate > 96000);
+        
 	switch (rate) {
 	case 32000:
-		if (current_rate > 48000) {
+		if (!is_single) {
 			reject_if_open = 1;
 		}
 		rate_bits = HDSPM_Frequency32KHz;
 		break;
 	case 44100:
-		if (current_rate > 48000) {
+		if (!is_single) {
 			reject_if_open = 1;
 		}
 		rate_bits = HDSPM_Frequency44_1KHz;
 		break;
 	case 48000:
-		if (current_rate > 48000) {
+		if (!is_single) {
 			reject_if_open = 1;
 		}
 		rate_bits = HDSPM_Frequency48KHz;
 		break;
 	case 64000:
-		if (current_rate <= 48000) {
+		if (!is_double) {
 			reject_if_open = 1;
 		}
 		rate_bits = HDSPM_Frequency64KHz;
 		break;
 	case 88200:
-		if (current_rate <= 48000) {
+		if (!is_double) {
 			reject_if_open = 1;
 		}
 		rate_bits = HDSPM_Frequency88_2KHz;
 		break;
 	case 96000:
-		if (current_rate <= 48000) {
+		if (!is_double) {
 			reject_if_open = 1;
 		}
 		rate_bits = HDSPM_Frequency96KHz;
 		break;
+	case 128000:
+		if (!is_quad) {
+			reject_if_open = 1;
+		}
+		rate_bits = HDSPM_Frequency128KHz;
+		break;
+	case 176400:
+		if (!is_quad) {
+			reject_if_open = 1;
+		}
+		rate_bits = HDSPM_Frequency176_4KHz;
+		break;
+	case 192000:
+		if (!is_quad) {
+			reject_if_open = 1;
+		}
+		rate_bits = HDSPM_Frequency192KHz;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -819,7 +952,7 @@
 	hdspm->control_register |= rate_bits;
 	hdspm_write(hdspm, HDSPM_controlRegister, hdspm->control_register);
 
-	if (rate > 64000)
+	if (rate > 96000 /* 64000*/)
 		hdspm->channel_map = channel_map_madi_qs;
 	else if (rate > 48000)
 		hdspm->channel_map = channel_map_madi_ds;
@@ -1452,53 +1585,112 @@
 
 static int hdspm_pref_sync_ref(struct hdspm * hdspm)
 {
-	/* Notice that this looks at the requested sync source,
-	   not the one actually in use.
-	 */
-	switch (hdspm->control_register & HDSPM_SyncRefMask) {
-	case HDSPM_SyncRef_Word:
-		return HDSPM_SYNC_FROM_WORD;
-	case HDSPM_SyncRef_MADI:
-		return HDSPM_SYNC_FROM_MADI;
-	}
+  /* Notice that this looks at the requested sync source,
+     not the one actually in use.
+   */
+  if (hdspm->is_aes32)
+  {
+    switch (hdspm->control_register & HDSPM_SyncRefMask)
+    {
+      // number gives number of AES, except for 0 which corresponds to
+      // WordClock
+      case 0: return 0;
+      case HDSPM_SyncRef0: return 1;
+      case HDSPM_SyncRef1: return 2;
+      case HDSPM_SyncRef1+HDSPM_SyncRef0: return 3;
+      case HDSPM_SyncRef2: return 4;
+      case HDSPM_SyncRef2+HDSPM_SyncRef0: return 5;
+      case HDSPM_SyncRef2+HDSPM_SyncRef1: return 6;
+      case HDSPM_SyncRef2+HDSPM_SyncRef1+HDSPM_SyncRef0: return 7;
+      case HDSPM_SyncRef3: return 8;
+    }
+  }
+  else
+  {
+    switch (hdspm->control_register & HDSPM_SyncRefMask) {
+      case HDSPM_SyncRef_Word:
+        return HDSPM_SYNC_FROM_WORD;
+      case HDSPM_SyncRef_MADI:
+        return HDSPM_SYNC_FROM_MADI;
+    }
+  }
 
-	return HDSPM_SYNC_FROM_WORD;
+  return HDSPM_SYNC_FROM_WORD;
 }
 
 static int hdspm_set_pref_sync_ref(struct hdspm * hdspm, int pref)
 {
-	hdspm->control_register &= ~HDSPM_SyncRefMask;
+  hdspm->control_register &= ~HDSPM_SyncRefMask;
 
-	switch (pref) {
-	case HDSPM_SYNC_FROM_MADI:
-		hdspm->control_register |= HDSPM_SyncRef_MADI;
-		break;
-	case HDSPM_SYNC_FROM_WORD:
-		hdspm->control_register |= HDSPM_SyncRef_Word;
-		break;
-	default:
-		return -1;
-	}
-	hdspm_write(hdspm, HDSPM_controlRegister, hdspm->control_register);
-	return 0;
+  if (hdspm->is_aes32)
+  {
+    switch (pref) {
+      case 0: hdspm->control_register |= 0; break;
+      case 1: hdspm->control_register |= HDSPM_SyncRef0; break;
+      case 2: hdspm->control_register |= HDSPM_SyncRef1; break;
+      case 3: hdspm->control_register |= HDSPM_SyncRef1+HDSPM_SyncRef0; break;
+      case 4: hdspm->control_register |= HDSPM_SyncRef2; break;
+      case 5: hdspm->control_register |= HDSPM_SyncRef2+HDSPM_SyncRef0; break;
+      case 6: hdspm->control_register |= HDSPM_SyncRef2+HDSPM_SyncRef1; break;
+      case 7: hdspm->control_register |= HDSPM_SyncRef2+HDSPM_SyncRef1+HDSPM_SyncRef0; break;
+      case 8: hdspm->control_register |= HDSPM_SyncRef3; break;
+      default: return -1;
+    }
+  }
+  else
+  {
+    switch (pref) {
+      case HDSPM_SYNC_FROM_MADI:
+        hdspm->control_register |= HDSPM_SyncRef_MADI;
+        break;
+      case HDSPM_SYNC_FROM_WORD:
+        hdspm->control_register |= HDSPM_SyncRef_Word;
+        break;
+      default:
+        return -1;
+    }
+  }
+  hdspm_write(hdspm, HDSPM_controlRegister, hdspm->control_register);
+  return 0;
 }
 
 static int snd_hdspm_info_pref_sync_ref(struct snd_kcontrol *kcontrol,
 					struct snd_ctl_elem_info *uinfo)
 {
-	static char *texts[] = { "Word", "MADI" };
-
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-
-	uinfo->value.enumerated.items = 2;
+  struct hdspm *hdspm = snd_kcontrol_chip(kcontrol);
 
-	if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
-		uinfo->value.enumerated.item =
-		    uinfo->value.enumerated.items - 1;
-	strcpy(uinfo->value.enumerated.name,
-	       texts[uinfo->value.enumerated.item]);
-	return 0;
+  if (hdspm->is_aes32)
+  {
+    static char *texts[] = { "Word", "AES1", "AES2", "AES3", "AES4", "AES5",
+      "AES6", "AES7", "AES8" };
+
+    uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+    uinfo->count = 1;
+
+    uinfo->value.enumerated.items = 9;
+
+    if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
+      uinfo->value.enumerated.item =
+        uinfo->value.enumerated.items - 1;
+    strcpy(uinfo->value.enumerated.name,
+        texts[uinfo->value.enumerated.item]);
+  }
+  else
+  {
+    static char *texts[] = { "Word", "MADI" };
+
+    uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+    uinfo->count = 1;
+
+    uinfo->value.enumerated.items = 2;
+
+    if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
+      uinfo->value.enumerated.item =
+        uinfo->value.enumerated.items - 1;
+    strcpy(uinfo->value.enumerated.name,
+        texts[uinfo->value.enumerated.item]);
+  }
+  return 0;
 }
 
 static int snd_hdspm_get_pref_sync_ref(struct snd_kcontrol *kcontrol,
@@ -1513,22 +1705,22 @@
 static int snd_hdspm_put_pref_sync_ref(struct snd_kcontrol *kcontrol,
 				       struct snd_ctl_elem_value *ucontrol)
 {
-	struct hdspm *hdspm = snd_kcontrol_chip(kcontrol);
-	int change, max;
-	unsigned int val;
-
-	max = 2;
-
-	if (!snd_hdspm_use_is_exclusive(hdspm))
-		return -EBUSY;
-
-	val = ucontrol->value.enumerated.item[0] % max;
-
-	spin_lock_irq(&hdspm->lock);
-	change = (int) val != hdspm_pref_sync_ref(hdspm);
-	hdspm_set_pref_sync_ref(hdspm, val);
-	spin_unlock_irq(&hdspm->lock);
-	return change;
+  struct hdspm *hdspm = snd_kcontrol_chip(kcontrol);
+  int change, max;
+  unsigned int val;
+
+  max = hdspm->is_aes32? 9 : 2;
+
+  if (!snd_hdspm_use_is_exclusive(hdspm))
+    return -EBUSY;
+
+  val = ucontrol->value.enumerated.item[0] % max;
+
+  spin_lock_irq(&hdspm->lock);
+  change = (int) val != hdspm_pref_sync_ref(hdspm);
+  hdspm_set_pref_sync_ref(hdspm, val);
+  spin_unlock_irq(&hdspm->lock);
+  return change;
 }
 
 #define HDSPM_AUTOSYNC_REF(xname, xindex) \
@@ -1542,41 +1734,73 @@
 
 static int hdspm_autosync_ref(struct hdspm * hdspm)
 {
-	/* This looks at the autosync selected sync reference */
-	unsigned int status2 = hdspm_read(hdspm, HDSPM_statusRegister2);
-
-	switch (status2 & HDSPM_SelSyncRefMask) {
-
-	case HDSPM_SelSyncRef_WORD:
-		return HDSPM_AUTOSYNC_FROM_WORD;
-
-	case HDSPM_SelSyncRef_MADI:
-		return HDSPM_AUTOSYNC_FROM_MADI;
-
-	case HDSPM_SelSyncRef_NVALID:
-		return HDSPM_AUTOSYNC_FROM_NONE;
-
-	default:
-		return 0;
-	}
+  if (hdspm->is_aes32)
+  {
+    unsigned int status = hdspm_read(hdspm, HDSPM_statusRegister);
+    unsigned int syncref = (status >> HDSPM_AES32_syncref_bit) & 0xF;
+    if (syncref == 0)
+      return HDSPM_AES32_AUTOSYNC_FROM_WORD;
+    if (syncref <= 8)
+      return syncref;
+    return HDSPM_AES32_AUTOSYNC_FROM_NONE;
+  }
+  else
+  {
+    /* This looks at the autosync selected sync reference */
+    unsigned int status2 = hdspm_read(hdspm, HDSPM_statusRegister2);
+
+    switch (status2 & HDSPM_SelSyncRefMask) {
+
+      case HDSPM_SelSyncRef_WORD:
+        return HDSPM_AUTOSYNC_FROM_WORD;
+
+      case HDSPM_SelSyncRef_MADI:
+        return HDSPM_AUTOSYNC_FROM_MADI;
+
+      case HDSPM_SelSyncRef_NVALID:
+        return HDSPM_AUTOSYNC_FROM_NONE;
+
+      default:
+        return 0;
+    }
 
-	return 0;
+    return 0;
+  }
 }
 
 static int snd_hdspm_info_autosync_ref(struct snd_kcontrol *kcontrol,
 				       struct snd_ctl_elem_info *uinfo)
 {
-	static char *texts[] = { "WordClock", "MADI", "None" };
+  struct hdspm *hdspm = snd_kcontrol_chip(kcontrol);
 
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = 3;
-	if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
-		uinfo->value.enumerated.item =
-		    uinfo->value.enumerated.items - 1;
-	strcpy(uinfo->value.enumerated.name,
-	       texts[uinfo->value.enumerated.item]);
-	return 0;
+  if (hdspm->is_aes32)
+  {
+    static char *texts[] = { "WordClock", "AES1", "AES2", "AES3", "AES4",
+      "AES5", "AES6", "AES7", "AES8", "None"};
+
+    uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+    uinfo->count = 1;
+    uinfo->value.enumerated.items = 10;
+    if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
+      uinfo->value.enumerated.item =
+        uinfo->value.enumerated.items - 1;
+    strcpy(uinfo->value.enumerated.name,
+        texts[uinfo->value.enumerated.item]);
+  }
+  else
+  {
+    static char *texts[] = { "WordClock", "MADI", "None" };
+
+    uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+    uinfo->count = 1;
+    uinfo->value.enumerated.items = 3;
+    if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
+      uinfo->value.enumerated.item =
+        uinfo->value.enumerated.items - 1;
+    strcpy(uinfo->value.enumerated.name,
+        texts[uinfo->value.enumerated.item]);
+  }
+  return 0;
 }
 
 static int snd_hdspm_get_autosync_ref(struct snd_kcontrol *kcontrol,
@@ -1841,6 +2065,195 @@
 	return change;
 }
 
+#define HDSPM_EMPHASIS(xname, xindex) \
+{ .iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
+  .name = xname, \
+  .index = xindex, \
+  .info = snd_hdspm_info_emphasis, \
+  .get = snd_hdspm_get_emphasis, \
+  .put = snd_hdspm_put_emphasis \
+}
+
+static int hdspm_emphasis(struct hdspm * hdspm)
+{
+	return (hdspm->control_register & HDSPM_Emphasis) ? 1 : 0;
+}
+
+static int hdspm_set_emphasis(struct hdspm * hdspm, int emp)
+{
+	if (emp)
+		hdspm->control_register |= HDSPM_Emphasis;
+	else
+		hdspm->control_register &= ~HDSPM_Emphasis;
+	hdspm_write(hdspm, HDSPM_controlRegister, hdspm->control_register);
+
+	return 0;
+}
+
+static int snd_hdspm_info_emphasis(struct snd_kcontrol *kcontrol,
+				       struct snd_ctl_elem_info *uinfo)
+{
+  uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
+  uinfo->count = 1;
+  uinfo->value.integer.min = 0;
+  uinfo->value.integer.max = 1;
+  return 0;
+}
+
+static int snd_hdspm_get_emphasis(struct snd_kcontrol *kcontrol,
+				      struct snd_ctl_elem_value *ucontrol)
+{
+	struct hdspm *hdspm = snd_kcontrol_chip(kcontrol);
+
+	spin_lock_irq(&hdspm->lock);
+	ucontrol->value.enumerated.item[0] = hdspm_emphasis(hdspm);
+	spin_unlock_irq(&hdspm->lock);
+	return 0;
+}
+
+static int snd_hdspm_put_emphasis(struct snd_kcontrol *kcontrol,
+				      struct snd_ctl_elem_value *ucontrol)
+{
+	struct hdspm *hdspm = snd_kcontrol_chip(kcontrol);
+	int change;
+	unsigned int val;
+
+	if (!snd_hdspm_use_is_exclusive(hdspm))
+		return -EBUSY;
+	val = ucontrol->value.integer.value[0] & 1;
+	spin_lock_irq(&hdspm->lock);
+	change = (int) val != hdspm_emphasis(hdspm);
+	hdspm_set_emphasis(hdspm, val);
+	spin_unlock_irq(&hdspm->lock);
+	return change;
+}
+
+#define HDSPM_DOLBY(xname, xindex) \
+{ .iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
+  .name = xname, \
+  .index = xindex, \
+  .info = snd_hdspm_info_dolby, \
+  .get = snd_hdspm_get_dolby, \
+  .put = snd_hdspm_put_dolby \
+}
+
+static int hdspm_dolby(struct hdspm * hdspm)
+{
+	return (hdspm->control_register & HDSPM_Dolby) ? 1 : 0;
+}
+
+static int hdspm_set_dolby(struct hdspm * hdspm, int dol)
+{
+	if (dol)
+		hdspm->control_register |= HDSPM_Dolby;
+	else
+		hdspm->control_register &= ~HDSPM_Dolby;
+	hdspm_write(hdspm, HDSPM_controlRegister, hdspm->control_register);
+
+	return 0;
+}
+
+static int snd_hdspm_info_dolby(struct snd_kcontrol *kcontrol,
+				       struct snd_ctl_elem_info *uinfo)
+{
+  uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
+  uinfo->count = 1;
+  uinfo->value.integer.min = 0;
+  uinfo->value.integer.max = 1;
+  return 0;
+}
+
+static int snd_hdspm_get_dolby(struct snd_kcontrol *kcontrol,
+				      struct snd_ctl_elem_value *ucontrol)
+{
+	struct hdspm *hdspm = snd_kcontrol_chip(kcontrol);
+
+	spin_lock_irq(&hdspm->lock);
+	ucontrol->value.enumerated.item[0] = hdspm_dolby(hdspm);
+	spin_unlock_irq(&hdspm->lock);
+	return 0;
+}
+
+static int snd_hdspm_put_dolby(struct snd_kcontrol *kcontrol,
+				      struct snd_ctl_elem_value *ucontrol)
+{
+	struct hdspm *hdspm = snd_kcontrol_chip(kcontrol);
+	int change;
+	unsigned int val;
+
+	if (!snd_hdspm_use_is_exclusive(hdspm))
+		return -EBUSY;
+	val = ucontrol->value.integer.value[0] & 1;
+	spin_lock_irq(&hdspm->lock);
+	change = (int) val != hdspm_dolby(hdspm);
+	hdspm_set_dolby(hdspm, val);
+	spin_unlock_irq(&hdspm->lock);
+	return change;
+}
+
+#define HDSPM_PROFESSIONAL(xname, xindex) \
+{ .iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
+  .name = xname, \
+  .index = xindex, \
+  .info = snd_hdspm_info_professional, \
+  .get = snd_hdspm_get_professional, \
+  .put = snd_hdspm_put_professional \
+}
+
+static int hdspm_professional(struct hdspm * hdspm)
+{
+	return (hdspm->control_register & HDSPM_Professional) ? 1 : 0;
+}
+
+static int hdspm_set_professional(struct hdspm * hdspm, int dol)
+{
+	if (dol)
+		hdspm->control_register |= HDSPM_Professional;
+	else
+		hdspm->control_register &= ~HDSPM_Professional;
+	hdspm_write(hdspm, HDSPM_controlRegister, hdspm->control_register);
+
+	return 0;
+}
+
+static int snd_hdspm_info_professional(struct snd_kcontrol *kcontrol,
+				       struct snd_ctl_elem_info *uinfo)
+{
+  uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
+  uinfo->count = 1;
+  uinfo->value.integer.min = 0;
+  uinfo->value.integer.max = 1;
+  return 0;
+}
+
+static int snd_hdspm_get_professional(struct snd_kcontrol *kcontrol,
+				      struct snd_ctl_elem_value *ucontrol)
+{
+	struct hdspm *hdspm = snd_kcontrol_chip(kcontrol);
+
+	spin_lock_irq(&hdspm->lock);
+	ucontrol->value.enumerated.item[0] = hdspm_professional(hdspm);
+	spin_unlock_irq(&hdspm->lock);
+	return 0;
+}
+
+static int snd_hdspm_put_professional(struct snd_kcontrol *kcontrol,
+				      struct snd_ctl_elem_value *ucontrol)
+{
+	struct hdspm *hdspm = snd_kcontrol_chip(kcontrol);
+	int change;
+	unsigned int val;
+
+	if (!snd_hdspm_use_is_exclusive(hdspm))
+		return -EBUSY;
+	val = ucontrol->value.integer.value[0] & 1;
+	spin_lock_irq(&hdspm->lock);
+	change = (int) val != hdspm_professional(hdspm);
+	hdspm_set_professional(hdspm, val);
+	spin_unlock_irq(&hdspm->lock);
+	return change;
+}
+
 #define HDSPM_INPUT_SELECT(xname, xindex) \
 { .iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
   .name = xname, \
@@ -1912,6 +2325,159 @@
 	return change;
 }
 
+#define HDSPM_DS_WIRE(xname, xindex) \
+{ .iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
+  .name = xname, \
+  .index = xindex, \
+  .info = snd_hdspm_info_ds_wire, \
+  .get = snd_hdspm_get_ds_wire, \
+  .put = snd_hdspm_put_ds_wire \
+}
+
+static int hdspm_ds_wire(struct hdspm * hdspm)
+{
+	return (hdspm->control_register & HDSPM_DS_DoubleWire) ? 1 : 0;
+}
+
+static int hdspm_set_ds_wire(struct hdspm * hdspm, int ds)
+{
+	if (ds)
+		hdspm->control_register |= HDSPM_DS_DoubleWire;
+	else
+		hdspm->control_register &= ~HDSPM_DS_DoubleWire;
+	hdspm_write(hdspm, HDSPM_controlRegister, hdspm->control_register);
+
+	return 0;
+}
+
+static int snd_hdspm_info_ds_wire(struct snd_kcontrol *kcontrol,
+				       struct snd_ctl_elem_info *uinfo)
+{
+	static char *texts[] = { "Single", "Double" };
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+	uinfo->count = 1;
+	uinfo->value.enumerated.items = 2;
+
+	if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
+		uinfo->value.enumerated.item =
+		    uinfo->value.enumerated.items - 1;
+	strcpy(uinfo->value.enumerated.name,
+	       texts[uinfo->value.enumerated.item]);
+
+	return 0;
+}
+
+static int snd_hdspm_get_ds_wire(struct snd_kcontrol *kcontrol,
+				      struct snd_ctl_elem_value *ucontrol)
+{
+	struct hdspm *hdspm = snd_kcontrol_chip(kcontrol);
+
+	spin_lock_irq(&hdspm->lock);
+	ucontrol->value.enumerated.item[0] = hdspm_ds_wire(hdspm);
+	spin_unlock_irq(&hdspm->lock);
+	return 0;
+}
+
+static int snd_hdspm_put_ds_wire(struct snd_kcontrol *kcontrol,
+				      struct snd_ctl_elem_value *ucontrol)
+{
+	struct hdspm *hdspm = snd_kcontrol_chip(kcontrol);
+	int change;
+	unsigned int val;
+
+	if (!snd_hdspm_use_is_exclusive(hdspm))
+		return -EBUSY;
+	val = ucontrol->value.integer.value[0] & 1;
+	spin_lock_irq(&hdspm->lock);
+	change = (int) val != hdspm_ds_wire(hdspm);
+	hdspm_set_ds_wire(hdspm, val);
+	spin_unlock_irq(&hdspm->lock);
+	return change;
+}
+
+#define HDSPM_QS_WIRE(xname, xindex) \
+{ .iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
+  .name = xname, \
+  .index = xindex, \
+  .info = snd_hdspm_info_qs_wire, \
+  .get = snd_hdspm_get_qs_wire, \
+  .put = snd_hdspm_put_qs_wire \
+}
+
+static int hdspm_qs_wire(struct hdspm * hdspm)
+{
+  if (hdspm->control_register & HDSPM_QS_DoubleWire)
+    return 1;
+  if (hdspm->control_register & HDSPM_QS_QuadWire)
+    return 2;
+  return 0;
+}
+
+static int hdspm_set_qs_wire(struct hdspm * hdspm, int mode)
+{
+  hdspm->control_register &= ~(HDSPM_QS_DoubleWire | HDSPM_QS_QuadWire);
+  switch (mode)
+  {
+    case 0: break;
+    case 1: hdspm->control_register |= HDSPM_QS_DoubleWire; break;
+    case 2: hdspm->control_register |= HDSPM_QS_QuadWire; break;
+  }
+  hdspm_write(hdspm, HDSPM_controlRegister, hdspm->control_register);
+
+  return 0;
+}
+
+static int snd_hdspm_info_qs_wire(struct snd_kcontrol *kcontrol,
+				       struct snd_ctl_elem_info *uinfo)
+{
+	static char *texts[] = { "Single", "Double", "Quad" };
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+	uinfo->count = 1;
+	uinfo->value.enumerated.items = 3;
+
+	if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
+		uinfo->value.enumerated.item =
+		    uinfo->value.enumerated.items - 1;
+	strcpy(uinfo->value.enumerated.name,
+	       texts[uinfo->value.enumerated.item]);
+
+	return 0;
+}
+
+static int snd_hdspm_get_qs_wire(struct snd_kcontrol *kcontrol,
+				      struct snd_ctl_elem_value *ucontrol)
+{
+	struct hdspm *hdspm = snd_kcontrol_chip(kcontrol);
+
+	spin_lock_irq(&hdspm->lock);
+	ucontrol->value.enumerated.item[0] = hdspm_qs_wire(hdspm);
+	spin_unlock_irq(&hdspm->lock);
+	return 0;
+}
+
+static int snd_hdspm_put_qs_wire(struct snd_kcontrol *kcontrol,
+				      struct snd_ctl_elem_value *ucontrol)
+{
+	struct hdspm *hdspm = snd_kcontrol_chip(kcontrol);
+	int change;
+	int val;
+
+	if (!snd_hdspm_use_is_exclusive(hdspm))
+		return -EBUSY;
+	val = ucontrol->value.integer.value[0];
+        if (val < 0)
+          val = 0;
+        if (val > 2)
+          val = 2;
+	spin_lock_irq(&hdspm->lock);
+	change = (int) val != hdspm_qs_wire(hdspm);
+	hdspm_set_qs_wire(hdspm, val);
+	spin_unlock_irq(&hdspm->lock);
+	return change;
+}
+
 /*           Simple Mixer
   deprecated since to much faders ???
   MIXER interface says output (source, destination, value)
@@ -2135,14 +2701,28 @@
 
 static int hdspm_wc_sync_check(struct hdspm * hdspm)
 {
-	int status2 = hdspm_read(hdspm, HDSPM_statusRegister2);
-	if (status2 & HDSPM_wcLock) {
-		if (status2 & HDSPM_wcSync)
-			return 2;
-		else
-			return 1;
-	}
-	return 0;
+  if (hdspm->is_aes32)
+  {
+    int status = hdspm_read(hdspm, HDSPM_statusRegister);
+    if (status & HDSPM_AES32_wcLock)
+    {
+      // I don't know how to differenciate sync from lock
+      // as if sync for now
+      return 2;
+    }
+    return 0;
+  }
+  else
+  {
+    int status2 = hdspm_read(hdspm, HDSPM_statusRegister2);
+    if (status2 & HDSPM_wcLock) {
+      if (status2 & HDSPM_wcSync)
+        return 2;
+      else
+        return 1;
+    }
+    return 0;
+  }
 }
 
 static int snd_hdspm_get_wc_sync_check(struct snd_kcontrol *kcontrol,
@@ -2188,9 +2768,47 @@
 }
 
 
+#define HDSPM_AES_SYNC_CHECK(xname, xindex) \
+{ .iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
+  .name = xname, \
+  .index = xindex, \
+  .access = SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE, \
+  .info = snd_hdspm_info_sync_check, \
+  .get = snd_hdspm_get_aes_sync_check \
+}
 
+static int hdspm_aes_sync_check(struct hdspm * hdspm, int idx)
+{
+  int status2 = hdspm_read(hdspm, HDSPM_statusRegister2);
+  if (status2 & (HDSPM_LockAES >> idx))
+  {
+    // I don't know how to differenciate sync from lock
+    // as if sync for now
+    return 2;
+  }
+  return 0;
+}
+
+static int snd_hdspm_get_aes_sync_check(struct snd_kcontrol *kcontrol,
+					     struct snd_ctl_elem_value *
+					     ucontrol)
+{
+  int offset;
+  struct hdspm *hdspm = snd_kcontrol_chip(kcontrol);
+
+  offset = ucontrol->id.index - 1;
+  if (offset < 0 || offset >= 8)
+    return -EINVAL;
+  
+  ucontrol->value.enumerated.item[0] =
+    hdspm_aes_sync_check(hdspm, offset);
+  return 0;
+}
 
-static struct snd_kcontrol_new snd_hdspm_controls[] = {
+
+
+
+static struct snd_kcontrol_new snd_hdspm_controls_madi[] = {
 
 	HDSPM_MIXER("Mixer", 0),
 /* 'Sample Clock Source' complies with the alsa control naming scheme */
@@ -2211,6 +2829,29 @@
 	HDSPM_INPUT_SELECT("Input Select", 0),
 };
 
+static struct snd_kcontrol_new snd_hdspm_controls_aes32[] = {
+
+	HDSPM_MIXER("Mixer", 0),
+/* 'Sample Clock Source' complies with the alsa control naming scheme */
+	HDSPM_CLOCK_SOURCE("Sample Clock Source", 0),
+
+	HDSPM_SYSTEM_CLOCK_MODE("System Clock Mode", 0),
+	HDSPM_PREF_SYNC_REF("Preferred Sync Reference", 0),
+	HDSPM_AUTOSYNC_REF("AutoSync Reference", 0),
+	HDSPM_SYSTEM_SAMPLE_RATE("System Sample Rate", 0),
+/* 'External Rate' complies with the alsa control naming scheme */
+	HDSPM_AUTOSYNC_SAMPLE_RATE("External Rate", 0),
+	HDSPM_WC_SYNC_CHECK("Word Clock Lock Status", 0),
+//	HDSPM_AES_SYNC_CHECK("AES Lock Status", 0), /* created in snd_hdspm_create_controls() */
+	HDSPM_LINE_OUT("Line Out", 0),
+	HDSPM_EMPHASIS("Emphasis", 0),
+	HDSPM_DOLBY("Non Audio", 0),
+	HDSPM_PROFESSIONAL("Professional", 0),
+	HDSPM_C_TMS("Clear Track Marker", 0),
+	HDSPM_DS_WIRE("Double Speed Wire Mode", 0),
+	HDSPM_QS_WIRE("Quad Speed Wire Mode", 0),
+};
+
 static struct snd_kcontrol_new snd_hdspm_playback_mixer = HDSPM_PLAYBACK_MIXER;
 
 
@@ -2240,48 +2881,75 @@
 
 static int snd_hdspm_create_controls(struct snd_card *card, struct hdspm * hdspm)
 {
-	unsigned int idx, limit;
-	int err;
-	struct snd_kcontrol *kctl;
-
-	/* add control list first */
-
-	for (idx = 0; idx < ARRAY_SIZE(snd_hdspm_controls); idx++) {
-		if ((err =
-		     snd_ctl_add(card, kctl =
-				 snd_ctl_new1(&snd_hdspm_controls[idx],
-					      hdspm))) < 0) {
-			return err;
-		}
-	}
-
-	/* Channel playback mixer as default control 
-	   Note: the whole matrix would be 128*HDSPM_MIXER_CHANNELS Faders, thats too big for any alsamixer
-	   they are accesible via special IOCTL on hwdep
-	   and the mixer 2dimensional mixer control */
-
-	snd_hdspm_playback_mixer.name = "Chn";
-	limit = HDSPM_MAX_CHANNELS;
-
-	/* The index values are one greater than the channel ID so that alsamixer
-	   will display them correctly. We want to use the index for fast lookup
-	   of the relevant channel, but if we use it at all, most ALSA software
-	   does the wrong thing with it ...
-	 */
-
-	for (idx = 0; idx < limit; ++idx) {
-		snd_hdspm_playback_mixer.index = idx + 1;
-		if ((err = snd_ctl_add(card,
-				       kctl =
-				       snd_ctl_new1
-				       (&snd_hdspm_playback_mixer,
-					hdspm)))) {
-			return err;
-		}
-		hdspm->playback_mixer_ctls[idx] = kctl;
-	}
+  unsigned int idx, limit;
+  int err;
+  struct snd_kcontrol *kctl;
+
+  /* add control list first */
+  if (hdspm->is_aes32)
+  {
+    struct snd_kcontrol_new aes_sync_ctl =
+      HDSPM_AES_SYNC_CHECK("AES Lock Status", 0);
+    
+    for (idx = 0; idx < ARRAY_SIZE(snd_hdspm_controls_aes32); idx++)
+    {
+      if ((err =
+            snd_ctl_add(card, kctl =
+              snd_ctl_new1(&snd_hdspm_controls_aes32[idx],
+                hdspm))) < 0) {
+        return err;
+      }
+    }
+    for (idx = 1; idx <= 8; idx++)
+    {
+      aes_sync_ctl.index = idx;
+      if ((err =
+            snd_ctl_add(card, kctl =
+              snd_ctl_new1(&aes_sync_ctl, hdspm))) < 0) {
+        return err;
+      }
+    }
+  }
+  else
+  {
+    for (idx = 0; idx < ARRAY_SIZE(snd_hdspm_controls_madi); idx++)
+    {
+      if ((err =
+            snd_ctl_add(card, kctl =
+              snd_ctl_new1(&snd_hdspm_controls_madi[idx],
+                hdspm))) < 0) {
+        return err;
+      }
+    }
+  }
+
+  /* Channel playback mixer as default control 
+Note: the whole matrix would be 128*HDSPM_MIXER_CHANNELS Faders, thats too big for any alsamixer
+they are accesible via special IOCTL on hwdep
+and the mixer 2dimensional mixer control */
+
+  snd_hdspm_playback_mixer.name = "Chn";
+  limit = HDSPM_MAX_CHANNELS;
+
+  /* The index values are one greater than the channel ID so that alsamixer
+     will display them correctly. We want to use the index for fast lookup
+     of the relevant channel, but if we use it at all, most ALSA software
+     does the wrong thing with it ...
+   */
+
+  for (idx = 0; idx < limit; ++idx) {
+    snd_hdspm_playback_mixer.index = idx + 1;
+    if ((err = snd_ctl_add(card,
+            kctl =
+            snd_ctl_new1
+            (&snd_hdspm_playback_mixer,
+             hdspm)))) {
+      return err;
+    }
+    hdspm->playback_mixer_ctls[idx] = kctl;
+  }
 
-	return 0;
+  return 0;
 }
 
 /*------------------------------------------------------------
@@ -2289,7 +2957,7 @@
  ------------------------------------------------------------*/
 
 static void
-snd_hdspm_proc_read(struct snd_info_entry * entry, struct snd_info_buffer *buffer)
+snd_hdspm_proc_read_madi(struct snd_info_entry * entry, struct snd_info_buffer *buffer)
 {
 	struct hdspm *hdspm = (struct hdspm *) entry->private_data;
 	unsigned int status;
@@ -2484,13 +3152,218 @@
 	snd_iprintf(buffer, "\n");
 }
 
+static void
+snd_hdspm_proc_read_aes32(struct snd_info_entry * entry, struct snd_info_buffer *buffer)
+{
+	struct hdspm *hdspm = (struct hdspm *) entry->private_data;
+	unsigned int status;
+	unsigned int status2;
+        unsigned int timecode;
+	int pref_syncref;
+	char *autosync_ref;
+	char *system_clock_mode;
+	char *clock_source;
+	int x;
+
+	status = hdspm_read(hdspm, HDSPM_statusRegister);
+	status2 = hdspm_read(hdspm, HDSPM_statusRegister2);
+        timecode = hdspm_read(hdspm, HDSPM_timecodeRegister);
+
+	snd_iprintf(buffer, "%s (Card #%d) Rev.%x\n",
+		    hdspm->card_name, hdspm->card->number + 1,
+		    hdspm->firmware_rev);
+
+	snd_iprintf(buffer, "IRQ: %d Registers bus: 0x%lx VM: 0x%lx\n",
+		    hdspm->irq, hdspm->port, (unsigned long)hdspm->iobase);
+
+	snd_iprintf(buffer, "--- System ---\n");
+
+	snd_iprintf(buffer,
+		    "IRQ Pending: Audio=%d, MIDI0=%d, MIDI1=%d, IRQcount=%d\n",
+		    status & HDSPM_audioIRQPending,
+		    (status & HDSPM_midi0IRQPending) ? 1 : 0,
+		    (status & HDSPM_midi1IRQPending) ? 1 : 0,
+		    hdspm->irq_count);
+	snd_iprintf(buffer,
+		    "HW pointer: id = %d, rawptr = %d (%d->%d) estimated= %ld (bytes)\n",
+		    ((status & HDSPM_BufferID) ? 1 : 0),
+		    (status & HDSPM_BufferPositionMask),
+		    (status & HDSPM_BufferPositionMask) % (2 *
+							   (int)hdspm->
+							   period_bytes),
+		    ((status & HDSPM_BufferPositionMask) -
+		     64) % (2 * (int)hdspm->period_bytes),
+		    (long) hdspm_hw_pointer(hdspm) * 4);
+
+	snd_iprintf(buffer,
+		    "MIDI FIFO: Out1=0x%x, Out2=0x%x, In1=0x%x, In2=0x%x \n",
+		    hdspm_read(hdspm, HDSPM_midiStatusOut0) & 0xFF,
+		    hdspm_read(hdspm, HDSPM_midiStatusOut1) & 0xFF,
+		    hdspm_read(hdspm, HDSPM_midiStatusIn0) & 0xFF,
+		    hdspm_read(hdspm, HDSPM_midiStatusIn1) & 0xFF);
+	snd_iprintf(buffer,
+		    "Register: ctrl1=0x%x, ctrl2=0x%x, status1=0x%x, status2=0x%x, timecode=0x%x\n",
+		    hdspm->control_register, hdspm->control2_register,
+		    status, status2, timecode);
+
+	snd_iprintf(buffer, "--- Settings ---\n");
+
+	x = 1 << (6 +
+		  hdspm_decode_latency(hdspm->
+				       control_register &
+				       HDSPM_LatencyMask));
+
+	snd_iprintf(buffer,
+		    "Size (Latency): %d samples (2 periods of %lu bytes)\n",
+		    x, (unsigned long) hdspm->period_bytes);
+
+	snd_iprintf(buffer, "Line out: %s,   Precise Pointer: %s\n",
+		    (hdspm->
+		     control_register & HDSPM_LineOut) ? "on " : "off",
+		    (hdspm->precise_ptr) ? "on" : "off");
+
+	snd_iprintf(buffer,
+		    "ClearTrackMarker %s, Emphasis %s, Dolby %s\n",
+		    (hdspm->
+		     control_register & HDSPM_clr_tms) ? "on" : "off",
+		    (hdspm->
+		     control_register & HDSPM_Emphasis) ? "on" : "off",
+		    (hdspm->
+		     control_register & HDSPM_Dolby) ? "on" : "off");
+
+	switch (hdspm_clock_source(hdspm)) {
+	case HDSPM_CLOCK_SOURCE_AUTOSYNC:
+		clock_source = "AutoSync";
+		break;
+	case HDSPM_CLOCK_SOURCE_INTERNAL_32KHZ:
+		clock_source = "Internal 32 kHz";
+		break;
+	case HDSPM_CLOCK_SOURCE_INTERNAL_44_1KHZ:
+		clock_source = "Internal 44.1 kHz";
+		break;
+	case HDSPM_CLOCK_SOURCE_INTERNAL_48KHZ:
+		clock_source = "Internal 48 kHz";
+		break;
+	case HDSPM_CLOCK_SOURCE_INTERNAL_64KHZ:
+		clock_source = "Internal 64 kHz";
+		break;
+	case HDSPM_CLOCK_SOURCE_INTERNAL_88_2KHZ:
+		clock_source = "Internal 88.2 kHz";
+		break;
+	case HDSPM_CLOCK_SOURCE_INTERNAL_96KHZ:
+		clock_source = "Internal 96 kHz";
+		break;
+	case HDSPM_CLOCK_SOURCE_INTERNAL_128KHZ:
+		clock_source = "Internal 128 kHz";
+		break;
+	case HDSPM_CLOCK_SOURCE_INTERNAL_176_4KHZ:
+		clock_source = "Internal 176.4 kHz";
+		break;
+	case HDSPM_CLOCK_SOURCE_INTERNAL_192KHZ:
+		clock_source = "Internal 192 kHz";
+		break;
+	default:
+		clock_source = "Error";
+	}
+	snd_iprintf(buffer, "Sample Clock Source: %s\n", clock_source);
+	if (!(hdspm->control_register & HDSPM_ClockModeMaster)) {
+		system_clock_mode = "Slave";
+	} else {
+		system_clock_mode = "Master";
+	}
+	snd_iprintf(buffer, "System Clock Mode: %s\n", system_clock_mode);
+
+	pref_syncref = hdspm_pref_sync_ref(hdspm);
+        if (pref_syncref == 0)
+          snd_iprintf(buffer, "Preferred Sync Reference: Word Clock\n");
+        else
+          snd_iprintf(buffer, "Preferred Sync Reference: AES%d\n",pref_syncref);
+          
+	snd_iprintf(buffer, "System Clock Frequency: %d\n",
+		    hdspm->system_sample_rate);
+
+        snd_iprintf(buffer, "Double speed: %s\n",
+            hdspm->control_register & HDSPM_DS_DoubleWire?
+              "Double wire" : "Single wire");
+        snd_iprintf(buffer, "Quad speed: %s\n",
+            hdspm->control_register & HDSPM_QS_DoubleWire?
+              "Double wire" :
+            hdspm->control_register & HDSPM_QS_QuadWire?
+              "Quad wire" : "Single wire");
+              
+	snd_iprintf(buffer, "--- Status:\n");
+
+        snd_iprintf(buffer, "Word: %s  Frequency: %d\n",
+            (status & HDSPM_AES32_wcLock)? "Sync   " : "No Lock",
+            HDSPM_bit2freq((status >> HDSPM_AES32_wcFreq_bit) & 0xF));
+
+        for (x=0; x<8; x++)
+        {
+          snd_iprintf(buffer, "AES%d: %s  Frequency: %d\n",
+              x+1,
+            (status2 & (HDSPM_LockAES >> x))? "Sync   ": "No Lock",
+            HDSPM_bit2freq((timecode >> (4*x)) & 0xF));
+        }
+
+	switch (hdspm_autosync_ref(hdspm))
+        {
+          case HDSPM_AES32_AUTOSYNC_FROM_NONE: autosync_ref="None"; break;
+          case HDSPM_AES32_AUTOSYNC_FROM_WORD: autosync_ref="Word Clock"; break;
+          case HDSPM_AES32_AUTOSYNC_FROM_AES1: autosync_ref="AES1"; break;
+          case HDSPM_AES32_AUTOSYNC_FROM_AES2: autosync_ref="AES2"; break;
+          case HDSPM_AES32_AUTOSYNC_FROM_AES3: autosync_ref="AES3"; break;
+          case HDSPM_AES32_AUTOSYNC_FROM_AES4: autosync_ref="AES4"; break;
+          case HDSPM_AES32_AUTOSYNC_FROM_AES5: autosync_ref="AES5"; break;
+          case HDSPM_AES32_AUTOSYNC_FROM_AES6: autosync_ref="AES6"; break;
+          case HDSPM_AES32_AUTOSYNC_FROM_AES7: autosync_ref="AES7"; break;
+          case HDSPM_AES32_AUTOSYNC_FROM_AES8: autosync_ref="AES8"; break;
+          default: autosync_ref = "---"; break;
+	}
+	snd_iprintf(buffer, "AutoSync ref = %s\n", autosync_ref);
+
+	snd_iprintf(buffer, "\n");
+}
+
+static void
+snd_hdspm_proc_read_debug(struct snd_info_entry * entry, struct snd_info_buffer *buffer)
+{
+  struct hdspm *hdspm = (struct hdspm *)entry->private_data;
+
+  int j,i;
+
+  /*
+  for (i=0; i<256; i+=j)
+  {
+    snd_iprintf(buffer, "0x%08X: ", i);
+    for (j=0; j<4; j++)
+      snd_iprintf(buffer, "%08X ", hdspm_read(hdspm, i+j));
+    snd_iprintf(buffer, "\n");
+  }
+  */
+  for (i=0; i<1024*64; i+=j)
+  {
+    snd_iprintf(buffer, "0x%08X: ", i);
+    for (j=0; j<16; j+=4)
+      snd_iprintf(buffer, "%08X ", hdspm_read(hdspm, i+j));
+    snd_iprintf(buffer, "\n");
+  }
+}
+
+
+
 static void __devinit snd_hdspm_proc_init(struct hdspm * hdspm)
 {
 	struct snd_info_entry *entry;
 
 	if (!snd_card_proc_new(hdspm->card, "hdspm", &entry))
 		snd_info_set_text_ops(entry, hdspm,
-				      snd_hdspm_proc_read);
+                    hdspm->is_aes32?
+                       snd_hdspm_proc_read_aes32 :
+                       snd_hdspm_proc_read_madi);
+	/* // debug file to read all hdspm registers
+           if (!snd_card_proc_new(hdspm->card, "debug", &entry))
+		snd_info_set_text_ops(entry, hdspm,
+		    snd_hdspm_proc_read_debug); */
 }
 
 /*------------------------------------------------------------
@@ -2507,13 +3380,20 @@
 
 	/* set defaults:       */
 
-	hdspm->control_register = HDSPM_ClockModeMaster |	/* Master Cloack Mode on */
-	    hdspm_encode_latency(7) |	/* latency maximum = 8192 samples */
-	    HDSPM_InputCoaxial |	/* Input Coax not Optical */
-	    HDSPM_SyncRef_MADI |	/* Madi is syncclock */
-	    HDSPM_LineOut |	/* Analog output in */
-	    HDSPM_TX_64ch |	/* transmit in 64ch mode */
-	    HDSPM_AutoInp;	/* AutoInput chossing (takeover) */
+        if (hdspm->is_aes32)
+          hdspm->control_register = HDSPM_ClockModeMaster |	/* Master Cloack Mode on */
+              hdspm_encode_latency(7) |	/* latency maximum = 8192 samples */
+              HDSPM_SyncRef0 |	/* AES1 is syncclock */
+              HDSPM_LineOut |	/* Analog output in */
+              HDSPM_Professional;  /* Professional mode */
+        else
+          hdspm->control_register = HDSPM_ClockModeMaster |	/* Master Cloack Mode on */
+              hdspm_encode_latency(7) |	/* latency maximum = 8192 samples */
+              HDSPM_InputCoaxial |	/* Input Coax not Optical */
+              HDSPM_SyncRef_MADI |	/* Madi is syncclock */
+              HDSPM_LineOut |	/* Analog output in */
+              HDSPM_TX_64ch |	/* transmit in 64ch mode */
+              HDSPM_AutoInp;	/* AutoInput chossing (takeover) */
 
 	/* ! HDSPM_Frequency0|HDSPM_Frequency1 = 44.1khz */
 	/* !  HDSPM_DoubleSpeed HDSPM_QuadSpeed = normal speed */
@@ -2823,6 +3703,8 @@
 
 		hdspm->playback_buffer =
 		    (unsigned char *) substream->runtime->dma_area;
+          snd_printdd("Allocated sample buffer for playback at 0x%08X\n",
+              hdspm->playback_buffer);
 	} else {
 		hdspm_set_sgbuf(hdspm, sgbuf, HDSPM_pageAddressBufferIn,
 				params_channels(params));
@@ -2832,7 +3714,15 @@
 
 		hdspm->capture_buffer =
 		    (unsigned char *) substream->runtime->dma_area;
+          snd_printdd("Allocated sample buffer for capture at 0x%08X\n",
+              hdspm->capture_buffer);
 	}
+        /*
+        snd_printdd("Allocated sample buffer for %s at 0x%08X\n",
+            substream->stream == SNDRV_PCM_STREAM_PLAYBACK ?
+              "playback" : "capture",
+              snd_pcm_sgbuf_get_addr(sgbuf, 0));
+        */
 	return 0;
 }
 
@@ -2983,9 +3873,10 @@
 		  SNDRV_PCM_RATE_44100 |
 		  SNDRV_PCM_RATE_48000 |
 		  SNDRV_PCM_RATE_64000 |
-		  SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000),
+		  SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000 |
+                  SNDRV_PCM_RATE_176400 | SNDRV_PCM_RATE_192000 ),
 	.rate_min = 32000,
-	.rate_max = 96000,
+	.rate_max = 192000,
 	.channels_min = 1,
 	.channels_max = HDSPM_MAX_CHANNELS,
 	.buffer_bytes_max =
@@ -3007,9 +3898,10 @@
 		  SNDRV_PCM_RATE_44100 |
 		  SNDRV_PCM_RATE_48000 |
 		  SNDRV_PCM_RATE_64000 |
-		  SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000),
+		  SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000 |
+                  SNDRV_PCM_RATE_176400 | SNDRV_PCM_RATE_192000),
 	.rate_min = 32000,
-	.rate_max = 96000,
+	.rate_max = 192000,
 	.channels_min = 1,
 	.channels_max = HDSPM_MAX_CHANNELS,
 	.buffer_bytes_max =
@@ -3316,7 +4208,8 @@
 
 	pcm = hdspm->pcm;
 
-	wanted = HDSPM_DMA_AREA_BYTES + 4096;	/* dont know why, but it works */
+//	wanted = HDSPM_DMA_AREA_BYTES + 4096;	/* dont know why, but it works */
+	wanted = HDSPM_DMA_AREA_BYTES;
 
 	if ((err =
 	     snd_pcm_lib_preallocate_pages_for_all(pcm,
@@ -3468,9 +4361,14 @@
 	pci_read_config_word(hdspm->pci,
 			     PCI_CLASS_REVISION, &hdspm->firmware_rev);
 
+        hdspm->is_aes32 = (hdspm->firmware_rev >= HDSPM_AESREVISION);
+
 	strcpy(card->driver, "HDSPM");
 	strcpy(card->mixername, "Xilinx FPGA");
-	hdspm->card_name = "RME HDSPM MADI";
+        if (hdspm->is_aes32)
+	  hdspm->card_name = "RME HDSPM AES32";
+        else
+          hdspm->card_name = "RME HDSPM MADI";
 
 	if ((err = pci_enable_device(pci)) < 0)
 		return err;
@@ -3496,6 +4394,11 @@
 		   (unsigned long)hdspm->iobase, hdspm->port,
 		   hdspm->port + io_extent - 1);
 
+        // Windows driver modifies the two following PCI registers
+        pci_write_config_byte(pci, PCI_COMMAND,
+            PCI_COMMAND_MASTER | PCI_COMMAND_MEMORY);
+        pci_write_config_byte(pci, PCI_LATENCY_TIMER, 0xFF);
+        
 	if (request_irq(pci->irq, snd_hdspm_interrupt,
 			IRQF_DISABLED | IRQF_SHARED, "hdspm",
 			(void *) hdspm)) {

--huq684BweRXVnRxX
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--huq684BweRXVnRxX
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--huq684BweRXVnRxX--
