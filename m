From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] ALSA: dice: fix compiler warning due to
	returning uninitialized value
Date: Thu, 13 Jun 2019 12:35:22 +0900
Message-ID: <20190613033522.20856-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com
 [64.147.123.19])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 16FCCF80791
 for <alsa-devel@alsa-project.org>; Thu, 13 Jun 2019 05:35:31 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, kbuild test robot <lkp@intel.com>
List-Id: alsa-devel@alsa-project.org

This commit fixes the warning due to returning uninitialized value
from start_streams() helper function.

   sound/firewire/dice/dice-stream.c: In function 'start_streams.isra.0':
>> sound/firewire/dice/dice-stream.c:350:6: warning: 'err' may be used uninitialized in this function [-Wmaybe-uninitialized]
     int err;
         ^~~

Reported-by: kbuild test robot <lkp@intel.com>
Fixes: 3cd2c2d780a2 ("ALSA: dice: reserve/release isochronous resources in pcm.hw_params/hw_free callbacks")
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/dice/dice-stream.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/firewire/dice/dice-stream.c b/sound/firewire/dice/dice-stream.c
index f61b99a72655..e9e5c5fffb70 100644
--- a/sound/firewire/dice/dice-stream.c
+++ b/sound/firewire/dice/dice-stream.c
@@ -389,7 +389,7 @@ static int start_streams(struct snd_dice *dice, enum amdtp_stream_direction dir,
 			return err;
 	}
 
-	return err;
+	return 0;
 }
 
 /*
-- 
2.20.1
