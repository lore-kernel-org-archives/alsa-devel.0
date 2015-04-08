From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 2/5] amixer: fix a bug to handle omitted value
	in parameter for enumerated element
Date: Thu,  9 Apr 2015 01:30:55 +0900
Message-ID: <1428510659-30393-3-git-send-email-o-takashi@sakamocchi.jp>
References: <1428510659-30393-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 942FC265388
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

In processing of 'sset' operation for enumerated elements, while loop is
used to skip separators for arguments which shows the value of each channel.
But the actual channel is not incremented, thus this sample causes wrong
result that D is set to third channel, instead of the last channel.

$ amixer sset enum-element-13,1019 A,B,,D

Furthermore, when the value of first channel is omitted, the command causes
'Invalid command' output.

This commit fixes these bug, by incrementing channel number according to
the loop and move the loop to the beginning of outer loop.

Fixes: 1a19ec153850('amixer: Don't set only the first item in sset_enum()')
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 amixer/amixer.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/amixer/amixer.c b/amixer/amixer.c
index ff1a927..a3de375 100644
--- a/amixer/amixer.c
+++ b/amixer/amixer.c
@@ -1279,22 +1279,28 @@ static int get_enum_item_index(snd_mixer_elem_t *elem, char **ptrp)
 static int sset_enum(snd_mixer_elem_t *elem, unsigned int argc, char **argv)
 {
 	unsigned int idx;
-	unsigned int item = 0;
+	unsigned int chn;
 	int check_flag = ignore_error ? 0 : -1;
 	int ival;
 	char *ptr;
 
 	for (idx = 1; idx < argc; idx++) {
 		ptr = argv[idx];
+		chn = 0;
 		while (*ptr) {
+			/* Skip separators between the value of each channel. */
+			while (*ptr == ',' || isspace(*ptr)) {
+				ptr++;
+				chn++;
+			}
+
+			/* Get index for given argument as enumerated item. */
 			ival = get_enum_item_index(elem, &ptr);
 			if (ival < 0)
 				return check_flag;
-			if (snd_mixer_selem_set_enum_item(elem, item++, ival) >= 0)
+
+			if (snd_mixer_selem_set_enum_item(elem, chn, ival) >= 0)
 				check_flag = 1;
-			/* skip separators */
-			while (*ptr == ',' || isspace(*ptr))
-				ptr++;
 		}
 	}
 	return check_flag;
-- 
2.1.0
