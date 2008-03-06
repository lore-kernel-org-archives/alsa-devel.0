From: Pawel MOLL <pawel.moll@st.com>
Subject: [PATCH] Support for playing WAV files with "extensible
	format"	header using aplay.
Date: Thu, 06 Mar 2008 14:34:43 +0000
Message-ID: <1204814083.22735.15.camel@bri1004.bri.st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from s200aog17.obsmtp.com (s200aog17.obsmtp.com [207.126.144.131])
	by alsa0.perex.cz (Postfix) with ESMTP id 17E46103852
	for <alsa-devel@alsa-project.org>; Thu,  6 Mar 2008 15:34:48 +0100 (CET)
Received: from zeta.dmz-eu.st.com (ns2.st.com [164.129.230.9])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D1325DAE0
	for <alsa-devel@alsa-project.org>; Thu,  6 Mar 2008 14:34:45 +0000 (GMT)
Received: from mail1.bri.st.com (mail1.bri.st.com [164.129.8.218])
	by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 76BD94C0E8
	for <alsa-devel@alsa-project.org>; Thu,  6 Mar 2008 14:34:45 +0000 (GMT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Support for playing WAV files with "extensible format" header using aplay.

WAV files with more than 2 channels or with more than 16 bits per samples can be saved
with "extensible format" chunk (see http://msdn2.microsoft.com/en-us/library/ms713496(VS.85).aspx).
For instance, sox, when converting data to 24- or 32-bits per sample format
uses this format, and aplay was unable to play such file. Now the problem is solved :-)

Signed-off-by: Pawel MOLL <pawel.moll@st.com>
---
diff -r 9c822ff3e9b9 aplay/aplay.c
--- a/aplay/aplay.c	Thu Feb 21 09:12:53 2008 +0100
+++ b/aplay/aplay.c	Thu Mar 06 14:25:52 2008 +0000
@@ -745,16 +745,29 @@ static ssize_t test_wavefile(int fd, u_c
 	check_wavefile_space(buffer, len, blimit);
 	test_wavefile_read(fd, buffer, &size, len, __LINE__);
 	f = (WaveFmtBody*) buffer;
+	if (LE_SHORT(f->format) == WAV_FMT_EXTENSIBLE) {
+		WaveFmtExtensibleBody *fe = (WaveFmtExtensibleBody*)buffer;
+		if (len < sizeof(WaveFmtExtensibleBody)) {
+			error(_("unknown length of extensible 'fmt ' chunk (read %u, should be %u at least)"),
+					len, (u_int)sizeof(WaveFmtExtensibleBody));
+			exit(EXIT_FAILURE);
+		}
+		if (memcmp(fe->guid_tag, WAV_GUID_TAG, 14) != 0) {
+			error(_("wrong format tag in extensible 'fmt ' chunk"));
+			exit(EXIT_FAILURE);
+		}
+		f->format = fe->guid_format;
+	}
         if (LE_SHORT(f->format) != WAV_FMT_PCM &&
             LE_SHORT(f->format) != WAV_FMT_IEEE_FLOAT) {
                 error(_("can't play WAVE-file format 0x%04x which is not PCM or FLOAT encoded"), LE_SHORT(f->format));
 		exit(EXIT_FAILURE);
 	}
-	if (LE_SHORT(f->modus) < 1) {
-		error(_("can't play WAVE-files with %d tracks"), LE_SHORT(f->modus));
-		exit(EXIT_FAILURE);
-	}
-	hwparams.channels = LE_SHORT(f->modus);
+	if (LE_SHORT(f->channels) < 1) {
+		error(_("can't play WAVE-files with %d tracks"), LE_SHORT(f->channels));
+		exit(EXIT_FAILURE);
+	}
+	hwparams.channels = LE_SHORT(f->channels);
 	switch (LE_SHORT(f->bit_p_spl)) {
 	case 8:
 		if (hwparams.format != DEFAULT_FORMAT &&
@@ -1805,7 +1818,7 @@ static void begin_wave(int fd, size_t cn
                 f.format = LE_SHORT(WAV_FMT_IEEE_FLOAT);
         else
                 f.format = LE_SHORT(WAV_FMT_PCM);
-	f.modus = LE_SHORT(hwparams.channels);
+	f.channels = LE_SHORT(hwparams.channels);
 	f.sample_fq = LE_INT(hwparams.rate);
 #if 0
 	tmp2 = (samplesize == 8) ? 1 : 2;
diff -r 9c822ff3e9b9 aplay/formats.h
--- a/aplay/formats.h	Thu Feb 21 09:12:53 2008 +0100
+++ b/aplay/formats.h	Thu Mar 06 14:25:52 2008 +0000
@@ -69,6 +69,10 @@ typedef struct voc_ext_block {
 #define WAV_FMT_PCM             0x0001
 #define WAV_FMT_IEEE_FLOAT      0x0003
 #define WAV_FMT_DOLBY_AC3_SPDIF 0x0092
+#define WAV_FMT_EXTENSIBLE      0xfffe
+
+/* Used with WAV_FMT_EXTENSIBLE format */
+#define WAV_GUID_TAG		"\x00\x00\x00\x00\x10\x00\x80\x00\x00\xAA\x00\x38\x9B\x71"
 
 /* it's in chunks like .voc and AMIGA iff, but my source say there
    are in only in this combination, so I combined them in one header;
@@ -81,13 +85,22 @@ typedef struct {
 } WaveHeader;
 
 typedef struct {
-	u_short format;		/* should be 1 for PCM-code */
-	u_short modus;		/* 1 Mono, 2 Stereo */
+	u_short format;		/* see WAV_FMT_* */
+	u_short channels;
 	u_int sample_fq;	/* frequence of sample */
 	u_int byte_p_sec;
 	u_short byte_p_spl;	/* samplesize; 1 or 2 bytes */
 	u_short bit_p_spl;	/* 8, 12 or 16 bit */
 } WaveFmtBody;
+
+typedef struct {
+	WaveFmtBody format;
+	u_short ext_size;
+	u_short bit_p_spl;
+	u_int channel_mask;
+	u_short guid_format;	/* WAV_FMT_* */
+	u_char guid_tag[14];	/* WAV_GUID_TAG */
+} WaveFmtExtensibleBody;
 
 typedef struct {
 	u_int type;		/* 'data' */
