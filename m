From: han.lu@intel.com
Subject: [PATCH 1/1] alsabat: add terminate status check for
	capture thread
Date: Sun, 17 Apr 2016 09:26:45 +0800
Message-ID: <1460856405-28390-1-git-send-email-han.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 4BB002604BE
 for <alsa-devel@alsa-project.org>; Sun, 17 Apr 2016 03:26:30 +0200 (CEST)
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

In loopback test, alsabat use pthread_join(pthread_t thread, **retval)
to wait for the capture thread to terminate. If the capture thread was
canceled, PTHREAD_CANCELED is placed in *retval, and the access to the
**retval will fail. Add status check to prevent illegal access to the
**retval.

Signed-off-by: Lu, Han <han.lu@intel.com>

diff --git a/bat/bat.c b/bat/bat.c
index e824065..1afdcb4 100644
--- a/bat/bat.c
+++ b/bat/bat.c
@@ -192,6 +192,12 @@ static void test_loopback(struct bat *bat)
 		exit(EXIT_FAILURE);
 	}
 
+	/* check if capture thread is canceled or not */
+	if (thread_result_capture == PTHREAD_CANCELED) {
+		fprintf(bat->log, _("Capture canceled.\n"));
+		return;
+	}
+
 	/* check capture status */
 	if (*thread_result_capture != 0) {
 		fprintf(bat->err, _("Exit capture thread fail: %d\n"),
-- 
2.5.0
