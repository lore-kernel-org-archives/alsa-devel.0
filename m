From: Tanu Kaskinen <tanu.kaskinen@digia.com>
Subject: [PATCH] ucm: Allow cset commands to have values with
	spaces.
Date: Thu, 9 Aug 2012 16:43:31 +0300
Message-ID: <1344519811-29520-1-git-send-email-tanu.kaskinen@digia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1.digia.com (smtp1.digia.com [82.118.214.156])
 by alsa0.perex.cz (Postfix) with ESMTP id 6AD6B266316
 for <alsa-devel@alsa-project.org>; Thu,  9 Aug 2012 15:14:57 +0200 (CEST)
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
Cc: Takashi Iwai <tiwai@suse.de>, Tanu Kaskinen <tanu.kaskinen@digia.com>
List-Id: alsa-devel@alsa-project.org

An example:
    cset "name='Input Select' Digital Mic"

The old parsing code interpreted "name='Input Select' Digital"
as the element id, which of course didn't work.

Signed-off-by: Tanu Kaskinen <tanu.kaskinen@digia.com>
---
 src/ucm/main.c |   19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/src/ucm/main.c b/src/ucm/main.c
index 4b37776..05a7b0a 100644
--- a/src/ucm/main.c
+++ b/src/ucm/main.c
@@ -170,8 +170,23 @@ static int execute_cset(snd_ctl_t *ctl, char *cset)
 	snd_ctl_elem_value_malloc(&value);
 	snd_ctl_elem_info_malloc(&info);
 
-	pos = strrchr(cset, ' ');
-	if (pos == NULL) {
+	/* Find the space after the element id, taking quoting with
+	   single-quotes into account. */
+	for (pos = cset; *pos != '\0'; pos += strcspn(pos, "' ")) {
+		if (*pos == ' ')
+			break;
+		if (*pos == '\'') {
+			pos++;
+			pos += strcspn(pos, "'");
+			if (*pos == '\0') {
+				uc_error("invalid element id (closing single-quote not found): %s", cset);
+				err = -EINVAL;
+				goto __fail;
+			}
+			pos++;
+		}
+	}
+	if (*pos == '\0') {
 		uc_error("undefined value for cset >%s<", cset);
 		err = -EINVAL;
 		goto __fail;
-- 
1.7.9.5
