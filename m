From: Tanu Kaskinen <tanu.kaskinen@linux.intel.com>
Subject: [PATCH 2/3] ucm: fix the logic of choosing the default
	cdev
Date: Tue, 17 Feb 2015 21:15:22 +0200
Message-ID: <1424200523-6314-3-git-send-email-tanu.kaskinen@linux.intel.com>
References: <1424200523-6314-1-git-send-email-tanu.kaskinen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 81BFA261615
 for <alsa-devel@alsa-project.org>; Tue, 17 Feb 2015 20:15:37 +0100 (CET)
In-Reply-To: <1424200523-6314-1-git-send-email-tanu.kaskinen@linux.intel.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

If the cdev has not been configured explicitly, use the PlaybackCTL
or CaptureCTL value if one of them is set. If neither are set, or if
both are set to different values, then there's no sensible default, so
executing the sequence should fail. The previous code probably tried
to implement this logic, but it was buggy.

Also use more descriptive variable names than "cdev1" and "cdev2".

Signed-off-by: Tanu Kaskinen <tanu.kaskinen@linux.intel.com>
---
 src/ucm/main.c | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/src/ucm/main.c b/src/ucm/main.c
index efb5be5..81a0950 100644
--- a/src/ucm/main.c
+++ b/src/ucm/main.c
@@ -299,8 +299,10 @@ static int execute_sequence(snd_use_case_mgr_t *uc_mgr,
 		case SEQUENCE_ELEMENT_TYPE_CSET:
 		case SEQUENCE_ELEMENT_TYPE_CSET_BIN_FILE:
 			if (cdev == NULL) {
-				const char *cdev1 = NULL, *cdev2 = NULL;
-				err = get_value3(&cdev1, "PlaybackCTL",
+				const char *playback_ctl = NULL;
+				const char *capture_ctl = NULL;
+
+				err = get_value3(&playback_ctl, "PlaybackCTL",
 						 value_list1,
 						 value_list2,
 						 value_list3);
@@ -308,23 +310,33 @@ static int execute_sequence(snd_use_case_mgr_t *uc_mgr,
 					uc_error("cdev is not defined!");
 					return err;
 				}
-				err = get_value3(&cdev2, "CaptureCTL",
+				err = get_value3(&capture_ctl, "CaptureCTL",
 						 value_list1,
 						 value_list2,
 						 value_list3);
 				if (err < 0 && err != -ENOENT) {
-					free((char *)cdev1);
+					free((char *)playback_ctl);
 					uc_error("cdev is not defined!");
 					return err;
 				}
-				if (cdev1 == NULL || cdev2 == NULL ||
-                                    strcmp(cdev1, cdev2) == 0) {
-					cdev = (char *)cdev1;
-					free((char *)cdev2);
-				} else {
-					free((char *)cdev1);
-					free((char *)cdev2);
+				if (playback_ctl == NULL &&
+				    capture_ctl == NULL) {
+					uc_error("cdev is not defined!");
+					return -EINVAL;
+				}
+				if (playback_ctl != NULL &&
+				    capture_ctl != NULL &&
+				    strcmp(playback_ctl, capture_ctl) != 0) {
+					free((char *)playback_ctl);
+					free((char *)capture_ctl);
+					uc_error("cdev is not defined!");
+					return -EINVAL;
 				}
+				if (playback_ctl != NULL) {
+					cdev = (char *)playback_ctl;
+					free((char *)capture_ctl);
+				} else
+					cdev = (char *)capture_ctl;
 			}
 			if (ctl == NULL) {
 				err = open_ctl(uc_mgr, &ctl, cdev);
-- 
1.9.3
