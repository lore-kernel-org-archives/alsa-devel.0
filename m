From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 09/19] ALSA: firewire-motu: code refactoring
	for initialization/destruction of AMDTP stream
Date: Sun,  4 Aug 2019 15:21:28 +0900
Message-ID: <20190804062138.1217-10-o-takashi@sakamocchi.jp>
References: <20190804062138.1217-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4AE15F800F4
 for <alsa-devel@alsa-project.org>; Sun,  4 Aug 2019 08:21:57 +0200 (CEST)
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
 sound/firewire/motu/motu-stream.c | 48 ++++++++++++-------------------
 1 file changed, 19 insertions(+), 29 deletions(-)

diff --git a/sound/firewire/motu/motu-stream.c b/sound/firewire/motu/motu-stream.c
index 2bbb335e8de1..cc9f34426a47 100644
--- a/sound/firewire/motu/motu-stream.c
+++ b/sound/firewire/motu/motu-stream.c
@@ -300,62 +300,52 @@ void snd_motu_stream_stop_duplex(struct snd_motu *motu)
 	}
 }
 
-static int init_stream(struct snd_motu *motu, enum amdtp_stream_direction dir)
+static int init_stream(struct snd_motu *motu, struct amdtp_stream *s)
 {
-	int err;
-	struct amdtp_stream *stream;
 	struct fw_iso_resources *resources;
+	enum amdtp_stream_direction dir;
+	int err;
 
-	if (dir == AMDTP_IN_STREAM) {
-		stream = &motu->tx_stream;
+	if (s == &motu->tx_stream) {
 		resources = &motu->tx_resources;
+		dir = AMDTP_IN_STREAM;
 	} else {
-		stream = &motu->rx_stream;
 		resources = &motu->rx_resources;
+		dir = AMDTP_OUT_STREAM;
 	}
 
 	err = fw_iso_resources_init(resources, motu->unit);
 	if (err < 0)
 		return err;
 
-	err = amdtp_motu_init(stream, motu->unit, dir, motu->spec->protocol);
-	if (err < 0) {
-		amdtp_stream_destroy(stream);
+	err = amdtp_motu_init(s, motu->unit, dir, motu->spec->protocol);
+	if (err < 0)
 		fw_iso_resources_destroy(resources);
-	}
 
 	return err;
 }
 
-static void destroy_stream(struct snd_motu *motu,
-			   enum amdtp_stream_direction dir)
+static void destroy_stream(struct snd_motu *motu, struct amdtp_stream *s)
 {
-	struct amdtp_stream *stream;
-	struct fw_iso_resources *resources;
+	amdtp_stream_destroy(s);
 
-	if (dir == AMDTP_IN_STREAM) {
-		stream = &motu->tx_stream;
-		resources = &motu->tx_resources;
-	} else {
-		stream = &motu->rx_stream;
-		resources = &motu->rx_resources;
-	}
-
-	amdtp_stream_destroy(stream);
-	fw_iso_resources_destroy(resources);
+	if (s == &motu->tx_stream)
+		fw_iso_resources_destroy(&motu->tx_resources);
+	else
+		fw_iso_resources_destroy(&motu->rx_resources);
 }
 
 int snd_motu_stream_init_duplex(struct snd_motu *motu)
 {
 	int err;
 
-	err = init_stream(motu, AMDTP_IN_STREAM);
+	err = init_stream(motu, &motu->tx_stream);
 	if (err < 0)
 		return err;
 
-	err = init_stream(motu, AMDTP_OUT_STREAM);
+	err = init_stream(motu, &motu->rx_stream);
 	if (err < 0)
-		destroy_stream(motu, AMDTP_IN_STREAM);
+		destroy_stream(motu, &motu->tx_stream);
 
 	return err;
 }
@@ -366,8 +356,8 @@ int snd_motu_stream_init_duplex(struct snd_motu *motu)
  */
 void snd_motu_stream_destroy_duplex(struct snd_motu *motu)
 {
-	destroy_stream(motu, AMDTP_IN_STREAM);
-	destroy_stream(motu, AMDTP_OUT_STREAM);
+	destroy_stream(motu, &motu->rx_stream);
+	destroy_stream(motu, &motu->tx_stream);
 
 	motu->substreams_counter = 0;
 }
-- 
2.20.1
