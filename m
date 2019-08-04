From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 10/19] ALSA: fireface: code refactoring for
	initialization/destruction of AMDTP stream
Date: Sun,  4 Aug 2019 15:21:29 +0900
Message-ID: <20190804062138.1217-11-o-takashi@sakamocchi.jp>
References: <20190804062138.1217-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C01E5F805A1
 for <alsa-devel@alsa-project.org>; Sun,  4 Aug 2019 08:21:58 +0200 (CEST)
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
 sound/firewire/fireface/ff-stream.c | 39 ++++++++++++++---------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/sound/firewire/fireface/ff-stream.c b/sound/firewire/fireface/ff-stream.c
index 4208b8004d1a..e4710204f481 100644
--- a/sound/firewire/fireface/ff-stream.c
+++ b/sound/firewire/fireface/ff-stream.c
@@ -39,54 +39,53 @@ static inline void finish_session(struct snd_ff *ff)
 	ff->spec->protocol->switch_fetching_mode(ff, false);
 }
 
-static int init_stream(struct snd_ff *ff, enum amdtp_stream_direction dir)
+static int init_stream(struct snd_ff *ff, struct amdtp_stream *s)
 {
-	int err;
 	struct fw_iso_resources *resources;
-	struct amdtp_stream *stream;
+	enum amdtp_stream_direction dir;
+	int err;
 
-	if (dir == AMDTP_IN_STREAM) {
+	if (s == &ff->tx_stream) {
 		resources = &ff->tx_resources;
-		stream = &ff->tx_stream;
+		dir = AMDTP_IN_STREAM;
 	} else {
 		resources = &ff->rx_resources;
-		stream = &ff->rx_stream;
+		dir = AMDTP_OUT_STREAM;
 	}
 
 	err = fw_iso_resources_init(resources, ff->unit);
 	if (err < 0)
 		return err;
 
-	err = amdtp_ff_init(stream, ff->unit, dir);
+	err = amdtp_ff_init(s, ff->unit, dir);
 	if (err < 0)
 		fw_iso_resources_destroy(resources);
 
 	return err;
 }
 
-static void destroy_stream(struct snd_ff *ff, enum amdtp_stream_direction dir)
+static void destroy_stream(struct snd_ff *ff, struct amdtp_stream *s)
 {
-	if (dir == AMDTP_IN_STREAM) {
-		amdtp_stream_destroy(&ff->tx_stream);
+	amdtp_stream_destroy(s);
+
+	if (s == &ff->tx_stream)
 		fw_iso_resources_destroy(&ff->tx_resources);
-	} else {
-		amdtp_stream_destroy(&ff->rx_stream);
+	else
 		fw_iso_resources_destroy(&ff->rx_resources);
-	}
 }
 
 int snd_ff_stream_init_duplex(struct snd_ff *ff)
 {
 	int err;
 
-	err = init_stream(ff, AMDTP_OUT_STREAM);
+	err = init_stream(ff, &ff->rx_stream);
 	if (err < 0)
-		goto end;
+		return err;
 
-	err = init_stream(ff, AMDTP_IN_STREAM);
+	err = init_stream(ff, &ff->tx_stream);
 	if (err < 0)
-		destroy_stream(ff, AMDTP_OUT_STREAM);
-end:
+		destroy_stream(ff, &ff->rx_stream);
+
 	return err;
 }
 
@@ -96,8 +95,8 @@ int snd_ff_stream_init_duplex(struct snd_ff *ff)
  */
 void snd_ff_stream_destroy_duplex(struct snd_ff *ff)
 {
-	destroy_stream(ff, AMDTP_IN_STREAM);
-	destroy_stream(ff, AMDTP_OUT_STREAM);
+	destroy_stream(ff, &ff->rx_stream);
+	destroy_stream(ff, &ff->tx_stream);
 }
 
 int snd_ff_stream_reserve_duplex(struct snd_ff *ff, unsigned int rate)
-- 
2.20.1
