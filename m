From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 10/15] ALSA: fireface: support
	allocate_resources operation in ff400 protocol
Date: Sun,  2 Jun 2019 16:12:54 +0900
Message-ID: <20190602071259.21622-11-o-takashi@sakamocchi.jp>
References: <20190602071259.21622-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 26048F8973B
 for <alsa-devel@alsa-project.org>; Sun,  2 Jun 2019 09:13:21 +0200 (CEST)
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

This commit is a part of preparation to perform allocation/release
of isochronous channels in pcm.hw_params/hw_free callbacks.

This commit implements allocate_resources callback for ff400 protocol.
In this callback, sampling transfer frequency is configured to the
device as well.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/fireface/ff-protocol-former.c | 36 +++++++++-----------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/sound/firewire/fireface/ff-protocol-former.c b/sound/firewire/fireface/ff-protocol-former.c
index 11575d17d6cc..0517eb718f54 100644
--- a/sound/firewire/fireface/ff-protocol-former.c
+++ b/sound/firewire/fireface/ff-protocol-former.c
@@ -429,12 +429,11 @@ const struct snd_ff_protocol snd_ff_protocol_ff800 = {
 #define FF400_TX_PACKET_FORMAT	0x00008010050cull
 #define FF400_ISOC_COMM_STOP	0x000080100510ull
 
-/*
- * Fireface 400 manages isochronous channel number in 3 bit field. Therefore,
- * we can allocate between 0 and 7 channel.
- */
-static int keep_resources(struct snd_ff *ff, unsigned int rate)
+// Fireface 400 manages isochronous channel number in 3 bit field. Therefore,
+// we can allocate between 0 and 7 channel.
+static int ff400_allocate_resources(struct snd_ff *ff, unsigned int rate)
 {
+	__le32 reg;
 	enum snd_ff_stream_mode mode;
 	int i;
 	int err;
@@ -447,11 +446,20 @@ static int keep_resources(struct snd_ff *ff, unsigned int rate)
 	if (i >= CIP_SFC_COUNT)
 		return -EINVAL;
 
+	// Set the number of data blocks transferred in a second.
+	reg = cpu_to_le32(rate);
+	err = snd_fw_transaction(ff->unit, TCODE_WRITE_QUADLET_REQUEST,
+				 FF400_STF, &reg, sizeof(reg), 0);
+	if (err < 0)
+		return err;
+
+	msleep(100);
+
 	err = snd_ff_stream_get_multiplier_mode(i, &mode);
 	if (err < 0)
 		return err;
 
-	/* Keep resources for in-stream. */
+	// Keep resources for in-stream.
 	ff->tx_resources.channels_mask = 0x00000000000000ffuLL;
 	err = fw_iso_resources_allocate(&ff->tx_resources,
 			amdtp_stream_get_max_payload(&ff->tx_stream),
@@ -459,7 +467,7 @@ static int keep_resources(struct snd_ff *ff, unsigned int rate)
 	if (err < 0)
 		return err;
 
-	/* Keep resources for out-stream. */
+	// Keep resources for out-stream.
 	ff->rx_resources.channels_mask = 0x00000000000000ffuLL;
 	err = fw_iso_resources_allocate(&ff->rx_resources,
 			amdtp_stream_get_max_payload(&ff->rx_stream),
@@ -475,19 +483,6 @@ static int ff400_begin_session(struct snd_ff *ff, unsigned int rate)
 	__le32 reg;
 	int err;
 
-	err = keep_resources(ff, rate);
-	if (err < 0)
-		return err;
-
-	/* Set the number of data blocks transferred in a second. */
-	reg = cpu_to_le32(rate);
-	err = snd_fw_transaction(ff->unit, TCODE_WRITE_QUADLET_REQUEST,
-				 FF400_STF, &reg, sizeof(reg), 0);
-	if (err < 0)
-		return err;
-
-	msleep(100);
-
 	/*
 	 * Set isochronous channel and the number of quadlets of received
 	 * packets.
@@ -589,6 +584,7 @@ const struct snd_ff_protocol snd_ff_protocol_ff400 = {
 	.fill_midi_msg		= former_fill_midi_msg,
 	.get_clock		= former_get_clock,
 	.switch_fetching_mode	= former_switch_fetching_mode,
+	.allocate_resources	= ff400_allocate_resources,
 	.begin_session		= ff400_begin_session,
 	.finish_session		= ff400_finish_session,
 	.dump_status		= former_dump_status,
-- 
2.20.1
