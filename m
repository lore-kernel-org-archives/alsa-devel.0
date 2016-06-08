From: han.lu@intel.com
Subject: [PATCH 1/4] alsabat: align the data type on float
Date: Thu,  9 Jun 2016 03:42:46 +0800
Message-ID: <edee37171304643a01ed79a52e518ef18de60a7c.1465404865.git.han.lu@intel.com>
References: <cover.1465404865.git.han.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id E748026577A
 for <alsa-devel@alsa-project.org>; Wed,  8 Jun 2016 13:46:38 +0200 (CEST)
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

Aligning the data type of fftw analyzer, sample converter and other
components on float, because:
  1. avoid unnecessary data type conversion;
  2. using float is more efficient than using double;
  3. the extra double accuracy is not required.

Signed-off-by: Lu, Han <han.lu@intel.com>

diff --git a/bat/analyze.c b/bat/analyze.c
index 58781d6..bdb1f83 100644
--- a/bat/analyze.c
+++ b/bat/analyze.c
@@ -26,10 +26,11 @@
 #include "gettext.h"
 
 #include "common.h"
+#include "bat-signal.h"
 
-static void check_amplitude(struct bat *bat, double *buf)
+static void check_amplitude(struct bat *bat, float *buf)
 {
-	double sum, average, amplitude;
+	float sum, average, amplitude;
 	int i, percent;
 
 	/* calculate average value */
@@ -39,7 +40,7 @@ static void check_amplitude(struct bat *bat, double *buf)
 
 	/* calculate peak-to-average amplitude */
 	for (i = 0, sum = 0.0; i < bat->frames; i++)
-		sum += abs(buf[i] - average);
+		sum += fabsf(buf[i] - average);
 	amplitude = sum / bat->frames * M_PI / 2.0;
 
 	/* calculate amplitude percentage against full range */
@@ -71,9 +72,9 @@ int check_peak(struct bat *bat, struct analyze *a, int end, int peak, float hz,
 	float tolerance = (delta_rate > delta_HZ) ? delta_rate : delta_HZ;
 
 	fprintf(bat->log, _("Detected peak at %2.2f Hz of %2.2f dB\n"), hz_peak,
-			10.0 * log10(a->mag[peak] / mean));
+			10.0 * log10f(a->mag[peak] / mean));
 	fprintf(bat->log, _(" Total %3.1f dB from %2.2f to %2.2f Hz\n"),
-			10.0 * log10(p / mean), start * hz, end * hz);
+			10.0 * log10f(p / mean), start * hz, end * hz);
 
 	if (hz_peak < DC_THRESHOLD) {
 		fprintf(bat->err, _(" WARNING: Found low peak %2.2f Hz,"),
@@ -161,7 +162,7 @@ static int check(struct bat *bat, struct analyze *a, int channel)
 
 static void calc_magnitude(struct bat *bat, struct analyze *a, int N)
 {
-	double r2, i2;
+	float r2, i2;
 	int i;
 
 	for (i = 1; i < N / 2; i++) {
@@ -176,36 +177,36 @@ static void calc_magnitude(struct bat *bat, struct analyze *a, int N)
 static int find_and_check_harmonics(struct bat *bat, struct analyze *a,
 		int channel)
 {
-	fftw_plan p;
+	fftwf_plan p;
 	int err = -ENOMEM, N = bat->frames;
 
 	/* Allocate FFT buffers */
-	a->in = (double *) fftw_malloc(sizeof(double) * bat->frames);
+	a->in = (float *) fftwf_malloc(sizeof(float) * bat->frames);
 	if (a->in == NULL)
 		goto out1;
 
-	a->out = (double *) fftw_malloc(sizeof(double) * bat->frames);
+	a->out = (float *) fftwf_malloc(sizeof(float) * bat->frames);
 	if (a->out == NULL)
 		goto out2;
 
-	a->mag = (double *) fftw_malloc(sizeof(double) * bat->frames);
+	a->mag = (float *) fftwf_malloc(sizeof(float) * bat->frames);
 	if (a->mag == NULL)
 		goto out3;
 
 	/* create FFT plan */
-	p = fftw_plan_r2r_1d(N, a->in, a->out, FFTW_R2HC,
+	p = fftwf_plan_r2r_1d(N, a->in, a->out, FFTW_R2HC,
 			FFTW_MEASURE | FFTW_PRESERVE_INPUT);
 	if (p == NULL)
 		goto out4;
 
-	/* convert source PCM to doubles */
-	bat->convert_sample_to_double(a->buf, a->in, bat->frames);
+	/* convert source PCM to floats */
+	bat->convert_sample_to_float(a->buf, a->in, bat->frames);
 
 	/* check amplitude */
 	check_amplitude(bat, a->in);
 
 	/* run FFT */
-	fftw_execute(p);
+	fftwf_execute(p);
 
 	/* FFT out is real and imaginary numbers - calc magnitude for each */
 	calc_magnitude(bat, a, N);
@@ -213,14 +214,14 @@ static int find_and_check_harmonics(struct bat *bat, struct analyze *a,
 	/* check data */
 	err = check(bat, a, channel);
 
-	fftw_destroy_plan(p);
+	fftwf_destroy_plan(p);
 
 out4:
-	fftw_free(a->mag);
+	fftwf_free(a->mag);
 out3:
-	fftw_free(a->out);
+	fftwf_free(a->out);
 out2:
-	fftw_free(a->in);
+	fftwf_free(a->in);
 out1:
 	return err;
 }
diff --git a/bat/bat.c b/bat/bat.c
index cd4ea2d..d534d48 100644
--- a/bat/bat.c
+++ b/bat/bat.c
@@ -37,7 +37,7 @@
 #include "alsa.h"
 #endif
 #include "convert.h"
-#ifdef HAVE_LIBFFTW3
+#ifdef HAVE_LIBFFTW3F
 #include "analyze.h"
 #endif
 
@@ -67,7 +67,7 @@ static int get_duration(struct bat *bat)
 
 	if (bat->frames <= 0 || bat->frames > MAX_FRAMES) {
 		fprintf(bat->err, _("Invalid duration. Range: (0, %d(%fs))\n"),
-				MAX_FRAMES, (double)MAX_FRAMES / bat->rate);
+				MAX_FRAMES, (float)MAX_FRAMES / bat->rate);
 		return -EINVAL;
 	}
 
@@ -317,7 +317,7 @@ static void set_defaults(struct bat *bat)
 	bat->sample_size = 2;
 	bat->format = BAT_PCM_FORMAT_S16_LE;
 	bat->convert_float_to_sample = convert_float_to_int16;
-	bat->convert_sample_to_double = convert_int16_to_double;
+	bat->convert_sample_to_float = convert_int16_to_float;
 	bat->frames = bat->rate * 2;
 	bat->target_freq[0] = 997.0;
 	bat->target_freq[1] = 997.0;
@@ -569,19 +569,19 @@ static int bat_init(struct bat *bat)
 	switch (bat->sample_size) {
 	case 1:
 		bat->convert_float_to_sample = convert_float_to_uint8;
-		bat->convert_sample_to_double = convert_uint8_to_double;
+		bat->convert_sample_to_float = convert_uint8_to_float;
 		break;
 	case 2:
 		bat->convert_float_to_sample = convert_float_to_int16;
-		bat->convert_sample_to_double = convert_int16_to_double;
+		bat->convert_sample_to_float = convert_int16_to_float;
 		break;
 	case 3:
 		bat->convert_float_to_sample = convert_float_to_int24;
-		bat->convert_sample_to_double = convert_int24_to_double;
+		bat->convert_sample_to_float = convert_int24_to_float;
 		break;
 	case 4:
 		bat->convert_float_to_sample = convert_float_to_int32;
-		bat->convert_sample_to_double = convert_int32_to_double;
+		bat->convert_sample_to_float = convert_int32_to_float;
 		break;
 	default:
 		fprintf(bat->err, _("Invalid PCM format: size=%d\n"),
@@ -633,7 +633,7 @@ int main(int argc, char *argv[])
 		test_loopback(&bat);
 
 analyze:
-#ifdef HAVE_LIBFFTW3
+#ifdef HAVE_LIBFFTW3F
 	if (!bat.standalone)
 		err = analyze_capture(&bat);
 #else
diff --git a/bat/common.h b/bat/common.h
index ad02a5a..ad91270 100644
--- a/bat/common.h
+++ b/bat/common.h
@@ -182,7 +182,7 @@ struct bat {
 	FILE *log;
 	FILE *err;
 
-	void (*convert_sample_to_double)(void *, double *, int);
+	void (*convert_sample_to_float)(void *, float *, int);
 	void (*convert_float_to_sample)(float *, void *, int, int);
 
 	void *buf;			/* PCM Buffer */
@@ -192,9 +192,9 @@ struct bat {
 
 struct analyze {
 	void *buf;
-	double *in;
-	double *out;
-	double *mag;
+	float *in;
+	float *out;
+	float *mag;
 };
 
 void prepare_wav_info(struct wav_container *, struct bat *);
diff --git a/bat/convert.c b/bat/convert.c
index dcbe912..f555389 100644
--- a/bat/convert.c
+++ b/bat/convert.c
@@ -18,7 +18,7 @@
 #include <stdlib.h>
 #include <stdint.h>
 
-void convert_uint8_to_double(void *buf, double *val, int samples)
+void convert_uint8_to_float(void *buf, float *val, int samples)
 {
 	int i;
 
@@ -26,7 +26,7 @@ void convert_uint8_to_double(void *buf, double *val, int samples)
 		val[i] = ((uint8_t *) buf)[i];
 }
 
-void convert_int16_to_double(void *buf, double *val, int samples)
+void convert_int16_to_float(void *buf, float *val, int samples)
 {
 	int i;
 
@@ -34,7 +34,7 @@ void convert_int16_to_double(void *buf, double *val, int samples)
 		val[i] = ((int16_t *) buf)[i];
 }
 
-void convert_int24_to_double(void *buf, double *val, int samples)
+void convert_int24_to_float(void *buf, float *val, int samples)
 {
 	int i;
 	int32_t tmp;
@@ -48,7 +48,7 @@ void convert_int24_to_double(void *buf, double *val, int samples)
 	}
 }
 
-void convert_int32_to_double(void *buf, double *val, int samples)
+void convert_int32_to_float(void *buf, float *val, int samples)
 {
 	int i;
 
diff --git a/bat/convert.h b/bat/convert.h
index 28828ba..699c07a 100644
--- a/bat/convert.h
+++ b/bat/convert.h
@@ -13,10 +13,10 @@
  *
  */
 
-void convert_uint8_to_double(void *, double *, int);
-void convert_int16_to_double(void *, double *, int);
-void convert_int24_to_double(void *, double *, int);
-void convert_int32_to_double(void *, double *, int);
+void convert_uint8_to_float(void *, float *, int);
+void convert_int16_to_float(void *, float *, int);
+void convert_int24_to_float(void *, float *, int);
+void convert_int32_to_float(void *, float *, int);
 void convert_float_to_uint8(float *, void *, int, int);
 void convert_float_to_int16(float *, void *, int, int);
 void convert_float_to_int24(float *, void *, int, int);
diff --git a/bat/signal.c b/bat/signal.c
index 61d2824..15bea0a 100644
--- a/bat/signal.c
+++ b/bat/signal.c
@@ -75,7 +75,7 @@ float sin_generator_next_sample(struct sin_generator *sg)
 	sg->state_real = sr * pr - si * pi;
 	sg->state_imag = sr * pi + pr * si;
 	/* return the input value so sine wave starts at exactly 0.0 */
-	return sr;
+	return (float)sr;
 }
 
 /* fills a vector with a sine wave */
diff --git a/configure.ac b/configure.ac
index eabbb22..05c3be1 100644
--- a/configure.ac
+++ b/configure.ac
@@ -91,7 +91,7 @@ if test x$bat = xtrue; then
   FFTW_CFLAGS=""
   dnl Check for libfftw3
   have_libfftw3="yes"
-  AC_CHECK_LIB([fftw3], [fftw_malloc], , [have_libfftw3="no"])
+  AC_CHECK_LIB([fftw3f], [fftwf_malloc], , [have_libfftw3="no"])
   dnl Check for libtinyalsa
   have_libtinyalsa=
   if test x$alsabat_backend_tiny = xtrue; then
-- 
2.5.0
