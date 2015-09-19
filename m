From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 13/15] ALSA: firewire-lib: rename PCM format
	helper function
Date: Sat, 19 Sep 2015 11:22:00 +0900
Message-ID: <1442629322-15457-14-git-send-email-o-takashi@sakamocchi.jp>
References: <1442629322-15457-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 18C9E260509
 for <alsa-devel@alsa-project.org>; Sat, 19 Sep 2015 04:22:14 +0200 (CEST)
In-Reply-To: <1442629322-15457-1-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Setting the format of PCM substream to AMDTP stream structure is important
to set a handler to copy actual PCM samples between buffers. The
processing should be in data block processing layer because essentially
it has no relationship to packet streaming.

This commit renames PCM format setting function to prepare for integrating
AM824 layer.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-stream.c            | 7 +++----
 sound/firewire/amdtp-stream.h            | 4 ++--
 sound/firewire/bebob/bebob_pcm.c         | 8 ++++----
 sound/firewire/dice/dice-pcm.c           | 6 ++----
 sound/firewire/fireworks/fireworks_pcm.c | 6 ++++--
 sound/firewire/oxfw/oxfw-pcm.c           | 4 ++--
 6 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index 06fbf23..cc640cd 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -272,7 +272,7 @@ static void read_pcm_s32(struct amdtp_stream *s,
 			 __be32 *buffer, unsigned int frames);
 
 /**
- * amdtp_stream_set_pcm_format - set the PCM format
+ * amdtp_am824_set_pcm_format - set the PCM format
  * @s: the AMDTP stream to configure
  * @format: the format of the ALSA PCM device
  *
@@ -280,8 +280,7 @@ static void read_pcm_s32(struct amdtp_stream *s,
  * MIDI) and before the stream is started, and must not be changed while the
  * stream is running.
  */
-void amdtp_stream_set_pcm_format(struct amdtp_stream *s,
-				 snd_pcm_format_t format)
+void amdtp_am824_set_pcm_format(struct amdtp_stream *s, snd_pcm_format_t format)
 {
 	if (WARN_ON(amdtp_stream_pcm_running(s)))
 		return;
@@ -305,7 +304,7 @@ void amdtp_stream_set_pcm_format(struct amdtp_stream *s,
 		break;
 	}
 }
