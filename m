From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 4/5] ALSA: bebob: use correct type for __be32
	data
Date: Sun, 18 Oct 2015 22:39:52 +0900
Message-ID: <1445175593-11293-5-git-send-email-o-takashi@sakamocchi.jp>
References: <1445175593-11293-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 630B12619FB
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

In former commit, metering is supported for BeBoB based models
customized by M-Audio. The data in transaction is aligned to
big-endianness, while in the driver code u16 typed variable is assigned
to the data. This causes sparse warnings.

bebob_maudio.c:651:31: warning: cast to restricted __be16
bebob_maudio.c:651:31: warning: cast to restricted __be16
bebob_maudio.c:651:31: warning: cast to restricted __be16
bebob_maudio.c:651:31: warning: cast to restricted __be16

This commit fixes this bug by using __be16 variable for the data.

Fixes: 3149ac489ff8('ALSA: bebob: Add support for M-Audio special Firewire series')
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/bebob/bebob_maudio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/firewire/bebob/bebob_maudio.c b/sound/firewire/bebob/bebob_maudio.c
index 7b86a6b..07e5abd 100644
--- a/sound/firewire/bebob/bebob_maudio.c
+++ b/sound/firewire/bebob/bebob_maudio.c
@@ -628,7 +628,7 @@ static const char *const special_meter_labels[] = {
 static int
 special_meter_get(struct snd_bebob *bebob, u32 *target, unsigned int size)
 {
-	u16 *buf;
+	__be16 *buf;
 	unsigned int i, c, channels;
 	int err;
 
-- 
2.1.4
