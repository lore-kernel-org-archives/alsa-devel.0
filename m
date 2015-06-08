From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 04/11] ALSA: bebob: use normalized
	representation for the type of clock source
Date: Mon,  8 Jun 2015 23:31:01 +0900
Message-ID: <1433773868-17505-5-git-send-email-o-takashi@sakamocchi.jp>
References: <1433773868-17505-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id DECFB260459
 for <alsa-devel@alsa-project.org>; Mon,  8 Jun 2015 16:31:15 +0200 (CEST)
In-Reply-To: <1433773868-17505-1-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: kim@incendio.no, alsa-devel@alsa-project.org, jh1ood@gmail.com, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

This commit changes function prototype and its processing. As a result,
function caller can execute additional processing.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/bebob/bebob.h        |  4 ++--
 sound/firewire/bebob/bebob_pcm.c    | 11 ++++++++---
 sound/firewire/bebob/bebob_proc.c   | 22 ++++++++++++----------
 sound/firewire/bebob/bebob_stream.c | 27 +++++++++++----------------
 4 files changed, 33 insertions(+), 31 deletions(-)

diff --git a/sound/firewire/bebob/bebob.h b/sound/firewire/bebob/bebob.h
index b69d0a3..f9f2180 100644
--- a/sound/firewire/bebob/bebob.h
+++ b/sound/firewire/bebob/bebob.h
@@ -211,8 +211,8 @@ int avc_bridgeco_get_plug_strm_fmt(struct fw_unit *unit,
 /* for AMDTP streaming */
 int snd_bebob_stream_get_rate(struct snd_bebob *bebob, unsigned int *rate);
 int snd_bebob_stream_set_rate(struct snd_bebob *bebob, unsigned int rate);
-int snd_bebob_stream_check_internal_clock(struct snd_bebob *bebob,
-					  bool *internal);
+int snd_bebob_stream_get_clock_src(struct snd_bebob *bebob,
+				   enum snd_bebob_clock_type *src);
 int snd_bebob_stream_discover(struct snd_bebob *bebob);
 int snd_bebob_stream_init_duplex(struct snd_bebob *bebob);
 int snd_bebob_stream_start_duplex(struct snd_bebob *bebob, unsigned int rate);
diff --git a/sound/firewire/bebob/bebob_pcm.c b/sound/firewire/bebob/bebob_pcm.c
index 4a55561..e3f65a0 100644
--- a/sound/firewire/bebob/bebob_pcm.c
+++ b/sound/firewire/bebob/bebob_pcm.c
@@ -157,7 +157,7 @@ pcm_open(struct snd_pcm_substream *substream)
 	struct snd_bebob *bebob = substream->private_data;
 	struct snd_bebob_rate_spec *spec = bebob->spec->rate;
 	unsigned int sampling_rate;
-	bool internal;
+	enum snd_bebob_clock_type src;
 	int err;
 
 	err = snd_bebob_stream_lock_try(bebob);
@@ -168,15 +168,20 @@ pcm_open(struct snd_pcm_substream *substream)
 	if (err < 0)
 		goto err_locked;
 
-	err = snd_bebob_stream_check_internal_clock(bebob, &internal);
+	err = snd_bebob_stream_get_clock_src(bebob, &src);
 	if (err < 0)
 		goto err_locked;
+	/* SYT-Match is not supported. */
+	if (src == SND_BEBOB_CLOCK_TYPE_SYT) {
+		err = -EBUSY;
+		goto err_locked;
+	}
 
 	/*
 	 * When source of clock is internal or any PCM stream are running,
 	 * the available sampling rate is limited at current sampling rate.
 	 */
-	if (!internal ||
+	if (src == SND_BEBOB_CLOCK_TYPE_EXTERNAL ||
 	    amdtp_stream_pcm_running(&bebob->tx_stream) ||
 	    amdtp_stream_pcm_running(&bebob->rx_stream)) {
 		err = spec->get(bebob, &sampling_rate);
diff --git a/sound/firewire/bebob/bebob_proc.c b/sound/firewire/bebob/bebob_proc.c
index 335da64..301cc6a 100644
--- a/sound/firewire/bebob/bebob_proc.c
+++ b/sound/firewire/bebob/bebob_proc.c
@@ -132,25 +132,27 @@ static void
 proc_read_clock(struct snd_info_entry *entry,
 		struct snd_info_buffer *buffer)
 {
+	static const char *const clk_labels[] = {
+		"Internal",
+		"External",
+		"SYT-Match",
+	};
 	struct snd_bebob *bebob = entry->private_data;
 	struct snd_bebob_rate_spec *rate_spec = bebob->spec->rate;
 	struct snd_bebob_clock_spec *clk_spec = bebob->spec->clock;
-	unsigned int rate, id;
-	bool internal;
+	enum snd_bebob_clock_type src;
+	unsigned int rate;
 
 	if (rate_spec->get(bebob, &rate) >= 0)
 		snd_iprintf(buffer, "Sampling rate: %d\n", rate);
 
-	if (clk_spec) {
-		if (clk_spec->get(bebob, &id) >= 0)
+	if (snd_bebob_stream_get_clock_src(bebob, &src) >= 0) {
+		if (clk_spec)
 			snd_iprintf(buffer, "Clock Source: %s\n",
-				    clk_spec->labels[id]);
-	} else {
-		if (snd_bebob_stream_check_internal_clock(bebob,
-							  &internal) >= 0)
+				    clk_labels[src]);
+		else
 			snd_iprintf(buffer, "Clock Source: %s (MSU-dest: %d)\n",
-				    (internal) ? "Internal" : "External",
-				    bebob->sync_input_plug);
+				    clk_labels[src], bebob->sync_input_plug);
 	}
 }
 
diff --git a/sound/firewire/bebob/bebob_stream.c b/sound/firewire/bebob/bebob_stream.c
index 2ccef4ce..c8af8ff 100644
--- a/sound/firewire/bebob/bebob_stream.c
+++ b/sound/firewire/bebob/bebob_stream.c
@@ -116,8 +116,8 @@ end:
 	return err;
 }
 
-int
-snd_bebob_stream_check_internal_clock(struct snd_bebob *bebob, bool *internal)
+int snd_bebob_stream_get_clock_src(struct snd_bebob *bebob,
+				   enum snd_bebob_clock_type *src)
 {
 	struct snd_bebob_clock_spec *clk_spec = bebob->spec->clock;
 	u8 addr[AVC_BRIDGECO_ADDR_BYTES], input[7];
@@ -125,8 +125,6 @@ snd_bebob_stream_check_internal_clock(struct snd_bebob *bebob, bool *internal)
 	enum avc_bridgeco_plug_type type;
 	int err = 0;
 
-	*internal = false;
-
 	/* 1.The device has its own operation to switch source of clock */
 	if (clk_spec) {
 		err = clk_spec->get(bebob, &id);
@@ -144,10 +142,7 @@ snd_bebob_stream_check_internal_clock(struct snd_bebob *bebob, bool *internal)
 			goto end;
 		}
 
-		if (strncmp(clk_spec->labels[id], SND_BEBOB_CLOCK_INTERNAL,
-			    strlen(SND_BEBOB_CLOCK_INTERNAL)) == 0)
-			*internal = true;
-
+		*src = clk_spec->types[id];
 		goto end;
 	}
 
@@ -156,7 +151,7 @@ snd_bebob_stream_check_internal_clock(struct snd_bebob *bebob, bool *internal)
 	 *   to use internal clock always
 	 */
 	if (bebob->sync_input_plug < 0) {
-		*internal = true;
+		*src = SND_BEBOB_CLOCK_TYPE_INTERNAL;
 		goto end;
 	}
 
@@ -179,7 +174,7 @@ snd_bebob_stream_check_internal_clock(struct snd_bebob *bebob, bool *internal)
 	 * Here check the first field. This field is used for direction.
 	 */
 	if (input[0] == 0xff) {
-		*internal = true;
+		*src = SND_BEBOB_CLOCK_TYPE_INTERNAL;
 		goto end;
 	}
 
@@ -192,7 +187,7 @@ snd_bebob_stream_check_internal_clock(struct snd_bebob *bebob, bool *internal)
 		 */
 		if (input[1] == AVC_BRIDGECO_PLUG_MODE_SUBUNIT &&
 		    input[2] == 0x0c) {
-			*internal = true;
+			*src = SND_BEBOB_CLOCK_TYPE_INTERNAL;
 			goto end;
 		}
 	/* The source from any input units is for several purposes. */
@@ -206,7 +201,7 @@ snd_bebob_stream_check_internal_clock(struct snd_bebob *bebob, bool *internal)
 				 * short, this driver is the master of
 				 * synchronization.
 				 */
-				err = -EIO;
+				*src = SND_BEBOB_CLOCK_TYPE_SYT;
 				goto end;
 			} else {
 				/*
@@ -214,7 +209,7 @@ snd_bebob_stream_check_internal_clock(struct snd_bebob *bebob, bool *internal)
 				 * means that the synchronization stream is not
 				 * the Audio/MIDI compound stream.
 				 */
-				*internal = false;
+				*src = SND_BEBOB_CLOCK_TYPE_EXTERNAL;
 				goto end;
 			}
 		} else if (input[2] == AVC_BRIDGECO_PLUG_UNIT_EXT) {
@@ -233,18 +228,18 @@ snd_bebob_stream_check_internal_clock(struct snd_bebob *bebob, bool *internal)
 				 * SPDIF/ADAT or sometimes (not always) word
 				 * clock.
 				 */
-				*internal = false;
+				*src = SND_BEBOB_CLOCK_TYPE_EXTERNAL;
 				goto end;
 			} else if (type == AVC_BRIDGECO_PLUG_TYPE_SYNC) {
 				/* Often word clock. */
-				*internal = false;
+				*src = SND_BEBOB_CLOCK_TYPE_EXTERNAL;
 				goto end;
 			} else if (type == AVC_BRIDGECO_PLUG_TYPE_ADDITION) {
 				/*
 				 * Not standard.
 				 * Mostly, additional internal clock.
 				 */
-				*internal = true;
+				*src = SND_BEBOB_CLOCK_TYPE_INTERNAL;
 				goto end;
 			}
 		}
-- 
2.1.4
