From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: [PATCH] pcm_rate.c  fixes.
Date: Sun, 08 Aug 2004 16:59:42 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <41164DEE.703@superbug.demon.co.uk>
References: <41164197.4050001@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010903010409010207030805"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from anchor-post-34.mail.demon.net (anchor-post-34.mail.demon.net [194.217.242.92])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 0F00622F
	for <alsa-devel@alsa-project.org>; Sun,  8 Aug 2004 17:59:43 +0200 (MEST)
Received: from superbug.demon.co.uk ([80.176.146.252] helo=[192.168.1.10])
	by anchor-post-34.mail.demon.net with esmtp (Exim 3.35 #1)
	id 1Btq5H-000DtH-0Y
	for alsa-devel@alsa-project.org; Sun, 08 Aug 2004 15:59:43 +0000
In-Reply-To: <41164197.4050001@superbug.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------010903010409010207030805
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Updated patch to remove un-needed SNDERR messages.
See attached.

James Courtier-Dutton wrote:
> This should be the final patch required to pcm_rate.c. The patch is 
> against the current alsa-lib CVS.
> 
> This patch fixes a number of different bugs in pcm_rate.c.
> 1) Resampling now works for rate 192000 -> 8000.
> 2) zero samples are not accidentally inserted into the stream any more.
> 3) Corrects period size calculations.
> 4) Prevents avail_min and xfer_align being less than 1.
> 
> This should improve the sound quality. Further improvements can be made 
> by implementing polyphase filters, thereby removing aliases generally 
> caused by any resampling algorithm that does not include a low pass 
> filter before changing the number of samples.
> 
> Cheers
> 
> James
> 

--------------010903010409010207030805
Content-Type: text/plain;
 name="alsa-lib-pcm_rate.c-diff2.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsa-lib-pcm_rate.c-diff2.txt"

Index: alsa-lib/src/pcm/pcm_rate.c
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/src/pcm/pcm_rate.c,v
retrieving revision 1.84
diff -u -r1.84 pcm_rate.c
--- alsa-lib/src/pcm/pcm_rate.c	26 Apr 2004 07:40:13 -0000	1.84
+++ alsa-lib/src/pcm/pcm_rate.c	8 Aug 2004 15:57:43 -0000
@@ -27,8 +27,7 @@
  *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
  *
  */
-  
-#include <limits.h>
+#include <inttypes.h>
 #include <byteswap.h>
 #include "pcm_local.h"
 #include "pcm_plugin.h"
@@ -45,7 +44,8 @@
 
 #ifndef DOC_HIDDEN
 
-#define LINEAR_DIV (1<<16)
+/* LINEAR_DIV needs to be large enough to handle resampling from 192000 -> 8000 */
+#define LINEAR_DIV (1<<19)
 
 enum rate_type {
 	RATE_TYPE_LINEAR,		/* linear interpolation */
@@ -58,7 +58,7 @@
 		struct {
 			int init;
 			int16_t old_sample, new_sample;
-			int sum;
+			int64_t sum;
 		} linear;
 	} u;
 } snd_pcm_rate_state_t;
@@ -168,6 +168,9 @@
 				assert(src_frames1 <= src_frames);
 			}
 		} 
+		if (dst_frames != dst_frames1) {
+			SNDERR("dst_frames %lu, dst_frames1 %lu, src_frames %lu, src_frames1 %lu\n", dst_frames, dst_frames1, src_frames, src_frames1);
+		}
 		states->u.linear.old_sample = old_sample;
 		states->u.linear.new_sample = new_sample;
 		states++;
@@ -194,17 +197,18 @@
 	snd_pcm_uframes_t src_frames1 = 0;
 	snd_pcm_uframes_t dst_frames1 = 0;
 	int16_t sample = 0;
+	unsigned int pos = 0;
 
 	for (channel = 0; channel < channels; ++channel) {
 		const snd_pcm_channel_area_t *src_area = &src_areas[channel];
 		const snd_pcm_channel_area_t *dst_area = &dst_areas[channel];
-		unsigned int pos;
-		int sum;
+		int64_t sum;
 		const char *src;
 		char *dst;
 		int src_step, dst_step;
 		sum = states->u.linear.sum;
-		pos = 0;
+		//int16_t old_sample = states->u.linear.old_sample;
+		pos = LINEAR_DIV/2; /* Start at 0.5 */
 		states->u.linear.init = 0;
 		src = snd_pcm_channel_area_addr(src_area, src_offset);
 		dst = snd_pcm_channel_area_addr(dst_area, dst_offset);
@@ -223,26 +227,25 @@
 			src_frames1++;
 			pos += get_increment;
 			if (pos >= LINEAR_DIV) {
-				int s = sample;
 				pos -= LINEAR_DIV;
-				sum += s * (get_increment - pos);
-				sum /= LINEAR_DIV;
-				sample = sum;
 				goto *put;
 #define PUT16_END after_put
 #include "plugin_ops.h"
 #undef PUT16_END
 			after_put:
 				dst += dst_step;
-				sum = s * pos;
 				dst_frames1++;
 				assert(dst_frames1 <= dst_frames);
-			} else
-				sum += sample * get_increment;
+			}
 		}
