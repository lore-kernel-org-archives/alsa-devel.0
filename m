From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Subject: Re: arecord peak meter for S24_3 format
Date: Sat, 8 Oct 2005 18:05:57 +0100
Message-ID: <20051008170557.GA7723@palantir8>
References: <20051008143431.GA7457@palantir8>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20051008143431.GA7457@palantir8>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Managed to do some more testing with the ua-25 in S16_LE mode and
with plughw. Seems the 16 and 32 bit code was also not working properly.
The patch below fixes these as well, plus some more cleanup in the 24
bit code.

It is still not correct calulating the peak for any unsigned format,
but I can't be bothered about that. My guess is the code would become
more complicated.
Also, S24_[BL]E (24 bits in 4 bytes) is not working correctly as the
sign bit is not handled in the 32 bit code. I could fix this if people
feel it's important.

So please review the patch below, and apply if you feel its okay.
-- 
Martin

	Signed-off-by: Martin Habets <errandir_news@mph.eclipse.co.uk>
---
--- aplay.c.orig	2005-10-08 11:41:18.000000000 +0100
+++ aplay.c	2005-10-08 17:38:41.000000000 +0100
@@ -43,6 +43,7 @@
 #include <sys/uio.h>
 #include <sys/time.h>
 #include <sys/signal.h>
+#include <asm/byteorder.h>
 #include "aconfig.h"
 #include "gettext.h"
 #include "formats.h"
@@ -1099,8 +1100,10 @@
 static void compute_max_peak(u_char *data, size_t count)
 {
 	signed int val, max, max_peak = 0, perc;
+	static	int	run = 0;
 	size_t ocount = count;
-	
+	int	format_little_endian = snd_pcm_format_little_endian(hwparams.format);	
+
 	switch (bits_per_sample) {
 	case 8: {
 		signed char *valp = (signed char *)data;
@@ -1116,12 +1119,39 @@
 	case 16: {
 		signed short *valp = (signed short *)data;
 		signed short mask = snd_pcm_format_silence_16(hwparams.format);
+		signed short sval;
+
 		count /= 2;
 		while (count-- > 0) {
-			val = *valp++ ^ mask;
-			val = abs(val);
+			if (format_little_endian)
+				sval = __le16_to_cpu(*valp);
+			else	sval = __be16_to_cpu(*valp);
+			sval = abs(sval) ^ mask;
+			if (max_peak < sval)
+				max_peak = sval;
+			valp++;
+		}
+		break;
+	}
+	case 24: {
+		unsigned char *valp = data;
+		signed int mask = snd_pcm_format_silence_32(hwparams.format);
+
+		count /= 3;
+		while (count-- > 0) {
+			if (format_little_endian) {
+				val = valp[0] | (valp[1]<<8) | (valp[2]<<16);
+			} else {
+				val = (valp[0]<<16) | (valp[1]<<8) | valp[2];
+			}
+			/* Correct signed bit in 32-bit value */
+			if (val & (1<<(bits_per_sample-1))) {
+				val |= 0xff<<24;	/* Negate upper bits too */
+			}
+			val = abs(val) ^ mask;
 			if (max_peak < val)
 				max_peak = val;
+			valp += 3;
 		}
 		break;
 	}
@@ -1130,20 +1160,27 @@
 		signed int mask = snd_pcm_format_silence_32(hwparams.format);
 		count /= 4;
 		while (count-- > 0) {
-			val = *valp++ ^ mask;
-			val = abs(val);
+			if (format_little_endian)
+				val = __le32_to_cpu(*valp);
+			else	val = __be32_to_cpu(*valp);
+			val = abs(val) ^ mask;
 			if (max_peak < val)
 				max_peak = val;
+			valp++;
 		}
 		break;
 	}
 	default:
-		break;
+		if (run == 0) {
+			fprintf(stderr, "Unsupported bit size %d.\n", bits_per_sample);
+			run = 1;
+		}
+		return;
 	}
 	max = 1 << (bits_per_sample-1);
 	if (max <= 0)
 		max = 0x7fffffff;
-	printf(_("Max peak (%li samples): %05i (0x%04x) "), (long)ocount, max_peak, max_peak);
+	printf("Max peak (%li samples): 0x%08x ", (long)ocount, max_peak);
 	if (bits_per_sample > 16)
 		perc = max_peak / (max / 100);
 	else


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
