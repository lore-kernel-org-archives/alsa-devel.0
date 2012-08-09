From: Tanu Kaskinen <tanu.kaskinen@digia.com>
Subject: [PATCH v2] ucm: Allow cset commands to have values
	with spaces.
Date: Thu, 9 Aug 2012 18:16:36 +0300
Message-ID: <1344525396-8047-1-git-send-email-tanu.kaskinen@digia.com>
References: <1344519811-29520-1-git-send-email-tanu.kaskinen@digia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1.digia.com (smtp1.digia.com [82.118.214.156])
 by alsa0.perex.cz (Postfix) with ESMTP id E949B2663BF
 for <alsa-devel@alsa-project.org>; Thu,  9 Aug 2012 16:47:20 +0200 (CEST)
In-Reply-To: <1344519811-29520-1-git-send-email-tanu.kaskinen@digia.com>
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
 src/ucm/main.c |   22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/src/ucm/main.c b/src/ucm/main.c
index 4b37776..518349a 100644
--- a/src/ucm/main.c
+++ b/src/ucm/main.c
@@ -162,6 +162,7 @@ static int execute_cset(snd_ctl_t *ctl, char *cset)
 {
 	char *pos;
 	int err;
+	int nulled = 0;
 	snd_ctl_elem_id_t *id;
 	snd_ctl_elem_value_t *value;
 	snd_ctl_elem_info_t *info;
@@ -170,13 +171,28 @@ static int execute_cset(snd_ctl_t *ctl, char *cset)
 	snd_ctl_elem_value_malloc(&value);
 	snd_ctl_elem_info_malloc(&info);
 
-	pos = strrchr(cset, ' ');
-	if (pos == NULL) {
+	/* Find the space after the element id, taking quoting into account. */
+	for (pos = cset; *pos != ' ' && *pos != '\0'; pos += strcspn(pos, " '\"")) {
+		if (*pos == '\'' || *pos == '"') {
+			char quote = *pos;
+
+			pos++;
+			pos = strchr(pos, quote);
+			if (pos == NULL) {
+				uc_error("invalid element id (closing quote not found): %s", cset);
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
 	}
 	*pos = '\0';
+	nulled = 1;
 	err = snd_ctl_ascii_elem_id_parse(id, cset);
 	if (err < 0)
 		goto __fail;
@@ -196,7 +212,7 @@ static int execute_cset(snd_ctl_t *ctl, char *cset)
 		goto __fail;
 	err = 0;
       __fail:
-	if (pos != NULL)
+	if (nulled)
 		*pos = ' ';
 
 	if (id != NULL)
-- 
1.7.9.5