+
 		states->u.linear.sum = sum;
+		states->u.linear.old_sample = sample;
 		states++;
 	}
+	if (dst_frames != dst_frames1) {
+		SNDERR("dst %lu, dst1 %lu, src %lu, src1 %lu pos = %u\n", dst_frames, dst_frames1, src_frames, src_frames1, pos );
+	}
 }
 
 #endif /* DOC_HIDDEN */
@@ -254,9 +257,9 @@
 		return 0;
 	/* Round toward zero */
 	if (pcm->stream == SND_PCM_STREAM_PLAYBACK)
-		return muldiv_down(frames, LINEAR_DIV, rate->pitch);
+		return muldiv_near(frames, LINEAR_DIV, rate->pitch);
 	else
-		return muldiv_down(frames, rate->pitch, LINEAR_DIV);
+		return muldiv_near(frames, rate->pitch, LINEAR_DIV);
 }
 
 static snd_pcm_sframes_t snd_pcm_rate_slave_frames(snd_pcm_t *pcm, snd_pcm_sframes_t frames)
@@ -264,9 +267,9 @@
 	snd_pcm_rate_t *rate = pcm->private_data;
 	/* Round toward zero */
 	if (pcm->stream == SND_PCM_STREAM_PLAYBACK)
-		return muldiv_down(frames, rate->pitch, LINEAR_DIV);
+		return muldiv_near(frames, rate->pitch, LINEAR_DIV);
 	else
-		return muldiv_down(frames, LINEAR_DIV, rate->pitch);
+		return muldiv_near(frames, LINEAR_DIV, rate->pitch);
 }
 
 static int snd_pcm_rate_hw_refine_cprepare(snd_pcm_t *pcm ATTRIBUTE_UNUSED, snd_pcm_hw_params_t *params)
@@ -488,7 +491,7 @@
 		rate->func = snd_pcm_rate_shrink;
 		/* pitch is get_increment */
 	}
-	rate->pitch = (((u_int64_t)dst_rate * LINEAR_DIV) + src_rate - 1) / src_rate;
+	rate->pitch = (((u_int64_t)dst_rate * LINEAR_DIV) + (src_rate / 2)) / src_rate;
 	assert(!rate->states);
 	assert(!rate->pareas);
 	rate->states = malloc(channels * sizeof(*rate->states));
