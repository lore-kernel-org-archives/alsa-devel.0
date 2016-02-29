From: han.lu@intel.com
Subject: [PATCH 1/1] alsabat: truncate sample frames for faster
	FFT analysis
Date: Mon, 29 Feb 2016 10:33:45 +0800
Message-ID: <1456713225-11173-1-git-send-email-han.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 74722260564
 for <alsa-devel@alsa-project.org>; Mon, 29 Feb 2016 03:32:44 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, liam.r.girdwood@linux.intel.com, bernard.gautier@intel.com, alsa-devel@alsa-project.org
Cc: "Lu, Han" <han.lu@intel.com>
List-Id: alsa-devel@alsa-project.org

From: "Lu, Han" <han.lu@intel.com>

Truncate the sample frames to powers of 2, since the FFTW algorithm
runs especially fast in this case, and other sizes may be computed
by means of a slow, general-purpose algorithm.
In my test environment applying the patch, a sound clip of 33072
frames is cut off to 32768 frames before analysis, and the time
cost is reduced from 6.128s to 0.224s.

Signed-off-by: Lu, Han <han.lu@intel.com>

diff --git a/bat/analyze.c b/bat/analyze.c
index 60e2d1c..5cfdac3 100644
--- a/bat/analyze.c
+++ b/bat/analyze.c
@@ -256,6 +256,20 @@ static int reorder_data(struct bat *bat)
 	return 0;
 }
 
+/* truncate sample frames for faster FFT analysis process */
+static int truncate_frames(struct bat *bat)
+{
+	int shift = SHIFT_MAX;
+
+	for (; shift > SHIFT_MIN; shift--)
+		if (bat->frames & (1 << shift)) {
+			bat->frames = 1 << shift;
+			return 0;
+		}
+
+	return -EINVAL;
+}
+
 int analyze_capture(struct bat *bat)
 {
 	int err = 0;
@@ -263,6 +277,13 @@ int analyze_capture(struct bat *bat)
 	int c;
 	struct analyze a;
 
+	err = truncate_frames(bat);
+	if (err < 0) {
+		fprintf(bat->err, _("Invalid frame number for analysis: %d\n"),
+				bat->frames);
+		return err;
+	}
+
 	fprintf(bat->log, _("\nBAT analysis: signal has %d frames at %d Hz,"),
 			bat->frames, bat->rate);
 	fprintf(bat->log, _(" %d channels, %d bytes per sample.\n"),
diff --git a/bat/common.h b/bat/common.h
index b8f6670..ff03fc1 100644
--- a/bat/common.h
+++ b/bat/common.h
@@ -68,6 +68,12 @@
 #define FOUND_DC			(1<<1)
 #define FOUND_WRONG_PEAK		(1<<0)
 
+/* Truncate sample frames to (1 << N), for faster FFT analysis process. The
+ * valid range of N is (SHIFT_MIN, SHIFT_MAX). When N increases, the analysis
+ * will be more time-consuming, and the result will be more accurate. */
+#define SHIFT_MAX			(sizeof(int) * 8 - 2)
+#define SHIFT_MIN			8
+
 struct wav_header {
 	unsigned int magic; /* 'RIFF' */
 	unsigned int length; /* file len */
-- 
2.5.0
