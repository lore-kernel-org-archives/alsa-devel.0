From: "Jack O'Quin" <joq@io.com>
Subject: Re: Lowest latency: JACK, or ALSA directly?
Date: 17 Nov 2004 20:07:57 -0600
Message-ID: <87d5ybvria.fsf@sulphur.joq.us>
References: <20041111144152.GA12443@stud.ntnu.no>
	<87mzxozahr.fsf@sulphur.joq.us> <20041112090416.GA3167@stud.ntnu.no>
	<87oei3xbly.fsf@sulphur.joq.us> <s5hpt2jdmsr.wl@alsa2.suse.de>
	<87k6srx9wi.fsf@sulphur.joq.us> <s5hd5ycsexu.wl@alsa2.suse.de>
	<87oehwv0tc.fsf@sulphur.joq.us> <s5h6544s529.wl@alsa2.suse.de>
	<s5h4qjos1pb.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h4qjos1pb.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: =?iso-8859-1?q?Asbj=F8rn_S=E6b=F8?= <asbjs@stud.ntnu.no>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai <tiwai@suse.de> writes:

> At Wed, 17 Nov 2004 19:28:46 +0100,
> I wrote:
> > 
> > With this model, basically the number of periods in the buffer doesn't
> > mean the latency at all but is required just for the stream
> > configuration.  The required condition is only nperiods >= 2.
> > So, this option isn't even necessary if we query the nearest buffer
> > size to "f-val * period_size".  Maybe this would be a better
> > implementation from the perspective of usability.
> 
> Ok, the attached below is more radical change.  The -f option is
> removed and the semantics of -n option is changed.  It means the
> minimal playback latency requested by user.
> The buffer size doesn't have to be exactly nperiods * period_size.
> JACK accepts more periods returned from the driver than requested.
> Also, the different number of periods are accepted, too, for playback
> and capture directions.

I think that is much better from a user perspective.  IIUC, it is
backward compatible in the sense that every case that used to work
still does, but now some cards with minimum buffer sizes will be able
to support lower playback latency.

For user documentation, I can now describe --nperiods purely in terms
of playback latency, while noting that on some devices the actual
buffer may be larger.

> Untested as usual :)

I'll try it here with my Delta-66.  

That won't test any of the strange cases where -nperiods=2 but the
device actually requires a three-period buffer.  Which cards do you
know of that are affected by this?

> (BTW, the jack code is still based on the older ALSA API.
>  Is this intentional?)

It was intentional last year so JACK would work with all ALSA
versions.  A patch was recently submitted to use the newer interfaces.
The consensus on jackit-devel was that it is time to do that now, but
the patch has not yet been committed to CVS.

(Patch follows for your review...)

> From: Rohan Drape <rd@alphalink.com.au>
> Subject: [Jackit-devel] [Patch] Update alsa_driver to use new SW/HW param interface
> To: jackit-devel@lists.sourceforge.net
> Date: 02 Nov 2004 13:04:34 +1100
> 
> 
> As subject.  For curious reasons I had to make these changes some time
> ago.  I do not know if they are appropriate for the tree proper.
> 
> Regards,
> Rohan
> 
> [2. text/x-patch; 2004-11-02.0.patch]...

Index: alsa_driver.c
===================================================================
RCS file: /cvsroot/jackit/jack/drivers/alsa/alsa_driver.c,v
retrieving revision 1.57
diff -u -r1.57 alsa_driver.c
--- alsa_driver.c	20 Oct 2004 12:10:28 -0000	1.57
+++ alsa_driver.c	2 Nov 2004 01:44:25 -0000
@@ -385,9 +385,10 @@
 			break;
 	} 
 
