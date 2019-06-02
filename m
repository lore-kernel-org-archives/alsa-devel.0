From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 13/15] ALSA: fireface: update isochronous
	resources when starting packet streaming after bus-reset
Date: Sun,  2 Jun 2019 16:12:57 +0900
Message-ID: <20190602071259.21622-14-o-takashi@sakamocchi.jp>
References: <20190602071259.21622-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AD416F8974A
 for <alsa-devel@alsa-project.org>; Sun,  2 Jun 2019 09:13:25 +0200 (CEST)
In-Reply-To: <20190602071259.21622-1-o-takashi@sakamocchi.jp>
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
isochronous resources. The nodes to restart packet streaming should
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
 sound/firewire/fireface/ff-protocol-former.c | 34 ++++++++++++++------
 sound/firewire/fireface/ff-protocol-latter.c | 11 +++++++
 sound/firewire/fireface/ff-stream.c          |  5 +--
 3 files changed, 36 insertions(+), 14 deletions(-)

diff --git a/sound/firewire/fireface/ff-protocol-former.c b/sound/firewire/fireface/ff-protocol-former.c
index 0517eb718f54..bf44cad7985e 100644
--- a/sound/firewire/fireface/ff-protocol-former.c
+++ b/sound/firewire/fireface/ff-protocol-former.c
@@ -374,8 +374,15 @@ static int ff800_allocate_resources(struct snd_ff *ff, unsigned int rate)
 
 static int ff800_begin_session(struct snd_ff *ff, unsigned int rate)
 {
+	unsigned int generation = ff->rx_resources.generation;
 	__le32 reg;
 
+	if (generation != fw_parent_device(ff->unit)->card->generation) {
+		int err = fw_iso_resources_update(&ff->rx_resources);
+		if (err < 0)
+			return err;
+	}
+
 	reg = cpu_to_le32(0x80000000);
 	reg |= cpu_to_le32(ff->tx_stream.data_block_quadlets);
 	if (fw_parent_device(ff->unit)->max_speed == SCODE_800)
@@ -480,13 +487,22 @@ static int ff400_allocate_resources(struct snd_ff *ff, unsigned int rate)
 
 static int ff400_begin_session(struct snd_ff *ff, unsigned int rate)
 {
+	unsigned int generation = ff->rx_resources.generation;
 	__le32 reg;
 	int err;
 
-	/*
-	 * Set isochronous channel and the number of quadlets of received
-	 * packets.
-	 */
+	if (generation != fw_parent_device(ff->unit)->card->generation) {
+		err = fw_iso_resources_update(&ff->tx_resources);
+		if (err < 0)
+			return err;
+
+		err = fw_iso_resources_update(&ff->rx_resources);
+		if (err < 0)
+			return err;
+	}
+
+	// Set isochronous channel and the number of quadlets of received
+	// packets.
 	reg = cpu_to_le32(((ff->rx_stream.data_block_quadlets << 3) << 8) |
 			  ff->rx_resources.channel);
 	err = snd_fw_transaction(ff->unit, TCODE_WRITE_QUADLET_REQUEST,
@@ -494,11 +510,9 @@ static int ff400_begin_session(struct snd_ff *ff, unsigned int rate)
 	if (err < 0)
 		return err;
 
-	/*
-	 * Set isochronous channel and the number of quadlets of transmitted
-	 * packet.
-	 */
-	/* TODO: investigate the purpose of this 0x80. */
+	// Set isochronous channel and the number of quadlets of transmitted
+	// packet.
+	// TODO: investigate the purpose of this 0x80.
 	reg = cpu_to_le32((0x80 << 24) |
 			  (ff->tx_resources.channel << 5) |
 			  (ff->tx_stream.data_block_quadlets));
@@ -507,7 +521,7 @@ static int ff400_begin_session(struct snd_ff *ff, unsigned int rate)
 	if (err < 0)
 		return err;
 
-	/* Allow to transmit packets. */
+	// Allow to transmit packets.
 	reg = cpu_to_le32(0x00000001);
 	return snd_fw_transaction(ff->unit, TCODE_WRITE_QUADLET_REQUEST,
 				 FF400_ISOC_COMM_START, &reg, sizeof(reg), 0);
diff --git a/sound/firewire/fireface/ff-protocol-latter.c b/sound/firewire/fireface/ff-protocol-latter.c
index 3d12ba5b2a9b..8d6ebb638e93 100644
--- a/sound/firewire/fireface/ff-protocol-latter.c
+++ b/sound/firewire/fireface/ff-protocol-latter.c
@@ -175,6 +175,7 @@ static int latter_allocate_resources(struct snd_ff *ff, unsigned int rate)
 
 static int latter_begin_session(struct snd_ff *ff, unsigned int rate)
 {
+	unsigned int generation = ff->rx_resources.generation;
 	unsigned int flag;
 	u32 data;
 	__le32 reg;
@@ -189,6 +190,16 @@ static int latter_begin_session(struct snd_ff *ff, unsigned int rate)
 	else
 		return -EINVAL;
 
+	if (generation != fw_parent_device(ff->unit)->card->generation) {
+		err = fw_iso_resources_update(&ff->tx_resources);
+		if (err < 0)
+			return err;
+
+		err = fw_iso_resources_update(&ff->rx_resources);
+		if (err < 0)
+			return err;
+	}
+
 	data = (ff->tx_resources.channel << 8) | ff->rx_resources.channel;
 	reg = cpu_to_le32(data);
 	err = snd_fw_transaction(ff->unit, TCODE_WRITE_QUADLET_REQUEST,
diff --git a/sound/firewire/fireface/ff-stream.c b/sound/firewire/fireface/ff-stream.c
index d9d1b469a8e9..4f40dfb11979 100644
--- a/sound/firewire/fireface/ff-stream.c
+++ b/sound/firewire/fireface/ff-stream.c
@@ -234,15 +234,12 @@ void snd_ff_stream_stop_duplex(struct snd_ff *ff)
 
 void snd_ff_stream_update_duplex(struct snd_ff *ff)
 {
-	/* The device discontinue to transfer packets.  */
+	// The device discontinue to transfer packets.
 	amdtp_stream_pcm_abort(&ff->tx_stream);
 	amdtp_stream_stop(&ff->tx_stream);
 
 	amdtp_stream_pcm_abort(&ff->rx_stream);
 	amdtp_stream_stop(&ff->rx_stream);
-
-	fw_iso_resources_update(&ff->tx_resources);
-	fw_iso_resources_update(&ff->rx_resources);
 }
 
 void snd_ff_stream_lock_changed(struct snd_ff *ff)
-- 
2.20.1
