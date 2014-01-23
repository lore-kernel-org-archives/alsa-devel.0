From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: Refactor slot assignment code
Date: Thu, 23 Jan 2014 11:48:59 +0100
Message-ID: <1390474139-26108-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 76B8F264E9F
 for <alsa-devel@alsa-project.org>; Thu, 23 Jan 2014 11:48:59 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 61842AC5B
 for <alsa-devel@alsa-project.org>; Thu, 23 Jan 2014 10:48:59 +0000 (UTC)
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
List-Id: alsa-devel@alsa-project.org

There are two loops that are almost identical but only with different
checks.  Refactor them with a simple helper, and give a bit more
comments what's doing there.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/init.c | 57 +++++++++++++++++++++++++++++--------------------------
 1 file changed, 30 insertions(+), 27 deletions(-)

diff --git a/sound/core/init.c b/sound/core/init.c
index e3c93cd77ee7..0d42fcda0de2 100644
--- a/sound/core/init.c
+++ b/sound/core/init.c
@@ -131,6 +131,31 @@ static inline int init_info_for_card(struct snd_card *card)
 #define init_info_for_card(card)
 #endif
 
+static int check_empty_slot(struct module *module, int slot)
+{
+	return !slots[slot] || !*slots[slot];
+}
+
+/* return an empty slot number (>= 0) found in the given bitmask @mask.
+ * @mask == -1 == 0xffffffff means: take any free slot up to 32
+ * when no slot is available, return the original @mask as is.
+ */
+static int get_slot_from_bitmask(int mask, int (*check)(struct module *, int),
+				 struct module *module)
+{
+	int slot;
+
+	for (slot = 0; slot < SNDRV_CARDS; slot++) {
+		if (slot < 32 && !(mask & (1U << slot)))
+			continue;
+		if (!test_bit(slot, snd_cards_lock)) {
+			if (check(module, slot))
+				return slot; /* found */
+		}
+	}
+	return mask; /* unchanged */
+}
+
 /**
  *  snd_card_create - create and initialize a soundcard structure
  *  @idx: card index (address) [0 ... (SNDRV_CARDS-1)]
@@ -152,7 +177,7 @@ int snd_card_create(int idx, const char *xid,
 		    struct snd_card **card_ret)
 {
 	struct snd_card *card;
-	int err, idx2;
+	int err;
 
 	if (snd_BUG_ON(!card_ret))
 		return -EINVAL;
@@ -167,32 +192,10 @@ int snd_card_create(int idx, const char *xid,
 		strlcpy(card->id, xid, sizeof(card->id));
 	err = 0;
 	mutex_lock(&snd_card_mutex);
-	if (idx < 0) {
-		for (idx2 = 0; idx2 < SNDRV_CARDS; idx2++) {
-			/* idx == -1 == 0xffff means: take any free slot */
-			if (idx2 < 32 && !(idx & (1U << idx2)))
-				continue;
-			if (!test_bit(idx2, snd_cards_lock)) {
-				if (module_slot_match(module, idx2)) {
-					idx = idx2;
-					break;
-				}
-			}
-		}
-	}
-	if (idx < 0) {
-		for (idx2 = 0; idx2 < SNDRV_CARDS; idx2++) {
-			/* idx == -1 == 0xffff means: take any free slot */
-			if (idx2 < 32 && !(idx & (1U << idx2)))
-				continue;
-			if (!test_bit(idx2, snd_cards_lock)) {
-				if (!slots[idx2] || !*slots[idx2]) {
-					idx = idx2;
-					break;
-				}
-			}
-		}
-	}
+	if (idx < 0) /* first check the matching module-name slot */
+		idx = get_slot_from_bitmask(idx, module_slot_match, module);
+	if (idx < 0) /* if not matched, assign an empty slot */
+		idx = get_slot_from_bitmask(idx, check_empty_slot, module);
 	if (idx < 0)
 		err = -ENODEV;
 	else if (idx < snd_ecards_limit) {
-- 
1.8.5.2
