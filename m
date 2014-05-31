From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] bebob: Use ARRAY_SIZE() instead of sizeof()
	for return condition
Date: Sat, 31 May 2014 15:33:52 +0900
Message-ID: <1401518032-7223-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 9BE2E2650C2
 for <alsa-devel@alsa-project.org>; Sat, 31 May 2014 08:33:59 +0200 (CEST)
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

The parser for stream format information should return when detecting wrong
value for sampling rate. But it doesn't.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/bebob/bebob_stream.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/firewire/bebob/bebob_stream.c b/sound/firewire/bebob/bebob_stream.c
index 514c7c9..bc4f827 100644
--- a/sound/firewire/bebob/bebob_stream.c
+++ b/sound/firewire/bebob/bebob_stream.c
@@ -749,7 +749,7 @@ parse_stream_formation(u8 *buf, unsigned int len,
 		if (buf[2] == bridgeco_freq_table[i])
 			break;
 	}
-	if (i == sizeof(bridgeco_freq_table))
+	if (i == ARRAY_SIZE(bridgeco_freq_table))
 		return -ENOSYS;
 
 	/* Avoid double count by different entries for the same rate. */
-- 
1.8.3.2
