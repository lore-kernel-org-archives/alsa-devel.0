From: han.lu@intel.com
Subject: [PATCH 4/4] alsabat: add noise detection
Date: Thu,  9 Jun 2016 03:42:49 +0800
Message-ID: <c87c020f6c22a1656664d897a45bd4d1cd838948.1465404865.git.han.lu@intel.com>
References: <cover.1465404865.git.han.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 6DB73265DE3
 for <alsa-devel@alsa-project.org>; Wed,  8 Jun 2016 13:46:40 +0200 (CEST)
In-Reply-To: <cover.1465404865.git.han.lu@intel.com>
In-Reply-To: <cover.1465404865.git.han.lu@intel.com>
References: <cover.1465404865.git.han.lu@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org
Cc: "Lu, Han" <han.lu@intel.com>
List-Id: alsa-devel@alsa-project.org

From: "Lu, Han" <han.lu@intel.com>

Alsabat reports error when noise above threshold be detected.
Use either of the options below to designate the threshold. (e.g.
if the ratio of noise to signal is 5%, the snr is about 26dB.)
    --snr-db <value in dB>
    --snr-pc <value in %>

The noise detection is performed in time domain. On each period
of the sine wave being analyzed, alsabat substracts a clean sine
wave from the source, calculates the RMS value of the residual,
and compares the result with the threshold. At last, alsabat
returns the number of periods with noise above threshold. 0 is
returned when the source is clean.

Signed-off-by: Lu, Han <han.lu@intel.com>

diff --git a/bat/alsabat-test.sh b/bat/alsabat-test.sh
index 2d31a77..7d024fb 100755
--- a/bat/alsabat-test.sh
+++ b/bat/alsabat-test.sh
@@ -81,6 +81,10 @@ feature_list_test () {
 	latestfile=`ls -t1 /tmp/bat.wav.* | head -n 1`
 	feature_test "--local -F $maxfreq --file $latestfile" \
 			"local mode: analyze local file"
+	feature_test "--snr-db 26" \
+			"noise detect threshold in SNR(dB)"
+	feature_test "--snr-pc 5" \
+			"noise detect threshold in noise percentage(%)"
 
 	print_result
 }
diff --git a/bat/alsabat.1 b/bat/alsabat.1
index 3f9b767..6f6da5c 100644
--- a/bat/alsabat.1
+++ b/bat/alsabat.1
@@ -132,6 +132,14 @@ just like in normal mode, but will not be analyzed.
 The ALSABAT being built without libfftw3 support is always in standalone mode.
 The ALSABAT in normal mode can also bypass data analysis using option
 "--standalone".
+.TP
+\fI\-\-snr\-db=#\fP
+Noise detection threshold in SNR (dB). 26dB indicates 5% noise in amplitude.
+ALSABAT will return error if signal SNR is smaller than the threshold.
+.TP
+\fI\-\-snr\-pc=#\fP
+Noise detection threshold in percentage of noise amplitude (%).
+ALSABAT will return error if the noise amplitude is larger than the threshold.
 
 .SH EXAMPLES
 
diff --git a/bat/analyze.c b/bat/analyze.c
index bdb1f83..17fff50 100644
--- a/bat/analyze.c
+++ b/bat/analyze.c
@@ -226,6 +226,169 @@ out1:
 	return err;
 }
 
