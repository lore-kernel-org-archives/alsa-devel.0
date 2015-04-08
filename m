From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 4/5] amixer: arrange validation logic
Date: Thu,  9 Apr 2015 01:30:57 +0900
Message-ID: <1428510659-30393-5-git-send-email-o-takashi@sakamocchi.jp>
References: <1428510659-30393-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 93EE12606C2
 for <alsa-devel@alsa-project.org>; Wed,  8 Apr 2015 18:31:11 +0200 (CEST)
In-Reply-To: <1428510659-30393-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

For better reading and easy understanding.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 amixer/amixer.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/amixer/amixer.c b/amixer/amixer.c
index 65ebf20..aec8d01 100644
--- a/amixer/amixer.c
+++ b/amixer/amixer.c
@@ -1271,14 +1271,18 @@ static int get_enum_item_index(snd_mixer_elem_t *elem, char **ptrp)
 		if (snd_mixer_selem_get_enum_item_name(elem, i, sizeof(name)-1, name) < 0)
 			continue;
 
+		/* Check given strings itself. */
 		len = strlen(name);
-		if (! strncmp(name, ptr, len)) {
-			if (! ptr[len] || ptr[len] == ',' || ptr[len] == '\n') {
-				ptr += len;
-				*ptrp = ptr;
-				return i;
-			}
-		}
+		if (strncmp(name, ptr, len) != 0)
+			continue;
+
+		/* Lack of separators between channels. */
+		if (ptr[len] != '\0' && ptr[len] != ',' && ptr[len] != '\n')
+			continue;
+
+		/* OK. The string is exactly one of items. */
+		*ptrp = ptr + len;
+		return i;
 	}
 	return -1;
 }
@@ -1294,9 +1298,9 @@ static int sset_enum(snd_mixer_elem_t *elem, unsigned int argc, char **argv)
 	for (idx = 1; idx < argc; idx++) {
 		ptr = argv[idx];
 		chn = 0;
-		while (*ptr) {
+		while (ptr[0] != '\0') {
 			/* Skip separators between the value of each channel. */
-			while (*ptr == ',' || isspace(*ptr)) {
+			while (ptr[0] == ',' || isspace(ptr[0])) {
 				ptr++;
 				chn++;
 			}
@@ -1304,8 +1308,12 @@ static int sset_enum(snd_mixer_elem_t *elem, unsigned int argc, char **argv)
 			/* Get index for given argument as enumerated item. */
 			ival = get_enum_item_index(elem, &ptr);
 			if (ival < 0)
-				return check_flag;
+				break;
 
+			/*
+			 * Stand success flag when at least one channel is
+			 * changed.
+			 */
 			if (snd_mixer_selem_set_enum_item(elem, chn, ival) >= 0)
 				check_flag = 1;
 		}
-- 
2.1.0
