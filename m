From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 6/8] ALSA: bebob: ensure to release isochronous
	resources in pcm.hw_params callback
Date: Tue, 18 Jun 2019 22:26:20 +0900
Message-ID: <20190618132622.32659-7-o-takashi@sakamocchi.jp>
References: <20190618132622.32659-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2D4D3F8971F
 for <alsa-devel@alsa-project.org>; Tue, 18 Jun 2019 15:26:38 +0200 (CEST)
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
 sound/firewire/bebob/bebob_stream.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/firewire/bebob/bebob_stream.c b/sound/firewire/bebob/bebob_stream.c
index 1070a675179d..63e78fc8711d 100644
--- a/sound/firewire/bebob/bebob_stream.c
+++ b/sound/firewire/bebob/bebob_stream.c
@@ -571,6 +571,9 @@ int snd_bebob_stream_reserve_duplex(struct snd_bebob *bebob, unsigned int rate)
 		amdtp_stream_stop(&bebob->rx_stream);
 
 		break_both_connections(bebob);
+
+		cmp_connection_release(&bebob->out_conn);
+		cmp_connection_release(&bebob->in_conn);
 	}
 
 	if (bebob->substreams_counter == 0 || curr_rate != rate) {
-- 
2.20.1
