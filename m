From: Adam Tla/lka <atlka@pg.gda.pl>
Subject: Re: Quake3 and DMIX
Date: Fri, 6 Feb 2004 19:14:54 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040206181454.GA11808@sunrise.pg.gda.pl>
References: <Pine.LNX.4.58.0401082219001.32519@ultros>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Q68bSM7Ycu6FN28Q"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0401082219001.32519@ultros>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA Mailing List <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,
I've made a small patch to aoss and alsa-lib. Now sound
in Quake3 started with aoss wrapper works.
Not quite good but it is a small progress anyway.
We should improve the aoss code. I am not an ALSA programmer
so I need more docs reading.

Maybe I commented too much in this patch but it is the first attempt.
I see that snd_pcm_rewind() function doesn't return positive value.

Next pcm_rate.c is broken in some way. mp3 file played with
mpg123 sounds better if I play it with OSS kernel emulation then
played with aoss and dmix plugin. In the second case we have high
frequencies cut. Also playing through aoss and dmix gives sound
clicks while OSS in kernel plays normally.



Regards
-- 
Adam Tla/lka      mailto:atlka@pg.gda.pl    ^v^ ^v^ ^v^
Computer Center,  Gdansk University of Technology, Poland
PGP public key:   finger atlka@sunrise.pg.gda.pl

--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="alsa-20040205.patch"

--- ./alsa-lib/src/pcm/pcm_rate_old.c	2004-02-04 10:21:12.000000000 +0100
+++ ./alsa-lib/src/pcm/pcm_rate.c	2004-02-06 14:46:15.000000000 +0100
@@ -460,8 +460,11 @@
 	rate->states = malloc(channels * sizeof(*rate->states));
 	if (rate->states == NULL)
 		return -ENOMEM;
+/*
+ * It's not working properly with plugins AST
 	if ((buffer_size / period_size) * period_size == buffer_size)
 		return 0;
+*/
 	rate->pareas = malloc(2 * channels * sizeof(*rate->pareas));
 	if (rate->pareas == NULL)
 		return -ENOMEM;
--- ./alsa-oss/alsa-oss_old.c	2003-12-01 15:06:23.000000000 +0100
+++ ./alsa-oss/alsa-oss.c	2004-02-06 14:39:20.000000000 +0100
@@ -193,7 +193,8 @@
 
 static int oss_dsp_hw_params(oss_dsp_t *dsp)
 {
-	int k;
+	int k,dir;
+	snd_pcm_uframes_t size;
 	for (k = 1; k >= 0; --k) {
 		oss_dsp_stream_t *str = &dsp->streams[k];
 		snd_pcm_t *pcm = str->pcm;
@@ -232,12 +233,21 @@
 			err = snd_pcm_hw_params_set_access_mask(pcm, hw, mask);
 			if (err < 0)
 				return err;
-			err = snd_pcm_hw_params_set_period_size(pcm, hw, str->mmap_period_bytes / str->frame_bytes, 0);
+			dir = 0;
+			size = str->mmap_period_bytes / str->frame_bytes;
+			err = snd_pcm_hw_params_set_period_size_near(pcm, hw, &size, &dir);
 			if (err < 0)
 				return err;
-			err = snd_pcm_hw_params_set_buffer_size(pcm, hw, str->mmap_buffer_bytes / str->frame_bytes);
+/*
+		err = snd_pcm_hw_params_get_buffer_size(hw, &dir);
+		if (err < 0)
+			return err;
+		fprintf(stderr, "\nBuffer size=%d wanted=%d",
+				dir,str->mmap_buffer_bytes / str->frame_bytes);
+		err = snd_pcm_hw_params_set_buffer_size(pcm, hw, dir);
 			if (err < 0)
 				return err;
+*/
 			err = snd_pcm_hw_params_set_access(pcm, hw, SND_PCM_ACCESS_MMAP_INTERLEAVED);
 			if (err < 0)
 				return err;
@@ -345,13 +355,10 @@
 static int oss_dsp_params(oss_dsp_t *dsp)
 {
 	int err;
-	err = oss_dsp_hw_params(dsp);
-	if (err < 0) 
-		return err;
-	err = oss_dsp_sw_params(dsp);
-	if (err < 0) 
-		return err;
-	return 0;
+	if ((err = oss_dsp_hw_params(dsp)) >= 0 )
+	if ((err = oss_dsp_sw_params(dsp)) >= 0 )
+		return 0;
+	return err;
 }
 
 static int oss_dsp_close(int fd)
@@ -765,7 +772,7 @@
 	return result;
 }
 
-#define USE_REWIND 1
+#define USE_REWIND 0
 
 static void oss_dsp_mmap_update(oss_dsp_t *dsp, snd_pcm_stream_t stream,
 				snd_pcm_sframes_t delay)
@@ -774,9 +781,12 @@
 	snd_pcm_t *pcm = str->pcm;
 	snd_pcm_sframes_t err;
 	snd_pcm_uframes_t size;
+	snd_pcm_uframes_t ofs;
+	snd_pcm_uframes_t frames;
 	const snd_pcm_channel_area_t *areas;
 	switch (stream) {
 	case SND_PCM_STREAM_PLAYBACK:
+/*
 		if (delay < 0) {
 			snd_pcm_reset(pcm);
 			str->mmap_advance -= delay;
@@ -784,6 +794,7 @@
 				str->mmap_advance = dsp->rate / 10;
 //			fprintf(stderr, "mmap_advance=%ld\n", str->mmap_advance);
 		}
+*/
 #if USE_REWIND
 		err = snd_pcm_rewind(pcm, str->buffer_size);
 		if (err < 0)
@@ -795,16 +806,20 @@
 		size = str->mmap_advance - delay;
 #endif
 		while (size > 0) {
-			snd_pcm_uframes_t ofs;
-			snd_pcm_uframes_t frames = size;
+			frames = size;
 			snd_pcm_mmap_begin(pcm, &areas, &ofs, &frames);
-//			fprintf(stderr, "copy %ld %ld %d\n", ofs, frames, dsp->format);
+			if (!frames)
+				return;
+//		fprintf(stderr, "copy %ld %ld %d\n", ofs, frames, dsp->format);
 			snd_pcm_areas_copy(areas, ofs, str->mmap_areas, ofs, 
 					   dsp->channels, frames,
 					   dsp->format);
 			err = snd_pcm_mmap_commit(pcm, ofs, frames);
-			assert(err == (snd_pcm_sframes_t) frames);
-			size -= frames;
+			if ( err <= 0)
+				return;
+//		assert(err == (snd_pcm_sframes_t) frames);
+			size -= err;
+			ofs += err;
 		}
 		break;
 	case SND_PCM_STREAM_CAPTURE:
@@ -1349,7 +1364,10 @@
 		result = MAP_FAILED;
 		goto _end;
 	}
-	assert(!str->mmap_buffer);
+	if (str->mmap_buffer){
+		free(str->mmap_buffer);
+		str->mmap_buffer = NULL;
+	}
 	result = malloc(len);
 	if (!result) {
 		result = MAP_FAILED;

--Q68bSM7Ycu6FN28Q--


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
