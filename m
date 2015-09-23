From: han.lu@intel.com
Subject: [PATCH V2 4/7] BAT: Add signal generator
Date: Wed, 23 Sep 2015 15:48:52 +0800
Message-ID: <a42aa5e4102a653d655275077971f94058b85e12.1442993440.git.han.lu@intel.com>
References: <cover.1442993440.git.han.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 126172604F8
 for <alsa-devel@alsa-project.org>; Wed, 23 Sep 2015 09:51:18 +0200 (CEST)
In-Reply-To: <cover.1442993440.git.han.lu@intel.com>
In-Reply-To: <cover.1442993440.git.han.lu@intel.com>
References: <cover.1442993440.git.han.lu@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, liam.r.girdwood@intel.com, bernard.gautier@intel.com, caleb@crome.org, alsa-devel@alsa-project.org
Cc: "Lu, Han" <han.lu@intel.com>
List-Id: alsa-devel@alsa-project.org

From: "Lu, Han" <han.lu@intel.com>

Add function that generates sine waveform through math lib.
The waveform can be used as source for playback or analysis.

Signed-off-by: Lu, Han <han.lu@intel.com>
Signed-off-by: Liam Girdwood <liam.r.girdwood@intel.com>
Signed-off-by: Bernard Gautier <bernard.gautier@intel.com>
Signed-off-by: Caleb Crome <caleb@crome.org>