@@ -581,56 +584,60 @@
 	params->boundary = boundary1;
 	sparams->boundary = boundary2;
 	if (pcm->stream == SND_PCM_STREAM_PLAYBACK) {
-		rate->pitch = (((u_int64_t)slave->period_size * LINEAR_DIV) + pcm->period_size - 1) / pcm->period_size;
+		rate->pitch = (((u_int64_t)slave->period_size * LINEAR_DIV) + (pcm->period_size/2) ) / pcm->period_size;
 		do {
-			snd_pcm_uframes_t cframes;
+			snd_pcm_uframes_t cframes,cframes_test;
 			
-			cframes = snd_pcm_rate_client_frames(pcm, slave->period_size - 1);
-			if (cframes == pcm->period_size - 1)
+			cframes = snd_pcm_rate_client_frames(pcm, slave->period_size );
+			if (cframes == pcm->period_size )
 				break;
-			if (cframes > pcm->period_size - 1) {
+			if (cframes > pcm->period_size ) {
 				rate->pitch++;
-				if ((snd_pcm_uframes_t)snd_pcm_rate_client_frames(pcm, slave->period_size - 1) < pcm->period_size - 1) {
-					SNDERR("Unable to satisfy pitch condition (%i/%i - %li/%li)\n", slave->rate, pcm->rate, slave->period_size - 1, pcm->period_size - 1);
+				cframes_test = snd_pcm_rate_client_frames(pcm, slave->period_size );
+				if (cframes_test < pcm->period_size ) {
+					SNDERR("Unable to satisfy pitch condition (%i/%i - %li/%li)\n", slave->rate, pcm->rate, slave->period_size, pcm->period_size);
 					return -EIO;
 				}
 			} else {
 				rate->pitch--;
-				if ((snd_pcm_uframes_t)snd_pcm_rate_client_frames(pcm, slave->period_size - 1) > pcm->period_size - 1) {
-					SNDERR("Unable to satisfy pitch condition (%i/%i - %li/%li)\n", slave->rate, pcm->rate, slave->period_size - 1, pcm->period_size - 1);
+				cframes_test = snd_pcm_rate_client_frames(pcm, slave->period_size );
+				if (cframes_test > pcm->period_size) {
+					SNDERR("Unable to satisfy pitch condition (%i/%i - %li/%li)\n", slave->rate, pcm->rate, slave->period_size, pcm->period_size);
 					return -EIO;
 				}
 			}
 		} while (1);
-		assert((snd_pcm_uframes_t)snd_pcm_rate_client_frames(pcm, slave->period_size - 1) == pcm->period_size - 1);
+		assert((snd_pcm_uframes_t)snd_pcm_rate_client_frames(pcm, slave->period_size ) == pcm->period_size );
 	} else {
-		rate->pitch = (((u_int64_t)pcm->period_size * LINEAR_DIV) + slave->period_size - 1) / slave->period_size;
+		rate->pitch = (((u_int64_t)pcm->period_size * LINEAR_DIV) + (slave->period_size/2) ) / slave->period_size;
 		do {
 			snd_pcm_uframes_t cframes;
 			
-			cframes = snd_pcm_rate_slave_frames(pcm, pcm->period_size - 1);
-			if (cframes == slave->period_size - 1)
+			cframes = snd_pcm_rate_slave_frames(pcm, pcm->period_size );
+			if (cframes == slave->period_size )
 				break;
-			if (cframes > slave->period_size - 1) {
+			if (cframes > slave->period_size ) {
 				rate->pitch++;
-				if ((snd_pcm_uframes_t)snd_pcm_rate_slave_frames(pcm, pcm->period_size - 1) < slave->period_size - 1) {
-					SNDERR("Unable to satisfy pitch condition (%i/%i - %li/%li)\n", slave->rate, pcm->rate, slave->period_size - 1, pcm->period_size - 1);
+				if ((snd_pcm_uframes_t)snd_pcm_rate_slave_frames(pcm, pcm->period_size ) < slave->period_size ) {
+					SNDERR("Unable to satisfy pitch condition (%i/%i - %li/%li)\n", slave->rate, pcm->rate, slave->period_size, pcm->period_size);
 					return -EIO;
 				}
 			} else {
 				rate->pitch--;
-				if ((snd_pcm_uframes_t)snd_pcm_rate_slave_frames(pcm, pcm->period_size - 1) > slave->period_size - 1) {
-					SNDERR("Unable to satisfy pitch condition (%i/%i - %li/%li)\n", slave->rate, pcm->rate, slave->period_size - 1, pcm->period_size - 1);
+				if ((snd_pcm_uframes_t)snd_pcm_rate_slave_frames(pcm, pcm->period_size) > slave->period_size ) {
+					SNDERR("Unable to satisfy pitch condition (%i/%i - %li/%li)\n", slave->rate, pcm->rate, slave->period_size , pcm->period_size );
 					return -EIO;
 				}
 			}
 		} while (1);
-		assert((snd_pcm_uframes_t)snd_pcm_rate_slave_frames(pcm, pcm->period_size - 1) == slave->period_size - 1);
+		assert((snd_pcm_uframes_t)snd_pcm_rate_slave_frames(pcm, pcm->period_size ) == slave->period_size );
 	}
 	recalc(pcm, &sparams->avail_min);
 	rate->orig_avail_min = sparams->avail_min;
 	recalc(pcm, &sparams->xfer_align);
 	recalc(pcm, &sparams->start_threshold);
+	if (sparams->avail_min < 1) sparams->avail_min = 1;
+	if (sparams->xfer_align < 1) sparams->xfer_align = 1;
 	if (sparams->start_threshold <= slave->buffer_size) {
 		if (sparams->start_threshold > (slave->buffer_size / sparams->avail_min) * sparams->avail_min)
 			sparams->start_threshold = (slave->buffer_size / sparams->avail_min) * sparams->avail_min;

--------------010903010409010207030805--


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
