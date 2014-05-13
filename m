From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 09/15] oxfw: Change the way to start stream
Date: Tue, 13 May 2014 23:27:46 +0900
Message-ID: <1399991272-5807-10-git-send-email-o-takashi@sakamocchi.jp>
References: <1399991272-5807-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1399991272-5807-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: clemens@ladisch.de
Cc: alsa-devel@alsa-project.org, fenlason@redhat.com, ffado-devel@lists.sf.net, linux1394-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

In past commit, this driver can keep stream formations for each sampling
rate. So its stream functionality can decide stream formations when given
some parameters.

This commit moves related codes from PCM functionality to stream
functionality.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/oxfw/oxfw.h        |  3 +-
 sound/firewire/oxfw/oxfw_pcm.c    | 38 +++------------
 sound/firewire/oxfw/oxfw_stream.c | 99 ++++++++++++++++++++++++++++++++++-----
 3 files changed, 96 insertions(+), 44 deletions(-)

diff --git a/sound/firewire/oxfw/oxfw.h b/sound/firewire/oxfw/oxfw.h
index 5d14424..e845581 100644
--- a/sound/firewire/oxfw/oxfw.h
+++ b/sound/firewire/oxfw/oxfw.h
@@ -60,7 +60,8 @@ struct snd_oxfw {
 };
 
 int snd_oxfw_stream_init_simplex(struct snd_oxfw *oxfw);
-int snd_oxfw_stream_start_simplex(struct snd_oxfw *oxfw);
+int snd_oxfw_stream_start_simplex(struct snd_oxfw *oxfw, unsigned int rate,
+				  unsigned int pcm_channels);
 void snd_oxfw_stream_stop_simplex(struct snd_oxfw *oxfw);
 void snd_oxfw_stream_destroy_simplex(struct snd_oxfw *oxfw);
 void snd_oxfw_stream_update_simplex(struct snd_oxfw *oxfw);
diff --git a/sound/firewire/oxfw/oxfw_pcm.c b/sound/firewire/oxfw/oxfw_pcm.c
index 75c0520..8f65e10 100644
--- a/sound/firewire/oxfw/oxfw_pcm.c
+++ b/sound/firewire/oxfw/oxfw_pcm.c
@@ -170,36 +170,10 @@ static int pcm_hw_params(struct snd_pcm_substream *substream,
 			 struct snd_pcm_hw_params *hw_params)
 {
 	struct snd_oxfw *oxfw = substream->private_data;
-	int err;
-
-	snd_oxfw_stream_stop_simplex(oxfw);
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
 
-	amdtp_stream_set_pcm_format(&oxfw->rx_stream,
-				    params_format(hw_params));
-
-	err = avc_general_set_sig_fmt(oxfw->unit, params_rate(hw_params),
-				      AVC_GENERAL_PLUG_DIR_IN, 0);
-	if (err < 0) {
-		dev_err(&oxfw->unit->device, "failed to set sample rate\n");
-		goto err_buffer;
-	}
-
-	return 0;
-
-err_buffer:
-	snd_pcm_lib_free_vmalloc_buffer(substream);
-error:
-	return err;
+	amdtp_stream_set_pcm_format(&oxfw->rx_stream, params_format(hw_params));
+	return snd_pcm_lib_alloc_vmalloc_buffer(substream,
+						params_buffer_bytes(hw_params));
 }
 
 static int pcm_hw_free(struct snd_pcm_substream *substream)
