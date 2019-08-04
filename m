From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 19/19] ALSA: firewire-lib: localize kernel APIs
	to start/stop each AMDTP stream
Date: Sun,  4 Aug 2019 15:21:38 +0900
Message-ID: <20190804062138.1217-20-o-takashi@sakamocchi.jp>
References: <20190804062138.1217-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9DA37F805A1
 for <alsa-devel@alsa-project.org>; Sun,  4 Aug 2019 08:22:12 +0200 (CEST)
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

As a result to support AMDTP domain, no drivers call kernel APIs to
start/stop each AMDTP stream. This commit localize these APIs.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-stream.c | 6 ++----
 sound/firewire/amdtp-stream.h | 2 --
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index 158d210caea7..1a92855c7647 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -894,7 +894,7 @@ static void amdtp_stream_first_callback(struct fw_iso_context *context,
  * amdtp_stream_set_parameters() and it must be started before any PCM or MIDI
  * device can be started.
  */
-int amdtp_stream_start(struct amdtp_stream *s, int channel, int speed)
+static int amdtp_stream_start(struct amdtp_stream *s, int channel, int speed)
 {
 	static const struct {
 		unsigned int data_block;
@@ -1027,7 +1027,6 @@ int amdtp_stream_start(struct amdtp_stream *s, int channel, int speed)
 
 	return err;
 }
-EXPORT_SYMBOL(amdtp_stream_start);
 
 /**
  * amdtp_stream_pcm_pointer - get the PCM buffer position
@@ -1098,7 +1097,7 @@ EXPORT_SYMBOL(amdtp_stream_update);
  * All PCM and MIDI devices of the stream must be stopped before the stream
  * itself can be stopped.
  */
-void amdtp_stream_stop(struct amdtp_stream *s)
+static void amdtp_stream_stop(struct amdtp_stream *s)
 {
 	mutex_lock(&s->mutex);
 
@@ -1118,7 +1117,6 @@ void amdtp_stream_stop(struct amdtp_stream *s)
 
 	mutex_unlock(&s->mutex);
 }
-EXPORT_SYMBOL(amdtp_stream_stop);
 
 /**
  * amdtp_stream_pcm_abort - abort the running PCM device
diff --git a/sound/firewire/amdtp-stream.h b/sound/firewire/amdtp-stream.h
index 15d471660a43..bbbca964b9b4 100644
--- a/sound/firewire/amdtp-stream.h
+++ b/sound/firewire/amdtp-stream.h
@@ -188,9 +188,7 @@ int amdtp_stream_set_parameters(struct amdtp_stream *s, unsigned int rate,
 				unsigned int data_block_quadlets);
 unsigned int amdtp_stream_get_max_payload(struct amdtp_stream *s);
 
-int amdtp_stream_start(struct amdtp_stream *s, int channel, int speed);
 void amdtp_stream_update(struct amdtp_stream *s);
-void amdtp_stream_stop(struct amdtp_stream *s);
 
 int amdtp_stream_add_pcm_hw_constraints(struct amdtp_stream *s,
 					struct snd_pcm_runtime *runtime);
-- 
2.20.1
