From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 04/12] ALSA: firewire-digi00x: code refactoring
	to keep isochronous resources
Date: Tue, 11 Jun 2019 22:21:10 +0900
Message-ID: <20190611132118.8378-5-o-takashi@sakamocchi.jp>
References: <20190611132118.8378-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 38488F806F5
 for <alsa-devel@alsa-project.org>; Tue, 11 Jun 2019 15:21:31 +0200 (CEST)
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

All of models in Digidesign Digi00x family have the same formation of
data channels in isochronous packet for both directions. This commit
simplifies allocation of isochronous resources in this point.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/digi00x/digi00x-stream.c | 42 +++++++++++--------------
 1 file changed, 18 insertions(+), 24 deletions(-)

diff --git a/sound/firewire/digi00x/digi00x-stream.c b/sound/firewire/digi00x/digi00x-stream.c
index 8104af94aed5..2bddeb3e4bf5 100644
--- a/sound/firewire/digi00x/digi00x-stream.c
+++ b/sound/firewire/digi00x/digi00x-stream.c
@@ -196,12 +196,14 @@ static void release_resources(struct snd_dg00x *dg00x)
 	fw_iso_resources_free(&dg00x->rx_resources);
 }
 
-static int keep_resources(struct snd_dg00x *dg00x, unsigned int rate)
+static int keep_resources(struct snd_dg00x *dg00x, struct amdtp_stream *stream,
+			  unsigned int rate)
 {
-	unsigned int i;
+	struct fw_iso_resources *resources;
+	int i;
 	int err;
 
-	/* Check sampling rate. */
+	// Check sampling rate.
 	for (i = 0; i < SND_DG00X_RATE_COUNT; i++) {
 		if (snd_dg00x_stream_rates[i] == rate)
 			break;
@@ -209,31 +211,19 @@ static int keep_resources(struct snd_dg00x *dg00x, unsigned int rate)
 	if (i == SND_DG00X_RATE_COUNT)
 		return -EINVAL;
 
-	/* Keep resources for out-stream. */
-	err = amdtp_dot_set_parameters(&dg00x->rx_stream, rate,
-				       snd_dg00x_stream_pcm_channels[i]);
-	if (err < 0)
-		return err;
-	err = fw_iso_resources_allocate(&dg00x->rx_resources,
-				amdtp_stream_get_max_payload(&dg00x->rx_stream),
-				fw_parent_device(dg00x->unit)->max_speed);
-	if (err < 0)
-		return err;
+	if (stream == &dg00x->tx_stream)
+		resources = &dg00x->tx_resources;
+	else
+		resources = &dg00x->rx_resources;
 
-	/* Keep resources for in-stream. */
-	err = amdtp_dot_set_parameters(&dg00x->tx_stream, rate,
+	err = amdtp_dot_set_parameters(stream, rate,
 				       snd_dg00x_stream_pcm_channels[i]);
 	if (err < 0)
 		return err;
-	err = fw_iso_resources_allocate(&dg00x->tx_resources,
-				amdtp_stream_get_max_payload(&dg00x->tx_stream),
-				fw_parent_device(dg00x->unit)->max_speed);
-	if (err < 0) {
-		fw_iso_resources_free(&dg00x->rx_resources);
-		return err;
-	}
 
-	return 0;
+	return fw_iso_resources_allocate(resources,
+				amdtp_stream_get_max_payload(stream),
+				fw_parent_device(dg00x->unit)->max_speed);
 }
 
 int snd_dg00x_stream_init_duplex(struct snd_dg00x *dg00x)
@@ -306,7 +296,11 @@ int snd_dg00x_stream_start_duplex(struct snd_dg00x *dg00x, unsigned int rate)
 		if (err < 0)
 			goto error;
 
-		err = keep_resources(dg00x, rate);
+		err = keep_resources(dg00x, &dg00x->rx_stream, rate);
+		if (err < 0)
+			goto error;
+
+		err = keep_resources(dg00x, &dg00x->tx_stream, rate);
 		if (err < 0)
 			goto error;
 
-- 
2.20.1
