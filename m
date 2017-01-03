From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 2/3] ALSA: firewire-tascam: Fix to handle error
	from initialization of stream data
Date: Tue,  3 Jan 2017 11:58:33 +0900
Message-ID: <20170103025834.17159-3-o-takashi@sakamocchi.jp>
References: <20170103025834.17159-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id C1765266C9A
 for <alsa-devel@alsa-project.org>; Tue,  3 Jan 2017 03:58:40 +0100 (CET)
In-Reply-To: <20170103025834.17159-1-o-takashi@sakamocchi.jp>
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

This module has a bug not to return error code in a case that data
structure for transmitted packets fails to be initialized.

This commit fixes the bug.

Fixes: 35efa5c489de ("ALSA: firewire-tascam: add streaming functionality")
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/tascam/tascam-stream.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/firewire/tascam/tascam-stream.c b/sound/firewire/tascam/tascam-stream.c
index 4ad3bd7..f1657a4 100644
--- a/sound/firewire/tascam/tascam-stream.c
+++ b/sound/firewire/tascam/tascam-stream.c
@@ -343,7 +343,7 @@ int snd_tscm_stream_init_duplex(struct snd_tscm *tscm)
 	if (err < 0)
 		amdtp_stream_destroy(&tscm->rx_stream);
 
-	return 0;
+	return err;
 }
 
 /* At bus reset, streaming is stopped and some registers are clear. */
-- 
2.9.3
