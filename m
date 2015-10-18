From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 3/5] ALSA: fireworks: use u32 type for
	be32_to_cpup() macro
Date: Sun, 18 Oct 2015 22:39:51 +0900
Message-ID: <1445175593-11293-4-git-send-email-o-takashi@sakamocchi.jp>
References: <1445175593-11293-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 6501C261AAF
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

In former commit, snd_efw_command_get_phys_meters() was added to handle
metering data. The given buffer is used to save transaction result and to
convert between endianness. But this causes sparse warnings.

fireworks_command.c:269:25: warning: incorrect type in argument 1 (different base types)
fireworks_command.c:269:25:    expected unsigned int [usertype] *p
fireworks_command.c:269:25:    got restricted __be32 [usertype] *

This commit fixes this bug.

Fixes: bde8a8f23bbe('ALSA: fireworks: Add transaction and some commands')
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/fireworks/fireworks_command.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/firewire/fireworks/fireworks_command.c b/sound/firewire/fireworks/fireworks_command.c
index 166f805..94bab04 100644
--- a/sound/firewire/fireworks/fireworks_command.c
+++ b/sound/firewire/fireworks/fireworks_command.c
@@ -257,7 +257,7 @@ int snd_efw_command_get_phys_meters(struct snd_efw *efw,
 				    struct snd_efw_phys_meters *meters,
 				    unsigned int len)
 {
-	__be32 *buf = (__be32 *)meters;
+	u32 *buf = (u32 *)meters;
 	unsigned int i;
 	int err;
 
-- 
2.1.4
