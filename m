From: Markus Grabner <grabner@icg.tu-graz.ac.at>
Subject: Re: sample rate conversion
Date: Sun, 5 Sep 2004 22:57:26 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200409052257.27674.grabner@icg.tu-graz.ac.at>
References: <200409021953.57939.grabner@icg.tu-graz.ac.at> <Pine.LNX.4.58.0409031710210.21405@linux.local> <413898A7.7090502@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_223OBZO6d029dSV"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <413898A7.7090502@superbug.demon.co.uk>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: Jaroslav Kysela <perex@suse.cz>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--Boundary-00=_223OBZO6d029dSV
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


	Hi again!

    Now I looked at the resampling code in more detail and (I think) 
understand the issues (downsampling happens in snd_pcm_rate_shrink with fixed 
input and output buffer sizes simply by omitting some of the input samples 
according to the desired sample rate ratio). I modified the code to do a 
linear interpolation between the closest two samples instead of just 
selecting the closest one, and this completely removes the annoying noise I 
previously reported (at least as far as I can tell with high-quality 
headphones). The patch is attached.

Needless to say, adding interpolation in the innermost loop requires more 
processor time, so I evaluated my approach with a 370 seconds long 16bit 
stereo MP3 file. I am using a Pentium II 350MHz (yes, such dinosaurs still 
exist :-) with 512MB RAM and found the following results:

user mode cpu-time consumed while playing the complete audio file:
without interpolation: 7 seconds
with interpolation: 11 seconds

-> CPU usage:
without interpolation: 1.9%
with interpolation: 3%

I optimized the code to avoid floating point operations, but there are still 
two multiplications and one division involved. However, since modern PCs are 
~10 times faster, further optimization is not really urgent in my opinion.

The upsampling code already does some interpolation (also using two 
multiplications and one division). Not surprisingly therefore, the test file 
sounded significantly better if downsampled with sox to 32kHz and then played 
on the 39kHz device (ALSA upsampling) than directly played (ALSA-1.0.6 
downsampling).

Would you consider to include this code in a future release of the ALSA 
library?

	Kind regards,
		Markus


-- 
Markus Grabner - Computer Graphics and Vision
Graz University of Technology, Inffeldgasse 16/II, 8010 Graz, Austria
Phone: +43/316/873-5041, Fax: +43/316/873-5050
Email: grabner@icg.tu-graz.ac.at, WWW: http://www.icg.tu-graz.ac.at/~grabner

--Boundary-00=_223OBZO6d029dSV
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="downsample_interpolate.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="downsample_interpolate.patch"

--- alsa-lib-1.0.6-orig/src/pcm/pcm_rate.c	2004-08-09 08:31:41.000000000 +0200
+++ alsa-lib-1.0.6/src/pcm/pcm_rate.c	2004-09-05 22:46:17.947253031 +0200
@@ -45,7 +45,8 @@
 #ifndef DOC_HIDDEN
 
 /* LINEAR_DIV needs to be large enough to handle resampling from 192000 -> 8000 */
-#define LINEAR_DIV (1<<19)
+#define LINEAR_DIV_SHIFT 19
+#define LINEAR_DIV (1<<LINEAR_DIV_SHIFT)
 
 enum rate_type {
 	RATE_TYPE_LINEAR,		/* linear interpolation */
@@ -206,9 +207,12 @@
 		const char *src;
 		char *dst;
 		int src_step, dst_step;
+		int16_t old_sample = 0;
+		int16_t new_sample = 0;
+		int old_weight, new_weight;
 		sum = states->u.linear.sum;
 		//int16_t old_sample = states->u.linear.old_sample;
-		pos = LINEAR_DIV/2; /* Start at 0.5 */
+		pos = LINEAR_DIV - get_increment; /* Force first sample to be copied */
 		states->u.linear.init = 0;
 		src = snd_pcm_channel_area_addr(src_area, src_offset);
 		dst = snd_pcm_channel_area_addr(dst_area, dst_offset);
@@ -223,11 +227,15 @@
 #include "plugin_ops.h"
 #undef GET16_END
 		after_get:
+			new_sample = sample;
 			src += src_step;
 			src_frames1++;
 			pos += get_increment;
 			if (pos >= LINEAR_DIV) {
 				pos -= LINEAR_DIV;
+				old_weight = (pos << (32 - LINEAR_DIV_SHIFT)) / (get_increment >> (LINEAR_DIV_SHIFT - 16));
+				new_weight = 0x10000 - old_weight;
+				sample = (old_sample * old_weight + new_sample * new_weight) >> 16;
 				goto *put;
 #define PUT16_END after_put
 #include "plugin_ops.h"
@@ -237,6 +245,7 @@
 				dst_frames1++;
 				assert(dst_frames1 <= dst_frames);
 			}
+			old_sample = new_sample;
 		}
 
 		states->u.linear.sum = sum;

--Boundary-00=_223OBZO6d029dSV--


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
