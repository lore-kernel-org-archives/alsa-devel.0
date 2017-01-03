From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 1/3] ALSA: fireworks: fix asymmetric API call
	at unit removal
Date: Tue,  3 Jan 2017 11:58:32 +0900
Message-ID: <20170103025834.17159-2-o-takashi@sakamocchi.jp>
References: <20170103025834.17159-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id C28AB266CB0
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

ALSA fireworks driver has a bug not to call an API to destroy
'cmp_connection' structure for input direction. Currently this causes no
issues because it just destroys 'mutex' structure, while it's better to
fix it for future work.

Fix: d23c2cc4485d ("ALSA: fireworks/bebob/dice/oxfw: allow stream destructor after releasing runtime")
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/fireworks/fireworks_stream.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/firewire/fireworks/fireworks_stream.c b/sound/firewire/fireworks/fireworks_stream.c
index ee47924..827161b 100644
--- a/sound/firewire/fireworks/fireworks_stream.c
+++ b/sound/firewire/fireworks/fireworks_stream.c
@@ -117,7 +117,7 @@ destroy_stream(struct snd_efw *efw, struct amdtp_stream *stream)
 		conn = &efw->in_conn;
 
 	amdtp_stream_destroy(stream);
-	cmp_connection_destroy(&efw->out_conn);
+	cmp_connection_destroy(conn);
 }
 
 static int
-- 
2.9.3
