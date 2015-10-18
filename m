From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 2/5] ALSA: dice: assign converted data to the
	same type of variable
Date: Sun, 18 Oct 2015 22:39:50 +0900
Message-ID: <1445175593-11293-3-git-send-email-o-takashi@sakamocchi.jp>
References: <1445175593-11293-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 66947264F30
 for <alsa-devel@alsa-project.org>; Sun, 18 Oct 2015 15:39:58 +0200 (CEST)
In-Reply-To: <1445175593-11293-1-git-send-email-o-takashi@sakamocchi.jp>
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

In former commit, u32 data was assigned to __be32 variable instead of an
int variable. This is not enough solution because it still causes sparse
warnings.

dice.c:80:23: warning: incorrect type in assignment (different base types)
dice.c:80:23:    expected restricted __be32 [usertype] value
dice.c:80:23:    got unsigned int
dice.c:81:21: warning: restricted __be32 degrades to integer
dice.c:81:46: warning: restricted __be32 degrades to integer

This commit fixes this bug.

Fixes: 7c2d4c0cf5ba('ALSA: dice: Split transaction functionality into a file')
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/dice/dice.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/firewire/dice/dice.c b/sound/firewire/dice/dice.c
index 70a111d..5d99436 100644
--- a/sound/firewire/dice/dice.c
+++ b/sound/firewire/dice/dice.c
@@ -29,7 +29,8 @@ static int dice_interface_check(struct fw_unit *unit)
 	struct fw_csr_iterator it;
 	int key, val, vendor = -1, model = -1, err;
 	unsigned int category, i;
-	__be32 *pointers, value;
+	__be32 *pointers;
+	u32 value;
 	__be32 version;
 
 	pointers = kmalloc_array(ARRAY_SIZE(min_values), sizeof(__be32),
-- 
2.1.4
