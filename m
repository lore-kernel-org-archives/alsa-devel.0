From: Pete Zaitcev <zaitcev@yahoo.com>
Subject: Re: snd_pcm_writei is stuck with EPIPE
Date: Sun, 14 Nov 2004 11:06:18 -0800 (PST)
Message-ID: <20041114190618.86791.qmail@web60401.mail.yahoo.com>
References: <419641AA.5010209@cubic.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1819361140-1100459178=:84928"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <419641AA.5010209@cubic.org>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Dirk Jagdmann <doj@cubic.org>
Cc: alsa-devel@lists.sourceforge.net, mh@mpg123.de, perex@suse.cz, zaitcev@yahoo.com
List-Id: alsa-devel@alsa-project.org

--0-1819361140-1100459178=:84928
Content-Type: text/plain; charset=us-ascii
Content-Id: 
Content-Disposition: inline

It looks I found it. The trick is to call snd_pcm_prepare when an underflow
is reported. Working patch is attached in case Michael is interested.
Also, there's an old patch at alsa-project.org which supports ALSA 0.5 API
and is integrated into mpg123-0.59r. Maybe Jaroslav would add this there.

The error code is documented in the Doxygen docs, but nothing was said
that the error is persistent and has to be reset, and how to reset it.
Probably worth fixing as well.

-- Pete


		
__________________________________ 
Do you Yahoo!? 
Check out the new Yahoo! Front Page. 
www.yahoo.com 
 

--0-1819361140-1100459178=:84928
Content-Type: text/x-patch; name="mpg123-0.59r-p3.diff"
Content-Description: mpg123-0.59r-p3.diff
Content-Disposition: inline; filename="mpg123-0.59r-p3.diff"

Support of ALSA 0.9 API shipping in Fedora Core 3.

diff -upr mpg123-0.59r/audio_alsa.c mpg123-0.59r-p3/audio_alsa.c
--- mpg123-0.59r/audio_alsa.c	1999-05-28 03:25:50.000000000 -0700
+++ mpg123-0.59r-p3/audio_alsa.c	2004-11-14 10:56:10.135657333 -0800
@@ -4,9 +4,10 @@
  *  Code by Anders Semb Hermansen <ahermans@vf.telia.no>
  *  Cleanups by Jaroslav Kysela <perex@jcu.cz>
  *              Ville Syrjala <syrjala@sci.fi>
+ *  ALSA 0.9.0 API by Pete Zaitcev <zaitcev@yahoo.com>
  *
- *  You can use -a <soundcard #>:<device #>...
- *  For example: mpg123 -a 1:0 aaa.mpg
+ *  You can use -a <soundcard name>:<device #>[,<subdevice #>]...
+ *  For example: mpg123 -a hw:0,0 aaa.mpg
  *               mpg123 -a guspnp:1 aaa.mpg
  *
  * This file comes under GPL license. 
@@ -16,97 +17,157 @@
 
 #include <stdlib.h>
 #include <ctype.h>
-#include <sys/asoundlib.h>
+#include <alsa/asoundlib.h>
 