@@ -214,11 +188,11 @@ static int pcm_hw_free(struct snd_pcm_substream *substream)
 static int pcm_prepare(struct snd_pcm_substream *substream)
 {
 	struct snd_oxfw *oxfw = substream->private_data;
+	struct snd_pcm_runtime *runtime = substream->runtime;
 	int err;
 
-	snd_oxfw_stream_stop_simplex(oxfw);
-
-	err = snd_oxfw_stream_start_simplex(oxfw);
+	err = snd_oxfw_stream_start_simplex(oxfw, runtime->rate,
+					    runtime->channels);
 	if (err < 0)
 		goto end;
 
diff --git a/sound/firewire/oxfw/oxfw_stream.c b/sound/firewire/oxfw/oxfw_stream.c
index 954584e..2d09df8 100644
--- a/sound/firewire/oxfw/oxfw_stream.c
+++ b/sound/firewire/oxfw/oxfw_stream.c
@@ -8,6 +8,8 @@
 
 #include "oxfw.h"
 
+#define CALLBACK_TIMEOUT	200
+
 /*
  * According to their datasheet:
  *  OXFW970: 32.0/44.1/48.0/96.0 Khz, 8 audio channels I/O
@@ -48,29 +50,104 @@ static int stop_stream(struct snd_oxfw *oxfw)
 	cmp_connection_break(&oxfw->in_conn);
 }
 
-int snd_oxfw_stream_start_simplex(struct snd_oxfw *oxfw)
+static int start_stream(struct snd_oxfw *oxfw, unsigned int rate,
+			unsigned int pcm_channels)
 {
-	int err = 0;
+	struct snd_oxfw_stream_formation *formations;
+	unsigned int i, midi_ports;
+	struct amdtp_stream *stream;
+	struct cmp_connection *conn;
+	int err;
 
-	mutex_lock(&oxfw->mutex);
+	stream = &oxfw->rx_stream;
+	formations = oxfw->rx_stream_formations;
+	conn = &oxfw->in_conn;
+
+	/* Get stream formation */
+	for (i = 0; i < SND_OXFW_STREAM_FORMAT_ENTRIES; i++) {
+		if (formations[i].rate != rate)
+			continue;
+		if ((pcm_channels == 0) ||
+		    (formations[i].pcm == pcm_channels))
+			break;
+	}
+	if (i == SND_OXFW_STREAM_FORMAT_ENTRIES) {
+		err = -EINVAL;
+		goto end;
+	}
 
-	if (amdtp_streaming_error(&oxfw->rx_stream))
-		stop_stream(oxfw);
+	pcm_channels = formations[i].pcm;
+	midi_ports = formations[i].midi;
 
-	if (amdtp_stream_running(&oxfw->rx_stream))
+	/* The stream should have one pcm channels at least */
+	if (pcm_channels == 0) {
+		err = -EINVAL;
 		goto end;
+	}
+	amdtp_stream_set_parameters(stream, rate, pcm_channels, midi_ports);
 
-	err = cmp_connection_establish(&oxfw->in_conn,
-			amdtp_stream_get_max_payload(&oxfw->rx_stream));
+	/* Establish connection */
+	err = cmp_connection_establish(conn,
+				       amdtp_stream_get_max_payload(stream));
 	if (err < 0)
 		goto end;
 
-	err = amdtp_stream_start(&oxfw->rx_stream,
-				 oxfw->in_conn.resources.channel,
-				 oxfw->in_conn.speed);
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
 	if (err < 0)
 		stop_stream(oxfw);
 end:
+	return err;
+}
+
+int snd_oxfw_stream_start_simplex(struct snd_oxfw *oxfw, unsigned int rate,
+				  unsigned int pcm_channels)
+{
+	unsigned int curr_rate;
+	int err = 0;
+
+	mutex_lock(&oxfw->mutex);
+
+	/* packet queueing error */
+	if (amdtp_streaming_error(&oxfw->rx_stream))
+		stop_stream(oxfw);
+
+	/* arrange sampling rate */
+	err = avc_general_get_sig_fmt(oxfw->unit, &curr_rate,
+				      AVC_GENERAL_PLUG_DIR_IN, 0);
+	if (err < 0) {
+		dev_err(&oxfw->unit->device,
+			"fail to get sampling rate: %d\n", err);
+		goto end;
+	}
+	if (curr_rate != rate) {
+		stop_stream(oxfw);
+
+		err = avc_general_set_sig_fmt(oxfw->unit, rate,
+					      AVC_GENERAL_PLUG_DIR_IN, 0);
+		if (err < 0) {
+			dev_err(&oxfw->unit->device,
+				"fail to set sampling rate: %d\n", err);
+			goto end;
+		}
+	}
+
+	if (!amdtp_stream_running(&oxfw->rx_stream)) {
+		err = start_stream(oxfw, rate, pcm_channels);
+		if (err < 0)
+			dev_err(&oxfw->unit->device,
+				"fail to start stream: %d\n", err);
+	}
+end:
 	mutex_unlock(&oxfw->mutex);
 	return err;
 }
-- 
1.8.3.2


------------------------------------------------------------------------------
"Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
Instantly run your Selenium tests across 300+ browser/OS combos.
Get unparalleled scalability from the best Selenium testing platform available
Simple to use. Nothing to install. Get started now for free."
http://p.sf.net/sfu/SauceLabs
