From: han.lu@intel.com
Subject: [PATCH V4 1/4] BAT: Remove redundant message strings
Date: Tue, 20 Oct 2015 16:45:45 +0800
Message-ID: <37a7f43cfb4cf6ec1c087ad591c4f27f8f8b9600.1445330404.git.han.lu@intel.com>
References: <cover.1445330404.git.han.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 0B82E2661B5
 for <alsa-devel@alsa-project.org>; Tue, 20 Oct 2015 10:48:34 +0200 (CEST)
In-Reply-To: <cover.1445330404.git.han.lu@intel.com>
In-Reply-To: <cover.1445330404.git.han.lu@intel.com>
References: <cover.1445330404.git.han.lu@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, liam.r.girdwood@intel.com, bernard.gautier@intel.com, alsa-devel@alsa-project.org
Cc: "Lu, Han" <han.lu@intel.com>
List-Id: alsa-devel@alsa-project.org

From: "Lu, Han" <han.lu@intel.com>

Cutting down 6 message strings to 2, as translators need to work
on each different variant.

Signed-off-by: Lu, Han <han.lu@intel.com>

diff --git a/bat/bat.c b/bat/bat.c
index 24c74e8..4320e22 100644
--- a/bat/bat.c
+++ b/bat/bat.c
@@ -41,43 +41,33 @@ static int get_duration(struct bat *bat)
 	char *ptrf, *ptri;
 
 	duration_f = strtof(bat->narg, &ptrf);
-	if (duration_f == HUGE_VALF || duration_f == -HUGE_VALF) {
-		fprintf(bat->err, _("duration float overflow: %f %d\n"),
-				duration_f, -errno);
-		return -errno;
-	} else if (duration_f == 0.0 && errno != 0) {
-		fprintf(bat->err, _("duration float underflow: %f %d\n"),
-				duration_f, -errno);
-		return -errno;
-	}
+	if (duration_f == HUGE_VALF || duration_f == -HUGE_VALF
+			|| (duration_f == 0.0 && errno != 0))
+		goto err_exit;
 
 	duration_i = strtol(bat->narg, &ptri, 10);
-	if (duration_i == LONG_MAX) {
-		fprintf(bat->err, _("duration long overflow: %ld %d\n"),
-				duration_i, -errno);
-		return -errno;
-	} else if (duration_i == LONG_MIN) {
-		fprintf(bat->err, _("duration long underflow: %ld %d\n"),
-				duration_i, -errno);
-		return -errno;
-	}
+	if (duration_i == LONG_MAX || duration_i == LONG_MIN)
+		goto err_exit;
 
-	if (*ptrf == 's') {
+	if (*ptrf == 's')
 		bat->frames = duration_f * bat->rate;
-	} else if (*ptri == 0) {
+	else if (*ptri == 0)
 		bat->frames = duration_i;
-	} else {
-		fprintf(bat->err, _("invalid duration: %s\n"), bat->narg);
-		return -EINVAL;
-	}
+	else
+		bat->frames = -1;
 
 	if (bat->frames <= 0 || bat->frames > MAX_FRAMES) {
-		fprintf(bat->err, _("duration out of range: (0, %d(%ds))\n"),
-				MAX_FRAMES, (bat->frames / bat->rate));
+		fprintf(bat->err, _("Invalid duration. Range: (0, %d(%fs))\n"),
+				MAX_FRAMES, (double)MAX_FRAMES / bat->rate);
 		return -EINVAL;
 	}
 
 	return 0;
+
+err_exit:
+	fprintf(bat->err, _("Duration overflow/underflow: %d\n"), -errno);
+
+	return -errno;
 }
 
 static void get_sine_frequencies(struct bat *bat, char *freq)
-- 
1.9.1
