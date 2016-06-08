From: han.lu@intel.com
Subject: [PATCH 2/4] alsabat: add channels parameter for
	adjust_waveform()
Date: Thu,  9 Jun 2016 03:42:47 +0800
Message-ID: <e03067bf9b55908fd3c3a303f92f80e4b9d643f1.1465404865.git.han.lu@intel.com>
References: <cover.1465404865.git.han.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 4857D265A7F
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

The function adjust_waveform() is a component of generate_sine_wave(),
and depended on bat->channels parameter. Add parameter "channels" to
remove the dependency, and then adjust_waveform() can be applied on
other use cases, e.g. a single channel sine wave generator.

Signed-off-by: Lu, Han <han.lu@intel.com>

diff --git a/bat/signal.c b/bat/signal.c
index 15bea0a..2047f53 100644
--- a/bat/signal.c
+++ b/bat/signal.c
@@ -109,7 +109,8 @@ static int reorder(struct bat *bat, float *val, int frames)
 	return 0;
 }
 
-static int adjust_waveform(struct bat *bat, float *val, int frames)
+static int adjust_waveform(struct bat *bat, float *val, int frames,
+		int channels)
 {
 	int i, nsamples, max;
 	float factor, offset = 0.0;
@@ -134,7 +135,7 @@ static int adjust_waveform(struct bat *bat, float *val, int frames)
 	}
 
 	factor = max * RANGE_FACTOR;
-	nsamples = bat->channels * frames;
+	nsamples = channels * frames;
 
 	for (i = 0; i < nsamples; i++)
 		val[i] = val[i] * factor + offset;
@@ -171,7 +172,7 @@ int generate_sine_wave(struct bat *bat, int frames, void *buf)
 		goto exit;
 
 	/* adjust amplitude and offset of waveform */
-	err = adjust_waveform(bat, sinus_f, frames);
+	err = adjust_waveform(bat, sinus_f, frames, bat->channels);
 	if (err != 0)
 		goto exit;
 
-- 
2.5.0
