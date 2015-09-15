From: han.lu@intel.com
Subject: [PATCH BAT V1 4/7] BAT: Add signal generator
Date: Tue, 15 Sep 2015 15:00:20 +0800
Message-ID: <ef753ac115ad1e6359ec30254bebeea9f39c9e6a.1442298607.git.han.lu@intel.com>
References: <cover.1442298607.git.han.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id A536A2605EF
 for <alsa-devel@alsa-project.org>; Tue, 15 Sep 2015 09:01:46 +0200 (CEST)
In-Reply-To: <cover.1442298607.git.han.lu@intel.com>
In-Reply-To: <cover.1442298607.git.han.lu@intel.com>
References: <cover.1442298607.git.han.lu@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.com, liam.r.girdwood@intel.com, bernard.gautier@intel.com, alsa-devel@alsa-project.org
Cc: "Lu, Han" <han.lu@intel.com>
List-Id: alsa-devel@alsa-project.org

From: "Lu, Han" <han.lu@intel.com>

Add function that generates sine waveform through math lib.
The waveform can be used as source for playback or analysis.

Signed-off-by: Lu, Han <han.lu@intel.com>
Signed-off-by: Liam Girdwood <liam.r.girdwood@intel.com>
Signed-off-by: Bernard Gautier <bernard.gautier@intel.com>

diff --git a/bat/signal.c b/bat/signal.c
new file mode 100644
index 0000000..1efb81e
--- /dev/null
+++ b/bat/signal.c
@@ -0,0 +1,88 @@
+/*
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
+#include <stdio.h>
+#include <stddef.h>
+#include <stdlib.h>
+#include <math.h>
+#include <stdbool.h>
+
+#include "gettext.h"
+#include "common.h"
+
+void sinf_sign(struct bat *bat,
+		float *out, int length, int max, int *phase, float *val)
+{
+	int i = *phase, k, c, idx;
+	float factor = max * RANGE_FACTOR;
+
+	for (k = 0; k < length; k++) {
+		for (c = 0; c < bat->channels; c++) {
+			idx = k * bat->channels + c;
+			out[idx] = sinf(val[c] * i) * factor;
+		}
+		i++;
+		if (i == bat->rate)
+			i = 0; /* Restart from 0 after one sine wave period */
+	}
+	*phase = i;
+}
+
+void sinf_unsign(struct bat *bat,
+		float *out, int length, int max, int *phase, float *val)
+{
+	int i = *phase, k, c, idx;
+	float factor = max * RANGE_FACTOR / 2.0;
+	float offset = max * (1 - RANGE_FACTOR) / 2.0;
+
+	for (k = 0; k < length; k++) {
+		for (c = 0; c < bat->channels; c++) {
+			idx = k * bat->channels + c;
+			out[idx] = (sinf(val[c] * i) + 1.0) * factor
+				+ offset;
+		}
+		i++;
+		if (i == bat->rate)
+			i = 0; /* Restart from 0 after one sine wave period */
+	}
+	*phase = i;
+}
+
+int generate_sine_wave(struct bat *bat, int length, void *buf, int max)
+{
+	static int i;
+	int c, buf_bytes;
+	float sin_val[MAX_CHANNELS];
+	float *sinus_f = NULL;
+
+	buf_bytes = bat->channels * length;
+	sinus_f = (float *) malloc(buf_bytes * sizeof(float));
+	if (sinus_f == NULL) {
+		fprintf(bat->err, _("Not enough memory.\n"));
+		return -ENOMEM;
+	}
+
+	for (c = 0; c < bat->channels; c++)
+		sin_val[c] = 2.0 * M_PI * bat->target_freq[c]
+			/ (float) bat->rate;
+
+	bat->sinf_func(bat, sinus_f, length, max, &i, sin_val);
+
+	bat->convert_float_to_sample(sinus_f, buf, length, bat->channels);
+
+	free(sinus_f);
+
+	return 0;
+}
-- 
1.9.1
