From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 14/19] ALSA: oxfw: break packet streaming at
	bus-reset handler
Date: Wed, 12 Jun 2019 17:44:17 +0900
Message-ID: <20190612084422.5344-15-o-takashi@sakamocchi.jp>
References: <20190612084422.5344-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com
 [64.147.123.20])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 231CCF8973E
 for <alsa-devel@alsa-project.org>; Wed, 12 Jun 2019 10:44:50 +0200 (CEST)
In-Reply-To: <20190612084422.5344-1-o-takashi@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

In most cases, recovery from bus reset is not successful. This commit
aborts packet streaming in bus reset handler.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/oxfw/oxfw-stream.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/sound/firewire/oxfw/oxfw-stream.c b/sound/firewire/oxfw/oxfw-stream.c
index bb4ba6c196ea..806a7fded99d 100644
--- a/sound/firewire/oxfw/oxfw-stream.c
+++ b/sound/firewire/oxfw/oxfw-stream.c
@@ -363,17 +363,10 @@ void snd_oxfw_stream_destroy_simplex(struct snd_oxfw *oxfw,
 void snd_oxfw_stream_update_simplex(struct snd_oxfw *oxfw,
 				    struct amdtp_stream *stream)
 {
-	struct cmp_connection *conn;
-
-	if (stream == &oxfw->tx_stream)
-		conn = &oxfw->out_conn;
-	else
-		conn = &oxfw->in_conn;
+	stop_stream(oxfw, &oxfw->rx_stream);
 
-	if (cmp_connection_update(conn) < 0)
-		stop_stream(oxfw, stream);
-	else
-		amdtp_stream_update(stream);
+	if (oxfw->has_output)
+		stop_stream(oxfw, &oxfw->tx_stream);
 }
 
 int snd_oxfw_stream_get_current_formation(struct snd_oxfw *oxfw,
-- 
2.20.1
