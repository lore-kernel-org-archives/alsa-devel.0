From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: [PATCH] fix resamplers.
Date: Wed, 21 Jul 2004 22:50:24 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40FEE520.1040701@superbug.demon.co.uk>
References: <40FE8863.50009@superbug.demon.co.uk> <40FEB0BF.7000306@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060200050003060903070403"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <40FEB0BF.7000306@superbug.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------060200050003060903070403
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

James Courtier-Dutton wrote:
> James Courtier-Dutton wrote:
> 
>> The current pcm_rate.c tends to insert zero samples in the stream.
>>
>> E.g. Downsampling from 48000 -> 16000
>> Starts with a block of 2048, and has to create 682 samples.
>> The current code sometimes only produces 681 samples, leaving the last 
>> one zero.
>>
>> The attached patch fixes this problem.
>>
>> James
>>
>>
> 
> I have done more testing, and it does not quite fix everything.
> 
> James
> 
> 
> 

This PATCH against alsa-lib cvs seems to work well for me now.
Can some people please try it and tell me what they think ?

Thanks
James


--------------060200050003060903070403
Content-Type: text/plain;
 name="alsa-lib-rate-fix.diff.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsa-lib-rate-fix.diff.txt"

RCS file: /cvsroot/alsa/alsa-lib/src/pcm/pcm_rate.c,v
retrieving revision 1.84
diff -u -r1.84 pcm_rate.c
--- alsa-lib/src/pcm/pcm_rate.c	26 Apr 2004 07:40:13 -0000	1.84
+++ alsa-lib/src/pcm/pcm_rate.c	21 Jul 2004 21:44:31 -0000
@@ -254,9 +254,9 @@
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
@@ -264,9 +264,9 @@
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
@@ -581,51 +581,51 @@
 	params->boundary = boundary1;
 	sparams->boundary = boundary2;
 	if (pcm->stream == SND_PCM_STREAM_PLAYBACK) {
-		rate->pitch = (((u_int64_t)slave->period_size * LINEAR_DIV) + pcm->period_size - 1) / pcm->period_size;
+		rate->pitch = (((u_int64_t)slave->period_size * LINEAR_DIV) + pcm->period_size ) / pcm->period_size;
 		do {
 			snd_pcm_uframes_t cframes;
 			
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
+				if ((snd_pcm_uframes_t)snd_pcm_rate_client_frames(pcm, slave->period_size) < pcm->period_size - 1) {
+					SNDERR("Unable to satisfy pitch condition (%i/%i - %li/%li)\n", slave->rate, pcm->rate, slave->period_size, pcm->period_size);
 					return -EIO;
 				}
 			} else {
 				rate->pitch--;
-				if ((snd_pcm_uframes_t)snd_pcm_rate_client_frames(pcm, slave->period_size - 1) > pcm->period_size - 1) {
-					SNDERR("Unable to satisfy pitch condition (%i/%i - %li/%li)\n", slave->rate, pcm->rate, slave->period_size - 1, pcm->period_size - 1);
+				if ((snd_pcm_uframes_t)snd_pcm_rate_client_frames(pcm, slave->period_size) > pcm->period_size) {
+					SNDERR("Unable to satisfy pitch condition (%i/%i - %li/%li)\n", slave->rate, pcm->rate, slave->period_size, pcm->period_size);
 					return -EIO;
 				}
 			}
 		} while (1);
-		assert((snd_pcm_uframes_t)snd_pcm_rate_client_frames(pcm, slave->period_size - 1) == pcm->period_size - 1);
+		assert((snd_pcm_uframes_t)snd_pcm_rate_client_frames(pcm, slave->period_size ) == pcm->period_size );
 	} else {
-		rate->pitch = (((u_int64_t)pcm->period_size * LINEAR_DIV) + slave->period_size - 1) / slave->period_size;
+		rate->pitch = (((u_int64_t)pcm->period_size * LINEAR_DIV) + slave->period_size ) / slave->period_size;
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

--------------060200050003060903070403--


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