diff --git a/bat/signal.c b/bat/signal.c
new file mode 100644
index 0000000..595f76b
--- /dev/null
+++ b/bat/signal.c
@@ -0,0 +1,182 @@
+/*
+ * Copyright (C) 2015 Caleb Crome
+ * Copyright (C) 2013-2015 Intel Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+/*
+ * This is a general purpose sine wave generator that will stay stable
+ * for a long time, and with a little renormalization, could stay stay
+ * stable indefinitely
+ */
+
+#include <stdio.h>
+#include <stddef.h>
+#include <stdlib.h>
+#include <math.h>
+#include <stdint.h>
+#include <stdbool.h>
+
+#include "gettext.h"
+#include "common.h"
+#include "signal.h"
+
+/*
+ * Initialize the sine wave generator.
+ * sin_generator:  gets initialized by this call.
+ * frequency:      the frequency for the sine wave.  must be < 0.5*sample_rate
+ * sample_rate:    the sample rate...
+ * returns 0 on success, -1 on error.
+ */
+int sin_generator_init(struct sin_generator *sg, float magnitude,
+		float frequency, float sample_rate)
+{
+	/* angular frequency:  cycles/sec / (samp/sec) * rad/cycle = rad/samp */
+	float w = frequency / sample_rate * 2 * M_PI;
+	if (frequency >= sample_rate / 2)
+		return -1;
+	sg->phasor_real = cos(w);
+	sg->phasor_imag = sin(w);
+	sg->magnitude   = magnitude;
+	sg->state_real  = 0.0;
+	sg->state_imag  = magnitude;
+	sg->frequency = frequency;
+	sg->sample_rate = sample_rate;
+	return 0;
+}
+
+/*
+ * Generates the next sample in the sine wave.
+ * should be much faster than calling a sin function
+ * if it's inlined and optimized.
+ *
+ * returns the next value.  no possibility of error.
+ */
+float sin_generator_next_sample(struct sin_generator *sg)
+{
+	/* get shorthand to pointers */
+	const double pr = sg->phasor_real;
+	const double pi = sg->phasor_imag;
+	const double sr = sg->state_real;
+	const double si = sg->state_imag;
+	/* step the phasor -- complex multiply */
+	sg->state_real = sr * pr - si * pi;
+	sg->state_imag = sr * pi + pr * si;
+	/* return the input value so sine wave starts at exactly 0.0 */
+	return sr;
+}
+
+/* fills a vector with a sine wave */
+void sin_generator_vfill(struct sin_generator *sg, float *buf, int n)
+{
+	int i;
+	for (i = 0; i < n; i++)
+		*buf++ = sin_generator_next_sample(sg);
+}
+
+static int reorder(struct bat *bat, float *val, int frames)
+{
+	float *new_buf = NULL;
+	int i, c, bytes;
+
+	bytes = frames * bat->channels * sizeof(float);
+
+	new_buf = (float *) malloc(bytes);
+	if (new_buf == NULL) {
+		fprintf(bat->err, _("Not enough memory.\n"));
+		return -ENOMEM;
+	}
+
+	memcpy(new_buf, val, bytes);
+	for (i = 0; i < frames; i++)
+		for (c = 0; c < bat->channels; c++)
+			val[i * bat->channels + c] =
+				new_buf[c * frames + i];
+	free(new_buf);
+
+	return 0;
+}
+
+static int adjust_waveform(struct bat *bat, float *val, int frames)
+{
+	int i, nsamples, max;
+	float factor, offset = 0.0;
+
+	switch (bat->format) {
+	case SND_PCM_FORMAT_U8:
+		max = INT8_MAX;
+		offset = max;	/* shift for unsigned format */
+		break;
+	case SND_PCM_FORMAT_S16_LE:
+		max  = INT16_MAX;
+		break;
+	case SND_PCM_FORMAT_S24_3LE:
+		max = (1 << 23) - 1;
+		break;
+	case SND_PCM_FORMAT_S32_LE:
+		max = INT32_MAX;
+		break;
+	default:
+		fprintf(bat->err, _("Invalid PCM format: %s\n"),
+				snd_pcm_format_name(bat->format));
+		return -EINVAL;
+	}
+
+	factor = max * RANGE_FACTOR;
+	nsamples = bat->channels * frames;
+
+	for (i = 0; i < nsamples; i++)
+		val[i] = val[i] * factor + offset;
+
+	return 0;
+}
+
+int generate_sine_wave(struct bat *bat, int frames, void *buf)
+{
+	int err = 0;
+	int c, nsamples;
+	float *sinus_f = NULL;
+	static struct sin_generator sg[MAX_CHANNELS];
+
+	nsamples = bat->channels * frames;
+	sinus_f = (float *) malloc(nsamples * sizeof(float));
+	if (sinus_f == NULL) {
+		fprintf(bat->err, _("Not enough memory.\n"));
+		return -ENOMEM;
+	}
+
+	for (c = 0; c < bat->channels; c++) {
+		/* initialize static struct at the first time */
+		if (sg[c].frequency != bat->target_freq[c])
+			sin_generator_init(&sg[c], 1.0, bat->target_freq[c],
+					bat->rate);
+		/* fill buffer for each channel */
+		sin_generator_vfill(&sg[c], sinus_f + c * frames, frames);
+	}
+
+	/* reorder samples to interleaved mode */
+	err = reorder(bat, sinus_f, frames);
+	if (err != 0)
+		return err;
+
+	/* adjust amplitude and offset of waveform */
+	err = adjust_waveform(bat, sinus_f, frames);
+	if (err != 0)
+		return err;
+
+	bat->convert_float_to_sample(sinus_f, buf, frames, bat->channels);
+
+	free(sinus_f);
+
+	return 0;
+}
diff --git a/bat/signal.h b/bat/signal.h
new file mode 100644
index 0000000..a295517
--- /dev/null
+++ b/bat/signal.h
@@ -0,0 +1,30 @@
+/*
+ * Copyright (C) 2015 Caleb Crome
+ * Copyright (C) 2013-2015 Intel Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+/*
+ * Here's a generic sine wave generator that will work indefinitely
+ * for any frequency.
+ *
+ * Note:  the state & phasor are stored as doubles (and updated as
+ * doubles) because after a million samples the magnitude drifts a
+ * bit.  If we really need floats, it can be done with periodic
+ * renormalization of the state_real+state_imag magnitudes.
+ */
+
+int sin_generator_init(struct sin_generator *, float, float, float);
+float sin_generator_next_sample(struct sin_generator *);
+void sin_generator_vfill(struct sin_generator *, float *, int);
+int generate_sine_wave(struct bat *, int, void *);
-- 
1.9.1
