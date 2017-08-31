From: Zhang Keqiao <keqiao.zhang@intel.com>
Subject: [PATCH v1 4/4] alsabat: XRUN injections test criteria
Date: Thu, 31 Aug 2017 21:37:09 +0800
Message-ID: <20170831133709.25537-5-keqiao.zhang@intel.com>
References: <20170831133709.25537-1-keqiao.zhang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id BA8EE2673C4
 for <alsa-devel@alsa-project.org>; Thu, 31 Aug 2017 15:40:43 +0200 (CEST)
In-Reply-To: <20170831133709.25537-1-keqiao.zhang@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: keqiao.zhang@intel.com
List-Id: alsa-devel@alsa-project.org

Check if target number of frames can be detected after XRUNs.

Signed-off-by: Zhang Keqiao <keqiao.zhang@intel.com>
---
 bat/analyze.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/bat/analyze.c b/bat/analyze.c
index 17fff50..1c48a6b 100644
--- a/bat/analyze.c
+++ b/bat/analyze.c
@@ -471,9 +471,25 @@ int analyze_capture(struct bat *bat)
 		goto exit2;
 
 	items = fread(bat->buf, bat->frame_size, bat->frames, bat->fp);
-	if (items != bat->frames) {
-		err = -EIO;
-		goto exit2;
+
+	/* check the number of frames recorded after XRUNs */
+	if (bat->xarg) {
+		if (items != bat->frames) {
+			fprintf(bat->err, _("\nXRUN injection test FAILED\n"));
+			fprintf(bat->err, _("Target frames number %d, actually got %zu\n"),
+				bat->frames, items);
+			err = -EIO;
+			goto exit2;
+		} else {
+			fprintf(bat->log, _("\nXRUN injection test PASSED\n"));
+			err = 0; /* target frames can be detected after XRUNs */
+			goto exit2;
+		}
+	} else {
+		if (items != bat->frames) {
+			err = -EIO;
+			goto exit2;
+		}
 	}
 
 	err = reorder_data(bat);
-- 
2.9.3
