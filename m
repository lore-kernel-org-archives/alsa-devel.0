From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 03/13] dice: Split transaction
	functionality into a file
Date: Tue, 27 May 2014 12:42:10 +0900
Message-ID: <53840992.9000704@sakamocchi.jp>
References: <1400420198-24312-1-git-send-email-o-takashi@sakamocchi.jp>
 <1400420198-24312-4-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040504000706010002050408"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 75A252654B9
 for <alsa-devel@alsa-project.org>; Tue, 27 May 2014 05:42:16 +0200 (CEST)
In-Reply-To: <1400420198-24312-4-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------040504000706010002050408
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

This patch includes two bugs. Please apply attached fixup.


Regards

Takashi Sakamoto
o-takashi@sakamocchi.jp


--------------040504000706010002050408
Content-Type: text/x-diff;
 name="0084-fixup-for-PATCH-03-13.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0084-fixup-for-PATCH-03-13.patch"

>From 59777bb80164e54611a933ed090d67772e5b458b Mon Sep 17 00:00:00 2001
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Date: Tue, 27 May 2014 02:27:04 +0900
Subject: fixup for [PATCH 03/13]

fix wrong type of variable for function argument, and prevent from narrowing
conversion.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/dice/dice.c             | 8 ++++----
 sound/firewire/dice/dice_transaction.c | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/firewire/dice/dice.c b/sound/firewire/dice/dice.c
index f410030..a0172a7 100644
--- a/sound/firewire/dice/dice.c
+++ b/sound/firewire/dice/dice.c
@@ -865,7 +865,7 @@ static int dice_interface_check(struct fw_unit *unit)
 	};
 	struct fw_device *device = fw_parent_device(unit);
 	struct fw_csr_iterator it;
-	int key, vendor = -1, model = -1, err;
+	int key, val, vendor = -1, model = -1, err;
 	unsigned int category, i;
 	__be32 *pointers, value;
 	__be32 tx_data[4];
@@ -882,13 +882,13 @@ static int dice_interface_check(struct fw_unit *unit)
 	 * ID, and a 22-bit serial number.
 	 */
 	fw_csr_iterator_init(&it, unit->directory);
-	while (fw_csr_iterator_next(&it, &key, &value)) {
+	while (fw_csr_iterator_next(&it, &key, &val)) {
 		switch (key) {
 		case CSR_SPECIFIER_ID:
-			vendor = value;
+			vendor = val;
 			break;
 		case CSR_MODEL:
-			model = value;
+			model = val;
 			break;
 		}
 	}
diff --git a/sound/firewire/dice/dice_transaction.c b/sound/firewire/dice/dice_transaction.c
index 90773b8..1ac249a 100644
--- a/sound/firewire/dice/dice_transaction.c
+++ b/sound/firewire/dice/dice_transaction.c
@@ -12,7 +12,7 @@
 #define NOTIFICATION_TIMEOUT_MS	100
 
 static u64 get_subaddr(struct snd_dice *dice, enum snd_dice_addr_type type,
-		       unsigned int offset)
+		       u64 offset)
 {
 	switch (type) {
 	case SND_DICE_ADDR_TYPE_TX:
-- 
1.8.3.2


--------------040504000706010002050408
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------040504000706010002050408--
