From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 09/15] ALSA: fireface: support
	allocate_resources operation in ff800 protocol
Date: Sun,  2 Jun 2019 16:12:53 +0900
Message-ID: <20190602071259.21622-10-o-takashi@sakamocchi.jp>
References: <20190602071259.21622-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8A8A7F89739
 for <alsa-devel@alsa-project.org>; Sun,  2 Jun 2019 09:13:19 +0200 (CEST)
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

This commit implements allocate_resources callback for ff800 protocol.
As I noted in commit fc716397a5c7 ("ALSA: fireface: add support for
packet streaming on Fireface 800"), this unit allocates isochronous
resources for tx stream voluntarily. Therefore, this commit is to
maintain isochronous rsources for rx stream. In the callback,
sampling transfer frequency is configured to the device as well.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/fireface/ff-protocol-former.c | 46 ++++++++++----------
 1 file changed, 22 insertions(+), 24 deletions(-)

diff --git a/sound/firewire/fireface/ff-protocol-former.c b/sound/firewire/fireface/ff-protocol-former.c
index 8d1c2c6e907b..11575d17d6cc 100644
--- a/sound/firewire/fireface/ff-protocol-former.c
+++ b/sound/firewire/fireface/ff-protocol-former.c
@@ -293,27 +293,6 @@ static int former_fill_midi_msg(struct snd_ff *ff,
 
 #define FF800_TX_PACKET_ISOC_CH	0x0000801c0008
 
-static int allocate_rx_resources(struct snd_ff *ff)
-{
-	u32 data;
-	__le32 reg;
-	int err;
-
-	// Controllers should allocate isochronous resources for rx stream.
-	err = fw_iso_resources_allocate(&ff->rx_resources,
-				amdtp_stream_get_max_payload(&ff->rx_stream),
-				fw_parent_device(ff->unit)->max_speed);
-	if (err < 0)
-		return err;
-
-	// Set isochronous channel and the number of quadlets of rx packets.
-	data = ff->rx_stream.data_block_quadlets << 3;
-	data = (data << 8) | ff->rx_resources.channel;
-	reg = cpu_to_le32(data);
-	return snd_fw_transaction(ff->unit, TCODE_WRITE_QUADLET_REQUEST,
-				FF800_RX_PACKET_FORMAT, &reg, sizeof(reg), 0);
-}
-
 static int allocate_tx_resources(struct snd_ff *ff)
 {
 	__le32 reg;
@@ -355,8 +334,9 @@ static int allocate_tx_resources(struct snd_ff *ff)
 	return 0;
 }
 
-static int ff800_begin_session(struct snd_ff *ff, unsigned int rate)
+static int ff800_allocate_resources(struct snd_ff *ff, unsigned int rate)
 {
+	u32 data;
 	__le32 reg;
 	int err;
 
@@ -371,14 +351,31 @@ static int ff800_begin_session(struct snd_ff *ff, unsigned int rate)
 	// Let's sleep for a bit.
 	msleep(100);
 
-	err = allocate_rx_resources(ff);
+	// Controllers should allocate isochronous resources for rx stream.
+	err = fw_iso_resources_allocate(&ff->rx_resources,
+				amdtp_stream_get_max_payload(&ff->rx_stream),
+				fw_parent_device(ff->unit)->max_speed);
 	if (err < 0)
 		return err;
 
-	err = allocate_tx_resources(ff);
+	// Set isochronous channel and the number of quadlets of rx packets.
+	// This should be done before the allocation of tx resources to avoid
+	// periodical noise.
+	data = ff->rx_stream.data_block_quadlets << 3;
+	data = (data << 8) | ff->rx_resources.channel;
+	reg = cpu_to_le32(data);
+	err = snd_fw_transaction(ff->unit, TCODE_WRITE_QUADLET_REQUEST,
+				 FF800_RX_PACKET_FORMAT, &reg, sizeof(reg), 0);
 	if (err < 0)
 		return err;
 
+	return allocate_tx_resources(ff);
+}
+
+static int ff800_begin_session(struct snd_ff *ff, unsigned int rate)
+{
+	__le32 reg;
+
 	reg = cpu_to_le32(0x80000000);
 	reg |= cpu_to_le32(ff->tx_stream.data_block_quadlets);
 	if (fw_parent_device(ff->unit)->max_speed == SCODE_800)
@@ -420,6 +417,7 @@ const struct snd_ff_protocol snd_ff_protocol_ff800 = {
 	.fill_midi_msg		= former_fill_midi_msg,
 	.get_clock		= former_get_clock,
 	.switch_fetching_mode	= former_switch_fetching_mode,
+	.allocate_resources	= ff800_allocate_resources,
 	.begin_session		= ff800_begin_session,
 	.finish_session		= ff800_finish_session,
 	.dump_status		= former_dump_status,
-- 
2.20.1
