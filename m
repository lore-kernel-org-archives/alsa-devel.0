From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] [02/29] ALSA: dice: optimize bus reset handling
Date: Mon, 21 Oct 2013 21:21:56 +0200
Message-ID: <52657ED4.7050709@ladisch.de>
References: <52657E3B.7040205@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <52657E3B.7040205@ladisch.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

After a bus reset, do not stop the stream completely to avoid having to
reconfigure the device when restarting the stream.

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
---
 sound/firewire/dice.c |  148 +++++++++++++++++++++++++++++++------------------
 1 file changed, 93 insertions(+), 55 deletions(-)

diff --git a/sound/firewire/dice.c b/sound/firewire/dice.c
index ac71b2b..b081021 100644
--- a/sound/firewire/dice.c
+++ b/sound/firewire/dice.c
@@ -559,24 +559,92 @@ static int dice_close(struct snd_pcm_substream *substream)
 	return 0;
 }

-static void dice_stop_stream(struct dice *dice)
+static int dice_stream_start_packets(struct dice *dice)
 {
-	__be32 channel;
+	int err;
+
+	if (dice->stream_running)
+		return 0;

-	if (dice->stream_running) {
-		dice_enable_clear(dice);
+	err = amdtp_out_stream_start(&dice->stream, dice->resources.channel,
+				     fw_parent_device(dice->unit)->max_speed);
+	if (err < 0)
+		return err;

+	err = dice_enable_set(dice);
+	if (err < 0) {
 		amdtp_out_stream_stop(&dice->stream);
+		return err;
+	}

-		channel = cpu_to_be32((u32)-1);
-		snd_fw_transaction(dice->unit, TCODE_WRITE_QUADLET_REQUEST,
-				   rx_address(dice, RX_ISOCHRONOUS),
-				   &channel, 4);
+	dice->stream_running = true;

-		fw_iso_resources_free(&dice->resources);
+	return 0;
+}

-		dice->stream_running = false;
+static int dice_stream_start(struct dice *dice)
+{
+	__be32 channel;
+	int err;
+
+	if (!dice->resources.allocated) {
+		err = fw_iso_resources_allocate(&dice->resources,
+				amdtp_out_stream_get_max_payload(&dice->stream),
+				fw_parent_device(dice->unit)->max_speed);
+		if (err < 0)
+			goto error;
+
+		channel = cpu_to_be32(dice->resources.channel);
+		err = snd_fw_transaction(dice->unit,
+					 TCODE_WRITE_QUADLET_REQUEST,
+					 rx_address(dice, RX_ISOCHRONOUS),
+					 &channel, 4);
+		if (err < 0)
+			goto err_resources;
 	}
+
+	err = dice_stream_start_packets(dice);
+	if (err < 0)
+		goto err_rx_channel;
+
+	return 0;
+
+err_rx_channel:
+	channel = cpu_to_be32((u32)-1);
+	snd_fw_transaction(dice->unit, TCODE_WRITE_QUADLET_REQUEST,
+			   rx_address(dice, RX_ISOCHRONOUS), &channel, 4);
+err_resources:
+	fw_iso_resources_free(&dice->resources);
+error:
+	return err;
+}
+
+static void dice_stream_stop_packets(struct dice *dice)
+{
+	if (!dice->stream_running)
+		return;
+
+	dice_enable_clear(dice);
+
+	amdtp_out_stream_stop(&dice->stream);
+
+	dice->stream_running = false;
+}
+
+static void dice_stream_stop(struct dice *dice)
+{
+	__be32 channel;
+
+	dice_stream_stop_packets(dice);
+
+	if (!dice->resources.allocated)
+		return;
+
+	channel = cpu_to_be32((u32)-1);
+	snd_fw_transaction(dice->unit, TCODE_WRITE_QUADLET_REQUEST,
+			   rx_address(dice, RX_ISOCHRONOUS), &channel, 4);
+
+	fw_iso_resources_free(&dice->resources);
 }

 static int dice_hw_params(struct snd_pcm_substream *substream,
@@ -586,7 +654,7 @@ static int dice_hw_params(struct snd_pcm_substream *substream,
 	int err;

 	mutex_lock(&dice->mutex);
-	dice_stop_stream(dice);
+	dice_stream_stop(dice);
 	mutex_unlock(&dice->mutex);

 	err = snd_pcm_lib_alloc_vmalloc_buffer(substream,
@@ -608,7 +676,7 @@ static int dice_hw_free(struct snd_pcm_substream *substream)
 	struct dice *dice = substream->private_data;

 	mutex_lock(&dice->mutex);
-	dice_stop_stream(dice);
+	dice_stream_stop(dice);
 	mutex_unlock(&dice->mutex);

 	return snd_pcm_lib_free_vmalloc_buffer(substream);
@@ -617,42 +685,17 @@ static int dice_hw_free(struct snd_pcm_substream *substream)
 static int dice_prepare(struct snd_pcm_substream *substream)
 {
 	struct dice *dice = substream->private_data;
-	struct fw_device *device = fw_parent_device(dice->unit);
-	__be32 channel;
 	int err;

 	mutex_lock(&dice->mutex);

 	if (amdtp_out_streaming_error(&dice->stream))
-		dice_stop_stream(dice);
-
-	if (!dice->stream_running) {
-		err = fw_iso_resources_allocate(&dice->resources,
-				amdtp_out_stream_get_max_payload(&dice->stream),
-				device->max_speed);
-		if (err < 0)
-			goto error;
-
-		//TODO: RX_SEQ_START
-		channel = cpu_to_be32(dice->resources.channel);
-		err = snd_fw_transaction(dice->unit,
-					 TCODE_WRITE_QUADLET_REQUEST,
-					 rx_address(dice, RX_ISOCHRONOUS),
-					 &channel, 4);
-		if (err < 0)
-			goto err_resources;
-
-		err = amdtp_out_stream_start(&dice->stream,
-					     dice->resources.channel,
-					     device->max_speed);
-		if (err < 0)
-			goto err_resources;
-
-		err = dice_enable_set(dice);
-		if (err < 0)
-			goto err_stream;
+		dice_stream_stop_packets(dice);

-		dice->stream_running = true;
+	err = dice_stream_start(dice);
+	if (err < 0) {
+		mutex_unlock(&dice->mutex);
+		return err;
 	}

 	mutex_unlock(&dice->mutex);
@@ -660,15 +703,6 @@ static int dice_prepare(struct snd_pcm_substream *substream)
 	amdtp_out_stream_pcm_prepare(&dice->stream);

 	return 0;
-
-err_stream:
-	amdtp_out_stream_stop(&dice->stream);
-err_resources:
-	fw_iso_resources_free(&dice->resources);
-error:
-	mutex_unlock(&dice->mutex);
-
-	return err;
 }

 static int dice_trigger(struct snd_pcm_substream *substream, int cmd)
@@ -941,7 +975,7 @@ static void dice_remove(struct fw_unit *unit)

 	mutex_lock(&dice->mutex);
 	amdtp_out_stream_pcm_abort(&dice->stream);
-	dice_stop_stream(dice);
+	dice_stream_stop(dice);
 	dice_owner_clear(dice);
 	mutex_unlock(&dice->mutex);

@@ -953,8 +987,8 @@ static void dice_bus_reset(struct fw_unit *unit)
 	struct dice *dice = dev_get_drvdata(&unit->device);

 	mutex_lock(&dice->mutex);
+
 	/*
-	 * XXX is the following true?
 	 * On a bus reset, the DICE firmware disables streaming and then goes
 	 * off contemplating its own navel for hundreds of milliseconds before
 	 * it can react to any of our attempts to reenable streaming.  This
@@ -962,9 +996,13 @@ static void dice_bus_reset(struct fw_unit *unit)
 	 * to stop so that the application can restart them in an orderly
 	 * manner.
 	 */
-	dice_owner_update(dice);
 	amdtp_out_stream_pcm_abort(&dice->stream);
-	dice_stop_stream(dice);
+	dice_stream_stop_packets(dice);
+
+	dice_owner_update(dice);
+
+	fw_iso_resources_update(&dice->resources);
+
 	mutex_unlock(&dice->mutex);
 }


------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60135991&iu=/4140/ostg.clktrk
