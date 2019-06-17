From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 09/10] ALSA: firewire-motu: update isochronous
	resources when starting packet streaming after bus-reset
Date: Mon, 17 Jun 2019 17:15:09 +0900
Message-ID: <20190617081510.11025-10-o-takashi@sakamocchi.jp>
References: <20190617081510.11025-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com
 [64.147.123.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 44AD6F896F9
 for <alsa-devel@alsa-project.org>; Mon, 17 Jun 2019 10:15:31 +0200 (CEST)
In-Reply-To: <20190617081510.11025-1-o-takashi@sakamocchi.jp>
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
 sound/firewire/motu/motu-stream.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/firewire/motu/motu-stream.c b/sound/firewire/motu/motu-stream.c
index 5630a8f1f2f1..82891583b736 100644
--- a/sound/firewire/motu/motu-stream.c
+++ b/sound/firewire/motu/motu-stream.c
@@ -236,6 +236,7 @@ static int ensure_packet_formats(struct snd_motu *motu)
 
 int snd_motu_stream_start_duplex(struct snd_motu *motu)
 {
+	unsigned int generation = motu->rx_resources.generation;
 	int err = 0;
 
 	if (motu->substreams_counter == 0)
@@ -245,6 +246,16 @@ int snd_motu_stream_start_duplex(struct snd_motu *motu)
 	    amdtp_streaming_error(&motu->tx_stream))
 		finish_session(motu);
 
+	if (generation != fw_parent_device(motu->unit)->card->generation) {
+		err = fw_iso_resources_update(&motu->rx_resources);
+		if (err < 0)
+			return err;
+
+		err = fw_iso_resources_update(&motu->tx_resources);
+		if (err < 0)
+			return err;
+	}
+
 	if (!amdtp_stream_running(&motu->rx_stream)) {
 		err = ensure_packet_formats(motu);
 		if (err < 0)
-- 
2.20.1
