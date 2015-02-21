From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 3/4] ALSA: fireworks/bebob/dice/oxfw: allow stream destructor
	after releasing runtime
Date: Sat, 21 Feb 2015 23:54:59 +0900
Message-ID: <1424530500-9116-4-git-send-email-o-takashi@sakamocchi.jp>
References: <1424530500-9116-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1424530500-9116-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Currently stream destructor in each driver has a problem to be called in
a context in which sound card object is released, because the destructors
call amdtp_stream_pcm_abort() and touch PCM runtime data.

The PCM runtime data is destroyed in application's context with
snd_pcm_close(), on the other hand PCM substream data is destroyed after
sound card object is released, in most case after all of ALSA character
devices are released. When PCM runtime is destroyed and PCM substream is
remained, amdtp_stream_pcm_abort() touches PCM runtime data and causes
Null-pointer-dereference.

This commit changes stream destructors and allows each driver to call
it after releasing runtime.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/bebob/bebob_stream.c         | 12 ++++--------
 sound/firewire/dice/dice-stream.c           | 18 ++++++++++++------
 sound/firewire/fireworks/fireworks_stream.c | 15 ++++++++++-----
 sound/firewire/oxfw/oxfw-stream.c           |  6 ++++--
 4 files changed, 30 insertions(+), 21 deletions(-)

diff --git a/sound/firewire/bebob/bebob_stream.c b/sound/firewire/bebob/bebob_stream.c
index 0ebcabf..fcca3ee 100644
--- a/sound/firewire/bebob/bebob_stream.c
+++ b/sound/firewire/bebob/bebob_stream.c
@@ -410,8 +410,6 @@ break_both_connections(struct snd_bebob *bebob)
 static void
 destroy_both_connections(struct snd_bebob *bebob)
 {
-	break_both_connections(bebob);
-
 	cmp_connection_destroy(&bebob->in_conn);
 	cmp_connection_destroy(&bebob->out_conn);
 }
@@ -712,16 +710,14 @@ void snd_bebob_stream_update_duplex(struct snd_bebob *bebob)
 	mutex_unlock(&bebob->mutex);
 }
 
+/*
+ * This function should be called before starting streams or after stopping
+ * streams.
+ */
 void snd_bebob_stream_destroy_duplex(struct snd_bebob *bebob)
 {
 	mutex_lock(&bebob->mutex);
 
-	amdtp_stream_pcm_abort(&bebob->rx_stream);
-	amdtp_stream_pcm_abort(&bebob->tx_stream);
-
-	amdtp_stream_stop(&bebob->rx_stream);
-	amdtp_stream_stop(&bebob->tx_stream);
-
 	amdtp_stream_destroy(&bebob->rx_stream);
 	amdtp_stream_destroy(&bebob->tx_stream);
 
diff --git a/sound/firewire/dice/dice-stream.c b/sound/firewire/dice/dice-stream.c
index fa9cf76..07dbd01 100644
--- a/sound/firewire/dice/dice-stream.c
+++ b/sound/firewire/dice/dice-stream.c
@@ -311,14 +311,21 @@ end:
 	return err;
 }
 
+/*
+ * This function should be called before starting streams or after stopping
+ * streams.
+ */
 static void destroy_stream(struct snd_dice *dice, struct amdtp_stream *stream)
 {
-	amdtp_stream_destroy(stream);
+	struct fw_iso_resources *resources;
 
 	if (stream == &dice->tx_stream)
-		fw_iso_resources_destroy(&dice->tx_resources);
+		resources = &dice->tx_resources;
 	else
-		fw_iso_resources_destroy(&dice->rx_resources);
+		resources = &dice->rx_resources;
+
+	amdtp_stream_destroy(stream);
+	fw_iso_resources_destroy(resources);
 }
 
 int snd_dice_stream_init_duplex(struct snd_dice *dice)
@@ -332,6 +339,8 @@ int snd_dice_stream_init_duplex(struct snd_dice *dice)
 		goto end;
 
 	err = init_stream(dice, &dice->rx_stream);
+	if (err < 0)
+		destroy_stream(dice, &dice->tx_stream);
 end:
 	return err;
 }
@@ -340,10 +349,7 @@ void snd_dice_stream_destroy_duplex(struct snd_dice *dice)
 {
 	snd_dice_transaction_clear_enable(dice);
 
-	stop_stream(dice, &dice->tx_stream);
 	destroy_stream(dice, &dice->tx_stream);
-
-	stop_stream(dice, &dice->rx_stream);
 	destroy_stream(dice, &dice->rx_stream);
 
 	dice->substreams_counter = 0;
diff --git a/sound/firewire/fireworks/fireworks_stream.c b/sound/firewire/fireworks/fireworks_stream.c
index 4f440e1..f817b7a 100644
--- a/sound/firewire/fireworks/fireworks_stream.c
+++ b/sound/firewire/fireworks/fireworks_stream.c
@@ -100,17 +100,22 @@ end:
 	return err;
 }
 
+/*
+ * This function should be called before starting the stream or after stopping
+ * the streams.
+ */
 static void
 destroy_stream(struct snd_efw *efw, struct amdtp_stream *stream)
 {
-	stop_stream(efw, stream);
-
-	amdtp_stream_destroy(stream);
+	struct cmp_connection *conn;
 
 	if (stream == &efw->tx_stream)
-		cmp_connection_destroy(&efw->out_conn);
+		conn = &efw->out_conn;
 	else
-		cmp_connection_destroy(&efw->in_conn);
+		conn = &efw->in_conn;
+
+	amdtp_stream_destroy(stream);
+	cmp_connection_destroy(&efw->out_conn);
 }
 
 static int
diff --git a/sound/firewire/oxfw/oxfw-stream.c b/sound/firewire/oxfw/oxfw-stream.c
index bda845a..29ccb36 100644
--- a/sound/firewire/oxfw/oxfw-stream.c
+++ b/sound/firewire/oxfw/oxfw-stream.c
@@ -337,6 +337,10 @@ void snd_oxfw_stream_stop_simplex(struct snd_oxfw *oxfw,
 	stop_stream(oxfw, stream);
 }
 
+/*
+ * This function should be called before starting the stream or after stopping
+ * the streams.
+ */
 void snd_oxfw_stream_destroy_simplex(struct snd_oxfw *oxfw,
 				     struct amdtp_stream *stream)
 {
@@ -347,8 +351,6 @@ void snd_oxfw_stream_destroy_simplex(struct snd_oxfw *oxfw,
 	else
 		conn = &oxfw->in_conn;
 
-	stop_stream(oxfw, stream);
-
 	amdtp_stream_destroy(stream);
 	cmp_connection_destroy(conn);
 }
-- 
2.1.0


------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=190641631&iu=/4140/ostg.clktrk