-	if ((err = snd_pcm_hw_params_set_rate_near (handle, hw_params,
-						    driver->frame_rate, 0))
-	    < 0) {
+	unsigned int frame_rate = driver->frame_rate ;
+	err = snd_pcm_hw_params_set_rate_near (handle, hw_params, &frame_rate, NULL) ;
+	driver->frame_rate = frame_rate ;
+	if (err < 0) {
 		jack_error ("ALSA: cannot set sample/frame rate to %"
 			    PRIu32 " for %s", driver->frame_rate,
 			    stream_name);
@@ -396,7 +397,9 @@
 	if (!*nchns) {
 		/*if not user-specified, try to find the maximum
 		 * number of channels */
-		*nchns = snd_pcm_hw_params_get_channels_max (hw_params);
+		unsigned int channels_max ;
+		err = snd_pcm_hw_params_get_channels_max (hw_params, &channels_max);
+		*nchns = channels_max ;
 
 		if (*nchns > 1024) { 
 
@@ -529,14 +532,14 @@
 			    jack_nframes_t user_nperiods,
 			    jack_nframes_t rate)
 {
-	int dir;
-	unsigned int p_period_size = 0;
-	unsigned int c_period_size = 0;
+	snd_pcm_uframes_t p_period_size = 0;
+	snd_pcm_uframes_t c_period_size = 0;
 	unsigned int p_nfragments = 0;
 	unsigned int c_nfragments = 0;
 	channel_t chn;
 	unsigned int pr = 0;
 	unsigned int cr = 0;
+	int err, dir;
 
 	driver->frame_rate = rate;
 	driver->frames_per_cycle = frames_per_cycle;
@@ -579,13 +582,11 @@
 	/* check the rate, since thats rather important */
 
 	if (driver->playback_handle) {
-		int dir;
-		pr = snd_pcm_hw_params_get_rate (driver->playback_hw_params, &dir);
+		snd_pcm_hw_params_get_rate (driver->playback_hw_params, &pr, &dir);
 	}
 
 	if (driver->capture_handle) {
-		int dir;
-		cr = snd_pcm_hw_params_get_rate (driver->capture_hw_params, &dir);
+		snd_pcm_hw_params_get_rate (driver->capture_hw_params, &cr, &dir);
 	}
 
 	if (driver->capture_handle && driver->playback_handle) {
@@ -620,19 +621,15 @@
 	/* check the fragment size, since thats non-negotiable */
 	
 	if (driver->playback_handle) {
-		p_period_size =
-			snd_pcm_hw_params_get_period_size (
-				driver->playback_hw_params, &dir);
-		p_nfragments =
-			snd_pcm_hw_params_get_periods (
-				driver->playback_hw_params, &dir);
-		driver->playback_sample_format = (snd_pcm_format_t)
-			snd_pcm_hw_params_get_format (
-				driver->playback_hw_params);
-		driver->playback_interleaved =
-			(snd_pcm_hw_params_get_access (
-				driver->playback_hw_params)
-			 == SND_PCM_ACCESS_MMAP_INTERLEAVED);
+		err = snd_pcm_hw_params_get_period_size (
+			driver->playback_hw_params, &p_period_size, &dir);
+		err = snd_pcm_hw_params_get_periods (
+			driver->playback_hw_params, &p_nfragments, &dir);
+		err = snd_pcm_hw_params_get_format (
+			driver->playback_hw_params, &(driver->playback_sample_format));
+		snd_pcm_access_t access ;
+		err = snd_pcm_hw_params_get_access (driver->playback_hw_params, &access);
+		driver->playback_interleaved = (access == SND_PCM_ACCESS_MMAP_INTERLEAVED);
 
 		if (p_period_size != driver->frames_per_cycle) {
 			jack_error ("alsa_pcm: requested an interrupt every %"
@@ -644,20 +641,16 @@
 	}
 
 	if (driver->capture_handle) {
-		c_period_size =
-			snd_pcm_hw_params_get_period_size (
-				driver->capture_hw_params, &dir);
-		c_nfragments =
-			snd_pcm_hw_params_get_periods (
-				driver->capture_hw_params, &dir);
-		driver->capture_sample_format = (snd_pcm_format_t)
-			snd_pcm_hw_params_get_format (
-				driver->capture_hw_params);
-		driver->capture_interleaved =
-			(snd_pcm_hw_params_get_access (
-				driver->capture_hw_params)
-			 == SND_PCM_ACCESS_MMAP_INTERLEAVED);
-	
+		err = snd_pcm_hw_params_get_period_size (
+			driver->capture_hw_params, &c_period_size, &dir);
+		err = snd_pcm_hw_params_get_periods (
+			driver->capture_hw_params, &c_nfragments, &dir);
+		err = snd_pcm_hw_params_get_format (
+			driver->capture_hw_params, &(driver->capture_sample_format));
+		snd_pcm_access_t access ;
+		err = snd_pcm_hw_params_get_access (driver->capture_hw_params, &access);
+		driver->capture_interleaved = (access == SND_PCM_ACCESS_MMAP_INTERLEAVED);
+
 		if (c_period_size != driver->frames_per_cycle) {
 			jack_error ("alsa_pcm: requested an interrupt every %"
 				    PRIu32
[3. text/x-patch; 2004-11-02.1.patch]...

Index: alsa_driver.h
===================================================================
RCS file: /cvsroot/jackit/jack/drivers/alsa/alsa_driver.h,v
retrieving revision 1.5
diff -u -r1.5 alsa_driver.h
--- alsa_driver.h	25 Mar 2004 19:31:50 -0000	1.5
+++ alsa_driver.h	2 Nov 2004 01:44:43 -0000
@@ -21,8 +21,6 @@
 #ifndef __jack_alsa_driver_h__
 #define __jack_alsa_driver_h__
 
-#define ALSA_PCM_OLD_HW_PARAMS_API
-#define ALSA_PCM_OLD_SW_PARAMS_API
 #include <alsa/asoundlib.h>
 
 #if __BYTE_ORDER == __LITTLE_ENDIAN

-- 
  joq


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
