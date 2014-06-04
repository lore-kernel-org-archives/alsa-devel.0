From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 3/6] fireworks: Improve comments about
	Fireworks transaction
Date: Wed,  4 Jun 2014 15:25:34 +0900
Message-ID: <1401863137-15103-4-git-send-email-o-takashi@sakamocchi.jp>
References: <1401863137-15103-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id D8DF32650AE
 for <alsa-devel@alsa-project.org>; Wed,  4 Jun 2014 08:25:54 +0200 (CEST)
In-Reply-To: <1401863137-15103-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

It includes descriptions to cause misreading.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/fireworks/fireworks_transaction.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/firewire/fireworks/fireworks_transaction.c b/sound/firewire/fireworks/fireworks_transaction.c
index a6a9e9f..255dabc 100644
--- a/sound/firewire/fireworks/fireworks_transaction.c
+++ b/sound/firewire/fireworks/fireworks_transaction.c
@@ -8,19 +8,19 @@
 
 /*
  * Fireworks have its own transaction. The transaction can be delivered by AV/C
- * Vendor Specific command. But at least Windows driver and firmware version 5.5
- * or later don't use it.
+ * Vendor Specific command frame or usual asynchronous transaction. At least,
+ * Windows driver and firmware version 5.5 or later don't use AV/C command.
  *
  * Transaction substance:
- *  At first, 6 data exist. Following to the 6 data, parameters for each
- *  commands exists. All of parameters are 32 bit alighed to big endian.
+ *  At first, 6 data exist. Following to the data, parameters for each command
+ *  exist. All of the parameters are 32 bit alighed to big endian.
  *   data[0]:	Length of transaction substance
  *   data[1]:	Transaction version
  *   data[2]:	Sequence number. This is incremented by the device
- *   data[3]:	transaction category
- *   data[4]:	transaction command
- *   data[5]:	return value in response.
- *   data[6-]:	parameters
+ *   data[3]:	Transaction category
+ *   data[4]:	Transaction command
+ *   data[5]:	Return value in response.
+ *   data[6-]:	Parameters
  *
  * Transaction address:
  *  command:	0xecc000000000
-- 
1.8.3.2