-EXPORT_SYMBOL(amdtp_stream_set_pcm_format);
+EXPORT_SYMBOL_GPL(amdtp_am824_set_pcm_format);
 
 /**
  * amdtp_stream_pcm_prepare - prepare PCM device for running
diff --git a/sound/firewire/amdtp-stream.h b/sound/firewire/amdtp-stream.h
index 984f02a..3fb82c7 100644
--- a/sound/firewire/amdtp-stream.h
+++ b/sound/firewire/amdtp-stream.h
@@ -190,8 +190,8 @@ void amdtp_stream_stop(struct amdtp_stream *s);
 
 int amdtp_stream_add_pcm_hw_constraints(struct amdtp_stream *s,
 					struct snd_pcm_runtime *runtime);
-void amdtp_stream_set_pcm_format(struct amdtp_stream *s,
-				 snd_pcm_format_t format);
+void amdtp_am824_set_pcm_format(struct amdtp_stream *s,
+				snd_pcm_format_t format);
 void amdtp_stream_pcm_prepare(struct amdtp_stream *s);
 unsigned long amdtp_stream_pcm_pointer(struct amdtp_stream *s);
 void amdtp_stream_pcm_abort(struct amdtp_stream *s);
diff --git a/sound/firewire/bebob/bebob_pcm.c b/sound/firewire/bebob/bebob_pcm.c
index 50610ca..8d8de4c 100644
--- a/sound/firewire/bebob/bebob_pcm.c
+++ b/sound/firewire/bebob/bebob_pcm.c
@@ -220,8 +220,8 @@ pcm_capture_hw_params(struct snd_pcm_substream *substream,
 
 	if (substream->runtime->status->state == SNDRV_PCM_STATE_OPEN)
 		atomic_inc(&bebob->substreams_counter);
-	amdtp_stream_set_pcm_format(&bebob->tx_stream,
-				    params_format(hw_params));
+
+	amdtp_am824_set_pcm_format(&bebob->tx_stream, params_format(hw_params));
 
 	return 0;
 }
@@ -239,8 +239,8 @@ pcm_playback_hw_params(struct snd_pcm_substream *substream,
 
 	if (substream->runtime->status->state == SNDRV_PCM_STATE_OPEN)
 		atomic_inc(&bebob->substreams_counter);
-	amdtp_stream_set_pcm_format(&bebob->rx_stream,
-				    params_format(hw_params));
+
+	amdtp_am824_set_pcm_format(&bebob->rx_stream, params_format(hw_params));
 
 	return 0;
 }
diff --git a/sound/firewire/dice/dice-pcm.c b/sound/firewire/dice/dice-pcm.c
index f5f3007..8cbcd5d 100644
--- a/sound/firewire/dice/dice-pcm.c
+++ b/sound/firewire/dice/dice-pcm.c
@@ -243,8 +243,7 @@ static int capture_hw_params(struct snd_pcm_substream *substream,
 		mutex_unlock(&dice->mutex);
 	}
 
-	amdtp_stream_set_pcm_format(&dice->tx_stream,
-				    params_format(hw_params));
+	amdtp_am824_set_pcm_format(&dice->tx_stream, params_format(hw_params));
 
 	return 0;
 }
@@ -265,8 +264,7 @@ static int playback_hw_params(struct snd_pcm_substream *substream,
 		mutex_unlock(&dice->mutex);
 	}
 
-	amdtp_stream_set_pcm_format(&dice->rx_stream,
-				    params_format(hw_params));
+	amdtp_am824_set_pcm_format(&dice->rx_stream, params_format(hw_params));
 
 	return 0;
 }
diff --git a/sound/firewire/fireworks/fireworks_pcm.c b/sound/firewire/fireworks/fireworks_pcm.c
index f186ab7..109fb1b 100644
--- a/sound/firewire/fireworks/fireworks_pcm.c
+++ b/sound/firewire/fireworks/fireworks_pcm.c
@@ -253,7 +253,8 @@ static int pcm_capture_hw_params(struct snd_pcm_substream *substream,
 
 	if (substream->runtime->status->state == SNDRV_PCM_STATE_OPEN)
 		atomic_inc(&efw->capture_substreams);
-	amdtp_stream_set_pcm_format(&efw->tx_stream, params_format(hw_params));
+
+	amdtp_am824_set_pcm_format(&efw->tx_stream, params_format(hw_params));
 
 	return 0;
 }
@@ -270,7 +271,8 @@ static int pcm_playback_hw_params(struct snd_pcm_substream *substream,
 
 	if (substream->runtime->status->state == SNDRV_PCM_STATE_OPEN)
 		atomic_inc(&efw->playback_substreams);
-	amdtp_stream_set_pcm_format(&efw->rx_stream, params_format(hw_params));
+
+	amdtp_am824_set_pcm_format(&efw->rx_stream, params_format(hw_params));
 
 	return 0;
 }
diff --git a/sound/firewire/oxfw/oxfw-pcm.c b/sound/firewire/oxfw/oxfw-pcm.c
index bddd287..217fe37 100644
--- a/sound/firewire/oxfw/oxfw-pcm.c
+++ b/sound/firewire/oxfw/oxfw-pcm.c
@@ -244,7 +244,7 @@ static int pcm_capture_hw_params(struct snd_pcm_substream *substream,
 		mutex_unlock(&oxfw->mutex);
 	}
 
-	amdtp_stream_set_pcm_format(&oxfw->tx_stream, params_format(hw_params));
+	amdtp_am824_set_pcm_format(&oxfw->tx_stream, params_format(hw_params));
 
 	return 0;
 }
@@ -265,7 +265,7 @@ static int pcm_playback_hw_params(struct snd_pcm_substream *substream,
 		mutex_unlock(&oxfw->mutex);
 	}
 
-	amdtp_stream_set_pcm_format(&oxfw->rx_stream, params_format(hw_params));
+	amdtp_am824_set_pcm_format(&oxfw->rx_stream, params_format(hw_params));
 
 	return 0;
 }
-- 
2.1.4
