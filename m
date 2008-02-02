From: Andrew Paprocki <andrew@ishiboo.com>
Subject: [PATCH] aplay/arecord - Add support for IEEE float
	32-bit WAV files
Date: Sat, 02 Feb 2008 17:29:52 -0400
Message-ID: <711f7227eb13715f8a4b.1201991392@am2>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ag-out-0708.google.com (ag-out-0708.google.com [72.14.246.248])
	by alsa0.perex.cz (Postfix) with ESMTP id 81BEF245F2
	for <alsa-devel@alsa-project.org>; Sat,  2 Feb 2008 23:30:11 +0100 (CET)
Received: by ag-out-0708.google.com with SMTP id 22so345152agd.8
	for <alsa-devel@alsa-project.org>; Sat, 02 Feb 2008 14:30:10 -0800 (PST)
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

This patch modifies aplay/arecord to support playing/capturing IEEE float
32-bit WAV files. Tested on HDA hardware in both stereo and multi-channel
modes. Added the WAV file constant for Dolby AC-3 S/PDIF passthrough to
formats.h for future use when AC-3 passthrough is better supported.

Signed-off-by: Andrew Paprocki <andrew@ishiboo.com>

diff -r 675baf17b7c9 -r 711f7227eb13 aplay/aplay.c
--- a/aplay/aplay.c	Mon Jan 21 10:42:48 2008 +0100
+++ b/aplay/aplay.c	Sat Feb 02 17:28:32 2008 -0500
@@ -745,8 +745,9 @@ static ssize_t test_wavefile(int fd, u_c
 	check_wavefile_space(buffer, len, blimit);
 	test_wavefile_read(fd, buffer, &size, len, __LINE__);
 	f = (WaveFmtBody*) buffer;
-	if (LE_SHORT(f->format) != WAV_PCM_CODE) {
-		error(_("can't play not PCM-coded WAVE-files"));
+        if (LE_SHORT(f->format) != WAV_FMT_PCM &&
+            LE_SHORT(f->format) != WAV_FMT_IEEE_FLOAT) {
+                error(_("can't play WAVE-file format 0x%04x which is not PCM or FLOAT encoded"), LE_SHORT(f->format));
 		exit(EXIT_FAILURE);
 	}
 	if (LE_SHORT(f->modus) < 1) {
@@ -788,7 +789,10 @@ static ssize_t test_wavefile(int fd, u_c
 		}
 		break;
 	case 32:
-		hwparams.format = SND_PCM_FORMAT_S32_LE;
+                if (LE_SHORT(f->format) == WAV_FMT_PCM)
+                        hwparams.format = SND_PCM_FORMAT_S32_LE;
+                else if (LE_SHORT(f->format) == WAV_FMT_IEEE_FLOAT)
+                        hwparams.format = SND_PCM_FORMAT_FLOAT_LE;
 		break;
 	default:
 		error(_(" can't play WAVE-files with sample %d bits wide"),
@@ -1778,6 +1782,7 @@ static void begin_wave(int fd, size_t cn
 		bits = 16;
 		break;
 	case SND_PCM_FORMAT_S32_LE:
+        case SND_PCM_FORMAT_FLOAT_LE:
 		bits = 32;
 		break;
 	case SND_PCM_FORMAT_S24_LE:
@@ -1796,7 +1801,10 @@ static void begin_wave(int fd, size_t cn
 	cf.type = WAV_FMT;
 	cf.length = LE_INT(16);
 
-	f.format = LE_SHORT(WAV_PCM_CODE);
+        if (hwparams.format == SND_PCM_FORMAT_FLOAT_LE)
+                f.format = LE_SHORT(WAV_FMT_IEEE_FLOAT);
+        else
+                f.format = LE_SHORT(WAV_FMT_PCM);
 	f.modus = LE_SHORT(hwparams.channels);
 	f.sample_fq = LE_INT(hwparams.rate);
 #if 0
diff -r 675baf17b7c9 -r 711f7227eb13 aplay/formats.h
--- a/aplay/formats.h	Mon Jan 21 10:42:48 2008 +0100
+++ b/aplay/formats.h	Sat Feb 02 17:28:32 2008 -0500
@@ -64,7 +64,11 @@ typedef struct voc_ext_block {
 #define WAV_WAVE		COMPOSE_ID('W','A','V','E')
 #define WAV_FMT			COMPOSE_ID('f','m','t',' ')
 #define WAV_DATA		COMPOSE_ID('d','a','t','a')
-#define WAV_PCM_CODE		1
+
+/* WAVE fmt block constants from Microsoft mmreg.h header */
+#define WAV_FMT_PCM             0x0001
+#define WAV_FMT_IEEE_FLOAT      0x0003
+#define WAV_FMT_DOLBY_AC3_SPDIF 0x0092
 
 /* it's in chunks like .voc and AMIGA iff, but my source say there
    are in only in this combination, so I combined them in one header;
