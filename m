From: han.lu@intel.com
Subject: [PATCH V4 4/4] BAT: Use dynamic temp file
Date: Tue, 20 Oct 2015 16:45:48 +0800
Message-ID: <0e967a07bb092cbf821f025bd75ef6b835a29a54.1445330404.git.han.lu@intel.com>
References: <cover.1445330404.git.han.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id B3F35266497
 for <alsa-devel@alsa-project.org>; Tue, 20 Oct 2015 10:48:47 +0200 (CEST)
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

Use dynamic temp file instead of fixed temp file to store recorded
wav data, for better security.

Signed-off-by: Lu, Han <han.lu@intel.com>

diff --git a/bat/bat.c b/bat/bat.c
index 2be3efb..e1343fb 100644
--- a/bat/bat.c
+++ b/bat/bat.c
@@ -451,6 +451,7 @@ static int validate_options(struct bat *bat)
 static int bat_init(struct bat *bat)
 {
 	int err = 0;
+	char name[] = TEMP_RECORD_FILE_NAME;
 
 	/* Determine logging to a file or stdout and stderr */
 	if (bat->logarg) {
@@ -473,10 +474,23 @@ static int bat_init(struct bat *bat)
 	}
 
 	/* Determine capture file */
-	if (bat->local)
+	if (bat->local) {
 		bat->capture.file = bat->playback.file;
-	else
-		bat->capture.file = TEMP_RECORD_FILE_NAME;
+	} else {
+		/* create temp file for sound record and analysis */
+		err = mkstemp(name);
+		if (err == -1) {
+			fprintf(bat->err, _("Fail to create record file: %d\n"),
+					-errno);
+			return -errno;
+		}
+		/* store file name which is dynamically created */
+		bat->capture.file = strdup(name);
+		if (bat->capture.file == NULL)
+			return -errno;
+		/* close temp file */
+		close(err);
+	}
 
 	/* Initial for playback */
 	if (bat->playback.file == NULL) {
@@ -590,8 +604,11 @@ analyze:
 	err = analyze_capture(&bat);
 out:
 	fprintf(bat.log, _("\nReturn value is %d\n"), err);
+
 	if (bat.logarg)
 		fclose(bat.log);
+	if (!bat.local)
+		free(bat.capture.file);
 
 	return err;
 }
diff --git a/bat/common.h b/bat/common.h
index f0254ab..90bc3e2 100644
--- a/bat/common.h
+++ b/bat/common.h
@@ -15,7 +15,7 @@
 
 #include <alsa/asoundlib.h>
 
-#define TEMP_RECORD_FILE_NAME		"/tmp/bat.wav"
+#define TEMP_RECORD_FILE_NAME		"/tmp/bat.wav.XXXXXX"
 
 #define OPT_BASE			300
 #define OPT_LOG				(OPT_BASE + 1)
-- 
1.9.1
