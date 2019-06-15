From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 6/6] ALSA: firewire-lib: split allocation of
	isochronous resources from establishment of connection
Date: Sat, 15 Jun 2019 18:11:01 +0900
Message-ID: <20190615091101.7515-7-o-takashi@sakamocchi.jp>
References: <20190615091101.7515-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com
 [64.147.123.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 43675F89731
 for <alsa-devel@alsa-project.org>; Sat, 15 Jun 2019 11:11:20 +0200 (CEST)
In-Reply-To: <20190615091101.7515-1-o-takashi@sakamocchi.jp>
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

In current implementation, establishment connection corresponds to
allocation of isochronous resources. Although this is an ideal
implementation of CMP described in IEC 61883-1, it's not enough
efficient to recover PCM substream multiplexed in packet streaming.
The packet streaming can always restart on the same allocated
isochronous resources even if the previous packet streaming
corrupted.

This commit splits allocation of isochronous resources from
establishment of connection so that CMP runs with allocated
isochronous resources.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/bebob/bebob_stream.c         | 30 ++++++---
 sound/firewire/cmp.c                        | 74 ++++++++++++---------
 sound/firewire/cmp.h                        |  7 +-
 sound/firewire/fireworks/fireworks_stream.c | 22 ++++--
 sound/firewire/oxfw/oxfw-stream.c           | 18 +++--
 5 files changed, 100 insertions(+), 51 deletions(-)

diff --git a/sound/firewire/bebob/bebob_stream.c b/sound/firewire/bebob/bebob_stream.c
index 9ef4663d13e5..1070a675179d 100644
--- a/sound/firewire/bebob/bebob_stream.c
+++ b/sound/firewire/bebob/bebob_stream.c
@@ -404,13 +404,11 @@ static int make_both_connections(struct snd_bebob *bebob)
 {
 	int err = 0;
 
-	err = cmp_connection_establish(&bebob->out_conn,
-			amdtp_stream_get_max_payload(&bebob->tx_stream));
+	err = cmp_connection_establish(&bebob->out_conn);
 	if (err < 0)
 		return err;
 
-	err = cmp_connection_establish(&bebob->in_conn,
-			amdtp_stream_get_max_payload(&bebob->rx_stream));
+	err = cmp_connection_establish(&bebob->in_conn);
 	if (err < 0) {
 		cmp_connection_break(&bebob->out_conn);
 		return err;
@@ -533,14 +531,23 @@ static int keep_resources(struct snd_bebob *bebob, struct amdtp_stream *stream,
 			  unsigned int rate, unsigned int index)
 {
 	struct snd_bebob_stream_formation *formation;
+	struct cmp_connection *conn;
+	int err;
 
-	if (stream == &bebob->tx_stream)
+	if (stream == &bebob->tx_stream) {
 		formation = bebob->tx_stream_formations + index;
-	else
+		conn = &bebob->out_conn;
+	} else {
 		formation = bebob->rx_stream_formations + index;
+		conn = &bebob->in_conn;
+	}
+
+	err = amdtp_am824_set_parameters(stream, rate, formation->pcm,
+					 formation->midi, false);
+	if (err < 0)
+		return err;
 
-	return amdtp_am824_set_parameters(stream, rate, formation->pcm,
-					  formation->midi, false);
+	return cmp_connection_reserve(conn, amdtp_stream_get_max_payload(stream));
 }
 
 int snd_bebob_stream_reserve_duplex(struct snd_bebob *bebob, unsigned int rate)
@@ -591,8 +598,10 @@ int snd_bebob_stream_reserve_duplex(struct snd_bebob *bebob, unsigned int rate)
 			return err;
 
 		err = keep_resources(bebob, &bebob->rx_stream, rate, index);
-		if (err < 0)
+		if (err < 0) {
+			cmp_connection_release(&bebob->out_conn);
 			return err;
+		}
 	}
 
 	return 0;
@@ -685,6 +694,9 @@ void snd_bebob_stream_stop_duplex(struct snd_bebob *bebob)
 		amdtp_stream_stop(&bebob->tx_stream);
 
 		break_both_connections(bebob);
+
+		cmp_connection_release(&bebob->out_conn);
+		cmp_connection_release(&bebob->in_conn);
 	}
 }
 
diff --git a/sound/firewire/cmp.c b/sound/firewire/cmp.c
index ae3bc1940efa..5dedc4f31842 100644
--- a/sound/firewire/cmp.c
+++ b/sound/firewire/cmp.c
@@ -185,6 +185,37 @@ void cmp_connection_destroy(struct cmp_connection *c)
 }
 EXPORT_SYMBOL(cmp_connection_destroy);
 