+static int calculate_noise_one_period(struct bat *bat,
+		struct noise_analyzer *na, float *src,
+		int length, int channel)
+{
+	int i, shift = 0;
+	float tmp, rms, gain, residual;
+	float a = 0.0, b = 1.0;
+
+	/* step 1. phase compensation */
+
+	if (length < 2 * na->nsamples)
+		return -EINVAL;
+
+	/* search for the beginning of a sine period */
+	for (i = 0, tmp = 0.0, shift = -1; i < na->nsamples; i++) {
+		/* find i where src[i] >= 0 && src[i+1] < 0 */
+		if (src[i] < 0.0)
+			continue;
+		if (src[i + 1] < 0.0) {
+			tmp = src[i] - src[i + 1];
+			a = src[i] / tmp;
+			b = -src[i + 1] / tmp;
+			shift = i;
+			break;
+		}
+	}
+
+	/* didn't find the beginning of a sine period */
+	if (shift == -1)
+		return -EINVAL;
+
+	/* shift sine waveform to source[0] = 0.0 */
+	for (i = 0; i < na->nsamples; i++)
+		na->source[i] = a * src[i + shift + 1] + b * src[i + shift];
+
+	/* step 2. gain compensation */
+
+	/* calculate rms of signal amplitude */
+	for (i = 0, tmp = 0.0; i < na->nsamples; i++)
+		tmp += na->source[i] * na->source[i];
+	rms = sqrtf(tmp / na->nsamples);
+
+	gain = na->rms_tgt / rms;
+
+	for (i = 0; i < na->nsamples; i++)
+		na->source[i] *= gain;
+
+	/* step 3. calculate snr in dB */
+
+	for (i = 0, tmp = 0.0, residual = 0.0; i < na->nsamples; i++) {
+		tmp = fabsf(na->target[i] - na->source[i]);
+		residual += tmp * tmp;
+	}
+
+	tmp = na->rms_tgt / sqrtf(residual / na->nsamples);
+	na->snr_db = 20.0 * log10f(tmp);
+
+	return 0;
+}
+
+static int calculate_noise(struct bat *bat, float *src, int channel)
+{
+	int err = 0;
+	struct noise_analyzer na;
+	float freq = bat->target_freq[channel];
+	float tmp, sum_snr_pc, avg_snr_pc, avg_snr_db;
+	int offset, i, cnt_noise, cnt_clean;
+	/* num of samples in each sine period */
+	int nsamples = (int) ceilf(bat->rate / freq);
+	/* each section has 2 sine periods, the first one for locating
+	 * and the second one for noise calculating */
+	int nsamples_per_section = nsamples * 2;
+	/* all sine periods will be calculated except the first one */
+	int nsection = bat->frames / nsamples - 1;
+
+	fprintf(bat->log, _("samples per period: %d\n"), nsamples);
+	fprintf(bat->log, _("total sections to detect: %d\n"), nsection);
+	na.source = (float *)malloc(sizeof(float) * nsamples);
+	if (!na.source) {
+		err = -ENOMEM;
+		goto out1;
+	}
+
+	na.target = (float *)malloc(sizeof(float) * nsamples);
+	if (!na.target) {
+		err = -ENOMEM;
+		goto out2;
+	}
+
+	/* generate standard single-tone signal */
+	err = generate_sine_wave_raw_mono(bat, na.target, freq, nsamples);
+	if (err < 0)
+		goto out3;
+
+	na.nsamples = nsamples;
+
+	/* calculate rms of standard signal */
+	for (i = 0, tmp = 0.0; i < nsamples; i++)
+		tmp += na.target[i] * na.target[i];
+	na.rms_tgt = sqrtf(tmp / nsamples);
+
+	/* calculate average noise level */
+	sum_snr_pc = 0.0;
+	cnt_clean = cnt_noise = 0;
+	for (i = 0, offset = 0; i < nsection; i++) {
+		na.snr_db = SNR_DB_INVALID;
+
+		err = calculate_noise_one_period(bat, &na, src + offset,
+				nsamples_per_section, channel);
+		if (err < 0)
+			goto out3;
+
+		if (na.snr_db > bat->snr_thd_db) {
+			cnt_clean++;
+			sum_snr_pc += 100.0 / powf(10.0, na.snr_db / 20.0);
+		} else {
+			cnt_noise++;
+		}
+		offset += nsamples;
+	}
+
+	if (cnt_noise > 0) {
+		fprintf(bat->err, _("Noise detected at %d points.\n"),
+				cnt_noise);
+		err = -cnt_noise;
+		if (cnt_clean == 0)
+			goto out3;
+	} else {
+		fprintf(bat->log, _("No noise detected.\n"));
+	}
+
+	avg_snr_pc = sum_snr_pc / cnt_clean;
+	avg_snr_db = 20.0 * log10f(100.0 / avg_snr_pc);
+	fprintf(bat->log, _("Average SNR is %.2f dB (%.2f %%) at %d points.\n"),
+			avg_snr_db, avg_snr_pc, cnt_clean);
+
+out3:
+	free(na.target);
+out2:
+	free(na.source);
+out1:
+	return err;
+}
+
+static int find_and_check_noise(struct bat *bat, void *buf, int channel)
+{
+	int err = 0;
+	float *source;
+
+	source = (float *)malloc(sizeof(float) * bat->frames);
+	if (!source)
+		return -ENOMEM;
+
+	/* convert source PCM to floats */
+	bat->convert_sample_to_float(buf, source, bat->frames);
+
+	/* adjust waveform and calculate noise */
+	err = calculate_noise(bat, source, channel);
+
+	free(source);
+	return err;
+}
+
 /**
  * Convert interleaved samples from channels in samples from a single channel
  */
