From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 3/5] amixer: expand local storage for item name
	according to kernel code
Date: Thu,  9 Apr 2015 01:30:56 +0900
Message-ID: <1428510659-30393-4-git-send-email-o-takashi@sakamocchi.jp>
References: <1428510659-30393-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 99A63265467
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

According to kernel code (snd_ctl_elem_init_enum_names() in
sound/core/control.c), the maximum length of item name is 63 characters
(+ 1 terminator = 64 bytes). But current amixer implementation
uses 40 bytes. This causes name truncation and fail to operation.

This commit fixes this bug by expanding the length of local variables.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 amixer/amixer.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/amixer/amixer.c b/amixer/amixer.c
index a3de375..65ebf20 100644
--- a/amixer/amixer.c
+++ b/amixer/amixer.c
@@ -812,7 +812,11 @@ static int show_selem(snd_mixer_t *handle, snd_mixer_selem_id_t *id, const char
 		if (snd_mixer_selem_is_enumerated(elem)) {
 			int i, items;
 			unsigned int idx;
-			char itemname[40];
+			/*
+			 * See snd_ctl_elem_init_enum_names() in
+			 * sound/core/control.c.
+			 */
+			char itemname[64];
 			items = snd_mixer_selem_get_enum_items(elem);
 			printf("  Items:");
 			for (i = 0; i < items; i++) {
@@ -1255,7 +1259,9 @@ static int get_enum_item_index(snd_mixer_elem_t *elem, char **ptrp)
 {
 	char *ptr = *ptrp;
 	int items, i, len;
-	char name[40];
+
+	/* See snd_ctl_elem_init_enum_names() in sound/core/control.c. */
+	char name[64];
 	
 	items = snd_mixer_selem_get_enum_items(elem);
 	if (items <= 0)
@@ -1264,6 +1270,7 @@ static int get_enum_item_index(snd_mixer_elem_t *elem, char **ptrp)
 	for (i = 0; i < items; i++) {
 		if (snd_mixer_selem_get_enum_item_name(elem, i, sizeof(name)-1, name) < 0)
 			continue;
+
 		len = strlen(name);
 		if (! strncmp(name, ptr, len)) {
 			if (! ptr[len] || ptr[len] == ',' || ptr[len] == '\n') {
-- 
2.1.0
