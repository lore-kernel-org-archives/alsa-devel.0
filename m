From: Adam Tla/lka <atlka@pg.gda.pl>
Subject: Small cosmetic patch to alsa-oss
Date: Thu, 26 Feb 2004 23:28:49 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040226222849.GA13177@sunrise.pg.gda.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="YZ5djTAD1cGYuMQK"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-devel@lists.sourceforge.net
Cc: Tomasz /Lomotowski <thorgal@pg.gda.pl>
List-Id: alsa-devel@alsa-project.org


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Welcome,

try this patch.
I observe that quake3 with this patch works with aoss.

Regards
-- 
Adam Tla/lka      mailto:atlka@pg.gda.pl    ^v^ ^v^ ^v^
System  & Network Administration Group           ~~~~~~
Computer Center,  Gdansk University of Technology, Poland
PGP public key:   finger atlka@sunrise.pg.gda.pl

--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="alsa-20040226.patch"

diff -ru alsa-20040226-orig/alsa-oss/alsa/alsa-oss.c alsa-20040226/alsa-oss/alsa/alsa-oss.c
--- alsa-20040226-orig/alsa-oss/alsa/alsa-oss.c	2004-02-19 17:02:20.000000000 +0100
+++ alsa-20040226/alsa-oss/alsa/alsa-oss.c	2004-02-26 20:26:39.000000000 +0100
@@ -196,10 +196,8 @@
 	if (!strncmp(file, "/dev/dsp", 8) ||
 	    !strncmp(file, "/dev/adsp", 9) ||
 	    !strncmp(file, "/dev/audio", 10)) {
-		fd = lib_oss_pcm_open(file, oflag);
-		if (fd >= 0) {
-			fds[fd] = calloc(sizeof(fd_t), 1);
-			if (fds[fd] == NULL) {
+		if ((fd = lib_oss_pcm_open(file, oflag)) >= 0) {
+			if (!(fds[fd] = calloc(sizeof(fd_t), 1))) {
 				ops[FD_OSS_DSP].close(fd);
 				errno = ENOMEM;
 				return -1;
@@ -209,10 +207,8 @@
 			poll_fds_add += lib_oss_pcm_poll_fds(fd);
 		}
 	} else if (!strncmp(file, "/dev/mixer", 10)) {
-		fd = lib_oss_mixer_open(file, oflag);
-		if (fd >= 0) {
-			fds[fd] = calloc(sizeof(fd_t), 1);
-			if (fds[fd] == NULL) {
+		if ((fd = lib_oss_mixer_open(file, oflag)) >= 0) {
+			if (!(fds[fd] = calloc(sizeof(fd_t), 1))) {
 				ops[FD_OSS_MIXER].close(fd);
 				errno = ENOMEM;
 				return -1;
@@ -220,11 +216,8 @@
 			fds[fd]->class = FD_OSS_MIXER;
 			fds[fd]->oflags = oflag;
 		}
-	} else {
-		fd = _open(file, oflag, mode);
-		if (fd >= 0)
+	} else if ((fd = _open(file, oflag, mode)) >= 0)
 			assert(fds[fd] == NULL);
-	}
 	return fd;
 }
 
@@ -671,18 +664,11 @@
 
 static void initialize()
 {
-	char *s = getenv("ALSA_OSS_WRAPPER");
-	if (s == NULL)
-		return;
-	s = getenv("ALSA_OSS_DEBUG");
-	if (s)
-		alsa_oss_debug = 1;
-	open_max = sysconf(_SC_OPEN_MAX);
-	if (open_max < 0)
-		exit(1);
-	fds = calloc(open_max, sizeof(*fds));
-	if (!fds)
+	if ((open_max = sysconf(_SC_OPEN_MAX)) < 0 ||
+	    !(fds = calloc(open_max, sizeof(*fds))))
 		exit(1);
+		if (getenv("ALSA_OSS_DEBUG"))
+		alsa_oss_debug = 1;
 	_open = dlsym(RTLD_NEXT, "open");
 	_close = dlsym(RTLD_NEXT, "close");
 	_write = dlsym(RTLD_NEXT, "write");
diff -ru alsa-20040226-orig/alsa-oss/alsa/pcm.c alsa-20040226/alsa-oss/alsa/pcm.c
--- alsa-20040226-orig/alsa-oss/alsa/pcm.c	2004-02-21 21:39:54.000000000 +0100
+++ alsa-20040226/alsa-oss/alsa/pcm.c	2004-02-26 23:18:46.000000000 +0100
@@ -39,6 +39,7 @@
 #include <alsa/asoundlib.h>
 
 #include "alsa-oss-emul.h"
+#define RETERR(_code_) if ((err = _code_) < 0) return err;
 
 int alsa_oss_debug = 0;
 snd_output_t *alsa_oss_debug_out = NULL;
@@ -71,6 +72,7 @@
 } oss_dsp_stream_t;
 
 typedef struct {
+	unsigned char hwset;
 	unsigned int channels;
 	unsigned int rate;
 	unsigned int oss_format;
@@ -203,7 +205,8 @@
 
 static int oss_dsp_hw_params(oss_dsp_t *dsp)
 {
-	int k;
+	int k, dir;
+	snd_pcm_uframes_t size;
 	for (k = 1; k >= 0; --k) {
 		oss_dsp_stream_t *str = &dsp->streams[k];
 		snd_pcm_t *pcm = str->pcm;
@@ -217,20 +220,12 @@
 		snd_pcm_hw_params_any(pcm, hw);
 		dsp->format = oss_format_to_alsa(dsp->oss_format);
 
-		err = snd_pcm_hw_params_set_format(pcm, hw, dsp->format);
-		if (err < 0)
-			return err;
-		err = snd_pcm_hw_params_set_channels(pcm, hw, dsp->channels);
-		if (err < 0)
-			return err;
+		RETERR(snd_pcm_hw_params_set_format(pcm, hw, dsp->format))
+		RETERR(snd_pcm_hw_params_set_channels(pcm, hw, dsp->channels))
 		rate = dsp->rate;
-		err = snd_pcm_hw_params_set_rate_near(pcm, hw, &rate, 0);
-		if (err < 0)
-			return err;
+		RETERR(snd_pcm_hw_params_set_rate_near(pcm, hw, &rate, 0))
 #if 0
-		err = snd_pcm_hw_params_set_periods_integer(pcm, hw);
-		if (err < 0)
-			return err;
+		RETERR(snd_pcm_hw_params_set_periods_integer(pcm, hw))
 #endif
 
 		if (str->mmap_buffer) {
@@ -240,41 +235,29 @@
 			snd_pcm_access_mask_set(mask, SND_PCM_ACCESS_MMAP_INTERLEAVED);
 			snd_pcm_access_mask_set(mask, SND_PCM_ACCESS_MMAP_NONINTERLEAVED);
 			snd_pcm_access_mask_set(mask, SND_PCM_ACCESS_MMAP_COMPLEX);
-			err = snd_pcm_hw_params_set_access_mask(pcm, hw, mask);
-			if (err < 0)
-				return err;
-			err = snd_pcm_hw_params_set_period_size(pcm, hw, str->alsa.mmap_period_bytes / str->frame_bytes, 0);
-			if (err < 0)
-				return err;
-			err = snd_pcm_hw_params_set_buffer_size(pcm, hw, str->alsa.mmap_buffer_bytes / str->frame_bytes);
-			if (err < 0)
-				return err;
-			err = snd_pcm_hw_params_set_access(pcm, hw, SND_PCM_ACCESS_MMAP_INTERLEAVED);
-			if (err < 0)
-				return err;
+			RETERR(snd_pcm_hw_params_set_access_mask(pcm, hw, mask))
+			dir = 0;
+			size = str->alsa.mmap_period_bytes / str->frame_bytes;
+			RETERR(snd_pcm_hw_params_set_period_size_near(pcm, hw, &size, &dir))
+			size = str->alsa.mmap_buffer_bytes / str->frame_bytes;
+			RETERR(snd_pcm_hw_params_set_buffer_size_near(pcm, hw, &size))
+			RETERR(snd_pcm_hw_params_set_access(pcm, hw, SND_PCM_ACCESS_MMAP_INTERLEAVED))
 		} else {
-			err = snd_pcm_hw_params_set_access(pcm, hw, SND_PCM_ACCESS_RW_INTERLEAVED);
-			if (err < 0)
-				return err;
+			RETERR(snd_pcm_hw_params_set_access(pcm, hw, SND_PCM_ACCESS_RW_INTERLEAVED))
 			periods_min = 2;
-			err = snd_pcm_hw_params_set_periods_min(pcm, hw, &periods_min, 0);
-			if (err < 0)
-				return err;
+			RETERR(snd_pcm_hw_params_set_periods_min(pcm, hw, &periods_min, 0))
 			if (dsp->maxfrags > 0) {
 				unsigned int periods_max = dsp->maxfrags;
-				err = snd_pcm_hw_params_set_periods_max(pcm, hw,
-									&periods_max, 0);
-				if (err < 0)
-					return err;
+				RETERR(snd_pcm_hw_params_set_periods_max(pcm, hw, &periods_max, 0))
 			}
 			if (dsp->fragshift > 0) {
 				snd_pcm_uframes_t s = (1 << dsp->fragshift) / str->frame_bytes;
 				s *= 16;
 				while (s >= 1024 && (err = snd_pcm_hw_params_set_buffer_size(pcm, hw, s)) < 0)
-					s /= 2;
+					s >>= 1;
 				s = (1 << dsp->fragshift) / str->frame_bytes;
 				while (s >= 256 && (err = snd_pcm_hw_params_set_period_size(pcm, hw, s, 0)) < 0)
-					s /= 2;
+					s >>= 1;
 				if (err < 0) {
 					s = (1 << dsp->fragshift) / str->frame_bytes;
 					err = snd_pcm_hw_params_set_period_size_near(pcm, hw, &s, 0);
@@ -282,13 +265,13 @@
 			} else {
 				snd_pcm_uframes_t s = 16, old_s;
 				while (s * 2 < dsp->rate / 2) 
-					s *= 2;
-				old_s = s = s / 2;
+					s <<= 1;
+				old_s = s = s >> 1;
 				while (s >= 1024 && (err = snd_pcm_hw_params_set_buffer_size(pcm, hw, s)) < 0)
-					s /= 2;
+					s >>= 1;
 				s = old_s;
 				while (s >= 256 && (err = snd_pcm_hw_params_set_period_size(pcm, hw, s, 0)) < 0)
-					s /= 2;
+					s >>= 1;
 				if (err < 0) {
 					s = old_s;
 					err = snd_pcm_hw_params_set_period_size_near(pcm, hw, &s, 0);
@@ -297,22 +280,16 @@
 			if (err < 0)
 				return err;
 		}
-		err = snd_pcm_hw_params(pcm, hw);
-		if (err < 0)
-			return err;
+		RETERR(snd_pcm_hw_params(pcm, hw))
 #if 0
 		if (alsa_oss_debug)
 			snd_pcm_dump_setup(pcm, stderr);
-#endif
 		if (err < 0)
 			return err;
+#endif
 		dsp->oss_format = alsa_format_to_oss(dsp->format);
-		err = snd_pcm_hw_params_get_period_size(hw, &str->alsa.period_size, 0);
-		if (err < 0)
-			return err;
-		err = snd_pcm_hw_params_get_buffer_size(hw, &str->alsa.buffer_size);
-		if (err < 0)
-			return err;
+		RETERR(snd_pcm_hw_params_get_period_size(hw, &str->alsa.period_size, 0))
+		RETERR(snd_pcm_hw_params_get_buffer_size(hw, &str->alsa.buffer_size))
 		str->oss.buffer_size = 1 << ld2(str->alsa.buffer_size);
 		if (str->oss.buffer_size < str->alsa.buffer_size)
 			str->oss.buffer_size *= 2;
@@ -375,15 +352,9 @@
 		snd_pcm_sw_params_set_silence_size(pcm, sw,
 						   str->alsa.period_size);
 #endif
-		err = snd_pcm_sw_params(pcm, sw);
-		if (err < 0)
-			return err;
-		err = snd_pcm_sw_params_current(pcm, sw);
-		if (err < 0)
-			return err;
-		err = snd_pcm_sw_params_get_boundary(sw, &str->alsa.boundary);
-		if (err < 0)
-			return err;
+		RETERR(snd_pcm_sw_params(pcm, sw))
+		RETERR(snd_pcm_sw_params_current(pcm, sw))
+		RETERR(snd_pcm_sw_params_get_boundary(sw, &str->alsa.boundary))
 	}
 	return 0;
 }
@@ -391,12 +362,10 @@
 static int oss_dsp_params(oss_dsp_t *dsp)
 {
 	int err;
-	err = oss_dsp_hw_params(dsp);
-	if (err < 0) 
-		return err;
-	err = oss_dsp_sw_params(dsp);
-	if (err < 0) 
-		return err;
+	dsp->hwset = 0;
+	RETERR(oss_dsp_hw_params(dsp))
+	dsp->hwset++;
+	RETERR(oss_dsp_sw_params(dsp))
 #if 0
 	if (alsa_oss_debug && alsa_oss_debug_out) {
 		int k;
@@ -462,33 +431,24 @@
 	int result;
 	char name[64];
 
-	char *s = getenv("ALSA_OSS_DEBUG");
-	if (s) {
+	if (getenv("ALSA_OSS_DEBUG")) {
 		alsa_oss_debug = 1;
 		if (alsa_oss_debug_out == NULL) {
 			if (snd_output_stdio_attach(&alsa_oss_debug_out, stderr, 0) < 0)
 				alsa_oss_debug_out = NULL;
 		}
 	}
-	switch (device) {
-	case OSS_DEVICE_DSP:
+	
+	if (device == OSS_DEVICE_DSP)
 		format = AFMT_U8;
-		sprintf(name, "dsp%d", card);
-		break;
-	case OSS_DEVICE_DSPW:
+	else if (device == OSS_DEVICE_DSPW)
 		format = AFMT_S16_LE;
-		sprintf(name, "dspW%d", card);
-		break;
-	case OSS_DEVICE_AUDIO:
-		sprintf(name, "audio%d", card);
-		break;
-	case OSS_DEVICE_ADSP:
-		sprintf(name, "adsp%d", card);
-		break;
-	default:
-		errno = ENOENT;
-		return -1;
-	}
+
+	if (!card)
+		strcpy(name, "default");
+	else
+		sprintf(name, "plughw:%d", card);
+
 	if (mode & O_NONBLOCK)
 		pcm_mode = SND_PCM_NONBLOCK;
 	switch (oflag & O_ACCMODE) {
@@ -506,21 +466,19 @@
 		errno = EINVAL;
 		return -1;
 	}
-	fd = open("/dev/null", oflag & O_ACCMODE);
-	if (fd < 0)
+	if ((fd = open("/dev/null", oflag & O_ACCMODE)) < 0)
 		return -1;
-	xfd = calloc(1, sizeof(fd_t));
-	if (!xfd) {
-		close(fd);
+	if (!(xfd = calloc(1, sizeof(fd_t)))) {
 		errno = ENOMEM;
+ _error1:
+		close(fd);
 		return -1;
 	}
-	dsp = calloc(1, sizeof(oss_dsp_t));
-	if (!dsp) {
-		close(fd);
-		free(xfd);
+	if (!(dsp = calloc(1, sizeof(oss_dsp_t)))) {
 		errno = ENOMEM;
-		return -1;
+ _error2:
+		free(xfd);
+		goto _error1;
 	}
 	xfd->dsp = dsp;
 	dsp->channels = 1;
@@ -530,53 +488,30 @@
 	for (k = 0; k < 2; ++k) {
 		if (!(streams & (1 << k)))
 			continue;
-		result = snd_pcm_open(&dsp->streams[k].pcm, name, k, pcm_mode);
-		if (result < 0) {
-			if (k == 1 && dsp->streams[0].pcm != NULL) {
-				dsp->streams[1].pcm = NULL;
-				streams &= ~(1 << SND_PCM_STREAM_CAPTURE);
-				result = 0;
-			}
-			break;
-		}
+		if ((result = snd_pcm_open(&dsp->streams[k].pcm, name, k, pcm_mode)) < 0)
+			goto _error3;
 	}
-	if (result < 0) {
-		result = 0;
-		for (k = 0; k < 2; ++k) {
-			if (dsp->streams[k].pcm) {
-				snd_pcm_close(dsp->streams[k].pcm);
-				dsp->streams[k].pcm = NULL;
-			}
-		}
-		/* try to open the default pcm as fallback */
-		if (card == 0 && (device == OSS_DEVICE_DSP || device == OSS_DEVICE_AUDIO))
-			strcpy(name, "default");
-		else
-			sprintf(name, "plughw:%d", card);
-		for (k = 0; k < 2; ++k) {
-			if (!(streams & (1 << k)))
-				continue;
-			result = snd_pcm_open(&dsp->streams[k].pcm, name, k, pcm_mode);
-			if (result < 0)
-				goto _error;
-		}
-	}
-	result = oss_dsp_params(dsp);
-	if (result < 0)
-		goto _error;
+	if ((result = oss_dsp_params(dsp)) < 0)
+		goto _error3;
 	xfd->fileno = fd;
 	insert_fd(xfd);
 	return fd;
 
- _error:
-	close(fd);
+ _error3:
+	for (k = 0; k < 2; ++k) {
+		if (dsp->streams[k].pcm) {
+			snd_pcm_close(dsp->streams[k].pcm);
+			dsp->streams[k].pcm = NULL;
+		}
+	}
 	errno = -result;
-	return -1;
+	free(dsp);
+	goto _error2;
 }
 
 ssize_t lib_oss_pcm_write(int fd, const void *buf, size_t n)
 {
-	ssize_t result;
+	ssize_t result = -1;
 	oss_dsp_t *dsp = look_for_dsp(fd);
 	oss_dsp_stream_t *str;
 	snd_pcm_t *pcm;
@@ -584,14 +519,11 @@
 
 	if (dsp == NULL) {
 		errno = EBADFD;
-		result = -1;
 		goto _end;
 	}
 	str = &dsp->streams[SND_PCM_STREAM_PLAYBACK];
-	pcm = str->pcm;
-	if (!pcm) {
+	if (!(pcm = str->pcm)) {
 		errno = EBADFD;
-		result = -1;
 		goto _end;
 	}
 	frames = n / str->frame_bytes;
@@ -629,7 +561,7 @@
 
 ssize_t lib_oss_pcm_read(int fd, void *buf, size_t n)
 {
-	ssize_t result;
+	ssize_t result = -1;
 	oss_dsp_t *dsp = look_for_dsp(fd);
 	oss_dsp_stream_t *str;
 	snd_pcm_t *pcm;
@@ -637,14 +569,11 @@
 
 	if (dsp == NULL) {
 		errno = EBADFD;
-		result = -1;
 		goto _end;
 	}
 	str = &dsp->streams[SND_PCM_STREAM_CAPTURE];
-	pcm = str->pcm;
-	if (!pcm) {
+	if (!(pcm = str->pcm)) {
 		errno = EBADFD;
-		result = -1;
 		goto _end;
 	}
 	frames = n / str->frame_bytes;
@@ -680,7 +609,7 @@
 	return result;
 }
 
-#define USE_REWIND 1
+#define USE_REWIND 0
 
 static void oss_dsp_mmap_update(oss_dsp_t *dsp, snd_pcm_stream_t stream,
 				snd_pcm_sframes_t delay)
@@ -700,15 +629,13 @@
 //			fprintf(stderr, "mmap_advance=%ld\n", str->mmap_advance);
 		}
 #if USE_REWIND
-		err = snd_pcm_rewind(pcm, str->alsa.buffer_size);
-		if (err < 0) {
+		if ((err = snd_pcm_rewind(pcm, str->alsa.buffer_size)) < 0) {
 			/* fallback to not very accurate method */
 			size = str->mmap_advance - delay;
 		} else {
 			size = str->mmap_advance;
 		}
-//		fprintf(stderr, "delay=%ld rewind=%ld forward=%ld\n",
-//			delay, err, size);
+//		fprintf(stderr, "delay=%ld rewind=%ld forward=%ld\n", delay, err, size);
 #else
 		size = str->mmap_advance - delay;
 #endif
@@ -716,18 +643,16 @@
 			snd_pcm_uframes_t ofs;
 			snd_pcm_uframes_t frames = size;
 			snd_pcm_mmap_begin(pcm, &areas, &ofs, &frames);
-			if (frames == 0)
+			if (!frames)
 				break;
 //			fprintf(stderr, "copy %ld %ld %d\n", ofs, frames, dsp->format);
 			snd_pcm_areas_copy(areas, ofs, str->mmap_areas, ofs, 
 					   dsp->channels, frames,
 					   dsp->format);
-			err = snd_pcm_mmap_commit(pcm, ofs, frames);
-			assert(err == (snd_pcm_sframes_t) frames);
-			if (err < 0)
+			if ((err = snd_pcm_mmap_commit(pcm, ofs, frames)) <= 0)
 				break;
-			size -= frames;
-			str->alsa.appl_ptr += frames;
+			size -= err;
+			str->alsa.appl_ptr += err;
 			str->alsa.appl_ptr %= str->alsa.boundary;
 		}
 		break;
@@ -762,17 +687,16 @@
 	{
 		int k;
 		DEBUG("SNDCTL_DSP_RESET)\n");
+		if (!dsp->hwset)
+			return -1;
 		result = 0;
 		for (k = 0; k < 2; ++k) {
 			str = &dsp->streams[k];
-			pcm = str->pcm;
-			if (!pcm)
+			if (!(pcm = str->pcm))
 				continue;
-			err = snd_pcm_drop(pcm);
-			if (err >= 0)
-				err = snd_pcm_prepare(pcm);
-			if (err < 0)
-				result = err;
+			if ((err = snd_pcm_drop(pcm)) >= 0)
+				if ((err = snd_pcm_prepare(pcm)) < 0)
+					result = err;
 			str->oss.bytes = 0;
 			str->oss.hw_bytes = 0;
 			str->alsa.appl_ptr = 0;
@@ -788,11 +712,9 @@
 		result = 0;
 		for (k = 0; k < 2; ++k) {
 			str = &dsp->streams[k];
-			pcm = str->pcm;
-			if (!pcm)
+			if (!(pcm = str->pcm))
 				continue;
-			err = snd_pcm_drain(pcm);
-			if (err >= 0)
+			if ((err = snd_pcm_drain(pcm)) >= 0)
 				err = snd_pcm_prepare(pcm);
 			if (err < 0)
 				result = err;
@@ -820,8 +742,7 @@
 		break;
 	case SNDCTL_DSP_CHANNELS:
 		dsp->channels = (*(int *)arg);
-		err = oss_dsp_params(dsp);
-		if (err < 0)
+		if ((err = oss_dsp_params(dsp)) < 0)
 			break;
 		DEBUG("SNDCTL_DSP_CHANNELS, %p[%d]) -> [%d]\n", arg, *(int *)arg, dsp->channels);
 		*(int *)arg = dsp->channels;
@@ -897,8 +818,7 @@
 			if (snd_pcm_state(pcm) == SND_PCM_STATE_RUNNING)
 				s |= PCM_ENABLE_OUTPUT;
 		}
-		pcm = dsp->streams[SND_PCM_STREAM_CAPTURE].pcm;
-		if (pcm) {
+		if ((pcm = dsp->streams[SND_PCM_STREAM_CAPTURE].pcm)) {
 			if (snd_pcm_state(pcm) == SND_PCM_STATE_RUNNING)
 				s |= PCM_ENABLE_INPUT;
 		}
@@ -911,41 +831,33 @@
 		DEBUG("SNDCTL_DSP_SETTRIGGER, %p[%d])\n", arg, *(int*)arg);
 		result = *(int*) arg;
 		str = &dsp->streams[SND_PCM_STREAM_CAPTURE];
-		pcm = str->pcm;
-		if (pcm) {
+		if ((pcm = str->pcm)) {
 			if (result & PCM_ENABLE_INPUT) {
 				if (str->stopped) {
 					str->stopped = 0;
-					err = oss_dsp_sw_params(dsp);
-					if (err < 0)
+					if ((err = oss_dsp_sw_params(dsp)) < 0)
 						break;
-					err = snd_pcm_start(pcm);
-					if (err < 0)
+					if ((err = snd_pcm_start(pcm)) < 0)
 						break;
 				}
 			} else {
 				if (!str->stopped) {
 					str->stopped = 1;
-					err = snd_pcm_drop(pcm);
-					if (err < 0)
+					if ((err = snd_pcm_drop(pcm)) < 0)
 						break;
-					err = oss_dsp_sw_params(dsp);
-					if (err < 0)
+					if ((err = oss_dsp_sw_params(dsp)) < 0)
 						break;
-					err = snd_pcm_prepare(pcm);
-					if (err < 0)
+					if ((err = snd_pcm_prepare(pcm)) < 0)
 						break;
 				}
 			}
 		}
 		str = &dsp->streams[SND_PCM_STREAM_PLAYBACK];
-		pcm = str->pcm;
-		if (pcm) {
+		if ((pcm = str->pcm)) {
 			if (result & PCM_ENABLE_OUTPUT) {
 				if (str->stopped) {
 					str->stopped = 0;
-					err = oss_dsp_sw_params(dsp);
-					if (err < 0)
+					if ((err = oss_dsp_sw_params(dsp)) < 0)
 						break;
 					if (str->mmap_buffer) {
 						const snd_pcm_channel_area_t *areas;
@@ -956,27 +868,22 @@
 						snd_pcm_areas_copy(areas, 0, str->mmap_areas, 0,
 								   dsp->channels, size,
 								   dsp->format);
-						cres = snd_pcm_mmap_commit(pcm, offset, size);
-						if (cres > 0) {
+						if ((cres = snd_pcm_mmap_commit(pcm, offset, size)) > 0) {
 							str->alsa.appl_ptr += cres;
 							str->alsa.appl_ptr %= str->alsa.boundary;
 						}
 					}
-					err = snd_pcm_start(pcm);
-					if (err < 0)
+					if ((err = snd_pcm_start(pcm)) < 0)
 						break;
 				}
 			} else {
 				if (!str->stopped) {
 					str->stopped = 1;
-					err = snd_pcm_drop(pcm);
-					if (err < 0)
+					if ((err = snd_pcm_drop(pcm)) < 0)
 						break;
-					err = oss_dsp_sw_params(dsp);
-					if (err < 0)
+					if ((err = oss_dsp_sw_params(dsp)) < 0)
 						break;
-					err = snd_pcm_prepare(pcm);
-					if (err < 0)
+					if ((err = snd_pcm_prepare(pcm)) < 0)
 						break;
 				}
 			}
@@ -986,22 +893,18 @@
 	case SNDCTL_DSP_GETISPACE:
 	{
 		snd_pcm_sframes_t avail, delay;
-		snd_pcm_state_t state;
 		audio_buf_info *info = arg;
 		str = &dsp->streams[SND_PCM_STREAM_CAPTURE];
-		pcm = str->pcm;
-		if (!pcm) {
+		if (!(pcm = str->pcm)) {
 			err = -EINVAL;
 			break;
 		}
-		state = snd_pcm_state(pcm);
-		if (state == SND_PCM_STATE_RUNNING) {
+		if (snd_pcm_state(pcm) == SND_PCM_STATE_RUNNING) {
 			snd_pcm_delay(pcm, &delay);
 			if (str->mmap_buffer)
 				oss_dsp_mmap_update(dsp, SND_PCM_STREAM_CAPTURE, delay);
 		}
-		avail = snd_pcm_avail_update(pcm);
-		if (avail < 0)
+		if ((avail = snd_pcm_avail_update(pcm)) < 0)
 			avail = 0;
 		if ((snd_pcm_uframes_t)avail > str->oss.buffer_size)
 			avail = str->oss.buffer_size;
@@ -1022,8 +925,7 @@
 		snd_pcm_state_t state;
 		audio_buf_info *info = arg;
 		str = &dsp->streams[SND_PCM_STREAM_PLAYBACK];
-		pcm = str->pcm;
-		if (!pcm) {
+		if (!(pcm = str->pcm)) {
 			err = -EINVAL;
 			break;
 		}
@@ -1034,8 +936,8 @@
 			if (str->mmap_buffer)
 				oss_dsp_mmap_update(dsp, SND_PCM_STREAM_PLAYBACK, delay);
 		}
-		avail = snd_pcm_avail_update(pcm);
-		if (avail < 0 || (snd_pcm_uframes_t)avail > str->oss.buffer_size)
+		if ((avail = snd_pcm_avail_update(pcm)) < 0 ||
+		    (snd_pcm_uframes_t)avail > str->oss.buffer_size)
 			avail = str->oss.buffer_size;
 		info->fragsize = str->oss.period_size * str->frame_bytes;
 		info->fragstotal = str->oss.periods;
@@ -1052,16 +954,13 @@
 	{
 		snd_pcm_sframes_t delay = 0, avail, diff;
 		snd_pcm_uframes_t hw_ptr;
-		snd_pcm_state_t state;
 		count_info *info = arg;
 		str = &dsp->streams[SND_PCM_STREAM_CAPTURE];
-		pcm = str->pcm;
-		if (!pcm) {
+		if (!(pcm = str->pcm)) {
 			err = -EINVAL;
 			break;
 		}
-		state = snd_pcm_state(pcm);
-		if (state == SND_PCM_STATE_RUNNING) {
+		if (snd_pcm_state(pcm) == SND_PCM_STATE_RUNNING) {
 			snd_pcm_delay(pcm, &delay);
 			if (str->mmap_buffer)
 				oss_dsp_mmap_update(dsp, SND_PCM_STREAM_CAPTURE, delay);
@@ -1097,8 +996,7 @@
 		snd_pcm_state_t state;
 		count_info *info = arg;
 		str = &dsp->streams[SND_PCM_STREAM_PLAYBACK];
-		pcm = str->pcm;
-		if (!pcm) {
+		if (!(pcm = str->pcm)) {
 			err = -EINVAL;
 			break;
 		}
@@ -1138,8 +1036,7 @@
 		snd_pcm_sframes_t delay = 0;
 		snd_pcm_state_t state;
 		str = &dsp->streams[SND_PCM_STREAM_PLAYBACK];
-		pcm = str->pcm;
-		if (!pcm) {
+		if (!(pcm = str->pcm)) {
 			err = -EINVAL;
 			break;
 		}
@@ -1222,8 +1119,7 @@
 		int err;
 		if (!pcm)
 			continue;
-		err = snd_pcm_nonblock(pcm, nonblock);
-		if (err < 0) {
+		if ((err = snd_pcm_nonblock(pcm, nonblock)) < 0) {
 			errno = -err;
 			return -1;
 		}
@@ -1264,9 +1160,13 @@
 		result = MAP_FAILED;
 		goto _end;
 	}
-	assert(!str->mmap_buffer);
-	result = malloc(len);
-	if (!result) {
+//	assert(!str->mmap_buffer);
+	if (str->mmap_buffer) {
+	    free(str->mmap_buffer);
+	    str->mmap_buffer = NULL;
+	    str->mmap_bytes = 0;
+	}
+	if (!(result = malloc(len))) {
 		result = MAP_FAILED;
 		goto _end;
 	}
@@ -1274,8 +1174,7 @@
 	str->mmap_bytes = len;
 	str->alsa.mmap_period_bytes = str->oss.period_size * str->frame_bytes;
 	str->alsa.mmap_buffer_bytes = str->oss.buffer_size * str->frame_bytes;
-	err = oss_dsp_params(dsp);
-	if (err < 0) {
+	if ((err = oss_dsp_params(dsp)) < 0) {
 		free(result);
 		errno = -err;
 		result = MAP_FAILED;
@@ -1304,8 +1203,7 @@
 	free(str->mmap_buffer);
 	str->mmap_buffer = 0;
 	str->mmap_bytes = 0;
-	err = oss_dsp_params(dsp);
-	if (err < 0) {
+	if ((err = oss_dsp_params(dsp)) < 0) {
 		errno = -err;
 		return -1;
 	}
@@ -1330,16 +1228,14 @@
 			continue;
 		if ((fmode & O_ACCMODE) == O_WRONLY && snd_pcm_stream(pcm) == SND_PCM_STREAM_CAPTURE)
 			continue;
-		count = snd_pcm_poll_descriptors_count(pcm);
-		if (count < 0) {
+		if ((count = snd_pcm_poll_descriptors_count(pcm)) < 0) {
 			errno = -count;
 			return -1;
 		}
 		{
 			struct pollfd ufds[count];
 			int j;
-			err = snd_pcm_poll_descriptors(pcm, ufds, count);
-			if (err < 0) {
+			if ((err = snd_pcm_poll_descriptors(pcm, ufds, count)) < 0) {
 				errno = -err;
 				return -1;
 			}
@@ -1383,8 +1279,7 @@
 		int err, count;
 		if (!pcm)
 			continue;
-		count = snd_pcm_poll_descriptors_count(pcm);
-		if (count < 0) {
+		if ((count = snd_pcm_poll_descriptors_count(pcm)) < 0) {
 			errno = -count;
 			return -1;
 		}
@@ -1392,8 +1287,7 @@
 			struct pollfd ufds[count];
 			int j;
 			unsigned short revents;
-			err = snd_pcm_poll_descriptors(pcm, ufds, count);
-			if (err < 0) {
+			if ((err = snd_pcm_poll_descriptors(pcm, ufds, count)) < 0) {
 				errno = -err;
 				return -1;
 			}
@@ -1408,8 +1302,7 @@
 					revents |= POLLERR;
 				ufds[j].revents = revents;
 			}
-			err = snd_pcm_poll_descriptors_revents(pcm, ufds, count, &revents);
-			if (err < 0) {
+			if ((err = snd_pcm_poll_descriptors_revents(pcm, ufds, count, &revents)) < 0) {
 				errno = -err;
 				return -1;
 			}
@@ -1438,8 +1331,7 @@
 		int err;
 		if (!pcm)
 			continue;
-		err = snd_pcm_poll_descriptors_count(pcm);
-		if (err < 0) {
+		if ((err = snd_pcm_poll_descriptors_count(pcm)) < 0) {
 			errno = -err;
 			return -1;
 		}
@@ -1466,13 +1358,11 @@
 			continue;
 		if ((fmode & O_ACCMODE) == O_WRONLY && snd_pcm_stream(pcm) == SND_PCM_STREAM_CAPTURE)
 			continue;
-		count = snd_pcm_poll_descriptors_count(pcm);
-		if (count < 0) {
+		if ((count = snd_pcm_poll_descriptors_count(pcm)) < 0) {
 			errno = -count;
 			return -1;
 		}
-		err = snd_pcm_poll_descriptors(pcm, ufds, count);
-		if (err < 0) {
+		if ((err = snd_pcm_poll_descriptors(pcm, ufds, count)) < 0) {
 			errno = -err;
 			return -1;
 		}
@@ -1497,13 +1387,11 @@
 		unsigned short revents;
 		if (!pcm)
 			continue;
-		count = snd_pcm_poll_descriptors_count(pcm);
-		if (count < 0) {
+		if ((count = snd_pcm_poll_descriptors_count(pcm)) < 0) {
 			errno = -count;
 			return -1;
 		}
-		err = snd_pcm_poll_descriptors_revents(pcm, ufds, count, &revents);
-		if (err < 0) {
+		if ((err = snd_pcm_poll_descriptors_revents(pcm, ufds, count, &revents)) < 0) {
 			errno = -err;
 			return -1;
 		}
@@ -1539,26 +1427,17 @@
 	va_start(args, oflag);
 	mode = va_arg(args, mode_t);
 	va_end(args);
-	result = stat(file, &s);
-	if (result < 0) {
-		if (!strncmp(file, "/dev/dsp", 8))
-			minor = (atoi(file + 8) << 4) | OSS_DEVICE_DSP;
-		else if (!strncmp(file, "/dev/dspW", 9))
-			minor = (atoi(file + 9) << 4) | OSS_DEVICE_DSPW;
-		else if (!strncmp(file, "/dev/adsp", 9))
-			minor = (atoi(file + 9) << 4) | OSS_DEVICE_ADSP;
-		else if (!strncmp(file, "/dev/audio", 10))
-			minor = (atoi(file + 10) << 4) | OSS_DEVICE_AUDIO;
-		else {
-			errno = ENOENT;
-			return -1;
-		}
-	} else {
-		if (!S_ISCHR(s.st_mode) || ((s.st_rdev >> 8) & 0xff) != OSS_MAJOR) {
-			errno = ENOENT;
-			return -1;
-		}
-		minor = s.st_rdev & 0xff;
+	if (!strncmp(file, "/dev/dsp", 8))
+		minor = (atoi(file + 8) << 4) | OSS_DEVICE_DSP;
+	else if (!strncmp(file, "/dev/dspW", 9))
+		minor = (atoi(file + 9) << 4) | OSS_DEVICE_DSPW;
+	else if (!strncmp(file, "/dev/adsp", 9))
+		minor = (atoi(file + 9) << 4) | OSS_DEVICE_ADSP;
+	else if (!strncmp(file, "/dev/audio", 10))
+		minor = (atoi(file + 10) << 4) | OSS_DEVICE_AUDIO;
+	else {
+		errno = ENOENT;
+		return -1;
 	}
 	if (! alsa_oss_debug)
 		snd_lib_error_set_handler(error_handler);

--YZ5djTAD1cGYuMQK--


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
