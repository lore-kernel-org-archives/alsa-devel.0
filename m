From: Remy Bruno <remy.bruno@trinnov.com>
Subject: [PATCH] RME 9632 fix at 192kHz
Date: Fri, 22 Feb 2008 15:25:44 +0100
Message-ID: <20080222142544.GA27805@trinnov.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="45Z9DzgjV8m4Oswq"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.trinnov.com (mail.trinnov.com [82.228.38.100])
	by alsa0.perex.cz (Postfix) with SMTP id 5CA7D103812
	for <alsa-devel@alsa-project.org>; Fri, 22 Feb 2008 15:25:45 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline

Hello,

I realized that one of my hdsp patches was not included in the hg tree, so I
guess I forgot to submit it, sorry for submitting only now.

Description:

The bits indicating SPDIF frequency in the status register are not the same for
the 9632 than for the other cards, because it also supports 192kHz. A specific
bitmask has thus been added (used in hdsp_spdif_sample_rate()).
The 9632 does not seem to report external sample rates greater than 96kHz. In
this case, the best seems to report spdif rate when autosync reference is
spdif. This also required to move function hdsp_spdif_sample_rate().

Signed-off-by: Remy Bruno <remy.bruno@trinnov.com>


Regards,
Remy

--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: attachment; filename=patch_alsa_080222

diff -r b87cbcc974d1 -r bf8d84bb62bc pci/rme9652/hdsp.c
--- a/pci/rme9652/hdsp.c	Tue Feb 19 13:16:41 2008 +0100
+++ b/pci/rme9652/hdsp.c	Tue Feb 19 16:13:03 2008 +0100
@@ -318,6 +318,7 @@ MODULE_FIRMWARE("digiface_firmware_rev11
 #define HDSP_midi1IRQPending    (1<<31)
 
 #define HDSP_spdifFrequencyMask    (HDSP_spdifFrequency0|HDSP_spdifFrequency1|HDSP_spdifFrequency2)
+#define HDSP_spdifFrequencyMask_9632 (HDSP_spdifFrequency0|HDSP_spdifFrequency1|HDSP_spdifFrequency2|HDSP_spdifFrequency3)
 
 #define HDSP_spdifFrequency32KHz   (HDSP_spdifFrequency0)
 #define HDSP_spdifFrequency44_1KHz (HDSP_spdifFrequency1)
@@ -328,7 +329,7 @@ MODULE_FIRMWARE("digiface_firmware_rev11
 #define HDSP_spdifFrequency96KHz   (HDSP_spdifFrequency2|HDSP_spdifFrequency1)
 
 /* This is for H9632 cards */
-#define HDSP_spdifFrequency128KHz   HDSP_spdifFrequencyMask
+#define HDSP_spdifFrequency128KHz   (HDSP_spdifFrequency0|HDSP_spdifFrequency1|HDSP_spdifFrequency2)
 #define HDSP_spdifFrequency176_4KHz HDSP_spdifFrequency3
 #define HDSP_spdifFrequency192KHz   (HDSP_spdifFrequency3|HDSP_spdifFrequency0)
 
@@ -885,10 +886,53 @@ static int snd_hdsp_use_is_exclusive(str
 	return ret;
 }
 
+static int hdsp_spdif_sample_rate(struct hdsp *hdsp)
+{
+	unsigned int status = hdsp_read(hdsp, HDSP_statusRegister);
+	unsigned int rate_bits = (status & HDSP_spdifFrequencyMask);
+
+	/* For the 9632, the mask is different */
+	if (hdsp->io_type == H9632)
+		 rate_bits = (status & HDSP_spdifFrequencyMask_9632);
+
+	if (status & HDSP_SPDIFErrorFlag)
+		return 0;
+	
+	switch (rate_bits) {
+	case HDSP_spdifFrequency32KHz: return 32000;
+	case HDSP_spdifFrequency44_1KHz: return 44100;
+	case HDSP_spdifFrequency48KHz: return 48000;
+	case HDSP_spdifFrequency64KHz: return 64000;
+	case HDSP_spdifFrequency88_2KHz: return 88200;
+	case HDSP_spdifFrequency96KHz: return 96000;
+	case HDSP_spdifFrequency128KHz: 
+		if (hdsp->io_type == H9632) return 128000;
+		break;
+	case HDSP_spdifFrequency176_4KHz: 
+		if (hdsp->io_type == H9632) return 176400;
+		break;
+	case HDSP_spdifFrequency192KHz: 
+		if (hdsp->io_type == H9632) return 192000;
+		break;
+	default:
+		break;
+	}
+	snd_printk ("Hammerfall-DSP: unknown spdif frequency status; bits = 0x%x, status = 0x%x\n", rate_bits, status);
+	return 0;
+}
+
 static int hdsp_external_sample_rate (struct hdsp *hdsp)
 {
 	unsigned int status2 = hdsp_read(hdsp, HDSP_status2Register);
 	unsigned int rate_bits = status2 & HDSP_systemFrequencyMask;
+
+	/* For the 9632 card, there seems to be no bit for indicating external
+	 * sample rate greater than 96kHz. The card reports the corresponding
+	 * single speed. So the best means seems to get spdif rate when
+	 * autosync reference is spdif */
+	if (hdsp->io_type == H9632 &&
+	    hdsp_autosync_ref(hdsp) == HDSP_AUTOSYNC_FROM_SPDIF)
+		 return hdsp_spdif_sample_rate(hdsp);
 
 	switch (rate_bits) {
 	case HDSP_systemFrequency32:   return 32000;
@@ -900,37 +944,6 @@ static int hdsp_external_sample_rate (st
 	default:
 		return 0;
 	}
-}
-
-static int hdsp_spdif_sample_rate(struct hdsp *hdsp)
-{
-	unsigned int status = hdsp_read(hdsp, HDSP_statusRegister);
-	unsigned int rate_bits = (status & HDSP_spdifFrequencyMask);
-
-	if (status & HDSP_SPDIFErrorFlag)
-		return 0;
-	
-	switch (rate_bits) {
-	case HDSP_spdifFrequency32KHz: return 32000;
-	case HDSP_spdifFrequency44_1KHz: return 44100;
-	case HDSP_spdifFrequency48KHz: return 48000;
-	case HDSP_spdifFrequency64KHz: return 64000;
-	case HDSP_spdifFrequency88_2KHz: return 88200;
-	case HDSP_spdifFrequency96KHz: return 96000;
-	case HDSP_spdifFrequency128KHz: 
-		if (hdsp->io_type == H9632) return 128000;
-		break;
-	case HDSP_spdifFrequency176_4KHz: 
-		if (hdsp->io_type == H9632) return 176400;
-		break;
-	case HDSP_spdifFrequency192KHz: 
-		if (hdsp->io_type == H9632) return 192000;
-		break;
-	default:
-		break;
-	}
-	snd_printk ("Hammerfall-DSP: unknown spdif frequency status; bits = 0x%x, status = 0x%x\n", rate_bits, status);
-	return 0;
 }
 
 static void hdsp_compute_period_size(struct hdsp *hdsp)

--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--45Z9DzgjV8m4Oswq--
