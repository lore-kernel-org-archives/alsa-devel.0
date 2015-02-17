From: Tanu Kaskinen <tanu.kaskinen@linux.intel.com>
Subject: [PATCH 1/3] ucm: fix incorrect error code sign
Date: Tue, 17 Feb 2015 21:15:21 +0200
Message-ID: <1424200523-6314-2-git-send-email-tanu.kaskinen@linux.intel.com>
References: <1424200523-6314-1-git-send-email-tanu.kaskinen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 00EEF26171B
 for <alsa-devel@alsa-project.org>; Tue, 17 Feb 2015 20:16:04 +0100 (CET)
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

Reported-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Tanu Kaskinen <tanu.kaskinen@linux.intel.com>
---
 src/ucm/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/ucm/main.c b/src/ucm/main.c
index 3924aee..efb5be5 100644
--- a/src/ucm/main.c
+++ b/src/ucm/main.c
@@ -304,7 +304,7 @@ static int execute_sequence(snd_use_case_mgr_t *uc_mgr,
 						 value_list1,
 						 value_list2,
 						 value_list3);
-				if (err < 0 && err != ENOENT) {
+				if (err < 0 && err != -ENOENT) {
 					uc_error("cdev is not defined!");
 					return err;
 				}
@@ -312,7 +312,7 @@ static int execute_sequence(snd_use_case_mgr_t *uc_mgr,
 						 value_list1,
 						 value_list2,
 						 value_list3);
-				if (err < 0 && err != ENOENT) {
+				if (err < 0 && err != -ENOENT) {
 					free((char *)cdev1);
 					uc_error("cdev is not defined!");
 					return err;
-- 
1.9.3
