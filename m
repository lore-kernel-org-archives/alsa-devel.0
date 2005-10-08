From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Subject: arecord peak meter for S24_3 format
Date: Sat, 8 Oct 2005 15:34:31 +0100
Message-ID: <20051008143431.GA7457@palantir8>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

I have an edirol ua-25 (uses S24_3LE format) connected to my
powerbook (i.e. big endian).
When I used 'arecord -vv tst.wav' the peak meter is always 0.
Using the patch below (against 1.0.10rc1) I get what looks to be
good output.

But now I wonder why the other code does not acount for endianess
differences between format and cpu?

My alsa kernel driver is still 1.0.8. Not sure if there are any fixes
related to this in later version. The actual recording sounds ok when
played back on the ua-25 or the built-in powermac chip.

Kinda confused,
-- 
Martin

--- aplay.c.orig	2005-10-08 11:41:18.000000000 +0100
+++ aplay.c	2005-10-08 15:01:44.000000000 +0100
@@ -1099,6 +1100,7 @@
 static void compute_max_peak(u_char *data, size_t count)
 {
 	signed int val, max, max_peak = 0, perc;
+	static	int	run = 0;
 	size_t ocount = count;
 	
 	switch (bits_per_sample) {
@@ -1125,6 +1127,33 @@
 		}
 		break;
 	}
+	case 24: {
+		unsigned char *valp = data;
+		signed int mask = snd_pcm_format_silence_32(hwparams.format);
+		int	format_little = snd_pcm_format_little_endian(hwparams.format);
+		count /= 3;
+		while (count-- > 0) {
+			if (format_little) {
+				val = valp[0] | (valp[1]<<8) | (valp[2]<<16);
+				//val = __le32_to_cpu(val) >> 8;
+			} else {
+				val = (valp[0]<<16) | (valp[1]<<8) | valp[2];
+				//val = __be32_to_cpu(val) >> 8;
+			}
+			// Correct signed bit in 32-bit value
+			if (val & (1<<(bits_per_sample-1))) {
+				val |= 0xff<<24;	// Negate upper bits too
+				val = -val;
+			}
+//printf("0x%lx\t",val);
+
+			val = abs(val) ^ mask;
+			if (max_peak < val)
+				max_peak = val;
+			data += 3;
+		}
+		break;
+	}
 	case 32: {
 		signed int *valp = (signed int *)data;
 		signed int mask = snd_pcm_format_silence_32(hwparams.format);
@@ -1138,7 +1167,11 @@
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


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
