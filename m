From: Caleb Crome <caleb@crome.org>
Subject: Re: [PATCH BAT V1 4/7] BAT: Add signal generator
Date: Fri, 18 Sep 2015 09:50:48 -0700
Message-ID: <CAG5mAdzweX=mEPE+eHSeYhoutiY=0zpZ8kH3ttBiZ0WiypAFCQ@mail.gmail.com>
References: <cover.1442298607.git.han.lu@intel.com>
 <ef753ac115ad1e6359ec30254bebeea9f39c9e6a.1442298607.git.han.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f174.google.com (mail-wi0-f174.google.com
 [209.85.212.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 1BCB4265703
 for <alsa-devel@alsa-project.org>; Fri, 18 Sep 2015 18:51:07 +0200 (CEST)
Received: by wicfx3 with SMTP id fx3so38474421wic.0
 for <alsa-devel@alsa-project.org>; Fri, 18 Sep 2015 09:51:07 -0700 (PDT)
In-Reply-To: <ef753ac115ad1e6359ec30254bebeea9f39c9e6a.1442298607.git.han.lu@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: han.lu@intel.com
Cc: bernard.gautier@intel.com, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, tiwai@suse.com, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

Hi Han, Liam, all,

It looks like you have run into the old problem that the math library
actually stinks at generating sine waves right :-)

> +       for (k = 0; k < length; k++) {
> +               for (c = 0; c < bat->channels; c++) {
> +                       idx = k * bat->channels + c;
> +                       out[idx] = sinf(val[c] * i) * factor;
> +               }
> +               i++;
> +               if (i == bat->rate)
> +                       i = 0; /* Restart from 0 after one sine wave period */
> +       }

If I'm reading this right, you're resetting the argument to the sinf
function.  This can generate unwanted distortion in the sine wave if
the frequency isn't an exact fraction of the sample rate.

Here's a little library (along with a test program) I just whipped up
using a phasor as the sine wave generator.
The test program runs it for a simulated 3 days, then prints a python
script to stdout that you can then run and plot to see the generated
wave.

This will work for any frequency sine wave, and as far as I know, it's
the best way to generate sine waves. (Not for calculating the sin of a
value though!)

Here is the generator and test program.  Sorry If this isn't the right
way to submit a file/patch, but I have no idea how to do it properly
:-/

BTW, this isn't actually integrated into the bat program, it's just
the little library for generating the sine waves.

Author: Caleb Crome <caleb@signalessence.com>
Date:   Fri Sep 18 09:45:43 2015 -0700

    added sin_generator

diff --git a/bat/sin_generator.c b/bat/sin_generator.c
new file mode 100644
index 0000000..e67f376
--- /dev/null
+++ b/bat/sin_generator.c
@@ -0,0 +1,120 @@
+#include "math.h"
+#include "sin_generator.h"
+/*
+ * Copyright (C) 2015 Caleb Crome
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
+
+/* Initialize the sine wave generator.
+ * sin_generator:  gets initialized by this call.
+ * frequency:      the frequency for the sine wave.  must be < 0.5*sample_rate
+ * sample_rate:    the the sample rate...
+ * returns 0 on success, -1 on error.
+ */
+int sin_generator_init(struct sin_generator *sg, float magnitude,
float frequency, float sample_rate)
+{
+    // angular frequency:  cycles/sec / (samp/sec) * rad/cycle = rad/samp
+    float w = frequency/sample_rate*2*M_PI;
+    if (frequency >= sample_rate/2)
+        return -1;
+    sg->phasor_real = cos(w);
+    sg->phasor_imag = sin(w);
+    sg->magnitude   = magnitude;
+    sg->state_real  = 0.0;
+    sg->state_imag  = magnitude;
+    sg->frequency = frequency;
+    sg->sample_rate = sample_rate;
+    return 0;
+}
+
+/*
+ * Generates the next sample in the sine wave.
+ * should be much faster than calling a sin function
+ * if it's inlined and optimized.
+ *
+ * returns the next value.  no possibility of error.
+*/
+float sin_generator_next_sample(struct sin_generator *sg)
+{
+    // get shorthand to pointers
+    const double pr = sg->phasor_real;
+    const double pi = sg->phasor_imag;
+    const double sr = sg->state_real;
+    const double si = sg->state_imag;
+    // step the phasor -- complex multiply
+    sg->state_real = sr * pr - si * pi;
+    sg->state_imag = sr * pi + pr * si;
+    return sr;  // return the input value so sine wave starts at
+            // exactly 0.0
+}
+/* fills a vector with a sine wave */
+void sin_generator_vfill(struct sin_generator *sg, float *buf, int n)
+{
+    int i;
+    for (i = 0; i < n; i++) {
+        *buf++ = sin_generator_next_sample(sg);
+    }
+}
+
+#ifdef TEST_PHASOR
+#define TESTSIZE (48000/1000)
+// compile with this command to create executable that will
+// auto-generate a self plotting plot :-)
+
+// gcc -g sin_generator.c -o sin_generator -lm -DTEST_PHASOR
+
+#include <stdio.h>
+
+void dumpbuffer(const char *name, float *buffer, int n)
+{
+    int i;
+    printf("%s = [\n", name);
+    for (i = 0; i < n; i++) {
+        printf("   %f,\n", buffer[i]);
+    }
+    printf("]\n");
+    printf("plot(%s)\n", name);
+}
+
+int main(int argc, char *argv[])
+{
+    float buffer[TESTSIZE];
+    long int  i;
+    struct sin_generator sg;
+
+    // test the first few.
+    sin_generator_init (&sg, 3.0, 1000, 48000);
+    sin_generator_vfill(&sg, buffer, TESTSIZE);
+    printf("from pylab import *\n");
+    dumpbuffer("s", buffer, TESTSIZE);
+
+    // now wind the phasor for 3 days worth of samples to see
+    // if magnitude drifts.
+    for (i = 0; i < (3L*24*60*60*48000); i++)
+        sin_generator_next_sample(&sg);
+
+    sin_generator_vfill(&sg, buffer, TESTSIZE);
+    // and let's see what that one looks like
+    dumpbuffer("o", buffer, TESTSIZE);
+    printf("show()\n");
+
+    return 0;
+}
+#endif
diff --git a/bat/sin_generator.h b/bat/sin_generator.h
new file mode 100644
index 0000000..2ab7561
--- /dev/null
+++ b/bat/sin_generator.h
@@ -0,0 +1,23 @@
+/*
+ * Here's a generic sine wave generator that will work indefinitely
for any frequency.
+ *
+ * Note:  the state & phasor are stored as doubles (and updated as
+ * doubles) because after a million samples the magnitude drifts a
+ * bit.  If we really need floats, it can be done with periodic
+ * renormalization of the state_real+state_imag magnitudes.  I was
+ */
+
+struct sin_generator;
+struct sin_generator {
+    double state_real;
+    double state_imag;
+    double phasor_real;
+    double phasor_imag;
+    float frequency;
+    float sample_rate;
+    float magnitude;
+};
+
+int   sin_generator_init(struct sin_generator *sg, float magnitude,
float frequency, float sample_rate);
+float sin_generator_next_sample(struct sin_generator *sg);
+void  sin_generator_vfill(struct sin_generator *sg, float *buf, int n);
