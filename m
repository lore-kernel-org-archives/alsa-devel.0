From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: MPG123 and alsa
Date: Tue, 25 May 2004 14:57:11 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0405251451240.6093-100000@studcom.urz.uni-halle.de>
References: <20040517092233.60503.qmail@web60810.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <20040517092233.60503.qmail@web60810.mail.yahoo.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: tsw@johana.com
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Tom Watson wrote:
> I just downloaded a version (most recent I assume) of MPG123.
> When I tried to do a 'make linux-alsa' I got a wholw bunch of
> errors.  While I suspect that this is because they are using an
> older oversion of alsa (0.5.x?).

Yes.

> and has anyone else done any mods to the mpg123 (or its library).

Try the patch below.


HTH
Clemens

-- 
diff -ur mpg123-pre0.59s-orig/audio.c mpg123-pre0.59s/audio.c
--- mpg123-pre0.59s-orig/audio.c	Thu Jan 18 15:00:33 2001
+++ mpg123-pre0.59s/audio.c	Sat May 22 16:52:21 2004
@@ -17,9 +17,6 @@
   ai->output = -1;
 #ifdef ALSA
   ai->handle = NULL;
-  ai->alsa_format.format = -1;
-  ai->alsa_format.rate = -1;
-  ai->alsa_format.channels = -1;
 #endif
   ai->device = NULL;
   ai->channels = -1;
diff -ur mpg123-pre0.59s-orig/audio.h mpg123-pre0.59s/audio.h
--- mpg123-pre0.59s-orig/audio.h	Thu Jan 18 15:00:33 2001
+++ mpg123-pre0.59s/audio.h	Sat May 22 16:55:10 2004
@@ -42,7 +42,9 @@


 #ifdef ALSA
-#include <sys/asoundlib.h>
+#define ALSA_PCM_NEW_HW_PARAMS_API
+#define ALSA_PCM_NEW_SW_PARAMS_API
+#include <alsa/asoundlib.h>
 #endif

 struct audio_info_struct
@@ -59,7 +61,6 @@
   int output;
 #ifdef ALSA
   snd_pcm_t *handle;
-  snd_pcm_format_t alsa_format;
 #endif
 #ifdef AIX_UMS
   UMSAudioDevice dev;
diff -ur mpg123-pre0.59s-orig/audio_alsa.c mpg123-pre0.59s/audio_alsa.c
--- mpg123-pre0.59s-orig/audio_alsa.c	Mon Sep 20 16:55:02 1999
+++ mpg123-pre0.59s/audio_alsa.c	Sat May 22 21:20:31 2004
@@ -1,189 +1,168 @@
 /*
- *  Driver for Advanced Linux Sound Architecture, http://alsa.jcu.cz
+ *  Driver for Advanced Linux Sound Architecture, http://www.alsa-project.org
  *
  *  Code by Anders Semb Hermansen <ahermans@vf.telia.no>
- *  Cleanups by Jaroslav Kysela <perex@jcu.cz>
+ *  Cleanups by Jaroslav Kysela <perex@suse.cz>
  *              Ville Syrjala <syrjala@sci.fi>
+ *  Modified for ALSA 1.0.x by Clemens Ladisch <clemens@ladisch.de>
  *
- *  You can use -a <soundcard #>:<device #>...
- *  For example: mpg123 -a 1:0 aaa.mpg
- *               mpg123 -a guspnp:1 aaa.mpg
+ *  You can use -a devicename ...
+ *  For example: mpg123 -a hw:1,0 aaa.mpg
+ *               mpg123 -a guspnp aaa.mpg
  *
  * This file comes under GPL license.
  */

 #include "mpg123.h"

-#include <stdlib.h>
-#include <ctype.h>
-#include <sys/asoundlib.h>
-
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
-
 int audio_open(struct audio_info_struct *ai)
 {
 	int err;
-	int card=0,device=0;
-	char scard[128], sdevice[128];
+	const char *pcm_name;

 	if(!ai)
 		return -1;
-	if(ai->device) {	/* parse ALSA device name */
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
-	}
-
-	if((err=snd_pcm_open(&ai->handle, card, device, SND_PCM_OPEN_PLAYBACK)) < 0 )
-	{
-		fprintf(stderr, "open failed: %s\n", snd_strerror(err));
-		exit(1);
-	}

-	if(audio_reset_parameters(ai) < 0)
+	pcm_name = ai->device ? ai->device : "default";
+	if((err=snd_pcm_open(&ai->handle, pcm_name, SND_PCM_STREAM_PLAYBACK, 0)) < 0)
 	{
-		audio_close(ai);
+		fprintf(stderr, "cannot open %s: %s\n", pcm_name, snd_strerror(err));
 		return -1;
 	}

-	return 0;
+	if(ai->format != -1)
+		/* we're going to play: initialize sample format */
+		return audio_reset_parameters(ai);
+	else
+		/* query mode; sample format will be set for each query */
+		return 0;
 }

