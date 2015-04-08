From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 1/5] amixer: gather local variables in the
	beginning of functions
Date: Thu,  9 Apr 2015 01:30:54 +0900
Message-ID: <1428510659-30393-2-git-send-email-o-takashi@sakamocchi.jp>
References: <1428510659-30393-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 949F626545B
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

Following to basic principles of C language programing.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 amixer/amixer.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/amixer/amixer.c b/amixer/amixer.c
index 36c92eb..ff1a927 100644
--- a/amixer/amixer.c
+++ b/amixer/amixer.c
@@ -1278,13 +1278,16 @@ static int get_enum_item_index(snd_mixer_elem_t *elem, char **ptrp)
 
 static int sset_enum(snd_mixer_elem_t *elem, unsigned int argc, char **argv)
 {
-	unsigned int idx, item = 0;
+	unsigned int idx;
+	unsigned int item = 0;
 	int check_flag = ignore_error ? 0 : -1;
+	int ival;
+	char *ptr;
 
 	for (idx = 1; idx < argc; idx++) {
-		char *ptr = argv[idx];
+		ptr = argv[idx];
 		while (*ptr) {
-			int ival = get_enum_item_index(elem, &ptr);
+			ival = get_enum_item_index(elem, &ptr);
 			if (ival < 0)
 				return check_flag;
 			if (snd_mixer_selem_set_enum_item(elem, item++, ival) >= 0)
-- 
2.1.0
