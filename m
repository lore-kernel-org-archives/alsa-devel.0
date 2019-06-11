From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 06/12] ALSA: firewire-digi00x: update
	isochronous resources when starting packet streaming after bus-reset
Date: Tue, 11 Jun 2019 22:21:12 +0900
Message-ID: <20190611132118.8378-7-o-takashi@sakamocchi.jp>
References: <20190611132118.8378-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0A7C5F89730
 for <alsa-devel@alsa-project.org>; Tue, 11 Jun 2019 15:21:35 +0200 (CEST)
In-Reply-To: <20190611132118.8378-1-o-takashi@sakamocchi.jp>
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

After bus reset, isochronous resource manager releases all of allocated
isochronous resources. The nodes to transfer isochronous packet should
request reallocation of the resources.

However, between the bus-reset and invocation of 'struct fw_driver.update'
handler, ALSA PCM application can detect this situation by XRUN because
the target device cancelled to transmit packets once bus-reset occurs.

Due to the above mechanism, ALSA fireface driver just stops packet
streaming in the update handler, thus pcm.prepare handler should
request the reallocation.

This commit requests the reallocation in pcm.prepare callback when
bus generation is changed.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/digi00x/digi00x-stream.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/firewire/digi00x/digi00x-stream.c b/sound/firewire/digi00x/digi00x-stream.c
index 3b903e42d29a..3c5e1c5a2e11 100644
--- a/sound/firewire/digi00x/digi00x-stream.c
+++ b/sound/firewire/digi00x/digi00x-stream.c
@@ -303,6 +303,7 @@ void snd_dg00x_stream_release_duplex(struct snd_dg00x *dg00x)
 
 int snd_dg00x_stream_start_duplex(struct snd_dg00x *dg00x)
 {
+	unsigned int generation = dg00x->rx_resources.generation;
 	int err = 0;
 
 	if (dg00x->substreams_counter == 0)
@@ -312,6 +313,16 @@ int snd_dg00x_stream_start_duplex(struct snd_dg00x *dg00x)
 	    amdtp_streaming_error(&dg00x->rx_stream))
 		finish_session(dg00x);
 
+	if (generation != fw_parent_device(dg00x->unit)->card->generation) {
+		err = fw_iso_resources_update(&dg00x->tx_resources);
+		if (err < 0)
+			goto error;
+
+		err = fw_iso_resources_update(&dg00x->rx_resources);
+		if (err < 0)
+			goto error;
+	}
+
 	/*
 	 * No packets are transmitted without receiving packets, reagardless of
 	 * which source of clock is used.
-- 
2.20.1