-#ifdef SND_LITTLE_ENDIAN
-#define SND_PCM_SFMT_S16_NE SND_PCM_SFMT_S16_LE
-#define SND_PCM_SFMT_U16_NE SND_PCM_SFMT_U16_LE
-#define SND_PCM_FMT_S16_NE SND_PCM_FMT_S16_LE
-#define SND_PCM_FMT_U16_NE SND_PCM_FMT_U16_LE
-#else
-#define SND_PCM_SFMT_S16_NE SND_PCM_SFMT_S16_BE
-#define SND_PCM_SFMT_U16_NE SND_PCM_SFMT_U16_BE
-#define SND_PCM_FMT_S16_NE SND_PCM_FMT_S16_BE
-#define SND_PCM_FMT_U16_NE SND_PCM_FMT_U16_BE
-#endif
+static int audio_set_playback_params(struct audio_info_struct *ai);
 
 int audio_open(struct audio_info_struct *ai)
 {
 	int err;
-	int card=0,device=0;
-	char scard[128], sdevice[128];
+	char *device;
 
 	if(!ai)
 		return -1;
 	if(ai->device) {	/* parse ALSA device name */
-		if(strchr(ai->device,':')) {	/* card with device */
-			strncpy(scard, ai->device, sizeof(scard)-1);
-			scard[sizeof(scard)-1] = '\0';
-			if (strchr(scard,':')) *strchr(scard,':') = '\0';
-			card = snd_card_name(scard);
-			if (card < 0) {
-				fprintf(stderr, "wrong soundcard number: %s\n", scard);
-				exit(1);
-			}
-			strncpy(sdevice, strchr(ai->device, ':') + 1, sizeof(sdevice)-1);
-		} else {
-			strncpy(sdevice, ai->device, sizeof(sdevice)-1);
-		}
-		sdevice[sizeof(sdevice)-1] = '\0';
-		device = atoi(sdevice);
-		if (!isdigit(sdevice[0]) || device < 0 || device > 31) {
-			fprintf(stderr, "wrong device number: %s\n", sdevice);
-			exit(1);
-		}
+		device = ai->device;
+	} else {
+		device = "hw:0,0";
 	}
 
-	if((err=snd_pcm_open(&ai->handle, card, device, SND_PCM_OPEN_PLAYBACK)) < 0 )
+	if ((err = snd_pcm_open(&ai->handle, device, SND_PCM_STREAM_PLAYBACK, 0)) < 0)
 	{
-		fprintf(stderr, "open failed: %s\n", snd_strerror(err));
+		fprintf(stderr, "open failed for %s: %s\n", device, snd_strerror(err));
+		/*
+		 * An exit is pretty disgusting, for a library.
+		 * We are trying to prevent perror() in mpg123 from
+		 * using a bogus errno.
+		 */
 		exit(1);
 	}
 
-	if(audio_reset_parameters(ai) < 0)
-	{
-		audio_close(ai);
+	if ((err = snd_pcm_hw_params_malloc(&ai->params)) < 0) {
+		fprintf(stderr, "params malloc failed: %s\n", snd_strerror(err));
+		snd_pcm_close(ai->handle);
 		return -1;
 	}
 
+	audio_set_playback_params(ai);	/* Probably not really needed. */
 	return 0;
 }
 
-static void audio_set_playback_params(struct audio_info_struct *ai)
+/*
+ * ALSA's setting model is a phantasmagoric nightmare. It has no notion of a
+ * current setting, but only a notion of a current set of settings. The only way
+ * to set rate and format is to start with a set which includes all settings,
+ * then narrow it down to the settings you need.
+ */
+static int audio_set_playback_params(struct audio_info_struct *ai)
 {
+	snd_pcm_hw_params_t *pp = ai->params;
 	int err;
-	snd_pcm_playback_info_t pi;
-	snd_pcm_playback_params_t pp;
+	snd_pcm_format_t format;
+	unsigned int buffer_time;
+
+	/*
+	 * First, obtain the complete set.
+	 */
+	if ((err = snd_pcm_hw_params_any(ai->handle, pp)) < 0) {
+		fprintf(stderr, "snd_pcm_hw_params_any failed: %s\n",
+		    snd_strerror(err));
+		return -1;
+	}
 
-	if((err=snd_pcm_playback_info(ai->handle, &pi)) < 0 )
+	/*
+	 * Narrorow access (not settable)
+	 */
+	err = snd_pcm_hw_params_set_access(ai->handle, pp, SND_PCM_ACCESS_RW_INTERLEAVED);
+	if (err < 0) {
+		fprintf(stderr, "snd_pcm_hw_params_set_access failed: %s\n",
+		    snd_strerror(err));
+		return -1;
+	}
+
+	/*
+	 * Narrow the set with mpg123 settables: channels, format, rate.
+	 */
+	if (ai->channels >= 1) {
+		err = snd_pcm_hw_params_set_channels(ai->handle, pp, ai->channels);
+		if (err < 0) {
+			fprintf(stderr,
+			    "snd_pcm_hw_params_set_channels failed: %s\n",
+			    snd_strerror(err));
+			return -1;
+		}
+	}
+
+	switch(ai->format)
 	{
-		fprintf(stderr, "playback info failed: %s\n", snd_strerror(err));
-		return;	/* not fatal error */
+	case AUDIO_FORMAT_SIGNED_16:
+	default:
+		format = SND_PCM_FORMAT_S16;
+		break;
+	case AUDIO_FORMAT_UNSIGNED_8:
+		format = SND_PCM_FORMAT_U8;
+		break;
+	case AUDIO_FORMAT_SIGNED_8:
+		format = SND_PCM_FORMAT_S8;
+		break;
+	case AUDIO_FORMAT_ULAW_8:
+		format = SND_PCM_FORMAT_MU_LAW;
+		break;
+	case AUDIO_FORMAT_ALAW_8:
+		format = SND_PCM_FORMAT_A_LAW;
+		break;
+	case AUDIO_FORMAT_UNSIGNED_16:
+		format = SND_PCM_FORMAT_U16;
+		break;
+	}
+	err = snd_pcm_hw_params_set_format(ai->handle, pp, format);
+	if (err < 0) {
+		fprintf(stderr,
+		    "snd_pcm_hw_params_set_format failed: %s\n",
+		    snd_strerror(err));
+		return -1;
 	}
 
-	bzero(&pp, sizeof(pp));
-	pp.fragment_size = pi.buffer_size/4;
-	if (pp.fragment_size > pi.max_fragment_size) pp.fragment_size = pi.max_fragment_size;
-	if (pp.fragment_size < pi.min_fragment_size) pp.fragment_size = pi.min_fragment_size;
-	pp.fragments_max = -1;
-	pp.fragments_room = 1;
+	if (ai->rate >= 0) {
+		err = snd_pcm_hw_params_set_rate(ai->handle, pp, ai->rate, 0);
+		if (err < 0) {
+			fprintf(stderr,
+			    "snd_pcm_hw_params_set_rate failed: %s\n",
+			    snd_strerror(err));
+			return -1;
+		}
+	}
 
-	if((err=snd_pcm_playback_params(ai->handle, &pp)) < 0 )
+	/*
+	 * Default in ALSA is way too interactive, skips like crazy.
+	 */
+	buffer_time = 500000;	/* Half second */
+	if ((err = snd_pcm_hw_params_set_buffer_time_near(ai->handle, pp,
+	    &buffer_time, 0)) < 0)
 	{
-		fprintf(stderr, "playback params failed: %s\n", snd_strerror(err));
-		return; /* not fatal error */
+		fprintf(stderr,
+		    "snd_pcm_hw_params_set_buffer_time_near failed: %s\n",
+		    snd_strerror(err));
 	}
+
+	/*
+	 * Finally, commit settings to the hardware.
+	 */
+	if ((err = snd_pcm_hw_params(ai->handle, pp)) < 0) {
+		fprintf(stderr, "snd_pcm_hw_params failed: %s\n", snd_strerror(err));
+		/* Not fatal for partial settings at initialization */
+		return 0;
+	}
+
+	return 0;
 }
 
 int audio_reset_parameters(struct audio_info_struct *ai)
 {
-	audio_set_format(ai);
-	audio_set_channels(ai);
-	audio_set_rate(ai);
 
+	audio_set_playback_params(ai);
 	return 0;
 }
 
@@ -117,81 +178,33 @@ int audio_rate_best_match(struct audio_i
 
 int audio_set_rate(struct audio_info_struct *ai)
 {
-	int ret;
 
 	if(!ai || ai->rate < 0)
 		return -1;
-
-	ai->alsa_format.rate=ai->rate;
-
-	if((ret=snd_pcm_playback_format(ai->handle, &ai->alsa_format)) < 0 )
-		return -1;
-
-	audio_set_playback_params(ai);
-
-	return 0;
+	return audio_set_playback_params(ai);
 }
 
 int audio_set_channels(struct audio_info_struct *ai)
 {
-	int ret;
 
-	if(ai->alsa_format.channels < 0)
+	if(ai->channels < 0)
 		return 0;
-
-	ai->alsa_format.channels = ai->channels;
-
-	if((ret=snd_pcm_playback_format(ai->handle, &ai->alsa_format)) < 0 )
-		return -1;
-
-	audio_set_playback_params(ai);
-
-	return 0;
+	return audio_set_playback_params(ai);
 }
 
 int audio_set_format(struct audio_info_struct *ai)
 {
-	int ret;
 
 	if(ai->format == -1)
 		return 0;
-
-	switch(ai->format)
-	{
-		case AUDIO_FORMAT_SIGNED_16:
-		default:
-			ai->alsa_format.format=SND_PCM_SFMT_S16_NE;
-			break;
-		case AUDIO_FORMAT_UNSIGNED_8:
-			ai->alsa_format.format=SND_PCM_SFMT_U8;
-			break;
-		case AUDIO_FORMAT_SIGNED_8:
-			ai->alsa_format.format=SND_PCM_SFMT_S8;
-			break;
-		case AUDIO_FORMAT_ULAW_8:
-			ai->alsa_format.format=SND_PCM_SFMT_MU_LAW;
-			break;
-		case AUDIO_FORMAT_ALAW_8:
-			ai->alsa_format.format=SND_PCM_SFMT_A_LAW;
-			break;
-		case AUDIO_FORMAT_UNSIGNED_16:
-			ai->alsa_format.format=SND_PCM_SFMT_U16_NE;
-			break;
-	}
-
-	if((ret=snd_pcm_playback_format(ai->handle, &ai->alsa_format)) < 0 )
-		return -1;
-
-	audio_set_playback_params(ai);
-
-	return 0;
+	return audio_set_playback_params(ai);
 }
 
 int audio_get_formats(struct audio_info_struct *ai)
 {
-	int i, err;
+	snd_pcm_format_mask_t *mask;
+	int i;
 	int fmt = -1;
-	snd_pcm_playback_info_t pi;
 
 	static int fmts[] = {
 		AUDIO_FORMAT_SIGNED_16, AUDIO_FORMAT_UNSIGNED_16,
@@ -199,19 +212,17 @@ int audio_get_formats(struct audio_info_
 		AUDIO_FORMAT_ULAW_8, AUDIO_FORMAT_ALAW_8
 	};
 	static int afmts[] = {
-		SND_PCM_FMT_S16_NE, SND_PCM_FMT_U16_NE,
-		SND_PCM_FMT_U8, SND_PCM_FMT_S8,
-		SND_PCM_FMT_MU_LAW, SND_PCM_FMT_A_LAW
+		SND_PCM_FORMAT_S16, SND_PCM_FORMAT_U16,
+		SND_PCM_FORMAT_U8, SND_PCM_FORMAT_S8,
+		SND_PCM_FORMAT_MU_LAW, SND_PCM_FORMAT_A_LAW
 	};
 
-	if((err=snd_pcm_playback_info(ai->handle, &pi)) < 0 )
-	{
-		fprintf(stderr, "playback info failed: %s\n", snd_strerror(err));
-		return -1;
-	}
+	snd_pcm_format_mask_alloca(&mask);
 
+	snd_pcm_hw_params_any(ai->handle, ai->params);
+	snd_pcm_hw_params_get_format_mask(ai->params, mask);
 	for (i = 0; i < 6; i++) {
-		if (pi.formats & afmts[i]) {
+		if (snd_pcm_format_mask_test(mask, afmts[i])) {
 			if (fmt == -1)
 				fmt = 0;
 			fmt |= fmts[i];
@@ -223,9 +234,32 @@ int audio_get_formats(struct audio_info_
 
 int audio_play_samples(struct audio_info_struct *ai,unsigned char *buf,int len)
 {
-	ssize_t ret;
+	int ret, err;
+	unsigned int factor;
 
-	ret=snd_pcm_write(ai->handle, buf, len);
+	factor = 0;
+	if (ai->channels != 1) factor += 1;
+	if (ai->format & AUDIO_FORMAT_MASK) factor += 1;
+
+	ret = 0;
+	while (len > 0) {
+		if ((err = snd_pcm_writei(ai->handle, buf, len >> factor)) < 0) {
+			if (err == -EPIPE) {
+				snd_pcm_prepare(ai->handle);
+				return ret;
+			} else if (err == -EAGAIN) {
+				err = 0;
+			} else {
+				fprintf(stderr, "snd_pcm_writei failed: %s\n",
+				    snd_strerror(ret));
+				return err;
+			}
+		}
+		err <<= factor;
+		ret += err;
+		len -= err;
+		buf += err;
+	}
 
 	return ret;
 }
@@ -233,6 +267,8 @@ int audio_play_samples(struct audio_info
 int audio_close(struct audio_info_struct *ai)
 {
 	int ret;
+
 	ret = snd_pcm_close(ai->handle);
+	snd_pcm_hw_params_free(ai->params);
 	return ret;
 }
diff -upr mpg123-0.59r/audio.c mpg123-0.59r-p3/audio.c
--- mpg123-0.59r/audio.c	1999-04-06 08:53:05.000000000 -0700
+++ mpg123-0.59r-p3/audio.c	2004-11-10 23:04:58.000000000 -0800
@@ -17,9 +17,7 @@ void audio_info_struct_init(struct audio
   ai->output = -1;
 #ifdef ALSA
   ai->handle = NULL;
-  ai->alsa_format.format = -1;
-  ai->alsa_format.rate = -1;
-  ai->alsa_format.channels = -1;
+  ai->params = NULL;
 #endif
   ai->device = NULL;
   ai->channels = -1;
diff -upr mpg123-0.59r/audio.h mpg123-0.59r-p3/audio.h
--- mpg123-0.59r/audio.h	1999-06-15 13:22:03.000000000 -0700
+++ mpg123-0.59r-p3/audio.h	2004-11-10 22:15:16.000000000 -0800
@@ -35,9 +35,8 @@ enum { DECODE_TEST, DECODE_AUDIO, DECODE
 #include <dmedia/audio.h>
 #endif
 
-
 #ifdef ALSA
-#include <sys/asoundlib.h>
+#include <alsa/asoundlib.h>
 #endif
 
 struct audio_info_struct
@@ -53,8 +52,8 @@ struct audio_info_struct
   long gain;
   int output;
 #ifdef ALSA
-  void *handle;
-  snd_pcm_format_t alsa_format;
+  snd_pcm_t *handle;
+  snd_pcm_hw_params_t *params;
 #endif
   char *device;
   int channels;

--0-1819361140-1100459178=:84928--


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
