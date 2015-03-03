From: Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH] amixer: Don't set only the first item in
	sset_enum()
Date: Tue,  3 Mar 2015 18:39:52 +0100
Message-ID: <1425404392-22598-1-git-send-email-pmeerw@pmeerw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pmeerw.net (ns.pmeerw.net [84.19.176.92])
 by alsa0.perex.cz (Postfix) with ESMTP id 38ECE261735
 for <alsa-devel@alsa-project.org>; Tue,  3 Mar 2015 18:40:09 +0100 (CET)
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
Cc: Peter Meerwald <pmeerw@pmeerw.net>
List-Id: alsa-devel@alsa-project.org

From: Peter Meerwald <p.meerwald@bct-electronic.com>

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 amixer/amixer.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/amixer/amixer.c b/amixer/amixer.c
index ed60e7c..36c92eb 100644
--- a/amixer/amixer.c
+++ b/amixer/amixer.c
@@ -1278,7 +1278,7 @@ static int get_enum_item_index(snd_mixer_elem_t *elem, char **ptrp)
 
 static int sset_enum(snd_mixer_elem_t *elem, unsigned int argc, char **argv)
 {
-	unsigned int idx, chn = 0;
+	unsigned int idx, item = 0;
 	int check_flag = ignore_error ? 0 : -1;
 
 	for (idx = 1; idx < argc; idx++) {
@@ -1287,7 +1287,7 @@ static int sset_enum(snd_mixer_elem_t *elem, unsigned int argc, char **argv)
 			int ival = get_enum_item_index(elem, &ptr);
 			if (ival < 0)
 				return check_flag;
-			if (snd_mixer_selem_set_enum_item(elem, chn, ival) >= 0)
+			if (snd_mixer_selem_set_enum_item(elem, item++, ival) >= 0)
 				check_flag = 1;
 			/* skip separators */
 			while (*ptr == ',' || isspace(*ptr))
-- 
1.7.9.5
