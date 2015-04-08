From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 5/5] amixer: use the same characters for
	separator.
Date: Thu,  9 Apr 2015 01:30:58 +0900
Message-ID: <1428510659-30393-6-git-send-email-o-takashi@sakamocchi.jp>
References: <1428510659-30393-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 57A5F2654BF
 for <alsa-devel@alsa-project.org>; Wed,  8 Apr 2015 18:31:13 +0200 (CEST)
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

The arguments are parsed as the value of each channel for enumerated
element in sset_enum() and get_enum_item_index(), the former is
a caller and the latter is a callee. Both of them evaluate the string
but use different characters for separator. This brings just cofusion
to users.

This commit fix this bug, by changing callee's characters according to
caller's characters.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 amixer/amixer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/amixer/amixer.c b/amixer/amixer.c
index aec8d01..fa4bde1 100644
--- a/amixer/amixer.c
+++ b/amixer/amixer.c
@@ -1276,8 +1276,8 @@ static int get_enum_item_index(snd_mixer_elem_t *elem, char **ptrp)
 		if (strncmp(name, ptr, len) != 0)
 			continue;
 
-		/* Lack of separators between channels. */
-		if (ptr[len] != '\0' && ptr[len] != ',' && ptr[len] != '\n')
+		/* Lack of string terminator and separator between channels. */
+		if (ptr[len] != '\0' && ptr[len] != ',' && !isspace(ptr[len]))
 			continue;
 
 		/* OK. The string is exactly one of items. */
-- 
2.1.0
