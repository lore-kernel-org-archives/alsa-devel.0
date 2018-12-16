From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 3/5] ALSA: fireface: allocate isochronous
	resources in mode-specific implementation
Date: Sun, 16 Dec 2018 17:32:31 +0900
Message-ID: <20181216083233.11358-4-o-takashi@sakamocchi.jp>
References: <20181216083233.11358-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com
 [209.85.214.196])
 by alsa0.perex.cz (Postfix) with ESMTP id C5257267946
 for <alsa-devel@alsa-project.org>; Sun, 16 Dec 2018 09:32:54 +0100 (CET)
Received: by mail-pl1-f196.google.com with SMTP id 101so4696604pld.6
 for <alsa-devel@alsa-project.org>; Sun, 16 Dec 2018 00:32:54 -0800 (PST)
In-Reply-To: <20181216083233.11358-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

The way to maintain isochronous resources on bus is different between
Fireface 400/800.

This commit is a preparation. This commit moves a function to allocate resource to
model-dependent implementation.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/fireface/ff-protocol-ff400.c | 51 +++++++++++++--
 sound/firewire/fireface/ff-stream.c         | 72 +++++++--------------
 2 files changed, 68 insertions(+), 55 deletions(-)

diff --git a/sound/firewire/fireface/ff-protocol-ff400.c b/sound/firewire/fireface/ff-protocol-ff400.c
index 374009545936..2280fab9b3c7 100644
--- a/sound/firewire/fireface/ff-protocol-ff400.c
+++ b/sound/firewire/fireface/ff-protocol-ff400.c
@@ -15,19 +15,60 @@
 #define FF400_TX_PACKET_FORMAT	0x00008010050cull
 #define FF400_ISOC_COMM_STOP	0x000080100510ull
 
