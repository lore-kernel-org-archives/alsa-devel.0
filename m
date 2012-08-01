From: Tanu Kaskinen <tanu.kaskinen@digia.com>
Subject: [PATCH] ucm: Return NULL from get_list0() and
	get_list20() in case of empty lists.
Date: Wed, 1 Aug 2012 16:06:16 +0300
Message-ID: <1343826376-13982-1-git-send-email-tanu.kaskinen@digia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1.digia.com (smtp1.digia.com [82.118.214.156])
 by alsa0.perex.cz (Postfix) with ESMTP id A6442264F04
 for <alsa-devel@alsa-project.org>; Wed,  1 Aug 2012 15:06:19 +0200 (CEST)
Received: from smtp1.digia.com (unknown [127.0.0.1])
 by IMSVA80 (Postfix) with ESMTP id 6153E37003F
 for <alsa-devel@alsa-project.org>; Wed,  1 Aug 2012 16:06:21 +0300 (EEST)
Received: from IT-EXCAS02-HKI.it.local (unknown [10.9.52.71])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by smtp1.digia.com (Postfix) with ESMTP id 5469E370034
 for <alsa-devel@alsa-project.org>; Wed,  1 Aug 2012 16:06:21 +0300 (EEST)
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
Cc: Tanu Kaskinen <tanu.kaskinen@digia.com>
List-Id: alsa-devel@alsa-project.org

alloc_str_list() sets the result to NULL too, so this patch
makes the behavior more consistent. This also fixes a crash
in PulseAudio, because PulseAudio assumes that
snd_use_case_get_list() always initializes the result, and
since snd_use_case_get_list() uses get_list20(), this
assumption didn't hold.
---
 src/ucm/main.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/src/ucm/main.c b/src/ucm/main.c
index 79901f8..4b37776 100644
--- a/src/ucm/main.c
+++ b/src/ucm/main.c
@@ -367,8 +367,10 @@ static int get_list0(struct list_head *list,
 	char *ptr, *str1;
 
 	cnt = alloc_str_list(list, 1, &res);
-	if (cnt <= 0)
+	if (cnt <= 0) {
+		*result = NULL;
 	        return cnt;
+	}
 	*result = (const char **)res;
 	list_for_each(pos, list) {
 		ptr = list_entry_offset(pos, char, offset);
@@ -414,8 +416,10 @@ static int get_list20(struct list_head *list,
 	char *ptr, *str1, *str2;
 
 	cnt = alloc_str_list(list, 2, &res);
-	if (cnt <= 0)
+	if (cnt <= 0) {
+		*result = NULL;
 	        return cnt;
+	}
         *result = (const char **)res;
 	list_for_each(pos, list) {
 		ptr = list_entry_offset(pos, char, offset);
-- 
1.7.9.5
