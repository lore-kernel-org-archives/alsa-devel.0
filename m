From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [RME MADI/RayDAT/AIO/AES] Changing hdspm_config and
	hdspm_status
Date: Mon, 22 Aug 2011 18:28:59 +0200
Message-ID: <4E5283CB.7070902@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ltw.loris.tv (ltw.loris.tv [85.14.220.160])
	by alsa0.perex.cz (Postfix) with ESMTP id 9423B2437D
	for <alsa-devel@alsa-project.org>;
	Mon, 22 Aug 2011 18:29:26 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA development <alsa-devel@alsa-project.org>
Cc: Robert Steffens <robert.steffens@iosono-sound.com>, Fredrik Lingvall <fredrik.lingvall@gmail.com>, Andre Schramm <andre.schramm@iosono-sound.com>, =?UTF-8?B?SsO2cm4gTmV0dGluZ3NtZWllcg==?= <nettings@stackingdwarves.net>
List-Id: alsa-devel@alsa-project.org

Hi!

Florian Faber has sent me some new bits of his work on hdspm. While the
changes to hdspm.c are straight-forward, he also cleaned up struct
hdspm_config and hdspm_status, thus changing the userspace API/ABI:


diff --git a/include/sound/hdspm.h b/include/sound/hdspm.h
index 1f59ea2..25eab09 100644
--- a/include/sound/hdspm.h
+++ b/include/sound/hdspm.h
@@ -58,17 +58,20 @@ struct hdspm_peak_rms {
 /* ------------ CONFIG block IOCTL ---------------------- */

 struct hdspm_config {
-	unsigned char pref_sync_ref;
-	unsigned char wordclock_sync_check;
-	unsigned char madi_sync_check;
-	unsigned int system_sample_rate;
-	unsigned int autosync_sample_rate;
-	unsigned char system_clock_mode;
-	unsigned char clock_source;
-	unsigned char autosync_ref;
-	unsigned char line_out;
-	unsigned int passthru;
-	unsigned int analog_out;
+	uint32_t dds;       /* dds increment */
+	uint16_t freq;      /* 32000/44100/48000 */
+	uint8_t wck_mul;    /* 1/2/4 */
+	uint8_t clock_mode; /* 0=master, 1=slave */
+	union {
+		struct {
+			uint8_t line_out;     /* 0=disabled, 1=enabled */
+			uint8_t tms;          /* 0=disabled, 1=enabled */
+			uint8_t input_select; /* 0=BNC, 1=optical */
+			uint8_t output_mode;  /* 0=56ch, 1=64ch */
+			uint8_t output_frame; /* 0=48K, 1=96K */
+			uint8_t sync_ref;     /* 0=WCK, 1=MADI, 2=TCO/SYNC_IN, 3=SYNC_IN */
+		} madi;
+	} card_specific;
 };

 #define SNDRV_HDSPM_IOCTL_GET_CONFIG \
@@ -161,7 +164,6 @@ struct hdspm_status {
 			uint8_t sync_madi; /* enum hdspm_sync */
 			uint8_t sync_tco; /* enum hdspm_sync */
 			uint8_t sync_in; /* enum hdspm_sync */
-			uint8_t madi_input; /* enum hdspm_madi_input */
 			uint8_t channel_format; /* enum hdspm_madi_channel_format */
 			uint8_t frame_format; /* enum hdspm_madi_frame_format */
 		} madi;



I guess this means we'd need to redefine two ioctl numbers. Besides
this, are there any current users of this code?

The changes are not upstream, yet, so we could arrange for a grace
period, maybe saying something like "Starting with Linux-3.x and
ALSA-1.0.y, you'll have to change your code". X and Y are yet to be
chosen wisely.

If you're interested to check if the upcoming changes affect your code,
I can send you the complete driver. I'll post the changes to hdspm.c in
a second, but that's just a preview for discussion, not necessarily the
final patch.


Cheers
