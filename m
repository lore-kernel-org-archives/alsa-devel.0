From: han.lu@intel.com
Subject: [PATCH BAT V1 5/7] BAT: Add converting functions
Date: Tue, 15 Sep 2015 15:00:21 +0800
Message-ID: <d47f70c0098cbeeb1b6186c266bdc6196c3457fc.1442298607.git.han.lu@intel.com>
References: <cover.1442298607.git.han.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id C3FEB260711
 for <alsa-devel@alsa-project.org>; Tue, 15 Sep 2015 09:01:48 +0200 (CEST)
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

Add functions that converting audio samples to double data for analysis,
and functions that converting float data to audio samples for playback.

Signed-off-by: Lu, Han <han.lu@intel.com>
Signed-off-by: Liam Girdwood <liam.r.girdwood@intel.com>
Signed-off-by: Bernard Gautier <bernard.gautier@intel.com>

diff --git a/bat/convert.c b/bat/convert.c
new file mode 100644
index 0000000..dcbe912
--- /dev/null
+++ b/bat/convert.c
@@ -0,0 +1,113 @@
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
+#include <stdint.h>
+
+void convert_uint8_to_double(void *buf, double *val, int samples)
+{
+	int i;
+
+	for (i = 0; i < samples; i++)
+		val[i] = ((uint8_t *) buf)[i];
+}
+
+void convert_int16_to_double(void *buf, double *val, int samples)
+{
+	int i;
+
+	for (i = 0; i < samples; i++)
+		val[i] = ((int16_t *) buf)[i];
+}
+
+void convert_int24_to_double(void *buf, double *val, int samples)
+{
+	int i;
+	int32_t tmp;
+
+	for (i = 0; i < samples; i++) {
+		tmp = ((uint8_t *) buf)[i * 3 + 2] << 24;
+		tmp |= ((uint8_t *) buf)[i * 3 + 1] << 16;
+		tmp |= ((uint8_t *) buf)[i * 3] << 8;
+		tmp >>= 8;
+		val[i] = tmp;
+	}
+}
+
+void convert_int32_to_double(void *buf, double *val, int samples)
+{
+	int i;
+
+	for (i = 0; i < samples; i++)
+		val[i] = ((int32_t *) buf)[i];
+}
+
+void convert_float_to_uint8(float *val, void *buf, int samples, int channels)
+{
+	int i, c, idx;
+
+	for (i = 0; i < samples; i++) {
+		for (c = 0; c < channels; c++) {
+			idx = i * channels + c;
+			((uint8_t *) buf)[idx] = (uint8_t) val[idx];
+		}
+	}
+}
+
+void convert_float_to_int16(float *val, void *buf, int samples, int channels)
+{
+	int i, c, idx;
+
+	for (i = 0; i < samples; i++) {
+		for (c = 0; c < channels; c++) {
+			idx = i * channels + c;
+			((int16_t *) buf)[idx] = (int16_t) val[idx];
+		}
+	}
+}
+
+void convert_float_to_int24(float *val, void *buf, int samples, int channels)
+{
+	int i, c, idx_f, idx_i;
+	int32_t val_f_i;
+
+	for (i = 0; i < samples; i++) {
+		for (c = 0; c < channels; c++) {
+			idx_f = i * channels + c;
+			idx_i = 3 * idx_f;
+			val_f_i = (int32_t) val[idx_f];
+			((int8_t *) buf)[idx_i + 0] =
+				(int8_t) (val_f_i & 0xff);
+			((int8_t *) buf)[idx_i + 1] =
+				(int8_t) ((val_f_i >> 8) & 0xff);
+			((int8_t *) buf)[idx_i + 2] =
+				(int8_t) ((val_f_i >> 16) & 0xff);
+		}
+	}
+}
+
+void convert_float_to_int32(float *val, void *buf, int samples, int channels)
+{
+	int i, c, idx;
+
+	for (i = 0; i < samples; i++) {
+		for (c = 0; c < channels; c++) {
+			idx = i * channels + c;
+			((int32_t *) buf)[idx] = (int32_t) val[idx];
+		}
+	}
+}
diff --git a/bat/convert.h b/bat/convert.h
new file mode 100644
index 0000000..28828ba
--- /dev/null
+++ b/bat/convert.h
@@ -0,0 +1,23 @@
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
+void convert_uint8_to_double(void *, double *, int);
+void convert_int16_to_double(void *, double *, int);
+void convert_int24_to_double(void *, double *, int);
+void convert_int32_to_double(void *, double *, int);
+void convert_float_to_uint8(float *, void *, int, int);
+void convert_float_to_int16(float *, void *, int, int);
+void convert_float_to_int24(float *, void *, int, int);
+void convert_float_to_int32(float *, void *, int, int);
-- 
1.9.1
