From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 46/52] oxfw: Change the way to start stream
Date: Wed, 29 Jan 2014 22:44:53 +0900
Message-ID: <1391003099-7109-47-git-send-email-o-takashi@sakamocchi.jp>
References: <1391003099-7109-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1391003099-7109-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: clemens@ladisch.de, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

In past commit, driver can keep formations for each sampling rate. So its
stream functionality can set its formation when given sampling rate.

But PCM functionality still set it. This commit move some codes to set
stream formation from PCM functionality to stream functionality.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/oxfw/oxfw.c        |  2 -
 sound/firewire/oxfw/oxfw.h        |  2 +-
 sound/firewire/oxfw/oxfw_pcm.c    | 49 +++-----------------
 sound/firewire/oxfw/oxfw_stream.c | 95 +++++++++++++++++++++++++++++++++++----
 4 files changed, 93 insertions(+), 55 deletions(-)

diff --git a/sound/firewire/oxfw/oxfw.c b/sound/firewire/oxfw/oxfw.c
index b0c7b2a..74319df 100644
--- a/sound/firewire/oxfw/oxfw.c
+++ b/sound/firewire/oxfw/oxfw.c
@@ -153,9 +153,7 @@ static void oxfw_remove(struct fw_unit *unit)
 {
 	struct snd_oxfw *oxfw = dev_get_drvdata(&unit->device);
 
-	mutex_lock(&oxfw->mutex);
 	snd_oxfw_stream_destroy(oxfw);
-	mutex_unlock(&oxfw->mutex);
 
 	snd_card_disconnect(oxfw->card);
 	snd_card_free_when_closed(oxfw->card);
diff --git a/sound/firewire/oxfw/oxfw.h b/sound/firewire/oxfw/oxfw.h
index 2de6671..253986f 100644
--- a/sound/firewire/oxfw/oxfw.h
+++ b/sound/firewire/oxfw/oxfw.h
@@ -58,7 +58,7 @@ struct snd_oxfw {
 };
 
 int snd_oxfw_stream_init(struct snd_oxfw *oxfw);
-int snd_oxfw_stream_start(struct snd_oxfw *oxfw);
+int snd_oxfw_stream_start(struct snd_oxfw *oxfw, unsigned int rate);
 void snd_oxfw_stream_stop(struct snd_oxfw *oxfw);
 void snd_oxfw_stream_destroy(struct snd_oxfw *oxfw);
 void snd_oxfw_stream_update(struct snd_oxfw *oxfw);
diff --git a/sound/firewire/oxfw/oxfw_pcm.c b/sound/firewire/oxfw/oxfw_pcm.c
index d217a9d..6755980 100644
--- a/sound/firewire/oxfw/oxfw_pcm.c
+++ b/sound/firewire/oxfw/oxfw_pcm.c
@@ -202,51 +202,15 @@ static int oxfw_close(struct snd_pcm_substream *substream)
 static int oxfw_hw_params(struct snd_pcm_substream *substream,
 			   struct snd_pcm_hw_params *hw_params)
 {
-	struct snd_oxfw *oxfw = substream->private_data;
-	int err;
-
-	mutex_lock(&oxfw->mutex);
-	snd_oxfw_stream_stop(oxfw);
-	mutex_unlock(&oxfw->mutex);
-
-	err = snd_pcm_lib_alloc_vmalloc_buffer(substream,
-					       params_buffer_bytes(hw_params));
-	if (err < 0)
-		goto error;
-
-	amdtp_stream_set_parameters(&oxfw->rx_stream,
-				    params_rate(hw_params),
-				    params_channels(hw_params),
-				    0);
-
-	amdtp_stream_set_pcm_format(&oxfw->rx_stream,
-				    params_format(hw_params));
-
-	err = avc_general_set_sig_fmt(oxfw->unit, params_rate(hw_params),
-				      AVC_GENERAL_PLUG_DIR_IN, 0);
-	if (err < 0)
-		goto err_buffer;
-	if (err != 0x09 /* ACCEPTED */) {
-		dev_err(&oxfw->unit->device, "failed to set sample rate\n");
-		err = -EIO;
-		goto error;
-	}
-
-	return 0;
-
-err_buffer:
-	snd_pcm_lib_free_vmalloc_buffer(substream);
-error:
-	return err;
+	return snd_pcm_lib_alloc_vmalloc_buffer(substream,
+						params_buffer_bytes(hw_params));
 }
 
 static int oxfw_hw_free(struct snd_pcm_substream *substream)
 {
 	struct snd_oxfw *oxfw = substream->private_data;
 
-	mutex_lock(&oxfw->mutex);
 	snd_oxfw_stream_stop(oxfw);
-	mutex_unlock(&oxfw->mutex);
 
 	return snd_pcm_lib_free_vmalloc_buffer(substream);
 }
@@ -254,19 +218,16 @@ static int oxfw_hw_free(struct snd_pcm_substream *substream)
 static int oxfw_prepare(struct snd_pcm_substream *substream)
 {
 	struct snd_oxfw *oxfw = substream->private_data;
+	struct snd_pcm_runtime *runtime = substream->runtime;
 	int err;
 
-	mutex_lock(&oxfw->mutex);
-
-	snd_oxfw_stream_stop(oxfw);
-
-	err = snd_oxfw_stream_start(oxfw);
+	err = snd_oxfw_stream_start(oxfw, runtime->rate);
 	if (err < 0)
 		goto end;
 
+	amdtp_stream_set_pcm_format(&oxfw->rx_stream, runtime->format);
 	amdtp_stream_pcm_prepare(&oxfw->rx_stream);
 end:
-	mutex_unlock(&oxfw->mutex);
 	return err;
 }
 
diff --git a/sound/firewire/oxfw/oxfw_stream.c b/sound/firewire/oxfw/oxfw_stream.c
index f1d6ce5..6554dec 100644
--- a/sound/firewire/oxfw/oxfw_stream.c
+++ b/sound/firewire/oxfw/oxfw_stream.c
@@ -7,6 +7,8 @@
 
 #include "oxfw.h"
 
+#define CALLBACK_TIMEOUT	200
+
 /*
  * According to their datasheet:
  *  OXFW970: 32.0/44.1/48.0/96.0 Khz, 8 audio channels I/O
@@ -39,27 +41,99 @@ end:
 	return err;
 }
 
-int snd_oxfw_stream_start(struct snd_oxfw *oxfw)
+static int start_stream(struct snd_oxfw *oxfw, unsigned int rate)
 {
+	unsigned int i, pcm_channels, midi_ports;
+	struct amdtp_stream *stream;
+	struct cmp_connection *conn;
+	int err;
+
+	/* Get stream formation */
+	for (i = 0; i < SND_OXFW_STREAM_TABLE_ENTRIES; i++) {
+		if (snd_oxfw_rate_table[i] == rate)
+			break;
+	}
+	if (i == SND_OXFW_STREAM_TABLE_ENTRIES) {
+		err = -EINVAL;
+		goto end;
+	}
+
+	pcm_channels = oxfw->rx_stream_formations[i].pcm;
+	midi_ports = oxfw->rx_stream_formations[i].midi;
+	conn = &oxfw->in_conn;
+	stream = &oxfw->rx_stream;
+
+	/* The stream should have one pcm channels at least */
+	if (pcm_channels == 0) {
+		err = -EINVAL;
+		goto end;
+	}
+	amdtp_stream_set_parameters(stream, rate, pcm_channels, midi_ports);
+
+	/* Establish connection */
+	err = cmp_connection_establish(conn,
+				       amdtp_stream_get_max_payload(stream));
+	if (err < 0)
+		goto end;
+
+	/* Start stream */
+	err = amdtp_stream_start(stream,
+				 conn->resources.channel,
+				 conn->speed);
+	if (err < 0) {
+		cmp_connection_break(conn);
+		goto end;
+	}
+
+	/* Wait first callback */
+	err = amdtp_stream_wait_callback(stream, CALLBACK_TIMEOUT);
+	if (err < 0)
+		snd_oxfw_stream_stop(oxfw);
+end:
+	return err;
+}
+
+int snd_oxfw_stream_start(struct snd_oxfw *oxfw, unsigned int rate)
+{
+	unsigned int curr_rate;
 	int err = 0;
 
+	mutex_lock(&oxfw->mutex);
+
+	/* packet queueing error */
 	if (amdtp_streaming_error(&oxfw->rx_stream))
 		snd_oxfw_stream_stop(oxfw);
 
 	if (amdtp_stream_running(&oxfw->rx_stream))
 		goto end;
 
-	err = cmp_connection_establish(&oxfw->in_conn,
-			amdtp_stream_get_max_payload(&oxfw->rx_stream));
+	/* arrange sampling rate */
+	err = avc_general_get_sig_fmt(oxfw->unit, &curr_rate,
+				      AVC_GENERAL_PLUG_DIR_IN, 0);
 	if (err < 0)
 		goto end;
+	if (err != 0x0c /* IMPLEMENTED/STABLE */) {
+		dev_err(&oxfw->unit->device,
+			"failed to get sample rate\n");
+		err = -EIO;
+		goto end;
+	}
+	if (curr_rate != rate) {
+		err = avc_general_set_sig_fmt(oxfw->unit, rate,
+					      AVC_GENERAL_PLUG_DIR_IN, 0);
+		if (err < 0)
+			goto end;
+		if (err != 0x09 /* ACCEPTED */) {
+			dev_err(&oxfw->unit->device,
+				"failed to set sample rate\n");
+			err = -EIO;
+			goto end;
+		}
+	}
 
-	err = amdtp_stream_start(&oxfw->rx_stream,
-				 oxfw->in_conn.resources.channel,
-				 oxfw->in_conn.speed);
-	if (err < 0)
-		snd_oxfw_stream_stop(oxfw);
+	err = start_stream(oxfw, rate);
 end:
+	mutex_unlock(&oxfw->mutex);
 	return err;
 }
 
