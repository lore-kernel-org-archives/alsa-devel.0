From: han.lu@intel.com
Subject: [PATCH 3/4] alsabat: add a single channel sine wave
	generator
Date: Thu,  9 Jun 2016 03:42:48 +0800
Message-ID: <b9544395785f623026f776411755fa5ebd29d869.1465404865.git.han.lu@intel.com>
References: <cover.1465404865.git.han.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 91E772657E5
 for <alsa-devel@alsa-project.org>; Wed,  8 Jun 2016 13:46:39 +0200 (CEST)
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

Add function generate_sine_wave_raw_mono(). It serves as a single
channel sine wave generator, to provide data for calculation (e.g.
for noise analysis).
The function is similar to generate_sine_wave(), but a lite revision.
It has no dependency on bat channels and target frequency, no malloc
inside, no data conversion from float to integer samples, and supports
one channel only.

Signed-off-by: Lu, Han <han.lu@intel.com>

diff --git a/bat/bat-signal.h b/bat/bat-signal.h
index a295517..3c314a5 100644
--- a/bat/bat-signal.h
+++ b/bat/bat-signal.h
@@ -28,3 +28,4 @@ int sin_generator_init(struct sin_generator *, float, float, float);
 float sin_generator_next_sample(struct sin_generator *);
 void sin_generator_vfill(struct sin_generator *, float *, int);
 int generate_sine_wave(struct bat *, int, void *);
+int generate_sine_wave_raw_mono(struct bat *, float *, float, int);
diff --git a/bat/signal.c b/bat/signal.c
index 2047f53..c9b5c7b 100644
--- a/bat/signal.c
+++ b/bat/signal.c
@@ -183,3 +183,21 @@ exit:
 
 	return err;
 }
+
+/* generate single channel sine waveform without sample conversion */
+int generate_sine_wave_raw_mono(struct bat *bat, float *buf,
+		float freq, int nsamples)
+{
+	int err = 0;
+	struct sin_generator sg;
+
+	err = sin_generator_init(&sg, 1.0, freq, bat->rate);
+	if (err < 0)
+		return err;
+	sin_generator_vfill(&sg, buf, nsamples);
+
+	/* adjust amplitude and offset of waveform */
+	err = adjust_waveform(bat, buf, nsamples, 1);
+
+	return err;
+}
-- 
2.5.0
