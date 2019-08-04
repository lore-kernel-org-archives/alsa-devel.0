From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 06/19] ALSA: fireworks: code refactoring for
	bus reset handler
Date: Sun,  4 Aug 2019 15:21:25 +0900
Message-ID: <20190804062138.1217-7-o-takashi@sakamocchi.jp>
References: <20190804062138.1217-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CC6B5F800F3
 for <alsa-devel@alsa-project.org>; Sun,  4 Aug 2019 08:21:52 +0200 (CEST)
In-Reply-To: <20190804062138.1217-1-o-takashi@sakamocchi.jp>
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

This commit is a preparation to support AMDTP domain.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/fireworks/fireworks_stream.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/sound/firewire/fireworks/fireworks_stream.c b/sound/firewire/fireworks/fireworks_stream.c
index 0f62c50055e9..af340491dc43 100644
--- a/sound/firewire/fireworks/fireworks_stream.c
+++ b/sound/firewire/fireworks/fireworks_stream.c
@@ -299,14 +299,11 @@ void snd_efw_stream_stop_duplex(struct snd_efw *efw)
 
 void snd_efw_stream_update_duplex(struct snd_efw *efw)
 {
-	if (cmp_connection_update(&efw->out_conn) < 0 ||
-	    cmp_connection_update(&efw->in_conn) < 0) {
-		stop_stream(efw, &efw->rx_stream);
-		stop_stream(efw, &efw->tx_stream);
-	} else {
-		amdtp_stream_update(&efw->rx_stream);
-		amdtp_stream_update(&efw->tx_stream);
-	}
+	stop_stream(efw, &efw->rx_stream);
+	stop_stream(efw, &efw->tx_stream);
+
+	amdtp_stream_pcm_abort(&efw->rx_stream);
+	amdtp_stream_pcm_abort(&efw->tx_stream);
 }
 
 void snd_efw_stream_destroy_duplex(struct snd_efw *efw)
-- 
2.20.1