-static int ff400_begin_session(struct snd_ff *ff, unsigned int rate)
+/*
+ * Fireface 400 manages isochronous channel number in 3 bit field. Therefore,
+ * we can allocate between 0 and 7 channel.
+ */
+static int keep_resources(struct snd_ff *ff, unsigned int rate)
 {
-	__le32 reg;
-	int i, err;
+	enum snd_ff_stream_mode mode;
+	int i;
+	int err;
 
-	/* Check whether the given value is supported or not. */
+	// Check whether the given value is supported or not.
 	for (i = 0; i < CIP_SFC_COUNT; i++) {
 		if (amdtp_rate_table[i] == rate)
 			break;
 	}
-	if (i == CIP_SFC_COUNT)
+	if (i >= CIP_SFC_COUNT)
 		return -EINVAL;
 
+	err = snd_ff_stream_get_multiplier_mode(i, &mode);
+	if (err < 0)
+		return err;
+
+	/* Keep resources for in-stream. */
+	ff->tx_resources.channels_mask = 0x00000000000000ffuLL;
+	err = fw_iso_resources_allocate(&ff->tx_resources,
+			amdtp_stream_get_max_payload(&ff->tx_stream),
+			fw_parent_device(ff->unit)->max_speed);
+	if (err < 0)
+		return err;
+
+	/* Keep resources for out-stream. */
+	err = amdtp_ff_set_parameters(&ff->rx_stream, rate,
+				      ff->spec->pcm_playback_channels[mode]);
+	if (err < 0)
+		return err;
+	ff->rx_resources.channels_mask = 0x00000000000000ffuLL;
+	err = fw_iso_resources_allocate(&ff->rx_resources,
+			amdtp_stream_get_max_payload(&ff->rx_stream),
+			fw_parent_device(ff->unit)->max_speed);
+	if (err < 0)
+		fw_iso_resources_free(&ff->tx_resources);
+
+	return err;
+}
+
+static int ff400_begin_session(struct snd_ff *ff, unsigned int rate)
+{
+	__le32 reg;
+	int err;
+
+	err = keep_resources(ff, rate);
+	if (err < 0)
+		return err;
+
 	/* Set the number of data blocks transferred in a second. */
 	reg = cpu_to_le32(rate);
 	err = snd_fw_transaction(ff->unit, TCODE_WRITE_QUADLET_REQUEST,
diff --git a/sound/firewire/fireface/ff-stream.c b/sound/firewire/fireface/ff-stream.c
index e6a8229a9d82..a490e4553721 100644
--- a/sound/firewire/fireface/ff-stream.c
+++ b/sound/firewire/fireface/ff-stream.c
@@ -31,54 +31,6 @@ int snd_ff_stream_get_multiplier_mode(enum cip_sfc sfc,
 	return 0;
 }
 
-/*
- * Fireface 400 manages isochronous channel number in 3 bit field. Therefore,
- * we can allocate between 0 and 7 channel.
- */
-static int keep_resources(struct snd_ff *ff, unsigned int rate)
-{
-	enum snd_ff_stream_mode mode;
-	int i;
-	int err;
-
-	for (i = 0; i < CIP_SFC_COUNT; ++i) {
-		if (amdtp_rate_table[i] == rate)
-			break;
-	}
-	if (i == CIP_SFC_COUNT)
-		return -EINVAL;
-
-	err = snd_ff_stream_get_multiplier_mode(i, &mode);
-	if (err < 0)
-		return err;
-
-	/* Keep resources for in-stream. */
-	err = amdtp_ff_set_parameters(&ff->tx_stream, rate,
-				      ff->spec->pcm_capture_channels[mode]);
-	if (err < 0)
-		return err;
-	ff->tx_resources.channels_mask = 0x00000000000000ffuLL;
-	err = fw_iso_resources_allocate(&ff->tx_resources,
-			amdtp_stream_get_max_payload(&ff->tx_stream),
-			fw_parent_device(ff->unit)->max_speed);
-	if (err < 0)
-		return err;
-
-	/* Keep resources for out-stream. */
-	err = amdtp_ff_set_parameters(&ff->rx_stream, rate,
-				      ff->spec->pcm_playback_channels[mode]);
-	if (err < 0)
-		return err;
-	ff->rx_resources.channels_mask = 0x00000000000000ffuLL;
-	err = fw_iso_resources_allocate(&ff->rx_resources,
-			amdtp_stream_get_max_payload(&ff->rx_stream),
-			fw_parent_device(ff->unit)->max_speed);
-	if (err < 0)
-		fw_iso_resources_free(&ff->tx_resources);
-
-	return err;
-}
-
 static void release_resources(struct snd_ff *ff)
 {
 	fw_iso_resources_free(&ff->tx_resources);
@@ -214,9 +166,29 @@ int snd_ff_stream_start_duplex(struct snd_ff *ff, unsigned int rate)
 	 * packets. Then, the device transfers packets.
 	 */
 	if (!amdtp_stream_running(&ff->rx_stream)) {
-		err = keep_resources(ff, rate);
+		enum snd_ff_stream_mode mode;
+		int i;
+
+		for (i = 0; i < CIP_SFC_COUNT; ++i) {
+			if (amdtp_rate_table[i] == rate)
+				break;
+		}
+		if (i >= CIP_SFC_COUNT)
+			return -EINVAL;
+
+		err = snd_ff_stream_get_multiplier_mode(i, &mode);
 		if (err < 0)
-			goto error;
+			return err;
+
+		err = amdtp_ff_set_parameters(&ff->tx_stream, rate,
+					ff->spec->pcm_capture_channels[mode]);
+		if (err < 0)
+			return err;
+
+		err = amdtp_ff_set_parameters(&ff->rx_stream, rate,
+					ff->spec->pcm_playback_channels[mode]);
+		if (err < 0)
+			return err;
 
 		err = ff->spec->protocol->begin_session(ff, rate);
 		if (err < 0)
-- 
2.19.1