@@ -74,15 +148,20 @@ void snd_oxfw_stream_stop(struct snd_oxfw *oxfw)
 void snd_oxfw_stream_destroy(struct snd_oxfw *oxfw)
 {
 	amdtp_stream_pcm_abort(&oxfw->rx_stream);
+
+	mutex_lock(&oxfw->mutex);
 	snd_oxfw_stream_stop(oxfw);
 	cmp_connection_destroy(&oxfw->in_conn);
+	mutex_unlock(&oxfw->mutex);
 }
 
 void snd_oxfw_stream_update(struct snd_oxfw *oxfw)
 {
 	if (cmp_connection_update(&oxfw->in_conn) < 0) {
 		amdtp_stream_pcm_abort(&oxfw->rx_stream);
+		mutex_lock(&oxfw->mutex);
 		snd_oxfw_stream_stop(oxfw);
+		mutex_unlock(&oxfw->mutex);
 	} else {
 		amdtp_stream_update(&oxfw->rx_stream);
 	}
-- 
1.8.3.2


------------------------------------------------------------------------------
WatchGuard Dimension instantly turns raw network data into actionable 
security intelligence. It gives you real-time visual feedback on key
security issues and trends.  Skip the complicated setup - simply import
a virtual appliance and go from zero to informed in seconds.
http://pubads.g.doubleclick.net/gampad/clk?id=123612991&iu=/4140/ostg.clktrk
