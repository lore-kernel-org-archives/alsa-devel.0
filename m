From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 08/13] speakers: Change the way to start stream
Date: Sat, 11 Jan 2014 00:29:30 +0900
Message-ID: <1389367775-21360-9-git-send-email-o-takashi@sakamocchi.jp>
References: <1388920417-5584-1-git-send-email-o-takashi@sakamocchi.jp>
 <1389367775-21360-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id A33402608C9
 for <alsa-devel@alsa-project.org>; Fri, 10 Jan 2014 16:29:58 +0100 (CET)
In-Reply-To: <1389367775-21360-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

In past commit, driver can keep formations for each sampling rate. So its
stream functionality can decide its formation when given sampling rate.

But PCM functionality still decide it. This commit move some codes to decide
stream formation from PCM functionality to stream functionality.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/speakers/speakers.h        |  2 +-
 sound/firewire/speakers/speakers_pcm.c    | 49 +++--------------------
 sound/firewire/speakers/speakers_stream.c | 66 +++++++++++++++++++++++++++++--
 3 files changed, 68 insertions(+), 49 deletions(-)

diff --git a/sound/firewire/speakers/speakers.h b/sound/firewire/speakers/speakers.h
index 977db20..90c65f4 100644
--- a/sound/firewire/speakers/speakers.h
+++ b/sound/firewire/speakers/speakers.h
@@ -58,7 +58,7 @@ struct fwspk {
 };
 
 int snd_fwspk_stream_init(struct fwspk *fwspk);
-int snd_fwspk_stream_start(struct fwspk *fwspk);
+int snd_fwspk_stream_start(struct fwspk *fwspk, unsigned int rate);
 void snd_fwspk_stream_stop(struct fwspk *fwspk);
 void snd_fwspk_stream_destroy(struct fwspk *fwspk);
 void snd_fwspk_stream_update(struct fwspk *fwspk);
diff --git a/sound/firewire/speakers/speakers_pcm.c b/sound/firewire/speakers/speakers_pcm.c
index cc4b610..2258ddf 100644
--- a/sound/firewire/speakers/speakers_pcm.c
+++ b/sound/firewire/speakers/speakers_pcm.c
@@ -141,13 +141,8 @@ int fwspk_open(struct snd_pcm_substream *substream)
 	};
 	struct fwspk *fwspk = substream->private_data;
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	bool used;
 	int err;
 
-	err = cmp_connection_check_used(&fwspk->in_conn, &used);
-	if ((err < 0) || used)
-		goto end;
-
 	runtime->hw = hw;
 
 	/* add rule between channels and sampling rate */
