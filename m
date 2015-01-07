From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] ALSA: fireworks: fix an endianness bug for
	transaction length
Date: Thu,  8 Jan 2015 00:31:16 +0900
Message-ID: <1420644676-29863-1-git-send-email-o-takashi@sakamocchi.jp>
References: <5484C572.7040606@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id 564DF26054F
 for <alsa-devel@alsa-project.org>; Wed,  7 Jan 2015 16:31:21 +0100 (CET)
In-Reply-To: <5484C572.7040606@ladisch.de>
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

Although the 't->length' is a big-endian value, it's used without any
conversion. This means that the driver always uses 'length' parameter.

Fixes: 555e8a8f7f14("ALSA: fireworks: Add command/response functionality into hwdep interface")
Reported-by: Clemens Ladisch <clemens@ladisch.de>
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/fireworks/fireworks_transaction.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/firewire/fireworks/fireworks_transaction.c b/sound/firewire/fireworks/fireworks_transaction.c
index 255dabc..2a85e42 100644
--- a/sound/firewire/fireworks/fireworks_transaction.c
+++ b/sound/firewire/fireworks/fireworks_transaction.c
@@ -124,7 +124,7 @@ copy_resp_to_buf(struct snd_efw *efw, void *data, size_t length, int *rcode)
 	spin_lock_irq(&efw->lock);
 
 	t = (struct snd_efw_transaction *)data;
-	length = min_t(size_t, t->length * sizeof(t->length), length);
+	length = min_t(size_t, be32_to_cpu(t->length) * sizeof(u32), length);
 
 	if (efw->push_ptr < efw->pull_ptr)
 		capacity = (unsigned int)(efw->pull_ptr - efw->push_ptr);
-- 
2.1.0