@@ -324,7 +487,21 @@ int analyze_capture(struct bat *bat)
 		a.buf = bat->buf +
 				c * bat->frames * bat->frame_size
 				/ bat->channels;
-		err = find_and_check_harmonics(bat, &a, c);
+		if (!bat->standalone) {
+			err = find_and_check_harmonics(bat, &a, c);
+			if (err != 0)
+				goto exit2;
+		}
+
+		if (snr_is_valid(bat->snr_thd_db)) {
+			fprintf(bat->log, _("\nChecking for SNR: "));
+			fprintf(bat->log, _("Threshold is %.2f dB (%.2f%%)\n"),
+					bat->snr_thd_db, 100.0
+					/ powf(10.0, bat->snr_thd_db / 20.0));
+			err = find_and_check_noise(bat, a.buf, c);
+			if (err != 0)
+				goto exit2;
+		}
 	}
 
 exit2:
diff --git a/bat/bat.c b/bat/bat.c
index d534d48..e650b01 100644
--- a/bat/bat.c
+++ b/bat/bat.c
@@ -24,6 +24,7 @@
 #include <math.h>
 #include <limits.h>
 #include <locale.h>
+#include <math.h>
 
 #include "aconfig.h"
 #include "gettext.h"
@@ -41,6 +42,38 @@
 #include "analyze.h"
 #endif
 
+/* get snr threshold in dB */
+static void get_snr_thd_db(struct bat *bat, char *thd)
+{
+	int err;
+	float thd_db;
+	char *ptrf;
+
+	thd_db = strtof(thd, &ptrf);
+	err = -errno;
+	if (!snr_is_valid(thd_db)) {
+		fprintf(bat->err, _("Invalid threshold '%s':%d\n"), thd, err);
+		exit(EXIT_FAILURE);
+	}
+	bat->snr_thd_db = thd_db;
+}
+
+/* get snr threshold in %, and convert to dB */
+static void get_snr_thd_pc(struct bat *bat, char *thd)
+{
+	int err;
+	float thd_pc;
+	char *ptrf;
+
+	thd_pc = strtof(thd, &ptrf);
+	err = -errno;
+	if (thd_pc <= 0.0 || thd_pc >= 100.0) {
+		fprintf(bat->err, _("Invalid threshold '%s':%d\n"), thd, err);
+		exit(EXIT_FAILURE);
+	}
+	bat->snr_thd_db = 20.0 * log10f(100.0 / thd_pc);
+}
+
 static int get_duration(struct bat *bat)
 {
 	int err;
@@ -299,6 +332,8 @@ _("Usage: alsabat [-options]...\n"
 "      --saveplay=#       file that storing playback content, for debug\n"
 "      --local            internal loop, set to bypass pcm hardware devices\n"
 "      --standalone       standalone mode, to bypass analysis\n"
+"      --snr-db=#         noise detect threshold, in SNR(dB)\n"
+"      --snr-pc=#         noise detect threshold, in noise percentage(%%)\n"
 ));
 	fprintf(bat->log, _("Recognized sample formats are: "));
 	fprintf(bat->log, _("U8 S16_LE S24_3LE S32_LE\n"));
@@ -322,6 +357,7 @@ static void set_defaults(struct bat *bat)
 	bat->target_freq[0] = 997.0;
 	bat->target_freq[1] = 997.0;
 	bat->sigma_k = 3.0;
+	bat->snr_thd_db = SNR_DB_INVALID;
 	bat->playback.device = NULL;
 	bat->capture.device = NULL;
 	bat->buf = NULL;