@@ -191,42 +186,8 @@ static int fwspk_close(struct snd_pcm_substream *substream)
 static int fwspk_hw_params(struct snd_pcm_substream *substream,
 			   struct snd_pcm_hw_params *hw_params)
 {
-	struct fwspk *fwspk = substream->private_data;
-	int err;
-
-	mutex_lock(&fwspk->mutex);
-	snd_fwspk_stream_stop(fwspk);
-	mutex_unlock(&fwspk->mutex);
-
-	err = snd_pcm_lib_alloc_vmalloc_buffer(substream,
-					       params_buffer_bytes(hw_params));
-	if (err < 0)
-		goto error;
-
-	amdtp_stream_set_parameters(&fwspk->rx_stream,
-				    params_rate(hw_params),
-				    params_channels(hw_params),
-				    0);
-
-	amdtp_stream_set_pcm_format(&fwspk->rx_stream,
-				    params_format(hw_params));
-
-	err = avc_general_set_sig_fmt(fwspk->unit, params_rate(hw_params),
-				      AVC_GENERAL_PLUG_DIR_IN, 0);
-	if (err < 0)
-		goto err_buffer;
-	if (err != 0x09 /* ACCEPTED */) {
-		dev_err(&fwspk->unit->device, "failed to set sample rate\n");
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
 
 static int fwspk_hw_free(struct snd_pcm_substream *substream)
@@ -243,16 +204,16 @@ static int fwspk_hw_free(struct snd_pcm_substream *substream)
 static int fwspk_prepare(struct snd_pcm_substream *substream)
 {
 	struct fwspk *fwspk = substream->private_data;
+	struct snd_pcm_runtime *runtime = substream->runtime;
 	int err;
 
 	mutex_lock(&fwspk->mutex);
 
-	snd_fwspk_stream_stop(fwspk);
-
-	err = snd_fwspk_stream_start(fwspk);
+	err = snd_fwspk_stream_start(fwspk, runtime->rate);
 	if (err < 0)
 		goto end;
 
+	amdtp_stream_set_pcm_format(&fwspk->rx_stream, runtime->format);
 	amdtp_stream_pcm_prepare(&fwspk->rx_stream);
 end:
 	mutex_unlock(&fwspk->mutex);
diff --git a/sound/firewire/speakers/speakers_stream.c b/sound/firewire/speakers/speakers_stream.c
index 17d83e4..ef2ac9d 100644
--- a/sound/firewire/speakers/speakers_stream.c
+++ b/sound/firewire/speakers/speakers_stream.c
@@ -41,18 +41,76 @@ end:
 	return err;
 }
 
-int snd_fwspk_stream_start(struct fwspk *fwspk)
+int snd_fwspk_stream_start(struct fwspk *fwspk, unsigned int rate)
 {
-	int err = 0;
+	unsigned int i, curr_rate, pcm_channels, midi_ports;
+	bool used;
+	int err;
 
-	if (amdtp_stream_running(&fwspk->rx_stream))
+	/* already start or not */
+	if (amdtp_stream_running(&fwspk->rx_stream)) {
+		err = 0;
+		goto end;
+	}
+
+	/* check other's connection */
+	err = cmp_connection_check_used(&fwspk->in_conn, &used);
+	if (err < 0)
+		goto end;
+	else if (used) {
+		err = -EBUSY;
+		goto end;
+	};
+
+	/* arrange sampling rate */
+	err = avc_general_get_sig_fmt(fwspk->unit, &curr_rate,
+				      AVC_GENERAL_PLUG_DIR_IN, 0);
+	if (err < 0)
 		goto end;
+	if (err != 0x0c /* IMPLEMENTED/STABLE */) {
+		dev_err(&fwspk->unit->device,
+			"failed to get sample rate\n");
+		err = -EIO;
+		goto end;
+	}
+	if (curr_rate != rate) {
+		err = avc_general_set_sig_fmt(fwspk->unit, rate,
+					      AVC_GENERAL_PLUG_DIR_IN, 0);
+		if (err < 0)
+			goto end;
+		if (err != 0x09 /* ACCEPTED */) {
+			dev_err(&fwspk->unit->device,
+				"failed to set sample rate\n");
+			err = -EIO;
+			goto end;
+		}
+	}
+
+	/* set stream formation */
+	for (i = 0; i < FWSPK_STREAM_TABLE_ENTRIES; i++) {
+		if (fwspk_rate_table[i] == rate)
+			break;
+	}
+	if (i == FWSPK_STREAM_TABLE_ENTRIES) {
+		err = -EINVAL;
+		goto end;
+	}
+	pcm_channels = fwspk->rx_stream_formations[i].pcm;
+	midi_ports = fwspk->rx_stream_formations[i].midi;
+	if ((pcm_channels == 0) && (midi_ports == 0)) {
+		err = -EINVAL;
+		goto end;
+	}
+	amdtp_stream_set_parameters(&fwspk->rx_stream, rate,
+				    pcm_channels, midi_ports);
 
+	/* establish connection */
 	err = cmp_connection_establish(&fwspk->in_conn,
-		amdtp_stream_get_max_payload(&fwspk->rx_stream));
+			amdtp_stream_get_max_payload(&fwspk->rx_stream));
 	if (err < 0)
 		goto end;
 
+	/* start stream */
 	err = amdtp_stream_start(&fwspk->rx_stream,
 				 fwspk->in_conn.resources.channel,
 				 fwspk->in_conn.speed);
-- 
1.8.3.2
