From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 01/15] ALSA: firewire-tascam: code refactoring
	for registration of isochronous channels
Date: Sun,  2 Jun 2019 16:12:45 +0900
Message-ID: <20190602071259.21622-2-o-takashi@sakamocchi.jp>
References: <20190602071259.21622-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D7CADF80CC4
 for <alsa-devel@alsa-project.org>; Sun,  2 Jun 2019 09:13:07 +0200 (CEST)
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

The registration of isochronous channels is done just after allocation
of isochronous resources. This commit separates the registration just
before starting packet streaming.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/tascam/tascam-stream.c | 84 +++++++++++++--------------
 1 file changed, 40 insertions(+), 44 deletions(-)

diff --git a/sound/firewire/tascam/tascam-stream.c b/sound/firewire/tascam/tascam-stream.c
index f1657a4e0621..7cddd9ece4ee 100644
--- a/sound/firewire/tascam/tascam-stream.c
+++ b/sound/firewire/tascam/tascam-stream.c
@@ -195,6 +195,19 @@ static void finish_session(struct snd_tscm *tscm)
 			   TSCM_ADDR_BASE + TSCM_OFFSET_ISOC_RX_ON,
 			   &reg, sizeof(reg), 0);
 
+	// Unregister channels.
+	reg = cpu_to_be32(0x00000000);
+	snd_fw_transaction(tscm->unit, TCODE_WRITE_QUADLET_REQUEST,
+			   TSCM_ADDR_BASE + TSCM_OFFSET_ISOC_TX_CH,
+			   &reg, sizeof(reg), 0);
+	reg = cpu_to_be32(0x00000000);
+	snd_fw_transaction(tscm->unit, TCODE_WRITE_QUADLET_REQUEST,
+			   TSCM_ADDR_BASE + TSCM_OFFSET_UNKNOWN,
+			   &reg, sizeof(reg), 0);
+	reg = cpu_to_be32(0x00000000);
+	snd_fw_transaction(tscm->unit, TCODE_WRITE_QUADLET_REQUEST,
+			   TSCM_ADDR_BASE + TSCM_OFFSET_ISOC_RX_CH,
+			   &reg, sizeof(reg), 0);
 }
 
 static int begin_session(struct snd_tscm *tscm)
@@ -202,6 +215,30 @@ static int begin_session(struct snd_tscm *tscm)
 	__be32 reg;
 	int err;
 