@@ -355,6 +391,8 @@ static void parse_arguments(struct bat *bat, int argc, char *argv[])
 		{"saveplay", 1, 0, OPT_SAVEPLAY},
 		{"local",    0, 0, OPT_LOCAL},
 		{"standalone", 0, 0, OPT_STANDALONE},
+		{"snr-db",   1, 0, OPT_SNRTHD_DB},
+		{"snr-pc",   1, 0, OPT_SNRTHD_PC},
 		{0, 0, 0, 0}
 	};
 
@@ -376,6 +414,12 @@ static void parse_arguments(struct bat *bat, int argc, char *argv[])
 		case OPT_STANDALONE:
 			bat->standalone = true;
 			break;
+		case OPT_SNRTHD_DB:
+			get_snr_thd_db(bat, optarg);
+			break;
+		case OPT_SNRTHD_PC:
+			get_snr_thd_pc(bat, optarg);
+			break;
 		case 'D':
 			if (bat->playback.device == NULL)
 				bat->playback.device = optarg;
@@ -634,7 +678,7 @@ int main(int argc, char *argv[])
 
 analyze:
 #ifdef HAVE_LIBFFTW3F
-	if (!bat.standalone)
+	if (!bat.standalone || snr_is_valid(bat.snr_thd_db))
 		err = analyze_capture(&bat);
 #else
 	fprintf(bat.log, _("No libfftw3 library. Exit without analysis.\n"));
diff --git a/bat/common.h b/bat/common.h
index ad91270..8214a03 100644
--- a/bat/common.h
+++ b/bat/common.h
@@ -22,6 +22,8 @@
 #define OPT_SAVEPLAY			(OPT_BASE + 3)
 #define OPT_LOCAL			(OPT_BASE + 4)
 #define OPT_STANDALONE			(OPT_BASE + 5)
+#define OPT_SNRTHD_DB			(OPT_BASE + 7)
+#define OPT_SNRTHD_PC			(OPT_BASE + 8)
 
 #define COMPOSE(a, b, c, d)		((a) | ((b)<<8) | ((c)<<16) | ((d)<<24))
 #define WAV_RIFF			COMPOSE('R', 'I', 'F', 'F')
@@ -75,6 +77,23 @@
 #define SHIFT_MAX			(sizeof(int) * 8 - 2)
 #define SHIFT_MIN			8
 
+/* Define SNR range in dB.
+ * if the noise is equal to signal, SNR = 0.0dB;
+ * if the noise is zero, SNR is limited by RIFF wav data width:
+ *     8 bit  -->  20.0 * log10f (powf(2.0, 8.0))  = 48.16 dB
+ *    16 bit  -->  20.0 * log10f (powf(2.0, 16.0)) = 96.33 dB
+ *    24 bit  -->  20.0 * log10f (powf(2.0, 24.0)) = 144.49 dB
+ *    32 bit  -->  20.0 * log10f (powf(2.0, 32.0)) = 192.66 dB
+ * so define the SNR range (0.0, 200.0) dB, value out of range is invalid. */
+#define SNR_DB_INVALID			-1.0
+#define SNR_DB_MIN			0.0
+#define SNR_DB_MAX			200.0
+
+inline bool snr_is_valid(float db)
+{
+	return (db > SNR_DB_MIN && db < SNR_DB_MAX);
+}
+
 struct wav_header {
 	unsigned int magic; /* 'RIFF' */
 	unsigned int length; /* file len */
@@ -151,6 +170,14 @@ struct sin_generator {
 	float magnitude;
 };
 
+struct noise_analyzer {
+	int nsamples;			/* number of sample */
+	float *source;			/* single-tone to be analyzed */
+	float *target;			/* target single-tone as standard */
+	float rms_tgt;			/* rms of target single-tone */
+	float snr_db;			/* snr in dB */
+};
+
 struct bat {
 	unsigned int rate;		/* sampling rate */
 	int channels;			/* nb of channels */
@@ -162,6 +189,7 @@ struct bat {
 	int period_size;		/* period size in frames */
 
 	float sigma_k;			/* threshold for peak detection */
+	float snr_thd_db;		/* threshold for noise detection (dB) */
 	float target_freq[MAX_CHANNELS];
 
 	int sinus_duration;		/* number of frames for playback */
-- 
2.5.0
