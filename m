From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] ALSA: firewire-lib: add missing description
	for kerneldoc
Date: Wed, 12 Nov 2014 22:55:27 +0900
Message-ID: <1415800527-5723-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id CF0972654E0
 for <alsa-devel@alsa-project.org>; Wed, 12 Nov 2014 14:55:41 +0100 (CET)
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

A description for second paramter for cmp_connection_check_used() is missing.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/cmp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/firewire/cmp.c b/sound/firewire/cmp.c
index ba8df5a..dcccb01 100644
--- a/sound/firewire/cmp.c
+++ b/sound/firewire/cmp.c
@@ -154,6 +154,7 @@ EXPORT_SYMBOL(cmp_connection_init);
 /**
  * cmp_connection_check_used - check connection is already esablished or not
  * @c: the connection manager to be checked
+ * @used: the pointer to store result to check the connection
  */
 int cmp_connection_check_used(struct cmp_connection *c, bool *used)
 {
-- 
2.1.0
