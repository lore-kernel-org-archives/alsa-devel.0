From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 01/12] ALSA: firewire-digi00x: refactoring to
	move timing of registration for isochronous channel
Date: Tue, 11 Jun 2019 22:21:07 +0900
Message-ID: <20190611132118.8378-2-o-takashi@sakamocchi.jp>
References: <20190611132118.8378-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 78628F80791
 for <alsa-devel@alsa-project.org>; Tue, 11 Jun 2019 15:21:26 +0200 (CEST)
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

This commit is a part of preparation to perform allocation/release
of isochronous resources in pcm.hw_params/hw_free callbacks.

The registration of isochronous channels is done just after allocation
of isochronous resources. This commit separates the registration just
before starting packet streaming.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/digi00x/digi00x-stream.c | 41 ++++++++++++-------------
 1 file changed, 19 insertions(+), 22 deletions(-)

diff --git a/sound/firewire/digi00x/digi00x-stream.c b/sound/firewire/digi00x/digi00x-stream.c
index 4d3b4ebbdd49..455c43e81850 100644
--- a/sound/firewire/digi00x/digi00x-stream.c
+++ b/sound/firewire/digi00x/digi00x-stream.c
@@ -130,6 +130,12 @@ static void finish_session(struct snd_dg00x *dg00x)
 	snd_fw_transaction(dg00x->unit, TCODE_WRITE_QUADLET_REQUEST,
 			   DG00X_ADDR_BASE + DG00X_OFFSET_STREAMING_SET,
 			   &data, sizeof(data), 0);
+
+	// Unregister isochronous channels for both direction.
+	data = 0;
+	snd_fw_transaction(dg00x->unit, TCODE_WRITE_QUADLET_REQUEST,
+			   DG00X_ADDR_BASE + DG00X_OFFSET_ISOC_CHANNELS,
+			   &data, sizeof(data), 0);
 }
 
 static int begin_session(struct snd_dg00x *dg00x)
@@ -138,6 +144,15 @@ static int begin_session(struct snd_dg00x *dg00x)
 	u32 curr;
 	int err;
 
+	// Register isochronous channels for both direction.
+	data = cpu_to_be32((dg00x->tx_resources.channel << 16) |
+			   dg00x->rx_resources.channel);
+	err = snd_fw_transaction(dg00x->unit, TCODE_WRITE_QUADLET_REQUEST,
+				 DG00X_ADDR_BASE + DG00X_OFFSET_ISOC_CHANNELS,
+				 &data, sizeof(data), 0);
+	if (err < 0)
+		goto error;
+
 	err = snd_fw_transaction(dg00x->unit, TCODE_READ_QUADLET_REQUEST,
 				 DG00X_ADDR_BASE + DG00X_OFFSET_STREAMING_STATE,
 				 &data, sizeof(data), 0);
@@ -171,13 +186,6 @@ static int begin_session(struct snd_dg00x *dg00x)
 
 static void release_resources(struct snd_dg00x *dg00x)
 {
-	__be32 data = 0;
-
-	/* Unregister isochronous channels for both direction. */
-	snd_fw_transaction(dg00x->unit, TCODE_WRITE_QUADLET_REQUEST,
-			   DG00X_ADDR_BASE + DG00X_OFFSET_ISOC_CHANNELS,
-			   &data, sizeof(data), 0);
-
 	/* Release isochronous resources. */
 	fw_iso_resources_free(&dg00x->tx_resources);
 	fw_iso_resources_free(&dg00x->rx_resources);
@@ -186,7 +194,6 @@ static void release_resources(struct snd_dg00x *dg00x)
 static int keep_resources(struct snd_dg00x *dg00x, unsigned int rate)
 {
 	unsigned int i;
-	__be32 data;
 	int err;
 
 	/* Check sampling rate. */
@@ -216,22 +223,12 @@ static int keep_resources(struct snd_dg00x *dg00x, unsigned int rate)
 	err = fw_iso_resources_allocate(&dg00x->tx_resources,
 				amdtp_stream_get_max_payload(&dg00x->tx_stream),
 				fw_parent_device(dg00x->unit)->max_speed);
-	if (err < 0)
-		goto error;
-
-	/* Register isochronous channels for both direction. */
-	data = cpu_to_be32((dg00x->tx_resources.channel << 16) |
-			   dg00x->rx_resources.channel);
-	err = snd_fw_transaction(dg00x->unit, TCODE_WRITE_QUADLET_REQUEST,
-				 DG00X_ADDR_BASE + DG00X_OFFSET_ISOC_CHANNELS,
-				 &data, sizeof(data), 0);
-	if (err < 0)
-		goto error;
+	if (err < 0) {
+		fw_iso_resources_free(&dg00x->rx_resources);
+		return err;
+	}
 
 	return 0;
-error:
-	release_resources(dg00x);
-	return err;
 }
 
 int snd_dg00x_stream_init_duplex(struct snd_dg00x *dg00x)
-- 
2.20.1