-static void audio_set_playback_params(struct audio_info_struct *ai)
+int audio_reset_parameters(struct audio_info_struct *ai)
 {
 	int err;
-	snd_pcm_playback_info_t pi;
-	snd_pcm_playback_params_t pp;
+	snd_pcm_format_t format;
+	unsigned int rate;
+	snd_pcm_uframes_t buffer_size;
+	snd_pcm_uframes_t period_size;
+	snd_pcm_uframes_t boundary;
+	snd_pcm_hw_params_t *hw;
+	snd_pcm_sw_params_t *sw;

-	if((err=snd_pcm_playback_info(ai->handle, &pi)) < 0 )
+	snd_pcm_hw_params_alloca(&hw);
+	if((err=snd_pcm_hw_params_any(ai->handle, hw)) < 0)
 	{
-		fprintf(stderr, "playback info failed: %s\n", snd_strerror(err));
-		return;	/* not fatal error */
+		fprintf(stderr, "no configuration available: %s\n", snd_strerror(err));
+		return -1;
 	}
-
-	bzero(&pp, sizeof(pp));
-	pp.fragment_size = pi.buffer_size/4;
-	if (pp.fragment_size > pi.max_fragment_size) pp.fragment_size = pi.max_fragment_size;
-	if (pp.fragment_size < pi.min_fragment_size) pp.fragment_size = pi.min_fragment_size;
-	pp.fragments_max = -1;
-	pp.fragments_room = 1;
-
-	if((err=snd_pcm_playback_params(ai->handle, &pp)) < 0 )
+	if((err=snd_pcm_hw_params_set_access(ai->handle, hw, SND_PCM_ACCESS_RW_INTERLEAVED)) < 0)
 	{
-		fprintf(stderr, "playback params failed: %s\n", snd_strerror(err));
-		return; /* not fatal error */
+		fprintf(stderr, "pcm doesn't support interleaved access: %s\n", snd_strerror(err));
+		return -1;
 	}
-}
-
-int audio_reset_parameters(struct audio_info_struct *ai)
-{
-	audio_set_format(ai);
-	audio_set_channels(ai);
-	audio_set_rate(ai);
-
-	return 0;
-}
-
-int audio_rate_best_match(struct audio_info_struct *ai)
-{
-	return 0;
-}
-
-int audio_set_rate(struct audio_info_struct *ai)
-{
-	int ret;
-
-	if(!ai || ai->rate < 0)
+	switch(ai->format)
+	{
+	case AUDIO_FORMAT_SIGNED_16:
+		format = SND_PCM_FORMAT_S16;
+		break;
+	case AUDIO_FORMAT_UNSIGNED_16:
+		format = SND_PCM_FORMAT_U16;
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
+	default:
+		fprintf(stderr, "invalid sample format %d\n", ai->format);
 		return -1;
-
-	ai->alsa_format.rate=ai->rate;
-
-	if((ret=snd_pcm_playback_format(ai->handle, &ai->alsa_format)) < 0 )
+	}
+	if((err=snd_pcm_hw_params_set_format(ai->handle, hw, format)) < 0)
+	{
+		fprintf(stderr, "cannot set format %s: %s\n",
+			snd_pcm_format_name(format), snd_strerror(err));
 		return -1;
-
-	audio_set_playback_params(ai);
-
-	return 0;
-}
-
-int audio_set_channels(struct audio_info_struct *ai)
-{
-	int ret;
-
-	if(ai->alsa_format.channels < 0)
-		return 0;
-
-	ai->alsa_format.channels = ai->channels;
-
-	if((ret=snd_pcm_playback_format(ai->handle, &ai->alsa_format)) < 0 )
+	}
+	if((err=snd_pcm_hw_params_set_channels(ai->handle, hw, ai->channels)) < 0)
+	{
+		fprintf(stderr, "cannot set %d channels: %s\n", ai->channels, snd_strerror(err));
 		return -1;
-
-	audio_set_playback_params(ai);
-
-	return 0;
-}
-
-int audio_set_format(struct audio_info_struct *ai)
-{
-	int ret;
-
-	if(ai->format == -1)
-		return 0;
-
-	switch(ai->format)
+	}
+	rate = ai->rate;
+	if((err=snd_pcm_hw_params_set_rate_near(ai->handle, hw, &rate, NULL)) < 0)
 	{
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
+		fprintf(stderr, "cannot set rate %u: %s\n", rate, snd_strerror(err));
+		return -1;
 	}
-
-	if((ret=snd_pcm_playback_format(ai->handle, &ai->alsa_format)) < 0 )
+	if(rate != ai->rate)
+	{
+		fprintf(stderr, "rate %ld not available, using %u\n", ai->rate, rate);
+	}
+	buffer_size = rate; /* one second */
+	if((err=snd_pcm_hw_params_set_buffer_size_near(ai->handle, hw, &buffer_size)) < 0)
+	{
+		fprintf(stderr, "cannot set buffer size: %s\n", snd_strerror(err));
 		return -1;
+	}
+	period_size = buffer_size / 4;
+	if((err=snd_pcm_hw_params_set_period_size_near(ai->handle, hw, &period_size, NULL)) < 0)
+	{
+		fprintf(stderr, "cannot set period size: %s\n", snd_strerror(err));
+		return -1;
+	}
+	if((err=snd_pcm_hw_params(ai->handle, hw)) < 0)
+	{
+		fprintf(stderr, "cannot set hw params: %s\n", snd_strerror(err));
+		return -1;
+	}

-	audio_set_playback_params(ai);
-
+	snd_pcm_sw_params_alloca(&sw);
+	if((err=snd_pcm_sw_params_current(ai->handle, sw)) < 0)
+	{
+		fprintf(stderr, "cannot get sw params: %s\n", snd_strerror(err));
+		return -1;
+	}
+	/* start playing when buffer is (almost) full */
+	if((err=snd_pcm_sw_params_set_start_threshold(ai->handle, sw, (buffer_size / period_size) * period_size)) < 0)
+	{
+		fprintf(stderr, "cannot set start threshold: %s\n", snd_strerror(err));
+		return -1;
+	}
+	if((err=snd_pcm_sw_params_get_boundary(sw, &boundary)) < 0)
+	{
+		fprintf(stderr, "cannot get boundary: %s\n", snd_strerror(err));
+		return -1;
+	}
+	/* never stop on underruns */
+	if((err=snd_pcm_sw_params_set_stop_threshold(ai->handle, sw, boundary)) < 0)
+	{
+		fprintf(stderr, "cannot set stop threshold: %s\n", snd_strerror(err));
+		return -1;
+	}
+	/* wake up on every interrupt */
+	if((err=snd_pcm_sw_params_set_avail_min(ai->handle, sw, 1)) < 0)
+	{
+		fprintf(stderr, "cannot set min avail: %s\n", snd_strerror(err));
+		return -1;
+	}
+	/* always write as many frames as possible */
+	if((err=snd_pcm_sw_params_set_xfer_align(ai->handle, sw, 1)) < 0)
+	{
+		fprintf(stderr, "cannot set transfer alignment: %s\n", snd_strerror(err));
+		return -1;
+	}
+	if((err=snd_pcm_sw_params(ai->handle, sw)) < 0)
+	{
+		fprintf(stderr, "cannot set sw params: %s\n", snd_strerror(err));
+		return -1;
+	}
 	return 0;
 }

