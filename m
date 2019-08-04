From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 07/19] ALSA: firewire-digi00x: code refactoring
	for initialization/destruction of AMDTP stream
Date: Sun,  4 Aug 2019 15:21:26 +0900
Message-ID: <20190804062138.1217-8-o-takashi@sakamocchi.jp>
References: <20190804062138.1217-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 548BEF804CA
 for <alsa-devel@alsa-project.org>; Sun,  4 Aug 2019 08:21:54 +0200 (CEST)
In-Reply-To: <20190804062138.1217-1-o-takashi@sakamocchi.jp>
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

This commit is a preparation to support AMDTP domain.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/digi00x/digi00x-stream.c | 65 ++++++++++++++++---------
 1 file changed, 42 insertions(+), 23 deletions(-)

diff --git a/sound/firewire/digi00x/digi00x-stream.c b/sound/firewire/digi00x/digi00x-stream.c
index 3e77dbd3ee22..cff193f00a97 100644
--- a/sound/firewire/digi00x/digi00x-stream.c
+++ b/sound/firewire/digi00x/digi00x-stream.c
@@ -218,43 +218,62 @@ static int keep_resources(struct snd_dg00x *dg00x, struct amdtp_stream *stream,
 				fw_parent_device(dg00x->unit)->max_speed);
 }
 
-int snd_dg00x_stream_init_duplex(struct snd_dg00x *dg00x)
+static int init_stream(struct snd_dg00x *dg00x, struct amdtp_stream *s)
 {
+	struct fw_iso_resources *resources;
+	enum amdtp_stream_direction dir;
 	int err;
 
-	/* For out-stream. */
-	err = fw_iso_resources_init(&dg00x->rx_resources, dg00x->unit);
+	if (s == &dg00x->tx_stream) {
+		resources = &dg00x->tx_resources;
+		dir = AMDTP_IN_STREAM;
+	} else {
+		resources = &dg00x->rx_resources;
+		dir = AMDTP_OUT_STREAM;
+	}
+
+	err = fw_iso_resources_init(resources, dg00x->unit);
 	if (err < 0)
-		goto error;
-	err = amdtp_dot_init(&dg00x->rx_stream, dg00x->unit, AMDTP_OUT_STREAM);
+		return err;
+
+	err = amdtp_dot_init(s, dg00x->unit, dir);
 	if (err < 0)
-		goto error;
+		fw_iso_resources_destroy(resources);
+
+	return err;
+}
 
-	/* For in-stream. */
-	err = fw_iso_resources_init(&dg00x->tx_resources, dg00x->unit);
+static void destroy_stream(struct snd_dg00x *dg00x, struct amdtp_stream *s)
+{
+	amdtp_stream_destroy(s);
+
+	if (s == &dg00x->tx_stream)
+		fw_iso_resources_destroy(&dg00x->tx_resources);
+	else
+		fw_iso_resources_destroy(&dg00x->rx_resources);
+}
+
+int snd_dg00x_stream_init_duplex(struct snd_dg00x *dg00x)
+{
+	int err;
+
+	err = init_stream(dg00x, &dg00x->rx_stream);
 	if (err < 0)
-		goto error;
-	err = amdtp_dot_init(&dg00x->tx_stream, dg00x->unit, AMDTP_IN_STREAM);
+		return err;
+
+	err = init_stream(dg00x, &dg00x->tx_stream);
 	if (err < 0)
-		goto error;
+		destroy_stream(dg00x, &dg00x->rx_stream);
 
-	return 0;
-error:
-	snd_dg00x_stream_destroy_duplex(dg00x);
 	return err;
 }
 
-/*
- * This function should be called before starting streams or after stopping
- * streams.
- */
+// This function should be called before starting streams or after stopping
+// streams.
 void snd_dg00x_stream_destroy_duplex(struct snd_dg00x *dg00x)
 {
-	amdtp_stream_destroy(&dg00x->rx_stream);
-	fw_iso_resources_destroy(&dg00x->rx_resources);
-
-	amdtp_stream_destroy(&dg00x->tx_stream);
-	fw_iso_resources_destroy(&dg00x->tx_resources);
+	destroy_stream(dg00x, &dg00x->rx_stream);
+	destroy_stream(dg00x, &dg00x->tx_stream);
 }
 
 int snd_dg00x_stream_reserve_duplex(struct snd_dg00x *dg00x, unsigned int rate)
-- 
2.20.1
