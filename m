From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 8/8] ALSA: oxfw: ensure to release isochronous
	resources in pcm.hw_params callback
Date: Tue, 18 Jun 2019 22:26:22 +0900
Message-ID: <20190618132622.32659-9-o-takashi@sakamocchi.jp>
References: <20190618132622.32659-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 495B2F89732
 for <alsa-devel@alsa-project.org>; Tue, 18 Jun 2019 15:26:41 +0200 (CEST)
In-Reply-To: <20190618132622.32659-1-o-takashi@sakamocchi.jp>
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

When stopping packet streaming in reserve function for duplex streams,
isochronous resources should be released.

Fixes: 7bc93821a70a ("ALSA: firewire-lib: split allocation of isochronous resources from establishment of connection")
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/oxfw/oxfw-stream.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/firewire/oxfw/oxfw-stream.c b/sound/firewire/oxfw/oxfw-stream.c
index a8bc798731ff..a7502810a3ad 100644
--- a/sound/firewire/oxfw/oxfw-stream.c
+++ b/sound/firewire/oxfw/oxfw-stream.c
@@ -283,10 +283,12 @@ int snd_oxfw_stream_reserve_duplex(struct snd_oxfw *oxfw,
 	if (formation.rate != rate || formation.pcm != pcm_channels) {
 		amdtp_stream_stop(&oxfw->rx_stream);
 		cmp_connection_break(&oxfw->in_conn);
+		cmp_connection_release(&oxfw->in_conn);
 
 		if (oxfw->has_output) {
 			amdtp_stream_stop(&oxfw->tx_stream);
 			cmp_connection_break(&oxfw->out_conn);
+			cmp_connection_release(&oxfw->out_conn);
 		}
 	}
 
-- 
2.20.1