@@ -191,7 +170,7 @@
 {
 	int i, err;
 	int fmt = -1;
-	snd_pcm_playback_info_t pi;
+	snd_pcm_hw_params_t *hw;

 	static int fmts[] = {
 		AUDIO_FORMAT_SIGNED_16, AUDIO_FORMAT_UNSIGNED_16,
@@ -199,19 +178,26 @@
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
+	snd_pcm_hw_params_alloca(&hw);
+	if((err=snd_pcm_hw_params_any(ai->handle, hw)) < 0)
 	{
-		fprintf(stderr, "playback info failed: %s\n", snd_strerror(err));
+		fprintf(stderr, "no configuration available: %s\n", snd_strerror(err));
 		return -1;
 	}
+	if(snd_pcm_hw_params_set_access(ai->handle, hw, SND_PCM_ACCESS_RW_INTERLEAVED))
+		return -1;
+	if(snd_pcm_hw_params_set_channels(ai->handle, hw, ai->channels))
+		return -1;
+	if(snd_pcm_hw_params_set_rate(ai->handle, hw, ai->rate, 0))
+		return -1;

 	for (i = 0; i < 6; i++) {
-		if (pi.formats & afmts[i]) {
+		if (snd_pcm_hw_params_test_format(ai->handle, hw, afmts[i]) == 0) {
 			if (fmt == -1)
 				fmt = 0;
 			fmt |= fmts[i];
@@ -223,16 +209,14 @@

 int audio_play_samples(struct audio_info_struct *ai,unsigned char *buf,int len)
 {
-	ssize_t ret;
-
-	ret=snd_pcm_write(ai->handle, buf, len);
-
-	return ret;
+	snd_pcm_uframes_t frames = snd_pcm_bytes_to_frames(ai->handle, len);
+	return snd_pcm_writei(ai->handle, buf, frames);
 }

 int audio_close(struct audio_info_struct *ai)
 {
-	int ret;
-	ret = snd_pcm_close(ai->handle);
-	return ret;
+	if (/* !aborted && */
+	    snd_pcm_state(ai->handle) == SND_PCM_STATE_RUNNING)
+		snd_pcm_drain(ai->handle);
+	return snd_pcm_close(ai->handle);
 }





-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
