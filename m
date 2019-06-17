From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 03/10] ALSA: firewire-motu: add helper function
	to keep isochronous resources
Date: Mon, 17 Jun 2019 17:15:03 +0900
Message-ID: <20190617081510.11025-4-o-takashi@sakamocchi.jp>
References: <20190617081510.11025-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com
 [64.147.123.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 69644F8075C
 for <alsa-devel@alsa-project.org>; Mon, 17 Jun 2019 10:15:22 +0200 (CEST)
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

This commit is a part of preparation to perform allocation/release
of isochronous resources in pcm.hw_params/hw_free callbacks.

This commit adds a helper function to allocate isochronous resources.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/motu/motu-stream.c | 57 +++++++++++++++++--------------
 1 file changed, 32 insertions(+), 25 deletions(-)

diff --git a/sound/firewire/motu/motu-stream.c b/sound/firewire/motu/motu-stream.c
index c136d7f8c49c..35b4e0f72fe2 100644
--- a/sound/firewire/motu/motu-stream.c
+++ b/sound/firewire/motu/motu-stream.c
@@ -26,48 +26,55 @@
 #define  RX_PACKET_EXCLUDE_DIFFERED_DATA_CHUNKS	0x00000040
 #define  TX_PACKET_TRANSMISSION_SPEED_MASK	0x0000000f
 
-static int start_both_streams(struct snd_motu *motu, unsigned int rate)
+static int keep_resources(struct snd_motu *motu, unsigned int rate,
+			  struct amdtp_stream *stream)
 {
+	struct fw_iso_resources *resources;
+	struct snd_motu_packet_format *packet_format;
 	unsigned int midi_ports = 0;
-	__be32 reg;
-	u32 data;
 	int err;
 
-	if ((motu->spec->flags & SND_MOTU_SPEC_RX_MIDI_2ND_Q) ||
-	    (motu->spec->flags & SND_MOTU_SPEC_RX_MIDI_3RD_Q))
-		midi_ports = 1;
+	if (stream == &motu->rx_stream) {
+		resources = &motu->rx_resources;
+		packet_format = &motu->rx_packet_formats;
 
-	/* Set packet formation to our packet streaming engine. */
-	err = amdtp_motu_set_parameters(&motu->rx_stream, rate, midi_ports,
-					&motu->rx_packet_formats);
-	if (err < 0)
-		return err;
+		if ((motu->spec->flags & SND_MOTU_SPEC_RX_MIDI_2ND_Q) ||
+		    (motu->spec->flags & SND_MOTU_SPEC_RX_MIDI_3RD_Q))
+			midi_ports = 1;
+	} else {
+		resources = &motu->tx_resources;
+		packet_format = &motu->tx_packet_formats;
 
-	if ((motu->spec->flags & SND_MOTU_SPEC_TX_MIDI_2ND_Q) ||
-	    (motu->spec->flags & SND_MOTU_SPEC_TX_MIDI_3RD_Q))
-		midi_ports = 1;
-	else
-		midi_ports = 0;
+		if ((motu->spec->flags & SND_MOTU_SPEC_TX_MIDI_2ND_Q) ||
+		    (motu->spec->flags & SND_MOTU_SPEC_TX_MIDI_3RD_Q))
+			midi_ports = 1;
+	}
 
-	err = amdtp_motu_set_parameters(&motu->tx_stream, rate, midi_ports,
-					&motu->tx_packet_formats);
+	err = amdtp_motu_set_parameters(stream, rate, midi_ports,
+					packet_format);
 	if (err < 0)
 		return err;
 
-	/* Get isochronous resources on the bus. */
-	err = fw_iso_resources_allocate(&motu->rx_resources,
-				amdtp_stream_get_max_payload(&motu->rx_stream),
+	return fw_iso_resources_allocate(resources,
+				amdtp_stream_get_max_payload(stream),
 				fw_parent_device(motu->unit)->max_speed);
+}
+
+static int start_both_streams(struct snd_motu *motu, unsigned int rate)
+{
+	__be32 reg;
+	u32 data;
+	int err;
+
+	err = keep_resources(motu, rate, &motu->tx_stream);
 	if (err < 0)
 		return err;
 
-	err = fw_iso_resources_allocate(&motu->tx_resources,
-				amdtp_stream_get_max_payload(&motu->tx_stream),
-				fw_parent_device(motu->unit)->max_speed);
+	err = keep_resources(motu, rate, &motu->rx_stream);
 	if (err < 0)
 		return err;
 
-	/* Configure the unit to start isochronous communication. */
+	// Configure the unit to start isochronous communication.
 	err = snd_motu_transaction_read(motu, ISOC_COMM_CONTROL_OFFSET, &reg,
 					sizeof(reg));
 	if (err < 0)
-- 
2.20.1