+int cmp_connection_reserve(struct cmp_connection *c,
+			   unsigned int max_payload_bytes)
+{
+	int err;
+
+	mutex_lock(&c->mutex);
+
+	if (WARN_ON(c->resources.allocated)) {
+		err = -EBUSY;
+		goto end;
+	}
+
+	c->speed = min(c->max_speed,
+		       fw_parent_device(c->resources.unit)->max_speed);
+
+	err = fw_iso_resources_allocate(&c->resources, max_payload_bytes,
+					c->speed);
+end:
+	mutex_unlock(&c->mutex);
+
+	return err;
+}
+EXPORT_SYMBOL(cmp_connection_reserve);
+
+void cmp_connection_release(struct cmp_connection *c)
+{
+	mutex_lock(&c->mutex);
+	fw_iso_resources_free(&c->resources);
+	mutex_unlock(&c->mutex);
+}
+EXPORT_SYMBOL(cmp_connection_release);
 
 static __be32 ipcr_set_modify(struct cmp_connection *c, __be32 ipcr)
 {
@@ -270,25 +301,18 @@ static int pcr_set_check(struct cmp_connection *c, __be32 pcr)
  * When this function succeeds, the caller is responsible for starting
  * transmitting packets.
  */
-int cmp_connection_establish(struct cmp_connection *c,
-			     unsigned int max_payload_bytes)
+int cmp_connection_establish(struct cmp_connection *c)
 {
 	int err;
 
-	if (WARN_ON(c->connected))
-		return -EISCONN;
-
-	c->speed = min(c->max_speed,
-		       fw_parent_device(c->resources.unit)->max_speed);
-
 	mutex_lock(&c->mutex);
 
-retry_after_bus_reset:
-	err = fw_iso_resources_allocate(&c->resources,
-					max_payload_bytes, c->speed);
-	if (err < 0)
-		goto err_mutex;
+	if (WARN_ON(c->connected)) {
+		mutex_unlock(&c->mutex);
+		return -EISCONN;
+	}
 
+retry_after_bus_reset:
 	if (c->direction == CMP_OUTPUT)
 		err = pcr_modify(c, opcr_set_modify, pcr_set_check,
 				 ABORT_ON_BUS_RESET);
@@ -297,21 +321,13 @@ int cmp_connection_establish(struct cmp_connection *c,
 				 ABORT_ON_BUS_RESET);
 
 	if (err == -EAGAIN) {
-		fw_iso_resources_free(&c->resources);
-		goto retry_after_bus_reset;
+		err = fw_iso_resources_update(&c->resources);
+		if (err >= 0)
+			goto retry_after_bus_reset;
 	}
-	if (err < 0)
-		goto err_resources;
-
-	c->connected = true;
-
-	mutex_unlock(&c->mutex);
-
-	return 0;
+	if (err >= 0)
+		c->connected = true;
 
-err_resources:
-	fw_iso_resources_free(&c->resources);
-err_mutex:
 	mutex_unlock(&c->mutex);
 
 	return err;
@@ -351,14 +367,12 @@ int cmp_connection_update(struct cmp_connection *c)
 				 SUCCEED_ON_BUS_RESET);
 
 	if (err < 0)
-		goto err_resources;
+		goto err_unconnect;
 
 	mutex_unlock(&c->mutex);
 
 	return 0;
 
-err_resources:
-	fw_iso_resources_free(&c->resources);
 err_unconnect:
 	c->connected = false;
 	mutex_unlock(&c->mutex);
@@ -395,8 +409,6 @@ void cmp_connection_break(struct cmp_connection *c)
 	if (err < 0)
 		cmp_error(c, "plug is still connected\n");
 
-	fw_iso_resources_free(&c->resources);
-
 	c->connected = false;
 
 	mutex_unlock(&c->mutex);
diff --git a/sound/firewire/cmp.h b/sound/firewire/cmp.h
index b60b415caa8f..26ab88000e34 100644
--- a/sound/firewire/cmp.h
+++ b/sound/firewire/cmp.h
@@ -42,8 +42,11 @@ int cmp_connection_init(struct cmp_connection *connection,
 int cmp_connection_check_used(struct cmp_connection *connection, bool *used);
 void cmp_connection_destroy(struct cmp_connection *connection);
 
-int cmp_connection_establish(struct cmp_connection *connection,
-			     unsigned int max_payload);
+int cmp_connection_reserve(struct cmp_connection *connection,
+			   unsigned int max_payload);
+void cmp_connection_release(struct cmp_connection *connection);
+
+int cmp_connection_establish(struct cmp_connection *connection);
 int cmp_connection_update(struct cmp_connection *connection);
 void cmp_connection_break(struct cmp_connection *connection);
 
diff --git a/sound/firewire/fireworks/fireworks_stream.c b/sound/firewire/fireworks/fireworks_stream.c
index 61342c49dc38..81c1bb209a89 100644
--- a/sound/firewire/fireworks/fireworks_stream.c
+++ b/sound/firewire/fireworks/fireworks_stream.c
@@ -63,8 +63,7 @@ static int start_stream(struct snd_efw *efw, struct amdtp_stream *stream,
 		conn = &efw->in_conn;
 
 	// Establish connection via CMP.
-	err = cmp_connection_establish(conn,
-				       amdtp_stream_get_max_payload(stream));
+	err = cmp_connection_establish(conn);
 	if (err < 0)
 		return err;
 
@@ -177,17 +176,25 @@ static int keep_resources(struct snd_efw *efw, struct amdtp_stream *stream,
 {
 	unsigned int pcm_channels;
 	unsigned int midi_ports;
+	struct cmp_connection *conn;
+	int err;
 
 	if (stream == &efw->tx_stream) {
 		pcm_channels = efw->pcm_capture_channels[mode];
 		midi_ports = efw->midi_out_ports;
+		conn = &efw->out_conn;
 	} else {
 		pcm_channels = efw->pcm_playback_channels[mode];
 		midi_ports = efw->midi_in_ports;
+		conn = &efw->in_conn;
 	}
 
-	return amdtp_am824_set_parameters(stream, rate, pcm_channels,
-					  midi_ports, false);
+	err = amdtp_am824_set_parameters(stream, rate, pcm_channels,
+					 midi_ports, false);
+	if (err < 0)
+		return err;
+
+	return cmp_connection_reserve(conn, amdtp_stream_get_max_payload(stream));
 }
 
 int snd_efw_stream_reserve_duplex(struct snd_efw *efw, unsigned int rate)
@@ -228,8 +235,10 @@ int snd_efw_stream_reserve_duplex(struct snd_efw *efw, unsigned int rate)
 			return err;
 
 		err = keep_resources(efw, &efw->rx_stream, rate, mode);
-		if (err < 0)
+		if (err < 0) {
+			cmp_connection_release(&efw->in_conn);
 			return err;
+		}
 	}
 
 	return 0;
@@ -285,6 +294,9 @@ void snd_efw_stream_stop_duplex(struct snd_efw *efw)
 	if (efw->substreams_counter == 0) {
 		stop_stream(efw, &efw->tx_stream);
 		stop_stream(efw, &efw->rx_stream);
+
+		cmp_connection_release(&efw->out_conn);
+		cmp_connection_release(&efw->in_conn);
 	}
 }
 
diff --git a/sound/firewire/oxfw/oxfw-stream.c b/sound/firewire/oxfw/oxfw-stream.c
index 837733f10736..a8bc798731ff 100644
--- a/sound/firewire/oxfw/oxfw-stream.c
+++ b/sound/firewire/oxfw/oxfw-stream.c
@@ -111,8 +111,7 @@ static int start_stream(struct snd_oxfw *oxfw, struct amdtp_stream *stream)
 	else
 		conn = &oxfw->out_conn;
 
-	err = cmp_connection_establish(conn,
-				       amdtp_stream_get_max_payload(stream));
+	err = cmp_connection_establish(conn);
 	if (err < 0)
 		return err;
 
@@ -203,15 +202,18 @@ static int keep_resources(struct snd_oxfw *oxfw, struct amdtp_stream *stream)
 	enum avc_general_plug_dir dir;
 	u8 **formats;
 	struct snd_oxfw_stream_formation formation;
+	struct cmp_connection *conn;
 	int i;
 	int err;
 
 	if (stream == &oxfw->rx_stream) {
 		dir = AVC_GENERAL_PLUG_DIR_IN;
 		formats = oxfw->rx_stream_formats;
+		conn = &oxfw->in_conn;
 	} else {
 		dir = AVC_GENERAL_PLUG_DIR_OUT;
 		formats = oxfw->tx_stream_formats;
+		conn = &oxfw->out_conn;
 	}
 
 	err = snd_oxfw_stream_get_current_formation(oxfw, dir, &formation);
@@ -239,8 +241,12 @@ static int keep_resources(struct snd_oxfw *oxfw, struct amdtp_stream *stream)
 	if (formation.pcm == 0)
 		return -EINVAL;
 
-	return amdtp_am824_set_parameters(stream, formation.rate, formation.pcm,
+	err = amdtp_am824_set_parameters(stream, formation.rate, formation.pcm,
 					 formation.midi * 8, false);
+	if (err < 0)
+		return err;
+
+	return cmp_connection_reserve(conn, amdtp_stream_get_max_payload(stream));
 }
 
 int snd_oxfw_stream_reserve_duplex(struct snd_oxfw *oxfw,
@@ -299,8 +305,10 @@ int snd_oxfw_stream_reserve_duplex(struct snd_oxfw *oxfw,
 
 		if (oxfw->has_output) {
 			err = keep_resources(oxfw, &oxfw->tx_stream);
-			if (err < 0)
+			if (err < 0) {
+				cmp_connection_release(&oxfw->in_conn);
 				return err;
+			}
 		}
 	}
 
@@ -361,10 +369,12 @@ void snd_oxfw_stream_stop_duplex(struct snd_oxfw *oxfw)
 	if (oxfw->substreams_count == 0) {
 		amdtp_stream_stop(&oxfw->rx_stream);
 		cmp_connection_break(&oxfw->in_conn);
+		cmp_connection_release(&oxfw->in_conn);
 
 		if (oxfw->has_output) {
 			amdtp_stream_stop(&oxfw->tx_stream);
 			cmp_connection_break(&oxfw->out_conn);
+			cmp_connection_release(&oxfw->out_conn);
 		}
 	}
 }
-- 
2.20.1