+	// Register the isochronous channel for transmitting stream.
+	reg = cpu_to_be32(tscm->tx_resources.channel);
+	err = snd_fw_transaction(tscm->unit, TCODE_WRITE_QUADLET_REQUEST,
+				 TSCM_ADDR_BASE + TSCM_OFFSET_ISOC_TX_CH,
+				 &reg, sizeof(reg), 0);
+	if (err < 0)
+		return err;
+
+	// Unknown.
+	reg = cpu_to_be32(0x00000002);
+	err = snd_fw_transaction(tscm->unit, TCODE_WRITE_QUADLET_REQUEST,
+				 TSCM_ADDR_BASE + TSCM_OFFSET_UNKNOWN,
+				 &reg, sizeof(reg), 0);
+	if (err < 0)
+		return err;
+
+	// Register the isochronous channel for receiving stream.
+	reg = cpu_to_be32(tscm->rx_resources.channel);
+	err = snd_fw_transaction(tscm->unit, TCODE_WRITE_QUADLET_REQUEST,
+				 TSCM_ADDR_BASE + TSCM_OFFSET_ISOC_RX_CH,
+				 &reg, sizeof(reg), 0);
+	if (err < 0)
+		return err;
+
 	reg = cpu_to_be32(0x00000001);
 	err = snd_fw_transaction(tscm->unit, TCODE_WRITE_QUADLET_REQUEST,
 				 TSCM_ADDR_BASE + TSCM_OFFSET_START_STREAMING,
@@ -216,7 +253,7 @@ static int begin_session(struct snd_tscm *tscm)
 	if (err < 0)
 		return err;
 
-	/* Set an option for unknown purpose. */
+	// Set an option for unknown purpose.
 	reg = cpu_to_be32(0x00002000);
 	err = snd_fw_transaction(tscm->unit, TCODE_WRITE_QUADLET_REQUEST,
 				 TSCM_ADDR_BASE + TSCM_OFFSET_SET_OPTION,
@@ -224,7 +261,7 @@ static int begin_session(struct snd_tscm *tscm)
 	if (err < 0)
 		return err;
 
-	/* Start multiplexing PCM samples on packets. */
+	// Start multiplexing PCM samples on packets.
 	reg = cpu_to_be32(0x00000001);
 	return snd_fw_transaction(tscm->unit,
 				  TCODE_WRITE_QUADLET_REQUEST,
@@ -234,30 +271,13 @@ static int begin_session(struct snd_tscm *tscm)
 
 static void release_resources(struct snd_tscm *tscm)
 {
-	__be32 reg;
-
-	/* Unregister channels. */
-	reg = cpu_to_be32(0x00000000);
-	snd_fw_transaction(tscm->unit, TCODE_WRITE_QUADLET_REQUEST,
-			   TSCM_ADDR_BASE + TSCM_OFFSET_ISOC_TX_CH,
-			   &reg, sizeof(reg), 0);
-	reg = cpu_to_be32(0x00000000);
-	snd_fw_transaction(tscm->unit, TCODE_WRITE_QUADLET_REQUEST,
-			   TSCM_ADDR_BASE + TSCM_OFFSET_UNKNOWN,
-			   &reg, sizeof(reg), 0);
-	reg = cpu_to_be32(0x00000000);
-	snd_fw_transaction(tscm->unit, TCODE_WRITE_QUADLET_REQUEST,
-			   TSCM_ADDR_BASE + TSCM_OFFSET_ISOC_RX_CH,
-			   &reg, sizeof(reg), 0);
-
-	/* Release isochronous resources. */
+	// Release isochronous resources.
 	fw_iso_resources_free(&tscm->tx_resources);
 	fw_iso_resources_free(&tscm->rx_resources);
 }
 
 static int keep_resources(struct snd_tscm *tscm, unsigned int rate)
 {
-	__be32 reg;
 	int err;
 
 	/* Keep resources for in-stream. */
@@ -280,30 +300,6 @@ static int keep_resources(struct snd_tscm *tscm, unsigned int rate)
 	if (err < 0)
 		return err;
 
-	/* Register the isochronous channel for transmitting stream. */
-	reg = cpu_to_be32(tscm->tx_resources.channel);
-	err = snd_fw_transaction(tscm->unit, TCODE_WRITE_QUADLET_REQUEST,
-				 TSCM_ADDR_BASE + TSCM_OFFSET_ISOC_TX_CH,
-				 &reg, sizeof(reg), 0);
-	if (err < 0)
-		goto error;
-
-	/* Unknown */
-	reg = cpu_to_be32(0x00000002);
-	err = snd_fw_transaction(tscm->unit, TCODE_WRITE_QUADLET_REQUEST,
-				 TSCM_ADDR_BASE + TSCM_OFFSET_UNKNOWN,
-				 &reg, sizeof(reg), 0);
-	if (err < 0)
-		goto error;
-
-	/* Register the isochronous channel for receiving stream. */
-	reg = cpu_to_be32(tscm->rx_resources.channel);
-	err = snd_fw_transaction(tscm->unit, TCODE_WRITE_QUADLET_REQUEST,
-				 TSCM_ADDR_BASE + TSCM_OFFSET_ISOC_RX_CH,
-				 &reg, sizeof(reg), 0);
-	if (err < 0)
-		goto error;
-
 	return 0;
 error:
 	release_resources(tscm);
-- 
2.20.1
